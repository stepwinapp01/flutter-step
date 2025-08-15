import 'package:flutter/material.dart';

/// Define los estilos visuales disponibles para el botón.
enum ButtonType { primary, secondary }

/// Un widget de botón reutilizable y estilizado para toda la aplicación.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final ButtonType type;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.type = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    // Deshabilita el botón si está cargando o si no tiene una acción onPressed.
    final bool isDisabled = isLoading || onPressed == null;

    return type == ButtonType.primary
        ? _buildElevatedButton(context, isDisabled)
        : _buildOutlinedButton(context, isDisabled);
  }

  Widget _buildElevatedButton(BuildContext context, bool isDisabled) {
    final buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
          )
        : Text(text);

    return icon != null && !isLoading
        ? ElevatedButton.icon(
            onPressed: isDisabled ? null : onPressed,
            style: buttonStyle,
            icon: icon!,
            label: Text(text),
          )
        : ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: buttonStyle,
            child: child,
          );
  }

  Widget _buildOutlinedButton(BuildContext context, bool isDisabled) {
    final buttonStyle = OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      side: BorderSide(color: Theme.of(context).primaryColor),
      foregroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2.5, color: Theme.of(context).primaryColor),
          )
        : Text(text);

    return icon != null && !isLoading
        ? OutlinedButton.icon(
            onPressed: isDisabled ? null : onPressed,
            style: buttonStyle,
            icon: icon!,
            label: Text(text),
          )
        : OutlinedButton(
            onPressed: isDisabled ? null : onPressed,
            style: buttonStyle,
            child: child,
          );
  }
}