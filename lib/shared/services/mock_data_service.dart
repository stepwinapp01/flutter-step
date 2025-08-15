class MockUser {
  final String uid;
  final String name;
  final String email;
  final int level;
  final String? photoUrl;
  final String plan;
  final double tokenBalance;
  final String? teamCode;
  final DateTime lastActive;
  
  MockUser({
    required this.uid,
    required this.name, 
    required this.email, 
    required this.level,
    this.photoUrl,
    required this.plan,
    required this.tokenBalance,
    this.teamCode,
    required this.lastActive,
  });
}

class TodayGoals {
  final int steps;
  final int targetSteps;
  final double tokensEarned;
  final double sleepHours;
  final double targetSleepHours;
  final double waterLiters;
  final double targetWaterLiters;
  final int meditationMinutes;
  final int targetMeditationMinutes;
  
  TodayGoals({
    required this.steps,
    required this.targetSteps,
    required this.tokensEarned,
    required this.sleepHours,
    required this.targetSleepHours,
    required this.waterLiters,
    required this.targetWaterLiters,
    required this.meditationMinutes,
    required this.targetMeditationMinutes,
  });
}

class MockDataService {
  static MockUser currentUser = MockUser(
    uid: 'user123',
    name: 'Usuario',
    email: 'usuario@example.com',
    level: 1,
    plan: 'básico',
    tokenBalance: 1250.5,
    teamCode: 'TEAM001',
    lastActive: DateTime.now(),
  );
  
  static List<Map<String, dynamic>> levels = [
    {
      'level': 1,
      'name': 'Semilla',
      'minSteps': 5000,
      'teamSize': 0,
      'withdrawLimit': 50,
    },
    {
      'level': 2,
      'name': 'Explorador',
      'minSteps': 7000,
      'teamSize': 3,
      'withdrawLimit': 100,
    },
    {
      'level': 3,
      'name': 'Despertar',
      'minSteps': 8000,
      'teamSize': 5,
      'withdrawLimit': 200,
    },
    {
      'level': 4,
      'name': 'Ascenso',
      'minSteps': 10000,
      'teamSize': 10,
      'withdrawLimit': 500,
    },
    {
      'level': 5,
      'name': 'Sabio',
      'minSteps': 12000,
      'teamSize': 20,
      'withdrawLimit': 1000,
    },
  ];
  
  static TodayGoals todayGoals = TodayGoals(
    steps: 5420,
    targetSteps: 8000,
    tokensEarned: 125.5,
    sleepHours: 7.2,
    targetSleepHours: 8.0,
    waterLiters: 1.8,
    targetWaterLiters: 2.5,
    meditationMinutes: 15,
    targetMeditationMinutes: 20,
  );
  
  static List<Map<String, dynamic>> subscriptionPlans = [
    {
      'id': 'basic',
      'name': 'Básico',
      'price': 11.0,
      'color': 0xFF10B981,
      'popular': false,
      'features': [
        'Seguimiento básico de pasos',
        'Metas diarias',
        'Hasta 5 tokens/día',
        'Soporte estándar',
      ],
    },
    {
      'id': 'pro',
      'name': 'Pro',
      'price': 18.0,
      'color': 0xFF3B82F6,
      'popular': true,
      'features': [
        'Todo lo del plan Básico',
        'Análisis avanzado',
        'Hasta 15 tokens/día',
        'Soporte prioritario',
        'Acceso a eventos exclusivos',
      ],
    },
    {
      'id': 'elite',
      'name': 'Elite',
      'price': 25.0,
      'color': 0xFFF59E0B,
      'popular': false,
      'features': [
        'Todo lo del plan Pro',
        'Coach personal 1:1',
        'Hasta 20 tokens/día',
        'Análisis biométrico',
        'Recompensas exclusivas',
      ],
    },
  ];
  
  static List<Map<String, dynamic>> withdrawalHistory = [
    {
      'amount': 50.0,
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'status': 'completed',
    },
    {
      'amount': 25.0,
      'date': DateTime.now().subtract(const Duration(days: 12)),
      'status': 'completed',
    },
  ];
  
  static Map<String, dynamic> mockFitnessPlan = {
    'name': 'Plan Básico',
    'duration': '4 semanas',
    'exercises': ['Caminata', 'Estiramientos'],
  };
  
  static List<Map<String, dynamic>> mockTeamMembers = [
    {'name': 'Ana', 'level': 2, 'tokens': 850},
    {'name': 'Carlos', 'level': 1, 'tokens': 650},
  ];
  
  static Map<String, dynamic> mockLeader = {
    'name': 'María',
    'level': 5,
    'tokens': 2500,
  };
  
  static List<Map<String, dynamic>> mockSocialPosts = [
    {
      'user': 'Pedro',
      'content': '¡Completé mis 10,000 pasos hoy!',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
    },
  ];
}