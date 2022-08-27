import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:carrot_market_by_flutter/model/address/address.dart';

class AddressService {
  Future<Address> getAddress(String searchKeyword) async {
    final data = {
      'confmKey': 'devU01TX0FVVEgyMDIyMDgyNzE0MDgxMTExMjkyMjM=',
      'keyword': searchKeyword,
      'resultType': 'json'
    };

    final response = await Dio()
        .get(
      'https://business.juso.go.kr/addrlink/addrLinkApi.do',
      queryParameters: data,
    )
        .catchError((e) {
      logger.e(e.error);
    });

    // results라는 데이터를 가지고 있어서 당연히
    // response.data['results']라고 해서 데이터 뺴야할줄 알았는데
    // response.data까지만 하면 나온다.... 후....
    Address addressModel = Address.fromJson(response.data);

    logger.d(addressModel.toJson());

    return addressModel;
  }
}
