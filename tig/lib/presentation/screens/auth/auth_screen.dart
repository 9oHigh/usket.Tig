import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';
import 'package:tig/presentation/providers/auth/auth_provider.dart';
import 'package:tig/presentation/screens/home/home_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  bool _isAnimationCompleted = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
        3,
        (index) => AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 800),
            ));
    _startAnimations();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 750));
    for (var controller in _controllers) {
      controller.forward();
      await Future.delayed(const Duration(milliseconds: 750));
    }
    _isAnimationCompleted = true;
  }

  Future<void> _signInWithGoogle(authProvider) async {
    if (!_isAnimationCompleted) return;

    setState(() {
      _isLoading = true;
    });

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      await authProvider.signInWithGoogle();
      await SharedPreferenceManager().setPref<bool>(PrefsType.isLoggedIn, true);
      messenger.showSnackBar(
        SnackBar(content: Text(Intl.message('auth_google_login_success'))),
      );
      navigator.pushReplacement(CupertinoPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
            content: Text(Intl.message('auth_google_login_failure',
                args: [e.toString()]))),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithKakao(authProvider) async {
    if (!_isAnimationCompleted) return;

    setState(() {
      _isLoading = true;
    });

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      await authProvider.signInWithKakao();
      await SharedPreferenceManager().setPref<bool>(PrefsType.isLoggedIn, true);
      messenger.showSnackBar(
        SnackBar(content: Text(Intl.message('auth_kakao_login_success'))),
      );
      navigator.pushReplacement(CupertinoPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
            content: Text(Intl.message('auth_kakao_login_failure',
                args: [e.toString()]))),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(authUseCaseProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Locale locale = Localizations.localeOf(context);
    String imagePath = locale.languageCode.toString().toLowerCase();
    if (!['ko', 'ja', 'zh', 'es', 'de', 'en', 'pt'].contains(imagePath)) {
      imagePath = 'en';
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(52),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              height: 200,
              child: isDarkMode
                  ? Image.asset("assets/images/dark_logo.png")
                  : Image.asset("assets/images/light_logo.png"),
            ),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controllers[0],
                  builder: (context, child) {
                    return Opacity(
                      opacity: _controllers[0].value,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: Intl.message('auth_elon_musk'),
                              style: _getTextStyle(context, isBold: true),
                            ),
                            TextSpan(
                              text: Intl.message('auth_pick_best'),
                              style: _getTextStyle(context),
                            ),
                            TextSpan(
                              text: Intl.message('auth_palnner'),
                              style: _getTextStyle(context, isBold: true),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 4,
                ),
                _buildAnimatedText(
                    Intl.message('auth_for_time_box_planner'), _controllers[1]),
                const SizedBox(
                  height: 4,
                ),
                _buildAnimatedText(
                    Intl.message('auth_with_timebox_planner'), _controllers[2]),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: isDarkMode ? Colors.white : Colors.black),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _buildAuthButtons(authProvider, imagePath),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _getTextStyle(BuildContext context, {bool isBold = false}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Locale locale = Localizations.localeOf(context);
    String fontName = "PaperlogyRegular";
    if (locale.languageCode == 'zh') {
      fontName = "CangJiGaoDeGuoMiaoHei";
    }
    return TextStyle(
      fontSize: 12,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: isDarkMode ? Colors.white : Colors.black,
    ).copyWith(fontFamily: fontName);
  }

  Widget _buildAuthButtons(authProvider, String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildAuthButton(
          onTap: () => _signInWithGoogle(authProvider),
          imagePath: "assets/images/login_button/google_login_$imagePath.png",
        ),
        const SizedBox(height: 4),
        _buildAuthButton(
          onTap: () => _signInWithKakao(authProvider),
          imagePath: "assets/images/login_button/kakao_login_$imagePath.png",
        ),
      ],
    );
  }

  Widget _buildAuthButton(
      {required VoidCallback onTap, required String imagePath}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 274.5,
        height: 50,
        child: Image.asset(imagePath),
      ),
    );
  }

  Widget _buildAnimatedText(String text, AnimationController controller) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: controller.value,
          child: Text(text, style: _getTextStyle(context)),
        );
      },
    );
  }
}
