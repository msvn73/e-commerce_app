import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../services/notification_service.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Logo Section
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
            vertical: AppConstants.paddingSmall, // Reduced from paddingLarge
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Name Text Only (single word)
              Text(
                'Drawnprint',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary, // Red color from app theme
                      letterSpacing: 0.5,
                    ),
              ),
            ],
          ),
        ),

        // Location Section
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
            vertical: AppConstants.paddingSmall, // Reduced from paddingMedium
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Teslimat Adresi',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    Text(
                      AppConstants.defaultLocation,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  // Show notification when bell is tapped
                  NotificationService.showNotification(
                    id: 1,
                    title: 'Test Bildirimi',
                    body: 'Bu bir test bildirimidir!',
                  );
                },
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
