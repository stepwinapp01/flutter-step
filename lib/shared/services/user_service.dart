class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  String _userName = 'Usuario';
  String _userEmail = '';
  String _userPhone = '';
  DateTime? _birthDate;
  String _gender = 'Hombre';
  double _weight = 0;
  double _height = 0;
  List<String> _medicalConditions = [];

  // Getters
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;
  DateTime? get birthDate => _birthDate;
  String get gender => _gender;
  double get weight => _weight;
  double get height => _height;
  List<String> get medicalConditions => _medicalConditions;

  // Setters
  void setUserName(String name) {
    _userName = name;
  }
  
  void setUserData({
    required String name,
    required String email,
    required String phone,
    required DateTime birthDate,
    required String gender,
    required double weight,
    required double height,
  }) {
    _userName = name;
    _userEmail = email;
    _userPhone = phone;
    _birthDate = birthDate;
    _gender = gender;
    _weight = weight;
    _height = height;
  }

  void setMedicalConditions(List<String> conditions) {
    _medicalConditions = conditions;
  }

  int get age {
    if (_birthDate == null) return 0;
    return DateTime.now().difference(_birthDate!).inDays ~/ 365;
  }

  void clearUserData() {
    _userName = 'Usuario';
    _userEmail = '';
    _userPhone = '';
    _birthDate = null;
    _gender = 'Hombre';
    _weight = 0;
    _height = 0;
    _medicalConditions = [];
  }
}