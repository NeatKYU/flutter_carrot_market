import 'package:carrot_market_by_flutter/model/chatroom_model/chatroom_model.dart';
import 'package:carrot_market_by_flutter/provider/user_provider.dart';
import 'package:carrot_market_by_flutter/repo/chat_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends StatelessWidget {
  final String userKey;
  const ChatListScreen({super.key, required this.userKey});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatroomModel>>(
        future: ChatService().getMyChatroomList(userKey),
        builder: (context, snapshot) {
          return Scaffold(
            body: ListView.separated(
              itemBuilder: (context, index) {
                ChatroomModel chatroomModel = snapshot.data![index];
                bool isBuyer = chatroomModel.buyerKey == userKey;

                return ListTile(
                  onTap: () {
                    GoRouter.of(context).go(
                        '/item/${chatroomModel.itemKey}/${chatroomModel.chatroomKey}');
                  },
                  leading: Container(
                    height: double.infinity,
                    child: ExtendedImage.network(
                      'https://picsum.photos/40',
                      fit: BoxFit.cover,
                      shape: BoxShape.circle,
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: isBuyer
                          ? chatroomModel.buyerKey
                          : chatroomModel.sellerKey,
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: ' '),
                        TextSpan(
                          text: chatroomModel.itemAddress,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    chatroomModel.lastMsg,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: ExtendedImage.network(
                    chatroomModel.itemImage,
                    fit: BoxFit.cover,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: Colors.grey[300],
                );
              },
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
            ),
          );
        });
  }
}
