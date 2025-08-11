import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Pantalla de soporte técnico con generación de tickets y chat en vivo
class TechnicalSupportScreen extends StatefulWidget {
  const TechnicalSupportScreen({super.key});

  @override
  State<TechnicalSupportScreen> createState() => _TechnicalSupportScreenState();
}

class _TechnicalSupportScreenState extends State<TechnicalSupportScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final _messageController = TextEditingController();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Técnico';
  String _selectedPriority = 'Media';
  
  final List<Map<String, dynamic>> _chatMessages = [
    {
      'isSupport': true,
      'message': '¡Hola! Soy el asistente de soporte de Step Win. ¿En qué puedo ayudarte hoy?',
      'time': DateTime.now().subtract(const Duration(minutes: 2)),
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Soporte Técnico'),
        backgroundColor: AppConstants.primaryPurple,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.chat), text: 'Chat en Vivo'),
            Tab(icon: Icon(Icons.confirmation_number), text: 'Crear Ticket'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLiveChatTab(),
          _buildCreateTicketTab(),
        ],
      ),
    );
  }

  Widget _buildLiveChatTab() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.green.shade50,
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text('Agente disponible - Tiempo de respuesta: ~2 min'),
            ],
          ),
        ),
        
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _chatMessages.length,
            itemBuilder: (context, index) {
              final message = _chatMessages[index];
              return _buildChatMessage(message);
            },
          ),
        ),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Escribe tu mensaje...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  maxLines: null,
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                onPressed: _sendChatMessage,
                backgroundColor: AppConstants.primaryPurple,
                mini: true,
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreateTicketTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Información del Usuario', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Usuario: Juan Pérez'),
                  Text('Email: usuario@stepwin.com'),
                  Text('Nivel: 3 (Despertar)'),
                  Text('Plan: Pro (\$18/mes)'),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Crear Nuevo Ticket', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  
                  const Text('Categoría *', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Técnico', child: Text('Problema Técnico')),
                      DropdownMenuItem(value: 'Pagos', child: Text('Pagos y Retiros')),
                      DropdownMenuItem(value: 'Cuenta', child: Text('Cuenta y Perfil')),
                      DropdownMenuItem(value: 'Tokens', child: Text('Tokens y Recompensas')),
                      DropdownMenuItem(value: 'Dispositivos', child: Text('Dispositivos Conectados')),
                      DropdownMenuItem(value: 'Otro', child: Text('Otro')),
                    ],
                    onChanged: (value) => setState(() => _selectedCategory = value!),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  const Text('Prioridad *', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedPriority,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Baja', child: Text('🟢 Baja - No urgente')),
                      DropdownMenuItem(value: 'Media', child: Text('🟡 Media - Respuesta en 24h')),
                      DropdownMenuItem(value: 'Alta', child: Text('🟠 Alta - Respuesta en 4h')),
                      DropdownMenuItem(value: 'Crítica', child: Text('🔴 Crítica - Respuesta inmediata')),
                    ],
                    onChanged: (value) => setState(() => _selectedPriority = value!),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  const Text('Asunto *', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      hintText: 'Describe brevemente el problema',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  const Text('Descripción detallada *', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Explica el problema con el mayor detalle posible...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    maxLines: 5,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _createTicket,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        'Crear Ticket',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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

  Widget _buildChatMessage(Map<String, dynamic> message) {
    final isSupport = message['isSupport'] as bool;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isSupport ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isSupport) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppConstants.primaryPurple,
              child: const Icon(Icons.support_agent, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSupport ? Colors.grey.shade200 : AppConstants.primaryPurple,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['message'],
                    style: TextStyle(
                      color: isSupport ? Colors.black87 : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message['time']),
                    style: TextStyle(
                      fontSize: 12,
                      color: isSupport ? Colors.grey.shade600 : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isSupport) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white, size: 16),
            ),
          ],
        ],
      ),
    );
  }

  void _sendChatMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _chatMessages.add({
        'isSupport': false,
        'message': _messageController.text.trim(),
        'time': DateTime.now(),
      });
    });
    
    _messageController.clear();
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _chatMessages.add({
            'isSupport': true,
            'message': 'Gracias por tu mensaje. Un agente revisará tu consulta y te responderá en breve.',
            'time': DateTime.now(),
          });
        });
      }
    });
  }

  void _createTicket() {
    if (_subjectController.text.trim().isEmpty || _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos obligatorios')),
      );
      return;
    }
    
    final ticketId = 'SW${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('✅ Ticket Creado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tu ticket ha sido creado exitosamente.'),
            const SizedBox(height: 8),
            Text('ID del Ticket: $ticketId', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Categoría: $_selectedCategory'),
            Text('Prioridad: $_selectedPriority'),
            const SizedBox(height: 8),
            const Text('Recibirás una respuesta por email según la prioridad seleccionada.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _clearForm();
            },
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    _subjectController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedCategory = 'Técnico';
      _selectedPriority = 'Media';
    });
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}