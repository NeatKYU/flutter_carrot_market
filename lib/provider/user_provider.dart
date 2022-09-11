// 이게 파일 사이즈 작으니까 이렇게 불러옴
import 'package:carrot_market_by_flutter/model/user_model/user_model.dart';
import 'package:carrot_market_by_flutter/repo/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/shared_pref_keys.dart';
import '../utils/logger.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  UserModel? _userModel;

  UserProvider() {
    initUser();
  }

  void setUserAuth(bool authState) {
    _user = null;
    // 구독중인 위젯들에게 알림!
    notifyListeners();
  }

  void initUser() {
    FirebaseAuth.instance.userChanges().listen((user) async {
      await _setNewUser(user);
      notifyListeners();
    });
  }

  Future _setNewUser(User? user) async {
    if (user != null && user.phoneNumber != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String address = prefs.getString(SHARED_ADDRESS) ?? "";
      double lat = prefs.getDouble(SHARED_LAT) ?? 0;
      double lon = prefs.getDouble(SHARED_LON) ?? 0;
      String phoneNumber = user.phoneNumber!;
      String userKey = user.uid;

      UserModel userModel = UserModel(
        userKey: '',
        phoneNumber: phoneNumber,
        address: address,
        // lat: lat,
        // lon: lon,
        geoFirePoint: GeoFirePoint(lat, lon),
        createdDate: DateTime.now().toUtc(),
      );

      // 싱글리턴을 사용하면 아래와같이 여러개의 생성자를 사용해도 하나의 주소값만 사용해서 메모리 이득 볼 수 있다.
      await UserService().createNewUser(userModel.toJson(), userKey);
      _userModel = await UserService().getUserModel(userKey);

      //이거 해줘야지 라우터에서 비교 가능!!!
      _user = user;
    }
  }

  User? get user => _user;
}
