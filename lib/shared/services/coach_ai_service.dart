class CoachAIService {
  static String generateWelcomeWithPlan(dynamic plan) {
    return '¡Hola! He creado un plan personalizado especialmente para ti. '
           'Este plan se adapta a tu nivel de condición física y objetivos. '
           'Recuerda que la constancia es clave para el éxito. ¡Vamos a comenzar!';
  }
  static Map<String, dynamic> generateFitnessPlan({
    required int age,
    required String fitnessLevel,
    required List<String> goals,
    required List<String> medicalConditions,
  }) {
    return {
      'dailySteps': _calculateSteps(fitnessLevel),
      'exercises': _generateExercises(fitnessLevel, goals),
      'nutrition': _generateNutrition(age, goals),
      'recovery': _generateRecovery(medicalConditions),
      'duration': '4 semanas',
    };
  }
  
  static int _calculateSteps(String level) {
    switch (level.toLowerCase()) {
      case 'principiante': return 6000;
      case 'intermedio': return 8000;
      case 'avanzado': return 10000;
      default: return 7000;
    }
  }
  
  static List<String> _generateExercises(String level, List<String> goals) {
    List<String> exercises = ['Caminata diaria'];
    
    if (goals.contains('Perder peso')) {
      exercises.add('Cardio 20 min');
    }
    if (goals.contains('Ganar músculo')) {
      exercises.add('Ejercicios de fuerza');
    }
    if (level == 'avanzado') {
      exercises.add('HIIT 2x semana');
    }
    
    return exercises;
  }
  
  static List<String> _generateNutrition(int age, List<String> goals) {
    List<String> nutrition = ['2 litros de agua diarios'];
    
    if (goals.contains('Perder peso')) {
      nutrition.add('Déficit calórico moderado');
    }
    if (age > 40) {
      nutrition.add('Suplemento de calcio');
    }
    
    return nutrition;
  }
  
  static List<String> _generateRecovery(List<String> conditions) {
    List<String> recovery = ['7-8 horas de sueño'];
    
    if (conditions.contains('Estrés')) {
      recovery.add('Meditación 15 min');
    }
    if (conditions.contains('Dolor articular')) {
      recovery.add('Estiramientos suaves');
    }
    
    return recovery;
  }
}