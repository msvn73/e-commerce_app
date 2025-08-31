import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/category.dart';
import '../providers/products_provider.dart';
import '../widgets/product_grid.dart';
import '../constants/app_constants.dart';
import '../constants/app_colors.dart';

class CategoryProductsScreen extends ConsumerWidget {
  final String categoryId;
  final Category? category;

  const CategoryProductsScreen({
    super.key,
    required this.categoryId,
    this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    // Kategori adına göre ürünleri filtrele
    final categoryProducts = products.where((product) {
      if (category == null) return false;

      // Kategori eşleştirmesi
      switch (category!.name) {
        case 'Elektronik':
          return product.category == 'Popüler' || product.category == 'T-Shirt';
        case 'Giyim':
          return product.category == 'T-Shirt' ||
              product.category == 'Erkek' ||
              product.category == 'Kadın';
        case 'Ev & Yaşam':
          return product.category == 'Alışveriş';
        case 'Spor':
          return product.category == 'Popüler';
        case 'Kitaplar':
          return product.category == 'Alışveriş';
        case 'Kozmetik':
          return product.category == 'Kadın';
        default:
          return false;
      }
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Custom App Bar with Hero Animation
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: category?.color ?? AppColors.primary,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black87),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  category?.name ?? 'Kategori',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Hero(
                  tag: 'category-${category?.id}',
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          category?.color ?? AppColors.primary,
                          (category?.color ?? AppColors.primary).withOpacity(
                            0.7,
                          ),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Pattern overlay
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.1,
                            child: Icon(
                              category?.icon ?? Icons.category,
                              size: 200,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Content
                        Positioned(
                          bottom: 80,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  category?.icon ?? Icons.category,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                category?.description ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Products count and filter info
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                child: Row(
                  children: [
                    const Icon(
                      Icons.inventory,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${categoryProducts.length} ürün bulundu',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        // TODO: Filter functionality
                      },
                      icon: const Icon(Icons.filter_list, size: 18),
                      label: const Text('Filtrele'),
                    ),
                  ],
                ),
              ),
            ),

            // Products Grid
            categoryProducts.isEmpty
                ? SliverToBoxAdapter(
                    child: SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category?.icon ?? Icons.category,
                            size: 80,
                            color: AppColors.textHint,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Bu kategoride henüz ürün yok',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Yakında yeni ürünler eklenecek',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.textHint),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppConstants.paddingMedium,
                      0,
                      AppConstants.paddingMedium,
                      100, // Bottom navigation için alan bırak
                    ),
                    sliver: ProductGrid(products: categoryProducts),
                  ),
          ],
        ),
      ),
    );
  }
}
