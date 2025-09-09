import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tig/presentation/page/auth/provider/auth_notifier_provider.dart';
import 'package:tig/presentation/page/home/home_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _startAnimations();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers() {
    _controllers = List.generate(
        3,
        (index) => AnimationController(
            vsync: this,
            duration: const Duration(
              milliseconds: 800,
            )));
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 750));
    for (var controller in _controllers) {
      controller.forward();
      await Future.delayed(const Duration(milliseconds: 750));
    }
    ref.read(authNotifierProvider.notifier).setAnimationCompleted(true);
  }

  void _pushHomeScreen() {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => const HomeScreen(),
    ));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(authNotifierProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Locale locale = Localizations.localeOf(context);
    final String imagePath = ['ko', 'ja', 'zh', 'es', 'de', 'en', 'pt']
            .contains(locale.languageCode.toLowerCase())
        ? locale.languageCode.toLowerCase()
        : 'en';

    Future.microtask(() {
      if (authProvider.message.isNotEmpty) _showSnackBar(authProvider.message);
      if (authProvider.isLoggedIn) _pushHomeScreen();
    });

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
                              style: _getTextStyle(context, isDarkMode,
                                  isBold: true),
                            ),
                            TextSpan(
                              text: Intl.message('auth_pick_best'),
                              style: _getTextStyle(context, isDarkMode),
                            ),
                            TextSpan(
                              text: Intl.message('auth_palnner'),
                              style: _getTextStyle(context, isDarkMode,
                                  isBold: true),
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
                _buildAnimatedText(Intl.message('auth_for_time_box_planner'),
                    _controllers[1], isDarkMode),
                const SizedBox(
                  height: 4,
                ),
                _buildAnimatedText(Intl.message('auth_with_timebox_planner'),
                    _controllers[2], isDarkMode),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: isDarkMode ? Colors.white : Colors.black),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: authProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildAuthButtons(imagePath),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _getTextStyle(BuildContext context, bool isDarkMode,
      {bool isBold = false}) {
    final Locale locale = Localizations.localeOf(context);
    String fontName = locale.languageCode == 'zh'
        ? "CangJiGaoDeGuoMiaoHei"
        : "PaperlogyRegular";
    return TextStyle(
      fontSize: 12,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: isDarkMode ? Colors.white : Colors.black,
    ).copyWith(fontFamily: fontName);
  }

  Widget _buildAuthButtons(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildAuthButton(
          onTap: () async =>
              await ref.read(authNotifierProvider.notifier).signInWithGoogle(),
          imagePath: "assets/images/login_button/google_login_$imagePath.png",
        ),
        const SizedBox(height: 4),
        _buildAuthButton(
          onTap: () async =>
              await ref.read(authNotifierProvider.notifier).signInWithKakao(),
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

  Widget _buildAnimatedText(
      String text, AnimationController controller, bool isDarkMode) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: controller.value,
          child: Text(text, style: _getTextStyle(context, isDarkMode)),
        );
      },
    );
  }
}
