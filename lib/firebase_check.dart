import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inicializar Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase inicializado correctamente");
  } catch (e) {
    print("❌ Error al inicializar Firebase: $e");
    return;
  }

  runApp(const FirebaseCheckApp());
}

class FirebaseCheckApp extends StatelessWidget {
  const FirebaseCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Check',
      home: Scaffold(
        appBar: AppBar(title: const Text('Firebase Check')),
        body: const Center(child: FirebaseCheckWidget()),
      ),
    );
  }
}

class FirebaseCheckWidget extends StatefulWidget {
  const FirebaseCheckWidget({super.key});

  @override
  State<FirebaseCheckWidget> createState() => _FirebaseCheckWidgetState();
}

class _FirebaseCheckWidgetState extends State<FirebaseCheckWidget> {
  String _status = 'Iniciando pruebas...';

  @override
  void initState() {
    super.initState();
    _runChecks();
  }

  Future<void> _runChecks() async {
    String result = '';

    // 1️⃣ Verificar Auth
    try {
      User? user = FirebaseAuth.instance.currentUser;
      result += '✅ Firebase Auth disponible\n';
      result += user != null
          ? 'Usuario actual: ${user.email}\n'
          : 'No hay usuario logueado\n';
    } catch (e) {
      result += '❌ Error Firebase Auth: $e\n';
    }

    // 2️⃣ Verificar Firestore
    try {
      var testDoc = FirebaseFirestore.instance.collection('test_check').doc('status');
      await testDoc.set({'timestamp': DateTime.now().toIso8601String()});
      var snapshot = await testDoc.get();
      if (snapshot.exists) {
        result += '✅ Firestore disponible y prueba OK\n';
      } else {
        result += '❌ Firestore no pudo guardar/leer el documento\n';
      }
    } catch (e) {
      result += '❌ Error Firestore: $e\n';
    }

    // Mostrar resultado en pantalla
    setState(() {
      _status = result;
    });

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Text(_status, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}