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
              GestureDetector(
                onTap: () async {
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
                child: SizedBox(
                  width: 200,
                  height: 44,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 14),
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: Image.asset("assets/images/google_logo.png"),
                          ),
                        ),
                        const Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "구글 로그인",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  final navigator = Navigator.of(context);
                  try {
                    await authUseCase.signInWithKakao();
                    messenger.showSnackBar(
                      const SnackBar(content: Text('카카오 로그인 성공')),
                    );
                    navigator.pushReplacementNamed('/home');
                  } catch (e) {
                    messenger.showSnackBar(
                      SnackBar(content: Text('카카오 로그인 실패: $e')),
                    );
                  }
                },
                child: SizedBox(
                    width: 200,
                    height: 44,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/kakao_login.png",
                        fit: BoxFit.fitWidth,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
