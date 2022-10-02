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
        if(_chatList[0].reference == null) _chatList.removeAt(0);
        ChatService()
            .getLatestChatList(_chatroomKey, _chatList[0].reference!)
            .then((latestChatList) {
          _chatList.insertAll(0, latestChatList);
          notifyListeners();
        });
      }
    });
  }

  // 채팅이 바로바로 뜨도록 일단 리스트에 넣어주고 그다음에 디비에 넣어준다.
  void addNewChat(ChatModel chatModel) {
    _chatList.insert(0, chatModel);
    notifyListeners();

    ChatService().createNewChat(_chatroomKey, chatModel);
  }

  List<ChatModel> get chatList => _chatList;
  ChatroomModel get chatroomModel => _chatroomModel;
  String get chatroomKey => _chatroomKey;
}
