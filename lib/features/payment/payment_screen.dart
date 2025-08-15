import 'package:flutter/material.dart';
import '../main_app/main_tabs_screen.dart';

/// Pantalla de pago con múltiples métodos
class PaymentScreen extends StatefulWidget {
  final String language;
  final Map<String, dynamic> selectedPlan;
  
  const PaymentScreen({
    super.key,
    required this.language,
    required this.selectedPlan,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = 'stripe';
  bool _isProcessing = false;

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'title': 'Método de Pago',
      'subtitle': 'Selecciona cómo quieres pagar tu suscripción',
      'planSelected': 'Plan seleccionado:',
      'paymentMethods': 'Métodos de pago',
      'creditCard': 'Tarjeta de Crédito/Débito',
      'cryptoUSDT': 'USDT (TRC20)',
      'cryptoUSDC': 'USDC (TRC20)',
      'securePayment': 'Pago seguro con Stripe',
      'cryptoPayment': 'Pago con criptomonedas',
      'instantPayment': 'Pago instantáneo',
      'processing': 'Procesando pago...',
      'payNow': 'Pagar Ahora',
      'total': 'Total:',
      'monthly': '/mes',
    },
    'en': {
      'title': 'Payment Method',
      'subtitle': 'Select how you want to pay for your subscription',
      'planSelected': 'Selected plan:',
      'paymentMethods': 'Payment methods',
      'creditCard': 'Credit/Debit Card',
      'cryptoUSDT': 'USDT (TRC20)',
      'cryptoUSDC': 'USDC (TRC20)',
      'securePayment': 'Secure payment with Stripe',
      'cryptoPayment': 'Cryptocurrency payment',
      'instantPayment': 'Instant payment',
      'processing': 'Processing payment...',
      'payNow': 'Pay Now',
      'total': 'Total:',
      'monthly': '/month',
    },
  };

  String _getText(String key) {
    return _translations[widget.language]?[key] ?? key;
  }

  void _processPayment() async {
    setState(() {
      _isProcessing = true;
    });

    // Simular procesamiento de pago
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      // Mostrar éxito y navegar a la app principal
      _showPaymentSuccess();
    }
  }

  void _showPaymentSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '¡Pago Exitoso!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Tu suscripción ${widget.selectedPlan['name']} está activa',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MainTabsScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Comenzar'),
              ),
            ),
          ],
        ),
      ),
    );
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
        title: Text(
          _getText('title'),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getText('subtitle'),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Plan seleccionado
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(widget.selectedPlan['color']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(widget.selectedPlan['color']).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getText('planSelected'),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.selectedPlan['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(widget.selectedPlan['color']),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _getText('total'),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$${widget.selectedPlan['price'].toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  Text(
                                    _getText('monthly'),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    Text(
                      _getText('paymentMethods'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Métodos de pago
                    _buildPaymentMethod(
                      'stripe',
                      _getText('creditCard'),
                      _getText('securePayment'),
                      Icons.credit_card,
                      Colors.blue,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    _buildPaymentMethod(
                      'usdt',
                      _getText('cryptoUSDT'),
                      _getText('cryptoPayment'),
                      Icons.currency_bitcoin,
                      Colors.green,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    _buildPaymentMethod(
                      'usdc',
                      _getText('cryptoUSDC'),
                      _getText('instantPayment'),
                      Icons.account_balance_wallet,
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
            
            // Botón de pago
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _processPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isProcessing
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(_getText('processing')),
                          ],
                        )
                      : Text(
                          '${_getText('payNow')} \$${widget.selectedPlan['price'].toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(
    String id,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    final isSelected = selectedPaymentMethod == id;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}