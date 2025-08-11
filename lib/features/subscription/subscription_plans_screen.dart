import 'package:flutter/material.dart';
import '../onboarding/level_terms_screen.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  State<SubscriptionPlansScreen> createState() => _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  int _selectedPlan = 1; // 0: Básico, 1: Pro, 2: Elite
  int _selectedPayment = 0; // 0: Tarjeta, 1: USDC, 2: USDT

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B46C1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Seleccionar Plan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              '🚀 Elige tu Plan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Selecciona el plan que mejor se adapte a tus objetivos',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            // Planes de suscripción
            _buildPlanCard(
              index: 0,
              title: 'Básico',
              price: '\$11',
              period: '/mes',
              features: [
                'Acceso a ejercicios básicos',
                'Seguimiento de progreso',
                'Chat con Coach Adán',
                'Comunidad básica',
              ],
              color: const Color(0xFF10B981),
              isPopular: false,
            ),
            
            _buildPlanCard(
              index: 1,
              title: 'Pro',
              price: '\$18',
              period: '/mes',
              features: [
                'Todo lo del plan Básico',
                'Planes personalizados',
                'Análisis avanzado',
                'Soporte prioritario',
                'Acceso a eventos exclusivos',
              ],
              color: const Color(0xFF3B82F6),
              isPopular: true,
            ),
            
            _buildPlanCard(
              index: 2,
              title: 'Elite',
              price: '\$25',
              period: '/mes',
              features: [
                'Todo lo del plan Pro',
                'Coach personal 1:1',
                'Nutrición personalizada',
                'Acceso VIP a la comunidad',
                'Recompensas exclusivas',
                'Análisis biométrico',
              ],
              color: const Color(0xFFF59E0B),
              isPopular: false,
            ),
            
            const SizedBox(height: 30),
            
            // Métodos de pago
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
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
                  
                  _buildPaymentOption(
                    index: 0,
                    icon: '💳',
                    title: 'Tarjeta de Crédito/Débito',
                    subtitle: 'Visa, Mastercard, American Express',
                  ),
                  
                  _buildPaymentOption(
                    index: 1,
                    icon: '🪙',
                    title: 'USDC',
                    subtitle: 'Pago con USD Coin',
                  ),
                  
                  _buildPaymentOption(
                    index: 2,
                    icon: '💰',
                    title: 'USDT',
                    subtitle: 'Pago con Tether',
                  ),
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
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6B46C1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Continuar con ${_getSelectedPlanName()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required int index,
    required String title,
    required String price,
    required String period,
    required List<String> features,
    required Color color,
    required bool isPopular,
  }) {
    final isSelected = _selectedPlan == index;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
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
            if (isPopular)
              Positioned(
                top: 0,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
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
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isSelected ? color : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? color : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? color : Colors.black,
                        ),
                      ),
                      Text(
                        period,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  ...features.map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: isSelected ? color : Colors.grey,
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
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required int index,
    required String icon,
    required String title,
    required String subtitle,
  }) {
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
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              icon,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
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

  String _getSelectedPlanName() {
    switch (_selectedPlan) {
      case 0: return 'Plan Básico';
      case 1: return 'Plan Pro';
      case 2: return 'Plan Elite';
      default: return 'Plan';
    }
  }

  void _processPurchase() {
    final planNames = ['Básico', 'Pro', 'Elite'];
    final paymentMethods = ['Tarjeta', 'USDC', 'USDT'];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 ¡Suscripción Exitosa!'),
        content: Text(
          'Has seleccionado el plan ${planNames[_selectedPlan]} con pago por ${paymentMethods[_selectedPayment]}.\n\n¡Bienvenido a Step Win Token!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar diálogo
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LevelTermsScreen(),
                ),
              );
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }
}