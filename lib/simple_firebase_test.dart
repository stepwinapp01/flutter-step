import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase inicializado correctamente");
  } catch (e) {
    print("❌ Error al inicializar Firebase: $e");
  }
  
  runApp(const SimpleFirebaseTest());
}

class SimpleFirebaseTest extends StatelessWidget {
  const SimpleFirebaseTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Test',
      home: Scaffold(
        appBar: AppBar(title: const Text('Firebase Test')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Firebase Test App'),
              SizedBox(height: 20),
              Text('Revisa la consola para ver los resultados'),
            ],
          ),
        ),
      ),
    );
  }
}