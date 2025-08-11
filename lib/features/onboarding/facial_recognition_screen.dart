import 'package:flutter/material.dart';
import '../payment/plan_selection_screen.dart';

/// Pantalla de reconocimiento facial (obligatorio nivel 2+)
class FacialRecognitionScreen extends StatefulWidget {
  final String language;
  
  const FacialRecognitionScreen({
    super.key,
    required this.language,
  });

  @override
  State<FacialRecognitionScreen> createState() => _FacialRecognitionScreenState();
}

class _FacialRecognitionScreenState extends State<FacialRecognitionScreen> 
    with SingleTickerProviderStateMixin {
  bool _isScanning = false;
  bool _scanCompleted = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'title': 'Verificación Facial',
      'subtitle': 'Para tu seguridad, necesitamos verificar tu identidad',
      'description': 'El reconocimiento facial previene cuentas múltiples y fraude. Tus datos biométricos están protegidos y encriptados.',
      'instructions': 'Instrucciones:',
      'step1': '• Mantén tu rostro centrado en el círculo',
      'step2': '• Asegúrate de tener buena iluminación',
      'step3': '• No uses lentes oscuros o máscaras',
      'step4': '• Mantente quieto durante el escaneo',
      'startScan': 'Iniciar Escaneo',
      'scanning': 'Escaneando...',
      'scanComplete': '¡Verificación Completada!',
      'continue': 'Continuar',
      'privacy': 'Privacidad: Tus datos biométricos se procesan localmente y se almacenan de forma encriptada.',
    },
    'en': {
      'title': 'Facial Verification',
      'subtitle': 'For your security, we need to verify your identity',
      'description': 'Facial recognition prevents multiple accounts and fraud. Your biometric data is protected and encrypted.',
      'instructions': 'Instructions:',
      'step1': '• Keep your face centered in the circle',
      'step2': '• Make sure you have good lighting',
      'step3': '• Don\'t wear dark glasses or masks',
      'step4': '• Stay still during scanning',
      'startScan': 'Start Scan',
      'scanning': 'Scanning...',
      'scanComplete': 'Verification Complete!',
      'continue': 'Continue',
      'privacy': 'Privacy: Your biometric data is processed locally and stored encrypted.',
    },
  };

  String _getText(String key) {
    return _translations[widget.language]?[key] ?? key;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _startFacialScan() async {
    setState(() {
      _isScanning = true;
    });

    _animationController.repeat(reverse: true);

    // Simular proceso de escaneo
    await Future.delayed(const Duration(seconds: 4));

    _animationController.stop();
    _animationController.reset();

    setState(() {
      _isScanning = false;
      _scanCompleted = true;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getText('title'),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _getText('subtitle'),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              
              const SizedBox(height: 20),
              
              Text(
                _getText('description'),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Área de escaneo facial
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Círculo de escaneo
                      AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _isScanning ? _scaleAnimation.value : 1.0,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _scanCompleted 
                                      ? Colors.green 
                                      : _isScanning 
                                          ? const Color(0xFF6B46C1)
                                          : Colors.grey.shade400,
                                  width: 4,
                                ),
                                color: _scanCompleted 
                                    ? Colors.green.withOpacity(0.1)
                                    : _isScanning 
                                        ? const Color(0xFF6B46C1).withOpacity(0.1)
                                        : Colors.grey.withOpacity(0.1),
                              ),
                              child: Icon(
                                _scanCompleted 
                                    ? Icons.check_circle
                                    : Icons.face,
                                size: 80,
                                color: _scanCompleted 
                                    ? Colors.green 
                                    : _isScanning 
                                        ? const Color(0xFF6B46C1)
                                        : Colors.grey.shade400,
                              ),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Estado del escaneo
                      Text(
                        _scanCompleted 
                            ? _getText('scanComplete')
                            : _isScanning 
                                ? _getText('scanning')
                                : _getText('instructions'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _scanCompleted 
                              ? Colors.green 
                              : const Color(0xFF374151),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      if (!_isScanning && !_scanCompleted) ...[
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_getText('step1'), style: const TextStyle(fontSize: 14)),
                            const SizedBox(height: 4),
                            Text(_getText('step2'), style: const TextStyle(fontSize: 14)),
                            const SizedBox(height: 4),
                            Text(_getText('step3'), style: const TextStyle(fontSize: 14)),
                            const SizedBox(height: 4),
                            Text(_getText('step4'), style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                      
                      if (_isScanning) ...[
                        const SizedBox(height: 20),
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B46C1)),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              
              // Nota de privacidad
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.security, color: Colors.blue.shade600),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _getText('privacy'),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Botón de acción
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isScanning 
                      ? null 
                      : _scanCompleted 
                          ? () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PlanSelectionScreen(language: widget.language),
                                ),
                              );
                            }
                          : _startFacialScan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _scanCompleted 
                        ? Colors.green 
                        : const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _scanCompleted 
                        ? _getText('continue')
                        : _getText('startScan'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}