import 'package:flutter/material.dart';
import 'simple_welcome_screen.dart';
import 'phone_registration_screen.dart';
import 'age_verification_screen.dart';
import 'fitness_assessment_screen.dart';
import 'medical_info_screen.dart';
import 'coach_plan_screen.dart';
import '../subscription/subscription_onboarding_screen.dart';
import '../levels/levels_system_screen.dart';
import 'level_terms_screen.dart';
import 'device_connection_screen.dart';
import 'face_verification_screen.dart';
import '../main_app/main_tabs_screen.dart';

/// Flujo completo de onboarding de Step Win App
/// 
/// Flujo completo de 13 pasos:
/// 1. SimpleWelcomeScreen - Bienvenida y selección de idioma
/// 2. PhoneRegistrationScreen - Registro de nombre y teléfono con SMS
/// 3. AgeVerificationScreen - Verificación de edad (16+)
/// 4. FitnessAssessmentScreen - Evaluación física completa
/// 5. MedicalInfoScreen - Información médica
/// 6. FitnessGoalsScreen - Selección de objetivos fitness
/// 7. CoachPlanScreen - Plan personalizado del Coach Adán
/// 8. SubscriptionOnboardingScreen - Selección de plan de suscripción
/// 9. LevelsSystemScreen - Explicación del sistema de niveles
/// 10. PlanSelectionScreen - Selección de plan de pago
/// 11. LevelTermsScreen - Términos y condiciones
/// 12. DeviceConnectionScreen - Conexión de dispositivos
/// 13. FaceVerificationScreen - Verificación facial
/// 14. MainTabsScreen - Aplicación principal
class OnboardingFlow {
  static void startOnboarding(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SimpleWelcomeScreen(),
      ),
    );
  }

  static void goToPhoneRegistration(BuildContext context, String language) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PhoneRegistrationScreen(language: language),
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

  static void goToMedicalInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MedicalInfoScreen(),
      ),
    );
  }

  static void goToCoachPlan(BuildContext context, List<String> medicalConditions) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CoachPlanScreen(medicalConditions: medicalConditions),
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

  static void goToLevelTerms(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LevelTermsScreen(),
      ),
    );
  }

  static void goToDeviceConnection(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DeviceConnectionScreen(),
      ),
    );
  }

  static void goToFaceVerification(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FaceVerificationScreen(),
      ),
    );
  }

  static void completeOnboarding(BuildContext context, {String language = 'es'}) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainTabsScreen(),
      ),
      (route) => false,
    );
  }
}