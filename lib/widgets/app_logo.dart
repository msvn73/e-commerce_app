import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool showShadow;

  const AppLogo({
    super.key,
    this.size = 60,
    this.showText = true,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Shopping Bag Logo Emblem
        Container(
          width: size * 0.8,
          height: size * 0.8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                AppColors.primary, // Red color
                Color(0xFFE53E3E), // Darker red
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: showShadow
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Shopping bag icon
              Icon(
                Icons.shopping_bag,
                color: Colors.white,
                size: size * 0.4,
              ),
              // Price tag indicator
              Positioned(
                top: size * 0.15,
                right: size * 0.15,
                child: Container(
                  width: size * 0.2,
                  height: size * 0.2,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFD700), // Gold color
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.attach_money,
                    color: Colors.white,
                    size: size * 0.12,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (showText) ...[
          SizedBox(width: size * 0.25),
          // App Name Text - Single word, red color
          Text(
            'Drawnprint',
            style: TextStyle(
              fontSize: size * 0.25,
              fontWeight: FontWeight.bold,
              color: AppColors.primary, // Red color from app theme
              letterSpacing: 0.5,
            ),
          ),
        ],
      ],
    );
  }
}
