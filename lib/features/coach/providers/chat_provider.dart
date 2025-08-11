import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';
import '../../../core/exceptions/app_exceptions.dart';

/// Provider que maneja el estado del chat con Coach Adán
/// 
/// Gestiona la lista de mensajes, envío de mensajes de usuario
/// y generación automática de respuestas del coach
class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(
      id: 'welcome',
      isCoach: true,
      message: '¡Hola! Soy Coach Adán, tu asistente personal de salud y bienestar. Estoy aquí para ayudarte a alcanzar tus metas de forma saludable y sostenible. ¿En qué puedo ayudarte hoy?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  /// Lista inmutable de todos los mensajes del chat
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  /// Agrega un mensaje a la lista y notifica a los listeners
  /// 
  /// [message] El mensaje a agregar al chat
  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  /// Envía un mensaje del usuario y genera una respuesta automática del coach
  /// 
  /// [text] El contenido del mensaje del usuario
  /// Valida que el texto no esté vacío antes de procesar
  void sendUserMessage(String text) {
    try {
      // Validar entrada
      if (text.trim().isEmpty) {
        throw const ValidationException('errorEmptyMessage');
      }
      
      if (text.length > 500) {
        throw const ValidationException('errorMessageTooLong');
      }
      
      final userMessage = ChatMessage.user(message: text.trim());
      addMessage(userMessage);
      
      // Simular respuesta del coach con manejo de errores
      Future.delayed(const Duration(seconds: 1), () {
        try {
          final coachResponse = ChatMessage.coach(
            message: _generateCoachResponse(text),
          );
          addMessage(coachResponse);
        } catch (e) {
          final errorMessage = ChatMessage.coach(
            message: 'errorGeneratingResponse',
          );
          addMessage(errorMessage);
        }
      });
    } on ValidationException catch (e) {
      // Mostrar mensaje de error al usuario
      final errorMessage = ChatMessage.coach(
        message: e.message, // Ya contiene la clave de localización
      );
      addMessage(errorMessage);
    } catch (e) {
      // Error genérico
      final errorMessage = ChatMessage.coach(
        message: 'errorGeneric',
      );
      addMessage(errorMessage);
    }
  }

  /// Genera una respuesta automática del coach basada en el mensaje del usuario
  /// 
  /// [userMessage] El mensaje del usuario para generar contexto
  /// Throws [ChatException] si no se puede generar una respuesta
  String _generateCoachResponse(String userMessage) {
    try {
      const responses = [
        'Excelente pregunta. Te recomiendo mantener una rutina constante y escuchar a tu cuerpo.',
        'Es importante que te mantengas hidratado y descanses adecuadamente entre entrenamientos.',
        'Recuerda que la consistencia es clave. Pequeños pasos diarios te llevarán a grandes resultados.',
        'Tu progreso es único. Enfócate en mejorar día a día sin compararte con otros.',
        'La alimentación es fundamental. ¿Has considerado incluir más proteínas en tu dieta?',
      ];
      
      if (responses.isEmpty) {
        throw const ChatException('No hay respuestas disponibles');
      }
      
      return responses[DateTime.now().millisecond % responses.length];
    } catch (e) {
      throw ChatException('Error al generar respuesta: ${e.toString()}');
    }
  }
}