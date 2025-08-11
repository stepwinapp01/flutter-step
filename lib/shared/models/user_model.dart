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

  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
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
      photoUrl: json['photoUrl'],
      level: json['level'] ?? 1,
      plan: json['plan'] ?? 'basic',
      tokenBalance: (json['tokenBalance'] ?? 0).toDouble(),
      kycVerified: json['kycVerified'] ?? false,
      facialRecognitionDone: json['facialRecognitionDone'] ?? false,
      language: json['language'] ?? 'es',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastActive: DateTime.parse(json['lastActive'] ?? DateTime.now().toIso8601String()),
      teamCode: json['teamCode'],
      connectedDevices: Map<String, bool>.from(json['connectedDevices'] ?? {}),
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
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
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
    );
  }
}