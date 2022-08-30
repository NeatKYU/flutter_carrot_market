import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:carrot_market_by_flutter/model/address/address.dart';
import 'package:carrot_market_by_flutter/model/convert_address/convert_address.dart';

class AddressService {
  String? kakaoAPIkey = dotenv.env['KAKAO_API_KEY'];
  String? kakaoUrl = dotenv.env['KAKAO_BASE_URL'];

  Future<Address> getAddress(String searchKeyword) async {
    final data = {
      'analyze_type': 'similar',
      'query': searchKeyword,
    };

    final response = await Dio()
        .get(
      '${kakaoUrl}/v2/local/search/address.json',
      queryParameters: data,
      options: Options(
        headers: {'Authorization': kakaoAPIkey},
      ),
    )
        .catchError((e) {
      logger.e(e.error);
    });

    // results라는 데이터를 가지고 있어서 당연히
    // response.data['results']라고 해서 데이터 뺴야할줄 알았는데
    // response.data까지만 하면 나온다.... 후....
    Address addressModel = Address.fromJson(response.data);

    return addressModel;
  }

  Future<void> convertLocToAddress(
      {required double lat, required double lng}) async {
    List<Map<String, dynamic>> addressList = [
      {
        'x': lng,
        'y': lat,
      },
      {
        'x': lng - 0.01,
        'y': lat - 0.01,
      },
      {
        'x': lng + 0.01,
        'y': lat + 0.01,
      },
      {
        'x': lng - 0.01,
        'y': lat + 0.01,
      },
      {
        'x': lng + 0.01,
        'y': lat - 0.01,
      },
    ];

    for (Map<String, dynamic> location in addressList) {
      final response = await Dio()
          .get(
        '${kakaoUrl}/v2/local/geo/coord2address.json',
        queryParameters: location,
        options: Options(
          headers: {'Authorization': kakaoAPIkey},
        ),
      )
          .catchError((e) {
        logger.e(e.error);
      });

      logger.d(response.data);
    }

    // ConvertAddress addressModel = ConvertAddress.fromJson(response.data);

    // return addressModel;
  }
}
