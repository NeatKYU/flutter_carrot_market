import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carrot_market_by_flutter/utils/logger.dart';

class UserService {
  // 똑같은 userService를 생성하게한다. 만약 생성되어있으면 이전에 생성된 값을 가져온다.
  // 공부가 필요한 부분인듯
  static final UserService _userService = UserService._internal();
  factory UserService() => _userService;
  UserService._internal();

  Future createNewUser(Map<String, dynamic> json, String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection('users').doc(userKey);

    // 아이디가 있는지 없는지 확인 용
    final DocumentSnapshot documentSnapshot = await documentReference.get();

    if (!documentSnapshot.exists) {
      documentReference.set(json);
    }
  }

  // DB에 데이터 저장
  Future firestoreTest() async {
    FirebaseFirestore.instance.collection('TESTING_COLLECTION').add({
      'testing': 'testing value',
      'number': 123123,
    });
  }

  // DB에 있는 데이터 가져오기
  void firestoreGetTest() {
    FirebaseFirestore.instance
        .collection('TESTING_COLLECTION')
        .doc('collection_id')
        .get()
        .then(
          (DocumentSnapshot<Map<String, dynamic>> value) => {
            logger.d(value.data()),
          },
        );
  }
}
