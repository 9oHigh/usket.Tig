import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/presentation/providers/auth/auth_provider.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUseCase = ref.watch(authUseCaseProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  final navigator = Navigator.of(context);
                  try {
                    await authUseCase.signInWithGoogle();
                    messenger.showSnackBar(
                      const SnackBar(content: Text('구글 로그인 성공')),
                    );
                    navigator.pushReplacementNamed('/home');
                  } catch (e) {
                    messenger.showSnackBar(
                      SnackBar(content: Text('로그인 실패: $e')),
                    );
                  }
                },
                child: const Text('구글로 로그인하기'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  final navigator = Navigator.of(context);
                  try {
                    await authUseCase.signInWithApple();
                    messenger.showSnackBar(
                      const SnackBar(content: Text('애플 로그인 성공')),
                    );
                    navigator.pushReplacementNamed('/home');
                  } catch (e) {
                    messenger.showSnackBar(
                      SnackBar(content: Text('로그인 실패: $e')),
                    );
                  }
                },
                child: const Text('애플로 로그인하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
