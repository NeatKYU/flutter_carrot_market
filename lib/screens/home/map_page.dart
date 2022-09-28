import 'dart:math';
import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:carrot_market_by_flutter/model/user_model/user_model.dart';
import 'package:carrot_market_by_flutter/provider/user_provider.dart';
import 'package:carrot_market_by_flutter/repo/image_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/provider.dart';

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
    generateData(widget._userModel.userKey, widget._userModel.geoFirePoint);
    controller = MapController(
      location: LatLng(widget._userModel.geoFirePoint.latitude,
          widget._userModel.geoFirePoint.longitude),
      zoom: 16,
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
            _myLocation(location)
          ],
        );
      },
    );
  }

  Future<List<String>> generateData(
      String userKey, GeoFirePoint geoFirePoint) async {
    List<String> itemKeys = [];

    DateTime now = DateTime.now().toUtc();
    final numOfItem = 20;
    await FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      for (int i = 0; i < numOfItem; i++) {
        final String itemKey = ImageStroage.createKey(userKey);
        itemKeys.add(itemKey);
        final DocumentReference postRef =
            FirebaseFirestore.instance.collection('items').doc(itemKey);

        final DocumentReference userItemDocReference = FirebaseFirestore
            .instance
            .collection('users')
            .doc(userKey)
            .collection('items')
            .doc(itemKey);

        var rng = new Random();
        GeoPoint geoPoint = geoFirePoint.data['geopoint'];
        final newGeoData = GeoFirePoint(
            geoPoint.latitude + (0.001 * (rng.nextInt(100) - 50)),
            geoPoint.longitude + (0.001 * (rng.nextInt(100) - 50)));

        ItemModel item = ItemModel(
          userKey: userKey,
          itemKey: itemKey,
          imageDownloadUrls: ['https://picsum.photos/200'],
          title: 'testing + $i',
          category: 'test',
          price: 100 * i,
          nego: i % 2 == 0,
          detail: 'testing detail + $i',
          address: 'testing address + $i',
          geoFirePoint: newGeoData,
          createdDate: now.subtract(Duration(days: i)),
        );

        tx.set(postRef, item.toJson());
        tx.set(userItemDocReference, item.toMinJson());
      }
    });
    return itemKeys;
  }

  final List<String> nouns = [
    'time',
    'year',
    'people',
    'way',
    'day',
    'man',
    'thing',
    'woman',
    'life',
    'child',
    'world',
    'school',
    'state',
    'family',
    'student',
    'group',
    'country',
    'problem',
    'hand',
    'part',
    'place',
    'case',
    'week',
    'company',
    'system',
    'program',
    'question',
    'work',
    'government',
    'number',
    'night',
    'point',
    'home',
    'water',
    'room',
    'mother',
    'area',
    'money',
    'story',
    'fact',
    'month',
    'lot',
    'right',
    'study',
    'book',
    'eye',
    'job',
    'word',
    'business'
  ];
}
