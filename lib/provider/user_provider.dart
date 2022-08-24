// 이게 파일 사이즈 작으니까 이렇게 불러옴
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  bool _userLoggedIn = false;

  void setUserAuth(bool authState) {
    _userLoggedIn = authState;
    // 구독중인 위젯들에게 알림!
    notifyListeners();
  }

  bool get userState => _userLoggedIn;
}
