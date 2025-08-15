import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage.coach(
      message: '¡Hola! Soy Coach Adán, tu entrenador personal. ¿En qué puedo ayudarte hoy?',
    ),
  ];

  List<ChatMessage> get messages => _messages;

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
    
    if (message.sender == Sender.user) {
      Future.delayed(const Duration(seconds: 2), () {
        _sendCoachResponse(message.message);
      });
    }
  }
  
  void sendUserMessage(String message) {
    addMessage(ChatMessage.user(message: message));
  }

  void _sendCoachResponse(String userMessage) {
    String response = _generateResponse(userMessage);
    addMessage(ChatMessage.coach(message: response));
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