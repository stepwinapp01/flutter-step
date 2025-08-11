import '../models/user_model.dart';
import '../models/health_goal_model.dart';
import 'validation_service.dart';
import 'coach_ai_service.dart';
import 'staking_service.dart';

/// Servicio de datos mock para toda la aplicación
class MockDataService {
  // Usuario actual mock
  static UserModel get currentUser => UserModel(
    uid: 'user_123',
    email: 'usuario@stepwin.com',
    name: 'Juan Pérez',
    photoUrl: 'https://via.placeholder.com/150',
    level: 3,
    plan: 'pro',
    tokenBalance: 1250.50,
    kycVerified: false,
    facialRecognitionDone: true,
    language: 'es',
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    lastActive: DateTime.now(),
    teamCode: 'TEAM123',
    connectedDevices: {
      'google_fit': true,
      'fitbit': false,
      'apple_health': false,
      'garmin': false,
    },
  );

  // Metas de salud de hoy
  static HealthGoalModel get todayGoals => HealthGoalModel(
    id: 'goal_today',
    userId: 'user_123',
    date: DateTime.now(),
    steps: 7500,
    targetSteps: 10000,
    sleepHours: 6.5,
    targetSleepHours: 7.0,
    waterLiters: 1.5,
    targetWaterLiters: 2.0,
    meditationMinutes: 5,
    targetMeditationMinutes: 10,
    coachSessionCompleted: false,
    tokensEarned: 125.0,
    isCompleted: false,
  );

  // Planes de suscripción
  static List<Map<String, dynamic>> get subscriptionPlans => [
    {
      'id': 'basic',
      'name': 'Básico',
      'price': 10.0,
      'currency': 'USD',
      'features': [
        'Seguimiento básico de pasos',
        'Metas diarias simples',
        'Chat con Coach Adán (5 mensajes/día)',
        'Retiro mínimo: 50 USDT',
      ],
      'color': 0xFF9CA3AF,
    },
    {
      'id': 'pro',
      'name': 'Pro',
      'price': 15.0,
      'currency': 'USD',
      'features': [
        'Seguimiento completo de salud',
        'Conexión con dispositivos',
        'Chat ilimitado con Coach Adán',
        'Feed del equipo',
        'Retiro mínimo: 25 USDT',
      ],
      'color': 0xFF6B46C1,
      'popular': true,
    },
    {
      'id': 'elite',
      'name': 'Élite',
      'price': 20.0,
      'currency': 'USD',
      'features': [
        'Todo lo de Pro +',
        'Análisis avanzado de datos',
        'Coaching personalizado',
        'Recompensas premium',
        'Retiro mínimo: 10 USDT',
        'Sin comisiones de retiro',
      ],
      'color': 0xFFD97706,
    },
  ];

  // Niveles del sistema
  static List<Map<String, dynamic>> get levels => [
    {'level': 1, 'name': 'Principiante', 'minSteps': 5000, 'teamSize': 0, 'withdrawLimit': 100},
    {'level': 2, 'name': 'Caminante', 'minSteps': 7000, 'teamSize': 2, 'withdrawLimit': 200},
    {'level': 3, 'name': 'Activo', 'minSteps': 8000, 'teamSize': 5, 'withdrawLimit': 300},
    {'level': 4, 'name': 'Atleta', 'minSteps': 10000, 'teamSize': 8, 'withdrawLimit': 500},
    {'level': 5, 'name': 'Experto', 'minSteps': 12000, 'teamSize': 12, 'withdrawLimit': 750},
    {'level': 6, 'name': 'Maestro', 'minSteps': 15000, 'teamSize': 15, 'withdrawLimit': 1000},
    {'level': 7, 'name': 'Leyenda', 'minSteps': 18000, 'teamSize': 20, 'withdrawLimit': 1500},
    {'level': 8, 'name': 'Campeón', 'minSteps': 20000, 'teamSize': 25, 'withdrawLimit': 2000},
    {'level': 9, 'name': 'Élite', 'minSteps': 25000, 'teamSize': 30, 'withdrawLimit': 3000},
    {'level': 10, 'name': 'Inmortal', 'minSteps': 30000, 'teamSize': 50, 'withdrawLimit': 5000},
  ];

  // Feed del equipo
  static List<Map<String, dynamic>> get teamFeed => [
    {
      'id': 'post_1',
      'userId': 'user_456',
      'userName': 'María García',
      'userPhoto': 'https://via.placeholder.com/50',
      'content': '¡Completé mis 10,000 pasos hoy! 🚶‍♀️',
      'image': 'https://via.placeholder.com/300x200',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'likes': 12,
      'comments': 3,
      'achievement': 'steps_goal',
    },
    {
      'id': 'post_2',
      'userId': 'user_789',
      'userName': 'Carlos López',
      'userPhoto': 'https://via.placeholder.com/50',
      'content': 'Sesión de meditación matutina completada ✨',
      'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
      'likes': 8,
      'comments': 1,
      'achievement': 'meditation_goal',
    },
  ];

  // Historial de retiros
  static List<Map<String, dynamic>> get withdrawalHistory => [
    {
      'id': 'withdrawal_1',
      'amount': 50.0,
      'currency': 'USDT',
      'status': 'completed',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'txHash': '0x1234...abcd',
      'fee': 1.5,
    },
    {
      'id': 'withdrawal_2',
      'amount': 25.0,
      'currency': 'USDC',
      'status': 'pending',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'fee': 0.75,
    },
  ];

