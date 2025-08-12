import 'package:flutter/material.dart';
import '../levels/levels_system_screen.dart';

/// Pantalla de configuración con todas las opciones
class SettingsScreen extends StatefulWidget {
  final String language;
  
  const SettingsScreen({
    super.key,
    required this.language,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool biometricAuth = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF6B46C1),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Perfil
            _buildSection(
              'Perfil',
              [
                _buildProfileTile(),
                _buildSettingsTile(
                  Icons.edit,
                  'Editar Perfil',
                  'Cambiar datos personales',
                  () => _showEditProfile(),
                ),
                _buildSettingsTile(
                  Icons.camera_alt,
                  'Foto de Perfil',
                  'Cambiar imagen de perfil',
                  () => _showChangePhoto(),
                ),
              ],
            ),
            
            // Sistema de Niveles
            _buildSection(
              'Sistema de Niveles',
              [
                _buildSettingsTile(
                  Icons.emoji_events,
                  'Ver Niveles',
                  'Conoce los 10 niveles de transformación',
                  () => _showLevelsSystem(),
                ),
                _buildSettingsTile(
                  Icons.trending_up,
                  'Mi Progreso',
                  'Nivel actual: Semilla - Suscripción \$11',
                  () => _showMyProgress(),
                ),
              ],
            ),
            
            // Apariencia
            _buildSection(
              'Apariencia',
              [
                _buildSwitchTile(
                  Icons.dark_mode,
                  'Modo Oscuro',
                  'Cambiar tema de la aplicación',
                  isDarkMode,
                  (value) => setState(() => isDarkMode = value),
                ),
              ],
            ),
            
            // Seguridad
            _buildSection(
              'Seguridad',
              [
                _buildSwitchTile(
                  Icons.fingerprint,
                  'Autenticación Biométrica',
                  'Usar huella o reconocimiento facial',
                  biometricAuth,
                  (value) => setState(() => biometricAuth = value),
                ),
                _buildSettingsTile(
                  Icons.face,
                  'Reconocimiento Facial',
                  'Configurar reconocimiento facial',
                  () => _showFaceRecognition(),
                ),
                _buildSettingsTile(
                  Icons.lock,
                  'Cambiar PIN',
                  'Modificar código de seguridad',
                  () => _showChangePin(),
                ),
              ],
            ),
            
            // Dispositivos
            _buildSection(
              'Dispositivos',
              [
                _buildSettingsTile(
                  Icons.watch,
                  'Conectar Dispositivos',
                  'Smartwatch, pulseras, etc.',
                  () => _showDeviceConnection(),
                ),
                _buildSettingsTile(
                  Icons.bluetooth,
                  'Dispositivos Conectados',
                  'Ver y gestionar conexiones',
                  () => _showConnectedDevices(),
                ),
              ],
            ),
            
            // Notificaciones
            _buildSection(
              'Notificaciones',
              [
                _buildSwitchTile(
                  Icons.notifications,
                  'Notificaciones Push',
                  'Recibir alertas y recordatorios',
                  notifications,
                  (value) => setState(() => notifications = value),
                ),
              ],
            ),
            
            // Soporte
            _buildSection(
              'Soporte',
              [
                _buildSettingsTile(
                  Icons.support_agent,
                  'Atención al Usuario',
                  'Chat y tickets de soporte',
                  () => _showSupport(),
                ),
                _buildSettingsTile(
                  Icons.help,
                  'Ayuda y FAQ',
                  'Preguntas frecuentes',
                  () => _showHelp(),
                ),
                _buildSettingsTile(
                  Icons.info,
                  'Acerca de',
                  'Versión y información de la app',
                  () => _showAbout(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildProfileTile() {
    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
        backgroundColor: Color(0xFF6B46C1),
        child: Text(
          'U',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: const Text(
        'Usuario Demo',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: const Text('usuario@stepwin.com'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showEditProfile(),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF6B46C1).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF6B46C1), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF6B46C1).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF6B46C1), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF6B46C1),
      ),
    );
  }

  void _showEditProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Editar Perfil',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Fecha de Nacimiento',
                  border: OutlineInputBorder(),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Perfil actualizado')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Guardar Cambios'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangePhoto() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Cambiar Foto de Perfil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tomar Foto'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Foto tomada (Mock)')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Elegir de Galería'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Foto seleccionada (Mock)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFaceRecognition() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FaceRecognitionScreen(),
      ),
    );
  }

  void _showChangePin() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cambiar PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'PIN Actual',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              maxLength: 4,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nuevo PIN',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              maxLength: 4,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Confirmar PIN',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              maxLength: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PIN actualizado exitosamente')),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showDeviceConnection() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DeviceConnectionScreen(),
      ),
    );
  }

  void _showConnectedDevices() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dispositivos Conectados'),
        content: const Text('No hay dispositivos conectados'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SupportScreen(),
      ),
    );
  }

  void _showHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ayuda'),
        content: const Text('Sección de ayuda en desarrollo'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Acerca de Step Win'),
        content: const Text('Versión 1.0.0\n\nTransforma tus pasos en recompensas reales'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLevelsSystem() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LevelsSystemScreen(),
      ),
    );
  }

  void _showMyProgress() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.emoji_events, color: Color(0xFF10B981)),
            SizedBox(width: 12),
            Text('Mi Progreso'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nivel Actual: Semilla',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Suscripción: \$11 USD'),
            const Text('Miembros activos: 0'),
            const Text('Ganancia mensual: \$0'),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.1,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
            const SizedBox(height: 16),
            const Text(
              'Próximo nivel: Explorador',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Necesitas 3 miembros activos'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showLevelsSystem();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
            ),
            child: const Text('Ver Todos los Niveles'),
          ),
        ],
      ),
    );
  }
}

