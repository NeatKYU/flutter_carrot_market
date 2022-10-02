import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:carrot_market_by_flutter/widgets/chat.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ChatroomScreen extends StatefulWidget {
  String chatroomKey;
  ChatroomScreen(this.chatroomKey, {super.key});

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('chat room'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: ExtendedImage.network(
                'https://picsum.photos/50',
                fit: BoxFit.cover,
                shape: BoxShape.rectangle,
              ),
              title: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: '거래완료'),
                    TextSpan(text: ' 거래 제목~'),
                  ],
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: '30000원'),
                    TextSpan(text: ' (가격제안불가)'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: common_padding),
              child: TextButton.icon(
                icon: Icon(Icons.edit),
                label: Text('후기 남기기'),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(common_padding),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      size: _size,
                      isMine: index % 2 == 0,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12);
                  },
                  itemCount: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: common_padding_sm),
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
                      decoration: InputDecoration(
                          hintText: '메시지를 입력하세요.',
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
                    onPressed: () {},
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
  }
}
