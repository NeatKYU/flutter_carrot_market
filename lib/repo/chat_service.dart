import 'dart:async';

import 'package:carrot_market_by_flutter/model/chat_model/chat_model.dart';
import 'package:carrot_market_by_flutter/model/chatroom_model/chatroom_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static final ChatService _chatService = ChatService._internal();
  factory ChatService() => _chatService;
  ChatService._internal();

  // create new chat room
  Future createNewChatroom(ChatroomModel chatroomModel) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection('chatrooms').doc(
            ChatroomModel.createKey(
                chatroomModel.buyerKey, chatroomModel.itemKey));

    final DocumentSnapshot documentSnapshot = await documentReference.get();

    if (!documentSnapshot.exists) {
      await documentReference.set(chatroomModel.toJson());
    }
  }

  // create new chat
  Future createNewChat(String chatroomKey, ChatModel chatModel) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(chatroomKey)
            .collection('chats')
            .doc();

    DocumentReference<Map<String, dynamic>> chatroomDocRef =
        FirebaseFirestore.instance.collection('chatrooms').doc(chatroomKey);

    await documentReference.set(chatModel.toJson());

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatModel.toJson());
      transaction.update(chatroomDocRef, {
        'lastMsg': chatModel.msg,
        'lastTime': chatModel.createDate,
        'lastMsgUserKey': chatModel.userKey
      });
    });
  }

  // get chatroom detail
  Stream<ChatroomModel> connectChatroom(String chatroomKey) {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomKey)
        .snapshots()
        .transform(snapshotToChatroom);
  }

  var snapshotToChatroom = StreamTransformer<
      DocumentSnapshot<Map<String, dynamic>>,
      ChatroomModel>.fromHandlers(handleData: (snapshot, sink) {
    ChatroomModel chatroom = ChatroomModel.fromSnapshot(snapshot);
    sink.add(chatroom);
  });

  // get chat list
  Future<List<ChatModel>> getChatList(String chatroomKey) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('chatrooms')
        .doc(chatroomKey)
        .collection('chats')
        .orderBy('createDate', descending: true)
        .limit(10)
        .get();

    List<ChatModel> chatList = [];

    snapshot.docs.forEach((chat) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(chat);
      chatList.add(chatModel);
    });

    return chatList;
  }

  // get latest chat list
  Future<List<ChatModel>> getLatestChatList(
      String chatroomKey, DocumentReference currentDocRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('chatrooms')
        .doc(chatroomKey)
        .collection('chats')
        .orderBy('createDate', descending: true)
        .endBeforeDocument(await currentDocRef.get())
        .get();

    List<ChatModel> chatList = [];

    snapshot.docs.forEach((chat) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(chat);
      chatList.add(chatModel);
    });

    return chatList;
  }

  // get older chat list
  Future<List<ChatModel>> getOlderChatList(
      String chatroomKey, DocumentReference oldDocRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('chatrooms')
        .doc(chatroomKey)
        .collection('chats')
        .orderBy('createDate', descending: true)
        .startAfterDocument(await oldDocRef.get())
        .limit(10)
        .get();

    List<ChatModel> chatList = [];

    snapshot.docs.forEach((chat) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(chat);
      chatList.add(chatModel);
    });

    return chatList;
  }

  // 내가 속한 채팅룸의 리스트를 가져와서 채팅 페이지에 뿌려줄 떄 사용
  Future<List<ChatroomModel>> getMyChatroomList(String myUserKey) async {
    List<ChatroomModel> chatroomList = [];

    QuerySnapshot<Map<String, dynamic>> buyingList =
        await FirebaseFirestore.instance
            .collection('chatrooms')
            // 내 키값과 buyer로 등록된 키 값이 같으면 가져온다. 즉, 내가 buyer인 채팅룸 리스트
            .where('buyerKey', isEqualTo: myUserKey)
            .get();

    QuerySnapshot<Map<String, dynamic>> sellingList =
        await FirebaseFirestore.instance
            .collection('chatrooms')
            // 내 키값과 seller로 등록된 키 값이 같으면 가져온다. 즉, 내가 seller 채팅룸 리스트
            .where('sellerKey', isEqualTo: myUserKey)
            .get();

    buyingList.docs.forEach((chatroom) {
      chatroomList.add(ChatroomModel.fromQuerySnapshot(chatroom));
    });
    sellingList.docs.forEach((chatroom) {
      chatroomList.add(ChatroomModel.fromQuerySnapshot(chatroom));
    });

    chatroomList.sort(((a, b) => a.lastMsgTime.compareTo(b.lastMsgTime)));

    return chatroomList;
  }
}
