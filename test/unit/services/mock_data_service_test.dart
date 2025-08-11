import 'package:flutter_test/flutter_test.dart';
import 'package:step_win_app/shared/services/mock_data_service.dart';

void main() {
  group('MockDataService', () {
    test('should return current user with valid data', () {
      final user = MockDataService.currentUser;
      
      expect(user.uid, isNotEmpty);
      expect(user.name, isNotEmpty);
      expect(user.email, contains('@'));
      expect(user.level, greaterThan(0));
      expect(user.tokenBalance, greaterThanOrEqualTo(0));
      expect(user.lastActive, isA<DateTime>());
    });

    test('should return fitness plan with exercises', () {
      final plan = MockDataService.mockFitnessPlan;
      final exercises = plan['exercises'] as List<Map<String, dynamic>>;
      
      expect(exercises, isNotEmpty);
      expect(exercises.length, greaterThan(0));
      
      for (final exercise in exercises) {
        expect(exercise['name'], isNotEmpty);
        expect(exercise['sets'], greaterThan(0));
        expect(exercise['reps'], greaterThan(0));
      }
    });

    test('should return team members list', () {
      final members = MockDataService.mockTeamMembers;
      
      expect(members, isNotEmpty);
      expect(members.length, greaterThan(0));
      
      for (final member in members) {
        expect(member.uid, isNotEmpty);
        expect(member.name, isNotEmpty);
        expect(member.email, contains('@'));
        expect(member.level, greaterThan(0));
      }
    });

    test('should return leader with high level', () {
      final leader = MockDataService.mockLeader;
      
      expect(leader.name, contains('Coach'));
      expect(leader.level, greaterThanOrEqualTo(10));
      expect(leader.tokenBalance, greaterThan(1000));
    });

    test('should return social posts with valid structure', () {
      final posts = MockDataService.mockSocialPosts;
      
      expect(posts, isNotEmpty);
      
      for (final post in posts) {
        expect(post['id'], isNotEmpty);
        expect(post['userName'], isNotEmpty);
        expect(post['content'], isNotEmpty);
        expect(post['timestamp'], isA<DateTime>());
        expect(post['likes'], isA<int>());
        expect(post['comments'], isA<int>());
      }
    });
  });
}