#!/bin/bash
set -e  # Exit on any error

# Step Win App - Asset Generation Script
# Automatiza la generación de íconos, splash screen y favicon

# Variables
PROJECT_NAME="Step Win App"
ICON_GENERATOR="flutter_launcher_icons:main"
SPLASH_GENERATOR="flutter_native_splash:create"

# Función para mostrar mensajes con formato
log_info() { echo "ℹ️  $1"; }
log_success() { echo "✅ $1"; }
log_error() { echo "❌ $1" >&2; }
log_warning() { echo "⚠️  $1"; }

# Función para verificar directorio del proyecto
check_project_directory() {
    if [ ! -f "pubspec.yaml" ]; then
        log_error "No se encontró pubspec.yaml. Ejecuta desde la raíz del proyecto."
        exit 1
    fi
}

# Función para verificar herramientas requeridas
check_tools() {
    log_info "🔍 Verificando herramientas requeridas..."
    
    if ! command -v flutter &> /dev/null; then
        log_error "Flutter no está instalado o no está en PATH"
        log_info "Instala Flutter desde: https://flutter.dev/docs/get-started/install"
        exit 1
    fi
    
    if ! command -v dart &> /dev/null; then
        log_error "Dart no está instalado o no está en PATH"
        log_info "Dart debería venir con Flutter. Verifica tu instalación."
        exit 1
    fi
    
    log_success "Herramientas verificadas correctamente"
}

log_info "🚀 Iniciando generación de assets para $PROJECT_NAME..."
check_tools
check_project_directory

# Función para generar íconos
generate_icons() {
    log_info "📱 Generando íconos de la aplicación..."
    if flutter pub run $ICON_GENERATOR; then
        log_success "Íconos generados correctamente"
    else
        log_error "Error al generar íconos"
        exit 1
    fi
}

# Función para generar splash screen
generate_splash() {
    log_info "🎨 Generando splash screen..."
    if flutter pub run $SPLASH_GENERATOR; then
        log_success "Splash screen generado correctamente"
    else
        log_error "Error al generar splash screen"
        exit 1
    fi
}

# Función para generar favicon
generate_favicon() {
    if [ -d "web" ]; then
        log_info "🌐 Generando favicon para web..."
        if [ -f "favicon_generator.dart" ]; then
            if dart run favicon_generator.dart; then
                log_success "Favicon generado correctamente"
            else
                log_error "Error al generar favicon"
                exit 1
            fi
        else
            log_warning "favicon_generator.dart no encontrado, saltando..."
        fi
    else
        log_info "Directorio web no encontrado, saltando favicon..."
    fi
}

# Función para limpiar y actualizar dependencias
clean_and_update() {
    log_info "🧹 Limpiando cache..."
    if flutter clean && flutter pub get; then
        log_success "Cache limpiado y dependencias actualizadas"
    else
        log_error "Error al limpiar cache o actualizar dependencias"
        exit 1
    fi
}

# Ejecutar generación de assets
generate_icons
generate_splash
generate_favicon

# Función para mostrar resumen final
show_summary() {
    echo ""
    log_success "¡Todos los assets han sido generados exitosamente!"
    echo "📋 Resumen:"
    echo "   - Íconos de aplicación: ✅"
    echo "   - Splash screen: ✅"
    echo "   - Favicon web: $([ -d "web" ] && echo "✅" || echo "N/A")"
    echo ""
    log_info "🎯 Próximo paso: flutter build apk --release"
}

clean_and_update
show_summary