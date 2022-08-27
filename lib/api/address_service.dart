import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:dio/dio.dart';

class AddressService {
  void getAddress(String searchKeyword) async {
    final data = {
      'confmKey': 'devU01TX0FVVEgyMDIyMDgyNzE0MDgxMTExMjkyMjM=',
      'keyword': searchKeyword,
      'resultType': 'json',
    };

    final response = await Dio()
        .get(
      'https://business.juso.go.kr/addrlink/addrLinkApiJsonp.do',
      queryParameters: data,
    )
        .catchError((e) {
      logger.e(e.error);
    });

    logger.d(response);
  }
}
