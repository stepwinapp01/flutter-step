class ChatMessage {
  final String message;
  final bool isCoach;
  final DateTime timestamp;
  
  ChatMessage({
    required this.message,
    required this.isCoach,
    required this.timestamp,
  });
}