  // Dispositivos conectables
  static List<Map<String, dynamic>> get availableDevices => [
    {
      'id': 'google_fit',
      'name': 'Google Fit',
      'icon': '🏃‍♂️',
      'description': 'Sincroniza pasos, sueño y actividades',
      'required': false,
    },
    {
      'id': 'fitbit',
      'name': 'Fitbit',
      'icon': '⌚',
      'description': 'Datos completos de salud y fitness',
      'required': true, // Requerido para nivel 3+
    },
    {
      'id': 'apple_health',
      'name': 'Apple Health',
      'icon': '🍎',
      'description': 'Integración completa con iOS',
      'required': false,
    },
    {
      'id': 'garmin',
      'name': 'Garmin Connect',
      'icon': '📱',
      'description': 'Datos profesionales de entrenamiento',
      'required': false,
    },
  ];

  // Respuestas del Coach Adán
  static List<String> get coachResponses => [
    '¡Excelente progreso! Mantén ese ritmo constante para alcanzar tus metas.',
    'Recuerda hidratarte bien durante el día. El agua es fundamental para tu rendimiento.',
    'El descanso es tan importante como el ejercicio. Intenta dormir 7-8 horas.',
    'La meditación te ayudará a mantener el equilibrio mental. ¿Has probado 5 minutos al despertar?',
    'Cada paso cuenta hacia tu objetivo. ¡Sigue así!',
    'La consistencia es clave. Es mejor poco pero constante que mucho de vez en cuando.',
    'Tu cuerpo necesita variedad. Alterna entre caminar, trotar y ejercicios de fuerza.',
    'Celebra tus pequeños logros. Cada meta cumplida es un paso hacia una vida más saludable.',
  ];
  
  /// Valida edad y autorización parental (Mock)
  static ValidationResult validateUserAge(DateTime birthDate, bool parentalConsent) {
    return ValidationService.validateAge(birthDate, parentalConsent);
  }
  
  /// Verifica si requiere reconocimiento facial
  static bool requiresFacialRecognition(int level) {
    return ValidationService.requiresFacialRecognition(level);
  }
  
  /// Valida subida de nivel
  static ValidationResult validateLevelUp(int currentLevel, String plan) {
    const activeUsers = 150; // Mock: usuarios activos simulados
    return ValidationService.validateLevelUp(currentLevel, plan, activeUsers);
  }
  
  /// Genera mensaje motivacional del Coach IA
  static String generateCoachMessage(int level, double tokens, DateTime lastActive) {
    return CoachAIService.generateMotivationalMessage(level, tokens, lastActive);
  }
  
  /// Evalúa riesgo de retención del usuario
  static UserRetentionRisk evaluateRetentionRisk(DateTime lastActive, int level, double tokens) {
    return CoachAIService.evaluateRetentionRisk(lastActive, level, tokens);
  }
  
  /// Procesa staking de tokens
  static StakingResult processTokenStaking(double amount, int level, double currentStaked) {
    return StakingService.processStaking(amount, level, currentStaked);
  }
  
  /// Calcula recompensas diarias de staking
  static double calculateStakingRewards(double stakedAmount, int level, String plan) {
    return StakingService.calculateDailyRewards(stakedAmount, level, plan);
  }

  // Plan de fitness mock
  static Map<String, dynamic> get mockFitnessPlan => {
    'id': 'plan_123',
    'name': 'Plan Básico',
    'exercises': [
      {'name': 'Caminata', 'sets': 1, 'reps': 10000, 'duration': 60},
      {'name': 'Flexiones', 'sets': 3, 'reps': 10, 'duration': 0},
      {'name': 'Sentadillas', 'sets': 3, 'reps': 15, 'duration': 0},
    ],
  };

  // Miembros del equipo mock
  static List<UserModel> get mockTeamMembers => [
    UserModel(
      uid: 'member_1',
      email: 'maria@example.com',
      name: 'María García',
      level: 4,
      tokenBalance: 850.0,
      plan: 'pro',
      kycVerified: true,
      facialRecognitionDone: true,
      language: 'es',
      connectedDevices: const {},
      createdAt: DateTime.now(),
      lastActive: DateTime.now(),
    ),
    UserModel(
      uid: 'member_2',
      email: 'carlos@example.com',
      name: 'Carlos López',
      level: 2,
      tokenBalance: 320.0,
      plan: 'basic',
      kycVerified: false,
      facialRecognitionDone: true,
      language: 'es',
      connectedDevices: const {},
      createdAt: DateTime.now(),
      lastActive: DateTime.now(),
    ),
  ];

  // Líder del equipo mock
  static UserModel get mockLeader => UserModel(
    uid: 'leader_1',
    email: 'coach@example.com',
    name: 'Coach Elite',
    level: 15,
    tokenBalance: 5000.0,
    plan: 'elite',
    kycVerified: true,
    facialRecognitionDone: true,
    language: 'es',
    connectedDevices: const {'fitbit': true, 'garmin': true},
    createdAt: DateTime.now(),
    lastActive: DateTime.now(),
  );

  // Posts sociales mock
  static List<Map<String, dynamic>> get mockSocialPosts => [
    {
      'id': 'post_1',
      'userName': 'María García',
      'content': '¡Completé mis 10,000 pasos hoy!',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'likes': 12,
      'comments': 3,
    },
    {
      'id': 'post_2',
      'userName': 'Carlos López',
      'content': 'Nueva meta personal en meditación',
      'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
      'likes': 8,
      'comments': 1,
    },
  ];
}