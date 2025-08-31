import 'package:go_router/go_router.dart';
import '../screens/main_screen.dart';
import '../screens/home_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/category_products_screen.dart';
import '../screens/notification_settings_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../widgets/auth_wrapper.dart';
import '../models/product.dart';
import '../models/category.dart';

final GoRouter router = GoRouter(
  routes: [
    // Auth routes
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    
    // Main app routes (protected)
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/categories',
          name: 'categories',
          builder: (context, state) => const CategoriesScreen(),
        ),
        GoRoute(
          path: '/favorites',
          name: 'favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: '/cart',
          name: 'cart',
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/notification-settings',
          name: 'notification-settings',
          builder: (context, state) => const NotificationSettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/product/:id',
      name: 'product-detail',
      builder: (context, state) {
        final productId = state.pathParameters['id']!;
        final product = state.extra as Product?;
        return ProductDetailScreen(productId: productId, product: product);
      },
    ),
    GoRoute(
      path: '/category-products/:categoryId',
      name: 'category-products',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId']!;
        final category = state.extra as Category?;
        return CategoryProductsScreen(
          categoryId: categoryId,
          category: category,
        );
      },
    ),
  ],
);
