import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const PlaceholderImage({
    super.key,
    required this.width,
    required this.height,
    this.text = '',
    this.backgroundColor = const Color(0xFFE5E7EB),
    this.textColor = const Color(0xFF6B7280),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: text.isNotEmpty
            ? Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              )
            : Icon(
                Icons.image,
                color: textColor,
                size: 32,
              ),
      ),
    );
  }
}

class UserAvatarPlaceholder extends StatelessWidget {
  final double radius;
  final String name;
  final Color backgroundColor;

  const UserAvatarPlaceholder({
    super.key,
    required this.radius,
    required this.name,
    this.backgroundColor = const Color(0xFF6B46C1),
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.6,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}