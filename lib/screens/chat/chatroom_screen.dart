import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:carrot_market_by_flutter/model/chat_model/chat_model.dart';
import 'package:carrot_market_by_flutter/model/chatroom_model/chatroom_model.dart';
import 'package:carrot_market_by_flutter/model/user_model/user_model.dart';
import 'package:carrot_market_by_flutter/provider/chat_provider.dart';
import 'package:carrot_market_by_flutter/provider/user_provider.dart';
import 'package:carrot_market_by_flutter/repo/chat_service.dart';
import 'package:carrot_market_by_flutter/widgets/chat.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class ChatroomScreen extends StatefulWidget {
  String chatroomKey;
  ChatroomScreen(this.chatroomKey, {super.key});

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController _sendMsgController = TextEditingController();
  late ChatProvider _chatProvider;

  @override
  void initState() {
    _chatProvider = ChatProvider(widget.chatroomKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    UserModel _userModel = context.read<UserProvider>().userModel!;

    return ChangeNotifierProvider<ChatProvider>.value(
      value: _chatProvider,
      child: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          ChatroomModel? chatroomModel =
              context.read<ChatProvider>().chatroomModel;
          return Scaffold(
            appBar: AppBar(
              title: Text('chat room'),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: chatroomModel == null
                        ? Shimmer.fromColors(
                            child: Container(width: 32, height: 32),
                            baseColor: Colors.grey,
                            highlightColor: Colors.white)
                        : ExtendedImage.network(
                            chatroomModel!.itemImage,
                            fit: BoxFit.cover,
                            shape: BoxShape.rectangle,
                          ),
                    title: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: '????????????'),
                          TextSpan(
                              text: chatroomModel == null
                                  ? ''
                                  : chatroomModel.itemTitle),
                        ],
                      ),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: chatroomModel == null
                                ? ''
                                : chatroomModel.itemPrice.toCurrencyString(
                                    mantissaLength: 0,
                                    trailingSymbol: '???',
                                  ),
                          ),
                          TextSpan(text: ' (??????????????????)'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: common_padding),
                    child: TextButton.icon(
                      icon: Icon(Icons.edit),
                      label: Text('?????? ?????????'),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(common_padding),
                      child: ListView.separated(
                        reverse: true,
                        itemBuilder: (context, index) {
                          bool _isMine = chatProvider.chatList[index].userKey ==
                              _userModel.userKey;
                          return ChatWidget(
                            size: _size,
                            isMine: _isMine,
                            chatModel: chatProvider.chatList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 12);
                        },
                        itemCount: chatProvider.chatList.length,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: common_padding_sm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _sendMsgController,
                            decoration: InputDecoration(
                                hintText: '???????????? ???????????????.',
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                  left: common_padding,
                                  right: common_padding_sm,
                                  top: common_padding_sm,
                                  bottom: common_padding_sm,
                                ),
                                suffixIcon: Icon(Icons.emoji_emotions_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            ChatModel chatModel = ChatModel(
                              createDate: DateTime.now(),
                              msg: _sendMsgController.text,
                              userKey: _userModel.userKey,
                            );

                            chatProvider.addNewChat(chatModel);
                            // await ChatService()
                            //     .createNewChat(widget.chatroomKey, chatModel);

                            _sendMsgController.clear();
                          },
                          icon: Icon(Icons.send),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
