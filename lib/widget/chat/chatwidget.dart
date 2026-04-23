import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isMe ? AppColors.purplePastel : Colors.white,
              border: Border.all(
                color: AppColors.purplePastel
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: LineStyles.context.copyWith(color : AppColors.darkGrey)
            ),
          ),
          Text(
            time,
            style: LineStyles.act_subtitle
          ),
        ],
      ),
    );
  }
}
