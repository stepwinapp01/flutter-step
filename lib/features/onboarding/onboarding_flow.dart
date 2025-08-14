import 'package:flutter/material.dart';
import 'simple_welcome_screen.dart';
import 'name_registration_screen.dart';
import 'age_verification_screen.dart';
import 'fitness_assessment_screen.dart';
import '../subscription/subscription_onboarding_screen.dart';
import '../levels/levels_system_screen.dart';
import '../main_app/main_tabs_screen.dart';

class OnboardingFlow {
  static void startOnboarding(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SimpleWelcomeScreen(),
      ),
    );
  }

  static void goToNameRegistration(BuildContext context, String language) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NameRegistrationScreen(language: language),
      ),
    );
  }

  static void goToAgeVerification(BuildContext context, String language) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AgeVerificationScreen(language: language),
      ),
    );
  }

  static void goToFitnessAssessment(BuildContext context, int age) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FitnessAssessmentScreen(age: age),
      ),
    );
  }

  static void goToSubscription(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SubscriptionOnboardingScreen(),
      ),
    );
  }

  static void goToLevelsSystem(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LevelsSystemScreen(isOnboarding: true),
      ),
    );
  }

  static void completeOnboarding(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainTabsScreen(),
      ),
      (route) => false,
    );
  }
}