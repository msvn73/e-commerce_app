import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/providers/session_provider.dart';
import '../../../../core/repositories/auth_repository.dart';
import '../../../../shared/presentation/widgets/loading_widget.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Clean form - no default values
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Check for admin credentials first (bypass validation)
    if (email == 'admin@admin.com' && password == 'admin123') {
      setState(() {
        _isLoading = true;
      });

      try {
        // Admin login
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          // Set admin session
          ref.read(sessionProvider.notifier).loginAsAdmin(email);
          context.go('/admin');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Admin girişi başarısız: ${e.toString()}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
      return;
    }

    // For regular users, validate form
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Get auth repository
        final authRepository = ref.read(authRepositoryProvider);
        
        // Validate user credentials
        final result = await authRepository.validateUserCredentials(
          email: email,
          password: password,
        );

        if (mounted) {
          if (result['success'] == true) {
            // Successful login
            final user = result['user'];
            final userName = user?.userMetadata?['full_name'] ?? 
                           user?.email?.split('@')[0] ?? 
                           'Kullanıcı';
            
            // Set user session
            ref.read(sessionProvider.notifier).loginAsUser(email, userName);
            context.go('/home');
          } else {
            // Show specific error message
            final errorMessage = result['error'] as String;
            final errorType = result['errorType'] as String;
            
            // Show error with different styling based on error type
            Color backgroundColor = Colors.red;
            if (errorType == 'user_not_found') {
              backgroundColor = Colors.orange;
            }
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: backgroundColor,
                duration: const Duration(seconds: 4),
                action: errorType == 'user_not_found' 
                  ? SnackBarAction(
                      label: 'Kayıt Ol',
                      textColor: Colors.white,
                      onPressed: () {
                        context.go('/register');
                      },
                    )
                  : null,
              ),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Lütfen geçerli email ve şifre girin'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Giriş başarısız: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => context.go('/home'),
          tooltip: 'Anasayfa',
        ),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        loadingMessage: 'Signing in...',
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),

                // Welcome Text
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to your account',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: Validators.email,
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: Validators.password,
                  onFieldSubmitted: (_) => _login(),
                ),
                const SizedBox(height: 8),

                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _showForgotPasswordDialog,
                    child: const Text(
                      'Şifremi Unuttum',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Login Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 16),

                // Register Link
                TextButton(
                  onPressed: () => context.go('/register'),
                  child: const Text('Don\'t have an account? Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Şifremi Unuttum'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'E-posta adresinizi girin. Size şifre sıfırlama bağlantısı göndereceğiz.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-posta Adresi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
                hintText: 'ornek@email.com',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = emailController.text.trim();

              if (email.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('E-posta adresi gereklidir'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(email)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Geçerli bir e-posta adresi girin'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // Show loading dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 16),
                      Text('E-posta gönderiliyor...'),
                    ],
                  ),
                ),
              );

              try {
                // Get auth repository
                final authRepository = ref.read(authRepositoryProvider);
                
                // Check if user exists first
                final userExists = await authRepository.checkUserExists(email);
                
                if (!userExists) {
                  // Close loading dialog
                  Navigator.of(context).pop();
                  
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Bu e-posta adresi ile kayıtlı bir hesap bulunamadı. '
                        'Lütfen önce hesap oluşturun.',
                      ),
                      backgroundColor: Colors.orange,
                      duration: const Duration(seconds: 4),
                      action: SnackBarAction(
                        label: 'Kayıt Ol',
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop(); // Close forgot password dialog
                          context.go('/register');
                        },
                      ),
                    ),
                  );
                  return;
                }

                // Send password reset email
                await authRepository.resetPassword(email);

                // Close loading dialog
                Navigator.of(context).pop();

                // Close forgot password dialog
                Navigator.of(context).pop();

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Şifre sıfırlama bağlantısı $email adresine gönderildi. '
                      'E-posta kutunuzu kontrol edin.',
                    ),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 5),
                  ),
                );
              } catch (e) {
                // Close loading dialog
                Navigator.of(context).pop();

                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('E-posta gönderme hatası: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Gönder'),
          ),
        ],
      ),
    );
  }
}
