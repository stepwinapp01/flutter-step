enum Sender { user, coach }

class ChatMessage {
  final String message;
  final Sender sender;
  final DateTime timestamp;
  
  ChatMessage({
    required this.message,
    required this.sender,
    required this.timestamp,
  });
  
  factory ChatMessage.user({required String message}) {
    return ChatMessage(
      message: message,
      sender: Sender.user,
      timestamp: DateTime.now(),
    );
  }
  
  factory ChatMessage.coach({required String message}) {
    return ChatMessage(
      message: message,
      sender: Sender.coach,
      timestamp: DateTime.now(),
    );
  }
  
  bool get isCoach => sender == Sender.coach;
}