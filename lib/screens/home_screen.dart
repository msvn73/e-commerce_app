import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/products_provider.dart';
import '../providers/categories_provider.dart';
import '../widgets/location_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_list.dart';
import '../widgets/product_grid.dart';
import '../widgets/daily_notification_widget.dart';
import '../constants/app_constants.dart';
import '../constants/app_colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final selectedCategory =
        ref.watch(categoriesProvider.notifier).selectedCategory;

    // Filter products based on category and search
    final filteredProducts = products.where((product) {
      final matchesCategory = selectedCategory.name == 'Tümü' ||
          product.category == selectedCategory.name;
      final matchesSearch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              );
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Location Header
            const SliverToBoxAdapter(child: LocationHeader()),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                child: SearchBarWidget(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      // Navigate to search results screen
                      context.push('/search-results', extra: {
                        'query': value,
                        'results': filteredProducts,
                      });
                    }
                  },
                ),
              ),
            ),

            // Banner Slider
            const SliverToBoxAdapter(child: BannerSlider()),

            // Günlük Bildirim Widget'ı
            const SliverToBoxAdapter(child: DailyNotificationWidget()),

            // Category List
            const SliverToBoxAdapter(child: CategoryList()),

            // Products Grid
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMedium,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _searchQuery.isNotEmpty
                              ? 'Arama Sonuçları'
                              : 'Öne Çıkan Ürünler',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        if (_searchQuery.isNotEmpty)
                          Text(
                            '${filteredProducts.length} ürün bulundu',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                          ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        context.go('/categories');
                      },
                      child: const Text('Tümünü Gör'),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppConstants.paddingMedium,
                AppConstants.paddingMedium,
                AppConstants.paddingMedium,
                100, // Bottom navigation için alan bırak
              ),
              sliver: ProductGrid(products: filteredProducts),
            ),
          ],
        ),
      ),
    );
  }
}
