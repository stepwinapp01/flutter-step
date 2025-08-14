# 🔍 Guía para Usar Flutter DevTools - Performance Analysis

## Paso 1: Ejecutar la App con DevTools

```bash
# En la terminal, ejecuta:
flutter run --debug

# Busca esta línea en la salida:
# The Flutter DevTools debugger and profiler on [device] is available at:
# http://127.0.0.1:9101?uri=http://127.0.0.1:[puerto]/[token]/
```

## Paso 2: Abrir DevTools

1. **Copia la URL completa** que aparece en tu consola
2. **Pégala en tu navegador** (Chrome recomendado)
3. DevTools se abrirá automáticamente

## Paso 3: Configurar Performance Profiling

### En DevTools:
1. **Ve a la pestaña "Performance"** (en la barra superior)
2. **Activa estas opciones:**
   - ✅ "Track Widget Builds" 
   - ✅ "Track CPU Profiler"
   - ✅ "Track User Interaction" (opcional)

## Paso 4: Capturar el Problema

1. **Presiona el botón "Record"** (🔴) en DevTools
2. **En la terminal de Flutter, presiona "R"** (hot restart)
3. **Espera a que la app se congele/crashee**
4. **Presiona "Stop"** (⏹️) en DevTools

## Paso 5: Analizar el Flame Chart

### Qué buscar:
- **Barras rojas anchas** = Operaciones que tardan mucho
- **Sección "UI Thread"** = Donde ocurren los bloqueos
- **Métodos con >16ms** = Causan frames perdidos

### Elementos críticos a identificar:
- `Firebase.initializeApp()` - Inicialización de Firebase
- `build()` methods - Construcción de widgets
- `async` operations - Operaciones asíncronas mal manejadas
- Network calls - Llamadas de red síncronas

## Paso 6: Interpretar Resultados

### Colores en el Flame Chart:
- 🟢 **Verde**: Operaciones rápidas (<16ms)
- 🟡 **Amarillo**: Operaciones lentas (16-33ms)
- 🔴 **Rojo**: Operaciones muy lentas (>33ms)

### Métricas importantes:
- **Frame time**: Debe ser <16ms para 60fps
- **CPU usage**: Picos indican operaciones pesadas
- **Memory**: Aumentos súbitos pueden causar GC pauses

## Comandos Útiles Durante el Análisis

```bash
# En la terminal de Flutter:
r    # Hot reload (cambios menores)
R    # Hot restart (reinicio completo)
p    # Toggle performance overlay
q    # Quit app
```

## Problemas Comunes y Sus Firmas

### 1. Firebase Initialization Blocking UI:
- Busca: `Firebase.initializeApp()` en el flame chart
- Duración: >1000ms
- Solución: Mover a pantalla de splash asíncrona

### 2. Synchronous Network Calls:
- Busca: `http.get()`, `dio.get()` sin await
- Duración: Variable (depende de red)
- Solución: Usar async/await correctamente

### 3. Heavy Widget Building:
- Busca: `build()` methods con duración >16ms
- Causa: Cálculos pesados en build()
- Solución: Mover lógica a initState() o usar FutureBuilder

## Próximos Pasos

Una vez que identifiques el método problemático:
1. **Anota el nombre exacto** del método/función
2. **Anota la duración** (tiempo en ms)
3. **Toma screenshot** del flame chart
4. **Comparte los resultados** para análisis específico