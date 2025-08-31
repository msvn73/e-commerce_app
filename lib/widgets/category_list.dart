import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/categories_provider.dart';
import '../constants/app_constants.dart';
import '../constants/app_colors.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                ref
                    .read(categoriesProvider.notifier)
                    .selectCategory(category.id);
              },
              child: AnimatedContainer(
                duration: AppConstants.shortAnimation,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: category.isSelected
                      ? AppColors.primary
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: category.isSelected
                        ? AppColors.primary
                        : AppColors.border,
                    width: 1,
                  ),
                  boxShadow: category.isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [
                          const BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                ),
                child: Center(
                  child: Text(
                    category.name,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: category.isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                          fontWeight: category.isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
