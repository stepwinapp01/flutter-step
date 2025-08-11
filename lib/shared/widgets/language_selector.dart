import 'package:flutter/material.dart';
import '../services/localization_service.dart';

class LanguageSelector extends StatelessWidget {
  final Function(String) onLanguageChanged;
  
  const LanguageSelector({super.key, required this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String language) {
        LocalizationService.setLanguage(language);
        onLanguageChanged(language);
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'es',
          child: Row(
            children: [
              Text('🇪🇸'),
              SizedBox(width: 8),
              Text('Español'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'en',
          child: Row(
            children: [
              Text('🇺🇸'),
              SizedBox(width: 8),
              Text('English'),
            ],
          ),
        ),
      ],
    );
  }
}