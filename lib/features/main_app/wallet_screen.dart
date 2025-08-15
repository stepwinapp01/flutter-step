import 'package:flutter/material.dart';


/// Pantalla de Wallet con gestión de tokens y retiros
class WalletScreen extends StatefulWidget {
  final String language;
  
  const WalletScreen({
    super.key,
    required this.language,
  });

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final Map<String, Map<String, String>> _translations = {
    'es': {
      'title': 'Mi Wallet',
      'balance': 'Balance Total',
      'available': 'Disponible',
      'staking': 'En Staking',
      'pending': 'Pendiente',
      'withdraw': 'Retirar',
      'deposit': 'Depositar',
      'history': 'Historial',
      'transactions': 'Transacciones Recientes',
      'noTransactions': 'No hay transacciones aún',
      'swt': 'SWT Tokens',
      'usdt': 'USDT',
      'usdc': 'USDC',
      'exchange': 'Cambiar Tokens',
    },
    'en': {
      'title': 'My Wallet',
      'balance': 'Total Balance',
      'available': 'Available',
      'staking': 'Staking',
      'pending': 'Pending',
      'withdraw': 'Withdraw',
      'deposit': 'Deposit',
      'history': 'History',
      'transactions': 'Recent Transactions',
      'noTransactions': 'No transactions yet',
      'swt': 'SWT Tokens',
      'usdt': 'USDT',
      'usdc': 'USDC',
      'exchange': 'Exchange Tokens',
    },
  };

  String _getText(String key) {
    return _translations[widget.language]?[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          _getText('title'),
          style: const TextStyle(
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
            // Balance principal
            _buildBalanceCard(),
            const SizedBox(height: 24),
            
            // Tokens disponibles
            _buildTokensSection(),
            const SizedBox(height: 24),
            
            // Botones de acción
            _buildActionButtons(),
            const SizedBox(height: 24),
            
            // Historial de transacciones
            _buildTransactionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6B46C1), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B46C1).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getText('balance'),
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$1,247.50',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildBalanceItem(
                  _getText('available'),
                  '\$847.50',
                  Icons.account_balance_wallet,
                ),
              ),
              Expanded(
                child: _buildBalanceItem(
                  _getText('staking'),
                  '\$350.00',
                  Icons.trending_up,
                ),
              ),
              Expanded(
                child: _buildBalanceItem(
                  _getText('pending'),
                  '\$50.00',
                  Icons.schedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String label, String amount, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.8),
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTokensSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mis Tokens',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            _buildTokenCard('SWT', '2,450', '🪙', const Color(0xFF6B46C1)),
            const SizedBox(height: 12),
            _buildTokenCard('USDT', '847.50', '💵', const Color(0xFF10B981)),
            const SizedBox(height: 12),
            _buildTokenCard('USDC', '400.00', '💰', const Color(0xFF3B82F6)),
          ],
        ),
      ],
    );
  }

  Widget _buildTokenCard(String symbol, String amount, String emoji, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              _showExchangeDialog();
            },
            icon: const Icon(Icons.swap_horiz),
            label: Text(_getText('exchange')),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implementar retiro
            },
            icon: const Icon(Icons.arrow_upward),
            label: Text(_getText('withdraw')),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6B46C1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _getText('transactions'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Ver historial completo
              },
              child: Text(_getText('history')),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTransactionsList(),
      ],
    );
  }

  Widget _buildTransactionsList() {
    final transactions = [
      {'type': 'reward', 'amount': '+25.50', 'description': 'Recompensa diaria', 'date': 'Hoy'},
      {'type': 'staking', 'amount': '+12.30', 'description': 'Staking rewards', 'date': 'Ayer'},
      {'type': 'withdraw', 'amount': '-100.00', 'description': 'Retiro USDT', 'date': '2 días'},
    ];

    if (transactions.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              _getText('noTransactions'),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: transactions.map((transaction) => _buildTransactionItem(transaction)).toList(),
    );
  }

  Widget _buildTransactionItem(Map<String, String> transaction) {
    IconData icon;
    Color color;
    
    switch (transaction['type']) {
      case 'reward':
        icon = Icons.stars;
        color = const Color(0xFF10B981);
        break;
      case 'staking':
        icon = Icons.trending_up;
        color = const Color(0xFF3B82F6);
        break;
      case 'withdraw':
        icon = Icons.arrow_upward;
        color = const Color(0xFFEF4444);
        break;
      default:
        icon = Icons.swap_horiz;
        color = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['description']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  transaction['date']!,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            transaction['amount']!,
            style: TextStyle(
              color: transaction['amount']!.startsWith('+') ? color : const Color(0xFFEF4444),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showExchangeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_getText('exchange')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Cambiar SWT Tokens por USDT/USDC'),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cantidad SWT',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.number,
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
                const SnackBar(content: Text('Intercambio procesado')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
            ),
            child: const Text('Cambiar'),
          ),
        ],
      ),
    );
  }
}