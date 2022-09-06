// 이게 파일 사이즈 작으니까 이렇게 불러옴
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../utils/logger.dart';

class UserProvider extends ChangeNotifier {
  bool _userLoggedIn = false;
  User? _user;

  UserProvider() {
    initUser();
  }

  void setUserAuth(bool authState) {
    _userLoggedIn = authState;
    // 구독중인 위젯들에게 알림!
    notifyListeners();
  }

  void initUser() {
    FirebaseAuth.instance.userChanges().listen((user) {
      _user = user;
      logger.d('user status = $user');
      notifyListeners();
    });
  }

  bool get loggedIn => _userLoggedIn;
  User? get user => _user;
}
