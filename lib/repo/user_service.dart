import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carrot_market_by_flutter/utils/logger.dart';

class UserService {
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
