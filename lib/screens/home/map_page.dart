import 'dart:math';
import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:carrot_market_by_flutter/model/user_model/user_model.dart';
import 'package:carrot_market_by_flutter/repo/item_service.dart';
import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';

// 아래 사이트 참고
// https://github.com/xclud/flutter_map/blob/main/example/lib/pages/raster_map_page.dart
class MapPage extends StatefulWidget {
  final UserModel _userModel;
  const MapPage(this._userModel, {super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final controller;

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    // 스케일의 차이만큼 줌 하기위한 설정
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;

      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      if (controller.zoom < 1) {
        controller.zoom = 1;
      }
      setState(() {});
    } else {
      final now = details.focalPoint;
      var diff = now - _dragStart!;
      _dragStart = now;
      final h = transformer.constraints.maxHeight;

      final vp = transformer.getViewport();
      if (diff.dy < 0 && vp.bottom - diff.dy < h) {
        diff = Offset(diff.dx, 0);
      }

      if (diff.dy > 0 && vp.top - diff.dy > 0) {
        diff = Offset(diff.dx, 0);
      }

      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  Widget _myLocation(Offset offset, {Color color = Colors.red}) {
    // offset으로 처리하지만 지도를 확대하거나 축소하면 위치가 달라지는 문제가 존재함
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      width: 24,
      height: 24,
      child: Align(
        alignment: Alignment.center,
        child: Icon(
          Icons.location_on,
          color: color,
        ),
      ),
    );
  }

  @override
  void initState() {
    controller = MapController(
      location: LatLng(widget._userModel.geoFirePoint.latitude,
          widget._userModel.geoFirePoint.longitude),
      zoom: 10,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MapLayout(
      controller: controller,
      builder: (context, transformer) {
        final location = transformer.toOffset(LatLng(
            widget._userModel.geoFirePoint.latitude,
            widget._userModel.geoFirePoint.longitude));

        Size _size = MediaQuery.of(context).size;
        final centerScreen = Offset(_size.width / 2, _size.height / 2);

        final latlngOnMap = transformer.toLatLng(centerScreen);

        return FutureBuilder<List<ItemModel>>(
            future: ItemService()
                .getNearByItems(widget._userModel.userKey, latlngOnMap),
            builder: (context, snapshot) {
              List<Widget> nearByItems = [];

              if (snapshot.hasData) {
                snapshot.data!.forEach((item) {
                  final offset = transformer.toOffset(LatLng(
                      item.geoFirePoint.latitude, item.geoFirePoint.longitude));
                  nearByItems.add(_myLocation(offset));
                });
              }

              return Stack(
                children: [
                  GestureDetector(
                    onScaleStart: _onScaleStart,
                    onScaleUpdate: ((details) =>
                        _onScaleUpdate(details, transformer)),
                    child: TileLayer(
                      builder: (context, x, y, z) {
                        final tilesInZoom = pow(2.0, z).floor();

                        while (x < 0) {
                          x += tilesInZoom;
                        }
                        while (y < 0) {
                          y += tilesInZoom;
                        }

                        x %= tilesInZoom;
                        y %= tilesInZoom;

                        //Google Maps
                        final url =
                            'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                        return ExtendedImage.network(
                          url,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  _myLocation(location),
                  ...nearByItems,
                ],
              );
            });
      },
    );
  }
}
