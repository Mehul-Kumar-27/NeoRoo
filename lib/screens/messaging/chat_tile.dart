import 'package:flutter/material.dart';
import 'package:neoroo_app/models/message_model.dart';

class ChatMessageTile extends StatelessWidget {
  final Messages message;
  final String userId;

  const ChatMessageTile({
    Key? key,
    required this.message,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe;
    if (userId == message.users[0]["id"]) {
      isMe = false;
    } else {
      isMe = true;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isMe
                    ? const Color.fromRGBO(88, 34, 102, 1)
                    : Colors.grey[350],
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: isMe
                        ? const Radius.circular(12)
                        : const Radius.circular(0),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
