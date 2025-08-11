/// Modelo que representa un mensaje en el chat
/// 
/// Contiene toda la información necesaria para mostrar un mensaje
/// incluyendo identificador, tipo de emisor, contenido y timestamp
class ChatMessage {
  /// Identificador único del mensaje
  final String id;
  
  /// Indica si el mensaje fue enviado por el coach (true) o usuario (false)
  final bool isCoach;
  
  /// Contenido del mensaje
  final String message;
  
  /// Fecha y hora de creación del mensaje
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.isCoach,
    required this.message,
    required this.timestamp,
  });

  /// Factory constructor para crear un mensaje de usuario
  /// 
  /// [message] El contenido del mensaje del usuario
  /// Genera automáticamente el ID y timestamp
  factory ChatMessage.user({
    required String message,
  }) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      isCoach: false,
      message: message,
      timestamp: DateTime.now(),
    );
  }

  /// Factory constructor para crear un mensaje del coach
  /// 
  /// [message] El contenido de la respuesta del coach
  /// Genera automáticamente el ID y timestamp
  factory ChatMessage.coach({
    required String message,
  }) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      isCoach: true,
      message: message,
      timestamp: DateTime.now(),
    );
  }
}