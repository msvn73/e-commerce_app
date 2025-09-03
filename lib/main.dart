import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'config/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Supabase
    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      anonKey: AppConfig.supabaseAnonKey,
    );
  } catch (e) {
    // Handle Supabase initialization error
    debugPrint('Supabase initialization failed: $e');
    // Continue with app launch even if Supabase fails
  }

  runApp(
    const ProviderScope(
      child: ECommerceApp(),
    ),
  );
}

class ECommerceApp extends ConsumerStatefulWidget {
  const ECommerceApp({super.key});

  @override
  ConsumerState<ECommerceApp> createState() => _ECommerceAppState();
}

class _ECommerceAppState extends ConsumerState<ECommerceApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'StyleHub - Moda E-Ticaret',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
