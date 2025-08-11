# Tests

## Estructura de Tests

```
test/
├── unit/                    # Tests unitarios
│   ├── models/             # Tests de modelos
│   ├── providers/          # Tests de providers
│   ├── services/           # Tests de servicios
│   ├── core/               # Tests de core (theme, utils)
│   └── shared/             # Tests de componentes compartidos
├── widget/                 # Tests de widgets
├── integration/            # Tests de integración
├── test_helpers/           # Utilidades para tests
└── test_all.dart          # Runner de todos los tests
```

## Ejecutar Tests

```bash
# Todos los tests
flutter test

# Tests específicos
flutter test test/unit/
flutter test test/widget/
flutter test test/integration/

# Test individual
flutter test test/unit/models/chat_message_test.dart

# Con cobertura
flutter test --coverage
```

## Tests Implementados

### Unit Tests ✅
- ChatMessage model
- ChatProvider state management
- MockDataService data validation
- AppConstants theme validation
- LocalizationService i18n

### Widget Tests ✅
- CoachAdanScreen rendering
- Chat bubble components
- Tab navigation

### Integration Tests ✅
- App flow end-to-end
- Chat functionality

## Cobertura Objetivo
- **Unit Tests**: 90%+
- **Widget Tests**: 80%+
- **Integration Tests**: Key user flows