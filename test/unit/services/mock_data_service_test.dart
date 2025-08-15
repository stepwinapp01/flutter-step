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

    test('should return fitness plan with valid structure', () {
      final plan = MockDataService.mockFitnessPlan;
      
      expect(plan['name'], isNotEmpty);
      expect(plan['duration'], isNotEmpty);
      expect(plan['exercises'], isA<List>());
    });

    test('should return team members list', () {
      final members = MockDataService.mockTeamMembers;
      
      expect(members, isNotEmpty);
      expect(members.length, greaterThan(0));
      
      for (final member in members) {
        expect(member['name'], isNotEmpty);
        expect(member['level'], greaterThan(0));
        expect(member['tokens'], greaterThanOrEqualTo(0));
      }
    });

    test('should return leader with high level', () {
      final leader = MockDataService.mockLeader;
      
      expect(leader['name'], isNotEmpty);
      expect(leader['level'], greaterThan(0));
      expect(leader['tokens'], greaterThan(0));
    });

    test('should return social posts with valid structure', () {
      final posts = MockDataService.mockSocialPosts;
      
      expect(posts, isNotEmpty);
      
      for (final post in posts) {
        expect(post['user'], isNotEmpty);
        expect(post['content'], isNotEmpty);
        expect(post['timestamp'], isA<DateTime>());
      }
    });

    test('should return withdrawal history', () {
      final history = MockDataService.withdrawalHistory;
      
      expect(history, isNotEmpty);
      
      for (final withdrawal in history) {
        expect(withdrawal['amount'], greaterThan(0));
        expect(withdrawal['date'], isA<DateTime>());
        expect(withdrawal['status'], isNotEmpty);
      }
    });
  });
}