import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tig/core/helpers/helpers.dart';
import 'package:tig/core/routes/app_navigator.dart';
import 'package:tig/generated/l10n.dart';
import 'package:tig/ads/admob_service.dart';
import 'package:tig/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tig/core/manager/purchase_observer.dart';
import 'package:tig/presentation/screens/subscribe_tig_app.dart';
import 'package:tig/presentation/screens/unsubscribe_tig_app.dart';
import 'firebase_options.dart';
import 'package:home_widget/home_widget.dart';

void main() async {
  
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HomeWidget.registerInteractivityCallback(backgroundCallback);

  final purchasesObserver = PurchasesObserver();
  await purchasesObserver.initialize();
  await purchasesObserver.checkSubscriptionStatus();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"));
  
  runApp(
    ProviderScope(
      child: TigApp(
        isSubscribed: purchasesObserver.isSubscribed,
      ),
    ),
  );
}

Future<void> backgroundCallback(Uri? uri) async {
  // MARK: - 위젯 클릭시 홈화면 이동 추가
}

class TigApp extends StatelessWidget {
  final bool isSubscribed;
  const TigApp({super.key, required this.isSubscribed});

  @override
  Widget build(BuildContext context) {
    return isSubscribed ? const SubscribedTigApp() : const UnSubscribedTigApp();
  }
}
