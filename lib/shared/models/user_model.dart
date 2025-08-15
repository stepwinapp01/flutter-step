/// Modelo de usuario completo para la aplicación Step Win
/// 
/// Contiene toda la información del usuario incluyendo:
/// - Datos básicos (uid, email, nombre)
/// - Progreso del juego (nivel, tokens, plan)
/// - Estado de verificación (KYC, reconocimiento facial)
/// - Configuración (idioma, dispositivos conectados)
/// - Metadatos (fechas de creación y última actividad)
class UserModel {
  /// Identificador único del usuario
  final String uid;
  
  /// Email del usuario (usado para autenticación)
  final String email;
  
  /// Nombre completo del usuario
  final String name;

  /// Número de teléfono del usuario
  final String? phone;
  
  /// URL de la foto de perfil (opcional)
  final String? photoUrl;
  
  /// Nivel actual del usuario (1-10)
  final int level;
  
  /// Plan de suscripción: 'basic', 'pro', 'elite'
  final String plan;
  
  /// Balance actual de tokens del usuario
  final double tokenBalance;
  
  /// Estado de verificación KYC (requerido para retiros >$100)
  final bool kycVerified;
  
  /// Estado del reconocimiento facial (requerido para nivel 2+)
  final bool facialRecognitionDone;
  
  /// Idioma preferido: 'es', 'en'
  final String language;
  
  /// Fecha de creación de la cuenta
  final DateTime createdAt;
  
  /// Última vez que el usuario estuvo activo
  final DateTime lastActive;
  
  /// Código del equipo (opcional, para funciones sociales)
  final String? teamCode;
  
  /// Dispositivos conectados (smartwatch, fitness tracker, etc.)
  final Map<String, bool> connectedDevices;
  
  /// Indica si el usuario ha completado el proceso de onboarding
  final bool hasCompletedOnboarding;

  /// Condiciones médicas del usuario
  final List<String> medicalConditions;

  /// Género del usuario: 'male', 'female'
  final String? gender;

  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.phone,
    this.photoUrl,
    required this.level,
    required this.plan,
    required this.tokenBalance,
    required this.kycVerified,
    required this.facialRecognitionDone,
    required this.language,
    required this.createdAt,
    required this.lastActive,
    this.teamCode,
    required this.connectedDevices,
    required this.hasCompletedOnboarding,
    this.medicalConditions = const [],
    this.gender,
  });

  /// Crea una instancia de UserModel desde un Map JSON
  /// 
  /// [json] Map con los datos del usuario
  /// Maneja valores nulos con defaults seguros
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'],
      photoUrl: json['photoUrl'],
      level: json['level'] ?? 1,
      plan: json['plan'] ?? 'basic',
      tokenBalance: (json['tokenBalance'] ?? 0).toDouble(),
      kycVerified: json['kycVerified'] ?? false,
      facialRecognitionDone: json['facialRecognitionDone'] ?? false,
      language: json['language'] ?? 'es',
      createdAt: _parseDateTime(json['createdAt']),
      lastActive: _parseDateTime(json['lastActive']),
      teamCode: json['teamCode'],
      connectedDevices: Map<String, bool>.from(json['connectedDevices'] ?? {}),
      hasCompletedOnboarding: json['hasCompletedOnboarding'] ?? false,
      medicalConditions: List<String>.from(json['medicalConditions'] ?? []),
      gender: json['gender'],
    );
  }

  /// Convierte la instancia a Map JSON para serialización
  /// 
  /// Returns Map con todos los campos del usuario
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'photoUrl': photoUrl,
      'level': level,
      'plan': plan,
      'tokenBalance': tokenBalance,
      'kycVerified': kycVerified,
      'facialRecognitionDone': facialRecognitionDone,
      'language': language,
      'createdAt': createdAt.toIso8601String(),
      'lastActive': lastActive.toIso8601String(),
      'teamCode': teamCode,
      'connectedDevices': connectedDevices,
      'hasCompletedOnboarding': hasCompletedOnboarding,
      'medicalConditions': medicalConditions,
      'gender': gender,
    };
  }

  /// Crea una copia del usuario con campos actualizados
  /// 
  /// Permite actualizar campos específicos manteniendo el resto
  /// Returns nueva instancia de UserModel con cambios aplicados
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? phone,
    String? photoUrl,
    int? level,
    String? plan,
    double? tokenBalance,
    bool? kycVerified,
    bool? facialRecognitionDone,
    String? language,
    DateTime? createdAt,
    DateTime? lastActive,
    String? teamCode,
    Map<String, bool>? connectedDevices,
    bool? hasCompletedOnboarding,
    List<String>? medicalConditions,
    String? gender,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      level: level ?? this.level,
      plan: plan ?? this.plan,
      tokenBalance: tokenBalance ?? this.tokenBalance,
      kycVerified: kycVerified ?? this.kycVerified,
      facialRecognitionDone: facialRecognitionDone ?? this.facialRecognitionDone,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      teamCode: teamCode ?? this.teamCode,
      connectedDevices: connectedDevices ?? this.connectedDevices,
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      medicalConditions: medicalConditions ?? this.medicalConditions,
      gender: gender ?? this.gender,
    );
  }
  
  /// Helper method to parse DateTime from various formats
  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) return DateTime.parse(value);
    // Handle Firestore Timestamp
    if (value.runtimeType.toString() == 'Timestamp') {
      return (value as dynamic).toDate();
    }
    return DateTime.now();
  }
}