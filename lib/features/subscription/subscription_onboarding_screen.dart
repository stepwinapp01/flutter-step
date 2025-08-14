import 'package:flutter/material.dart';
import '../levels/levels_system_screen.dart';
import '../onboarding/onboarding_flow.dart';

/// Pantalla de suscripción obligatoria en el onboarding
class SubscriptionOnboardingScreen extends StatefulWidget {
  const SubscriptionOnboardingScreen({super.key});

  @override
  State<SubscriptionOnboardingScreen> createState() => _SubscriptionOnboardingScreenState();
}

class _SubscriptionOnboardingScreenState extends State<SubscriptionOnboardingScreen> {
  int _selectedPlan = 1; // 0: Básico, 1: Pro, 2: Elite
  int _selectedPayment = 0; // 0: Tarjeta, 1: USDT, 2: USDC

  final List<Map<String, dynamic>> plans = [
    {
      'title': 'Básico',
      'price': '\$11',
      'period': '/mes',
      'color': Color(0xFF10B981),
      'features': [
        'Acceso a ejercicios básicos',
        'Seguimiento de progreso',
        'Chat con Coach Adán',
        'Comunidad básica',
        'Hasta 5 tokens/día',
      ],
      'isPopular': false,
    },
    {
      'title': 'Pro',
      'price': '\$18',
      'period': '/mes',
      'color': Color(0xFF3B82F6),
      'features': [
        'Todo lo del plan Básico',
        'Planes personalizados',
        'Análisis avanzado',
        'Soporte prioritario',
        'Hasta 15 tokens/día',
        'Acceso a eventos exclusivos',
      ],
      'isPopular': true,
    },
    {
      'title': 'Elite',
      'price': '\$25',
      'period': '/mes',
      'color': Color(0xFFF59E0B),
      'features': [
        'Todo lo del plan Pro',
        'Coach personal 1:1',
        'Nutrición personalizada',
        'Acceso VIP a la comunidad',
        'Hasta 20 tokens/día',
        'Recompensas exclusivas',
        'Análisis biométrico',
      ],
      'isPopular': false,
    },
  ];

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'icon': '💳',
      'title': 'Tarjeta de Crédito/Débito',
      'subtitle': 'Visa, Mastercard, American Express',
      'description': 'Pago seguro con tu tarjeta bancaria',
    },
    {
      'icon': '💰',
      'title': 'USDT (Tether)',
      'subtitle': 'Criptomoneda estable',
      'description': 'Pago con Tether en red TRC20 o ERC20',
    },
    {
      'icon': '🪙',
      'title': 'USDC (USD Coin)',
      'subtitle': 'Criptomoneda respaldada por USD',
      'description': 'Pago con USD Coin en múltiples redes',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2937),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    '🚀 ¡Bienvenido a Step Win!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Elige tu plan para comenzar tu transformación',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Planes de suscripción
                    ...plans.asMap().entries.map((entry) {
                      final index = entry.key;
                      final plan = entry.value;
                      return _buildPlanCard(index, plan);
                    }),
                    
                    const SizedBox(height: 30),
                    
                    // Métodos de pago
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '💳 Método de Pago',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          ...paymentMethods.asMap().entries.map((entry) {
                            final index = entry.key;
                            final method = entry.value;
                            return _buildPaymentOption(index, method);
                          }),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Botón de continuar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _processPurchase,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: plans[_selectedPlan]['color'],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Continuar con ${plans[_selectedPlan]['title']} - ${plans[_selectedPlan]['price']}/mes',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Términos
                    Text(
                      'Al continuar aceptas nuestros términos de servicio y política de privacidad. Puedes cancelar en cualquier momento.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(int index, Map<String, dynamic> plan) {
    final isSelected = _selectedPlan == index;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? plan['color'] : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (plan['isPopular'])
              Positioned(
                top: 0,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: plan['color'],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'MÁS POPULAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isSelected ? plan['color'] : Colors.grey.shade300,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? plan['color'] : Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white, size: 14)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        plan['title'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? plan['color'] : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        plan['price'],
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? plan['color'] : Colors.black,
                        ),
                      ),
                      Text(
                        plan['period'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  ...plan['features'].map<Widget>((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: isSelected ? plan['color'] : Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(int index, Map<String, dynamic> method) {
    final isSelected = _selectedPayment == index;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? Colors.white.withOpacity(0.2) 
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? Colors.white 
                : Colors.white.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Color(0xFF1F2937), size: 14)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              method['icon'],
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    method['subtitle'],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _processPurchase() {
    final selectedPlan = plans[_selectedPlan];
    final selectedPayment = paymentMethods[_selectedPayment];
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Text(selectedPayment['icon'], style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Procesando Pago',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Plan: ${selectedPlan['title']} ${selectedPlan['price']}/mes'),
            const SizedBox(height: 8),
            Text('Método: ${selectedPayment['title']}'),
            const SizedBox(height: 16),
            if (_selectedPayment > 0) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dirección de pago:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'TQn9Y2khEsLMWD5uPAaYs889SuM5AbRiEX',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Monto: ${selectedPlan['price'].substring(1)} ${_selectedPayment == 1 ? 'USDT' : 'USDC'}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            const Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Expanded(
                  child: Text('Verificando pago...'),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // Simular procesamiento de pago
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); // Cerrar diálogo de procesamiento
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 32),
              SizedBox(width: 12),
              Text('¡Pago Exitoso!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Has activado el plan ${selectedPlan['title']} exitosamente.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                '¡Ahora conoce nuestro sistema de niveles!',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar diálogo
                  OnboardingFlow.goToLevelsSystem(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedPlan['color'],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Ver Sistema de Niveles'),
              ),
            ),
          ],
        ),
      );
    });
  }
}