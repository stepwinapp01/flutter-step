import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(
      message: '¡Hola! Soy Coach Adán, tu entrenador personal. ¿En qué puedo ayudarte hoy?',
      isCoach: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  List<ChatMessage> get messages => _messages;

  void sendUserMessage(String message) {
    _messages.add(ChatMessage(
      message: message,
      isCoach: false,
      timestamp: DateTime.now(),
    ));
    notifyListeners();

    // Simular respuesta del coach
    Future.delayed(const Duration(seconds: 2), () {
      _sendCoachResponse(message);
    });
  }

  void _sendCoachResponse(String userMessage) {
    String response = _generateResponse(userMessage);
    _messages.add(ChatMessage(
      message: response,
      isCoach: true,
      timestamp: DateTime.now(),
    ));
    notifyListeners();
  }

  String _generateResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();
    
    if (lowerMessage.contains('rutina') || lowerMessage.contains('ejercicio')) {
      return 'Te recomiendo comenzar con 30 minutos de caminata diaria. Es importante mantener constancia y aumentar gradualmente la intensidad.';
    } else if (lowerMessage.contains('dieta') || lowerMessage.contains('comida')) {
      return 'Una alimentación balanceada incluye proteínas magras, vegetales, frutas y granos enteros. Evita los alimentos procesados y mantente hidratado.';
    } else if (lowerMessage.contains('motivación') || lowerMessage.contains('ánimo')) {
      return '¡Recuerda que cada paso cuenta! Establece metas pequeñas y celebra cada logro. Estoy aquí para apoyarte en tu transformación.';
    } else {
      return 'Entiendo tu consulta. Como tu coach personal, te recomiendo mantener una rutina constante de ejercicio y alimentación saludable. ¿Hay algo específico en lo que te gustaría que te ayude?';
    }
  }
}