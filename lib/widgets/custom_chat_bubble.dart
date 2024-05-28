import 'package:flutter/material.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/text_styles.dart';

class CustomChatBubble extends StatelessWidget {
  const CustomChatBubble({super.key, required this.isCurrentUser, required this.message});

  final bool isCurrentUser;
  final String message;

  @override
  Widget build(BuildContext context) {
    var messageAlignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    var color = isCurrentUser ? Colors.blue : Colors.grey[350];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SmartAmbulanceSizes.chatBubblePadding),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 100),
        child: Container(
          alignment: messageAlignment,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(SmartAmbulanceSizes.borderRadius)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message, style: SmartAmbulanceTextStyles.messageTextStyle,),
          ),
        ),
      )
    );
  }
}