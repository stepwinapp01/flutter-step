import 'package:flutter/material.dart';
import '../../models/chat_message.dart';

class UserChatBubble extends StatelessWidget {
  final ChatMessage message;

  const UserChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 40),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(message.message),
            ),
          ),
        ],
      ),
    );
  }
}