// Pantalla de reconocimiento facial
class FaceRecognitionScreen extends StatefulWidget {
  const FaceRecognitionScreen({super.key});

  @override
  State<FaceRecognitionScreen> createState() => _FaceRecognitionScreenState();
}

class _FaceRecognitionScreenState extends State<FaceRecognitionScreen> {
  bool isScanning = false;
  bool isConfigured = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reconocimiento Facial'),
        backgroundColor: const Color(0xFF6B46C1),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isScanning ? Colors.green : const Color(0xFF6B46C1),
                        width: 4,
                      ),
                    ),
                    child: Icon(
                      Icons.face,
                      size: 100,
                      color: isScanning ? Colors.green : const Color(0xFF6B46C1),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    isConfigured ? 'Reconocimiento Configurado' : 'Configurar Reconocimiento Facial',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isConfigured 
                        ? 'Tu rostro ha sido registrado exitosamente'
                        : 'Posiciona tu rostro en el círculo y mantente quieto',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  if (isScanning) ...[
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    const Text('Escaneando...'),
                  ],
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isConfigured ? null : _startFaceScan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  isConfigured ? 'Configurado ✓' : (isScanning ? 'Escaneando...' : 'Iniciar Escaneo'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startFaceScan() {
    setState(() => isScanning = true);
    
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isScanning = false;
        isConfigured = true;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reconocimiento facial configurado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }
}

// Pantalla de conexión de dispositivos
class DeviceConnectionScreen extends StatefulWidget {
  const DeviceConnectionScreen({super.key});

  @override
  State<DeviceConnectionScreen> createState() => _DeviceConnectionScreenState();
}

class _DeviceConnectionScreenState extends State<DeviceConnectionScreen> {
  bool isScanning = false;
  List<Map<String, dynamic>> availableDevices = [];
  List<String> connectedDevices = [];

  final List<Map<String, dynamic>> mockDevices = [
    {'name': 'Apple Watch Series 8', 'type': 'watch', 'battery': 85, 'icon': Icons.watch},
    {'name': 'Fitbit Charge 5', 'type': 'band', 'battery': 92, 'icon': Icons.fitness_center},
    {'name': 'Samsung Galaxy Watch', 'type': 'watch', 'battery': 67, 'icon': Icons.watch},
    {'name': 'Xiaomi Mi Band 7', 'type': 'band', 'battery': 78, 'icon': Icons.fitness_center},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conectar Dispositivos'),
        backgroundColor: const Color(0xFF6B46C1),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _scanForDevices,
            icon: Icon(isScanning ? Icons.stop : Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          if (connectedDevices.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Dispositivos Conectados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...connectedDevices.map((device) => _buildConnectedDevice(device)),
            const Divider(),
          ],
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dispositivos Disponibles',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (isScanning) const CircularProgressIndicator(),
              ],
            ),
          ),
          Expanded(
            child: availableDevices.isEmpty && !isScanning
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bluetooth_searching, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Toca el botón de búsqueda para escanear dispositivos'),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: availableDevices.length,
                    itemBuilder: (context, index) {
                      final device = availableDevices[index];
                      return _buildAvailableDevice(device);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedDevice(String deviceName) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(deviceName),
        subtitle: const Text('Conectado'),
        trailing: TextButton(
          onPressed: () => _disconnectDevice(deviceName),
          child: const Text('Desconectar'),
        ),
      ),
    );
  }

  Widget _buildAvailableDevice(Map<String, dynamic> device) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(device['icon'], color: const Color(0xFF6B46C1)),
        title: Text(device['name']),
        subtitle: Text('Batería: ${device['battery']}%'),
        trailing: ElevatedButton(
          onPressed: () => _connectDevice(device['name']),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6B46C1),
            foregroundColor: Colors.white,
          ),
          child: const Text('Conectar'),
        ),
      ),
    );
  }

  void _scanForDevices() {
    setState(() {
      isScanning = true;
      availableDevices.clear();
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        availableDevices = List.from(mockDevices);
        isScanning = false;
      });
    });
  }

  void _connectDevice(String deviceName) {
    setState(() {
      connectedDevices.add(deviceName);
      availableDevices.removeWhere((device) => device['name'] == deviceName);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$deviceName conectado exitosamente'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _disconnectDevice(String deviceName) {
    setState(() {
      connectedDevices.remove(deviceName);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$deviceName desconectado'),
      ),
    );
  }
}

// Pantalla de soporte
class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _ticketController = TextEditingController();
  List<Map<String, String>> chatMessages = [];
  List<Map<String, String>> tickets = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadMockData();
  }

  void _loadMockData() {
    chatMessages = [
      {'sender': 'support', 'message': '¡Hola! ¿En qué puedo ayudarte hoy?', 'time': '10:30'},
    ];
    tickets = [
      {'id': '#001', 'title': 'Problema con tokens', 'status': 'Abierto', 'date': '2024-01-15'},
      {'id': '#002', 'title': 'Error en la app', 'status': 'Resuelto', 'date': '2024-01-10'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atención al Usuario'),
        backgroundColor: const Color(0xFF6B46C1),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Chat en Vivo'),
            Tab(text: 'Mis Tickets'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatTab(),
          _buildTicketsTab(),
        ],
      ),
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: chatMessages.length,
            itemBuilder: (context, index) {
              final message = chatMessages[index];
              final isUser = message['sender'] == 'user';
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser ? const Color(0xFF6B46C1) : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message['message']!,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message['time']!,
                        style: TextStyle(
                          fontSize: 10,
                          color: isUser ? Colors.white70 : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Escribe tu mensaje...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _sendMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                ),
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTicketsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: _createTicket,
            icon: const Icon(Icons.add),
            label: const Text('Crear Nuevo Ticket'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6B46C1),
              foregroundColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return Card(
                child: ListTile(
                  leading: Icon(
                    ticket['status'] == 'Resuelto' ? Icons.check_circle : Icons.schedule,
                    color: ticket['status'] == 'Resuelto' ? Colors.green : Colors.orange,
                  ),
                  title: Text(ticket['title']!),
                  subtitle: Text('${ticket['id']} • ${ticket['date']}'),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ticket['status'] == 'Resuelto' ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      ticket['status']!,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      chatMessages.add({
        'sender': 'user',
        'message': _messageController.text,
        'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
      });
    });
    
    _messageController.clear();
    
    // Simular respuesta del soporte
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        chatMessages.add({
          'sender': 'support',
          'message': 'Gracias por tu mensaje. Un agente te responderá pronto.',
          'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
        });
      });
    });
  }

  void _createTicket() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Crear Ticket'),
        content: TextField(
          controller: _ticketController,
          decoration: const InputDecoration(
            labelText: 'Describe tu problema',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_ticketController.text.trim().isNotEmpty) {
                setState(() {
                  tickets.insert(0, {
                    'id': '#${(tickets.length + 1).toString().padLeft(3, '0')}',
                    'title': _ticketController.text,
                    'status': 'Abierto',
                    'date': '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                  });
                });
                _ticketController.clear();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ticket creado exitosamente')),
                );
              }
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }
}