import 'package:carrot_market_by_flutter/model/chat_model/chat_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  final Size size;
  final bool isMine;
  final ChatModel chatModel;

  const ChatWidget({
    super.key,
    required this.size,
    required this.isMine,
    required this.chatModel,
  });

  @override
  Widget build(BuildContext context) {
    return isMine ? _myChat() : _otherChat();
  }

  Widget _myChat() {
    final _radius = Radius.circular(20);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('오전 10:24'),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(
            maxWidth: size.width * 0.5,
            minHeight: 40,
          ),
          child: Text(chatModel.msg),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(
              bottomLeft: _radius,
              bottomRight: _radius,
              topLeft: _radius,
              topRight: Radius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _otherChat() {
    final _radius = Radius.circular(20);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExtendedImage.network(
          'https://picsum.photos/30',
          fit: BoxFit.cover,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.all(10),
              constraints: BoxConstraints(
                maxWidth: size.width * 0.5,
                minHeight: 40,
              ),
              child: Text(chatModel.msg),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: _radius,
                  bottomRight: _radius,
                  topLeft: Radius.circular(2),
                  topRight: _radius,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text('오전 10:24'),
          ],
        )
      ],
    );
  }
}
