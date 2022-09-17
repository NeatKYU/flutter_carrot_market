import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class ImageStroage {
  static Future<List<String>> UploadImages(List<Uint8List> images) async {
    if (FirebaseAuth.instance.currentUser == null) {
      return [];
    }

    var metaData = SettableMetadata(contentType: 'image/jpeg');
    String userKey = FirebaseAuth.instance.currentUser!.uid;

    List<String> downloadUrls = [];

    for (int i = 0; i < images.length; i++) {
      Reference ref =
          FirebaseStorage.instance.ref('images/${createKey(userKey)}/${i}.png');
      await ref.putData(images[i], metaData);

      downloadUrls.add(await ref.getDownloadURL());
    }

    return downloadUrls;
  }

  static String createKey(String userId) {
    String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    return userId + '_' + timeInMilli;
  }
}
