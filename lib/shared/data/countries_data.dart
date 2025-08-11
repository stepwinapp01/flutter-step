/// Lista completa de países con códigos telefónicos
class CountriesData {
  static final List<Map<String, String>> countries = [
    // América
    {'name': 'Estados Unidos', 'code': '+1', 'flag': '🇺🇸'},
    {'name': 'Canadá', 'code': '+1', 'flag': '🇨🇦'},
    {'name': 'México', 'code': '+52', 'flag': '🇲🇽'},
    {'name': 'Brasil', 'code': '+55', 'flag': '🇧🇷'},
    {'name': 'Argentina', 'code': '+54', 'flag': '🇦🇷'},
    {'name': 'Chile', 'code': '+56', 'flag': '🇨🇱'},
    {'name': 'Colombia', 'code': '+57', 'flag': '🇨🇴'},
    {'name': 'Perú', 'code': '+51', 'flag': '🇵🇪'},
    {'name': 'Venezuela', 'code': '+58', 'flag': '🇻🇪'},
    {'name': 'Ecuador', 'code': '+593', 'flag': '🇪🇨'},
    {'name': 'Uruguay', 'code': '+598', 'flag': '🇺🇾'},
    {'name': 'Paraguay', 'code': '+595', 'flag': '🇵🇾'},
    {'name': 'Bolivia', 'code': '+591', 'flag': '🇧🇴'},
    {'name': 'Guatemala', 'code': '+502', 'flag': '🇬🇹'},
    {'name': 'Costa Rica', 'code': '+506', 'flag': '🇨🇷'},
    {'name': 'Panamá', 'code': '+507', 'flag': '🇵🇦'},
    {'name': 'Honduras', 'code': '+504', 'flag': '🇭🇳'},
    {'name': 'Nicaragua', 'code': '+505', 'flag': '🇳🇮'},
    {'name': 'El Salvador', 'code': '+503', 'flag': '🇸🇻'},
    {'name': 'República Dominicana', 'code': '+1', 'flag': '🇩🇴'},
    {'name': 'Cuba', 'code': '+53', 'flag': '🇨🇺'},
    
    // Europa
    {'name': 'España', 'code': '+34', 'flag': '🇪🇸'},
    {'name': 'Francia', 'code': '+33', 'flag': '🇫🇷'},
    {'name': 'Reino Unido', 'code': '+44', 'flag': '🇬🇧'},
    {'name': 'Alemania', 'code': '+49', 'flag': '🇩🇪'},
    {'name': 'Italia', 'code': '+39', 'flag': '🇮🇹'},
    {'name': 'Portugal', 'code': '+351', 'flag': '🇵🇹'},
    {'name': 'Países Bajos', 'code': '+31', 'flag': '🇳🇱'},
    {'name': 'Bélgica', 'code': '+32', 'flag': '🇧🇪'},
    {'name': 'Suiza', 'code': '+41', 'flag': '🇨🇭'},
    {'name': 'Austria', 'code': '+43', 'flag': '🇦🇹'},
    {'name': 'Suecia', 'code': '+46', 'flag': '🇸🇪'},
    {'name': 'Noruega', 'code': '+47', 'flag': '🇳🇴'},
    {'name': 'Dinamarca', 'code': '+45', 'flag': '🇩🇰'},
    {'name': 'Polonia', 'code': '+48', 'flag': '🇵🇱'},
    {'name': 'Grecia', 'code': '+30', 'flag': '🇬🇷'},
    {'name': 'Rusia', 'code': '+7', 'flag': '🇷🇺'},
    
    // Asia
    {'name': 'China', 'code': '+86', 'flag': '🇨🇳'},
    {'name': 'Japón', 'code': '+81', 'flag': '🇯🇵'},
    {'name': 'Corea del Sur', 'code': '+82', 'flag': '🇰🇷'},
    {'name': 'India', 'code': '+91', 'flag': '🇮🇳'},
    {'name': 'Tailandia', 'code': '+66', 'flag': '🇹🇭'},
    {'name': 'Vietnam', 'code': '+84', 'flag': '🇻🇳'},
    {'name': 'Filipinas', 'code': '+63', 'flag': '🇵🇭'},
    {'name': 'Indonesia', 'code': '+62', 'flag': '🇮🇩'},
    {'name': 'Malasia', 'code': '+60', 'flag': '🇲🇾'},
    {'name': 'Singapur', 'code': '+65', 'flag': '🇸🇬'},
    {'name': 'Turquía', 'code': '+90', 'flag': '🇹🇷'},
    {'name': 'Israel', 'code': '+972', 'flag': '🇮🇱'},
    {'name': 'Emiratos Árabes Unidos', 'code': '+971', 'flag': '🇦🇪'},
    
    // África
    {'name': 'Sudáfrica', 'code': '+27', 'flag': '🇿🇦'},
    {'name': 'Nigeria', 'code': '+234', 'flag': '🇳🇬'},
    {'name': 'Egipto', 'code': '+20', 'flag': '🇪🇬'},
    {'name': 'Marruecos', 'code': '+212', 'flag': '🇲🇦'},
    
    // Oceanía
    {'name': 'Australia', 'code': '+61', 'flag': '🇦🇺'},
    {'name': 'Nueva Zelanda', 'code': '+64', 'flag': '🇳🇿'},
  ];

  static List<Map<String, String>> searchCountries(String query) {
    if (query.isEmpty) return countries;
    return countries.where((country) {
      return country['name']!.toLowerCase().contains(query.toLowerCase()) ||
             country['code']!.contains(query);
    }).toList();
  }
}