class MockUser {
  final String name;
  final String email;
  final int level;
  
  MockUser({required this.name, required this.email, required this.level});
}

class MockDataService {
  static MockUser currentUser = MockUser(
    name: 'Usuario',
    email: 'usuario@example.com',
    level: 1,
  );
}