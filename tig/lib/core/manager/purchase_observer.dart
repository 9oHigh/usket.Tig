import 'dart:async';
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io' show Platform;

class PurchasesObserver {
  void Function(AdaptyError)? onAdaptyErrorOccurred;
  void Function(Object)? onUnknownErrorOccurred;

  final adapty = Adapty();
  String localizedPrice = '990₩';

  static final PurchasesObserver _instance = PurchasesObserver._internal();
  factory PurchasesObserver() => _instance;
  PurchasesObserver._internal();

  bool isSubscribed = false;

  Future<void> initialize() async {
    try {
      adapty.setLogLevel(AdaptyLogLevel.verbose);
      adapty.activate();
      await _getLocalizedPrice();
      await _setFallbackPaywalls();
    } catch (e) {
      return;
    }
  }

  Future<void> _getLocalizedPrice() async {
    try {
      final paywall = await adapty.getPaywall(placementId: "settings");
      final products = await adapty.getPaywallProducts(paywall: paywall);

      if (products.isNotEmpty) {
        final localizedPrice = products.first.price.localizedString;
        this.localizedPrice = localizedPrice ?? "990₩";
      }
    } on AdaptyError catch (error) {
      onAdaptyErrorOccurred?.call(error);
    } catch (e) {
      onUnknownErrorOccurred?.call(e);
    }
  }

  Future<void> _setFallbackPaywalls() async {
    final filePath = Platform.isIOS
        ? 'assets/fallback_ios.json'
        : 'assets/fallback_android.json';
    final jsonString = await rootBundle.loadString(filePath);

    try {
      await adapty.setFallbackPaywalls(jsonString);
    } on AdaptyError catch (adaptyError) {
      onAdaptyErrorOccurred?.call(adaptyError);
    } catch (e) {
      onUnknownErrorOccurred?.call(e);
    }
  }

  Future<void> checkSubscriptionStatus() async {
    try {
      final profile = await adapty.getProfile();
      isSubscribed = profile.accessLevels["premium"]?.isActive ?? false;
    } on AdaptyError catch (error) {
      onAdaptyErrorOccurred?.call(error);
    } catch (e) {
      onUnknownErrorOccurred?.call(e);
    }
  }

  Future<AdaptyPaywallProduct?> getSubscriptionProduct(String paywallId) async {
    try {
      final paywall = await adapty.getPaywall(placementId: paywallId);
      final products = await adapty.getPaywallProducts(paywall: paywall);
      if (products.isNotEmpty) {
        return products.first;
      }
    } on AdaptyError catch (error) {
      onAdaptyErrorOccurred?.call(error);
    } catch (e) {
      onUnknownErrorOccurred?.call(e);
    }
    return null;
  }

  Future<void> purchaseSubscription(AdaptyPaywallProduct product) async {
    try {
      final profile = await adapty.makePurchase(product: product);
      isSubscribed = profile?.accessLevels["premium"]?.isActive ?? false;
    } on AdaptyError catch (error) {
      onAdaptyErrorOccurred?.call(error);
    } catch (e) {
      onUnknownErrorOccurred?.call(e);
    }
  }

  Future<void> restorePurchases() async {
    try {
      final profile = await adapty.restorePurchases();
      isSubscribed = profile.accessLevels["premium"]?.isActive ?? false;
    } on AdaptyError catch (error) {
      onAdaptyErrorOccurred?.call(error);
    } catch (e) {
      onUnknownErrorOccurred?.call(e);
    }
  }
}
