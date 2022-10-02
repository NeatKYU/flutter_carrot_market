import 'package:carrot_market_by_flutter/model/chat_model/chat_model.dart';
import 'package:carrot_market_by_flutter/model/chatroom_model/chatroom_model.dart';
import 'package:carrot_market_by_flutter/repo/chat_service.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  late ChatroomModel _chatroomModel;
  late String _chatroomKey;
  List<ChatModel> _chatList = [];

  ChatProvider(this._chatroomKey) {
    // 채팅룸 연결
    ChatService().connectChatroom(_chatroomKey).listen((chatroomModel) {
      this._chatroomModel = chatroomModel;

      if (_chatList.isEmpty) {
        // 채팅 리스트 아직 없으면 즉 처음 불러올때는 그냥 쿼리실행해서 chatList에 넣어줌
        ChatService().getChatList(_chatroomKey).then((chatList) {
          _chatList.addAll(chatList);
          notifyListeners();
        });
      } else {
        // 마지막? 채팅기록 가져와서 원래있던 리스트에 붙이기
        ChatService()
            .getLatestChatList(_chatroomKey, _chatList[0].reference!)
            .then((latestChatList) {
          _chatList.insertAll(0, latestChatList);
          notifyListeners();
        });
      }
    });
  }
}
