// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `End time`
  String get end_time {
    return Intl.message('End time', name: 'end_time', desc: '', args: []);
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Tig Mode`
  String get tig_mode {
    return Intl.message('Tig Mode', name: 'tig_mode', desc: '', args: []);
  }

  /// `Settings`
  String get setting {
    return Intl.message('Settings', name: 'setting', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `End`
  String get end {
    return Intl.message('End', name: 'end', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Please restart the app.\nERROR: {error}`
  String main_restart(Object error) {
    return Intl.message(
      'Please restart the app.\nERROR: $error',
      name: 'main_restart',
      desc: '',
      args: [error],
    );
  }

  /// `Google login successful`
  String get auth_google_login_success {
    return Intl.message(
      'Google login successful',
      name: 'auth_google_login_success',
      desc: '',
      args: [],
    );
  }

  /// `Google login failed\nERROR: {error}`
  String auth_google_login_failure(Object error) {
    return Intl.message(
      'Google login failed\nERROR: $error',
      name: 'auth_google_login_failure',
      desc: '',
      args: [error],
    );
  }

  /// `Google Login`
  String get auth_google_login {
    return Intl.message(
      'Google Login',
      name: 'auth_google_login',
      desc: '',
      args: [],
    );
  }

  /// `Kakao login successful`
  String get auth_kakao_login_success {
    return Intl.message(
      'Kakao login successful',
      name: 'auth_kakao_login_success',
      desc: '',
      args: [],
    );
  }

  /// `Kakao login failed\nERROR: {error}`
  String auth_kakao_login_failure(Object error) {
    return Intl.message(
      'Kakao login failed\nERROR: $error',
      name: 'auth_kakao_login_failure',
      desc: '',
      args: [error],
    );
  }

  /// `Kakao Login`
  String get auth_kakao_login {
    return Intl.message(
      'Kakao Login',
      name: 'auth_kakao_login',
      desc: '',
      args: [],
    );
  }

  /// `Elon Musk `
  String get auth_elon_musk {
    return Intl.message(
      'Elon Musk ',
      name: 'auth_elon_musk',
      desc: '',
      args: [],
    );
  }

  /// `chose the best `
  String get auth_pick_best {
    return Intl.message(
      'chose the best ',
      name: 'auth_pick_best',
      desc: '',
      args: [],
    );
  }

  /// `planner.`
  String get auth_palnner {
    return Intl.message('planner.', name: 'auth_palnner', desc: '', args: []);
  }

  /// `To achieve your goals,`
  String get auth_for_time_box_planner {
    return Intl.message(
      'To achieve your goals,',
      name: 'auth_for_time_box_planner',
      desc: '',
      args: [],
    );
  }

  /// `join TimeBox Planner.`
  String get auth_with_timebox_planner {
    return Intl.message(
      'join TimeBox Planner.',
      name: 'auth_with_timebox_planner',
      desc: '',
      args: [],
    );
  }

  /// `View Options`
  String get home_arrange_title {
    return Intl.message(
      'View Options',
      name: 'home_arrange_title',
      desc: '',
      args: [],
    );
  }

  /// `Save Completed`
  String get home_save_completed {
    return Intl.message(
      'Save Completed',
      name: 'home_save_completed',
      desc: '',
      args: [],
    );
  }

  /// `Your data has been saved successfully.`
  String get home_save_completed_desc {
    return Intl.message(
      'Your data has been saved successfully.',
      name: 'home_save_completed_desc',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get home_save_desc {
    return Intl.message('Save', name: 'home_save_desc', desc: '', args: []);
  }

  /// `Preparing data for Tig Mode.\nYou will see an ad while it is being prepared.\nPlease wait 🙏`
  String get home_tig_mode_prepare {
    return Intl.message(
      'Preparing data for Tig Mode.\nYou will see an ad while it is being prepared.\nPlease wait 🙏',
      name: 'home_tig_mode_prepare',
      desc: '',
      args: [],
    );
  }

  /// `Write down all the thoughts going through your mind right now!`
  String get home_braindump_placeholder {
    return Intl.message(
      'Write down all the thoughts going through your mind right now!',
      name: 'home_braindump_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Enter an activity`
  String get home_activity_placeholder {
    return Intl.message(
      'Enter an activity',
      name: 'home_activity_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `The changed date is {date}.`
  String home_swipe_date(Object date) {
    return Intl.message(
      'The changed date is $date.',
      name: 'home_swipe_date',
      desc: '',
      args: [date],
    );
  }

  /// `I have a question`
  String get menu_email_subject {
    return Intl.message(
      'I have a question',
      name: 'menu_email_subject',
      desc: '',
      args: [],
    );
  }

  /// `It would be helpful if you could send the following:\nDevice you're using:\nIssue or improvement:\n\nFeel free to add any other questions :)`
  String get menu_email_body {
    return Intl.message(
      'It would be helpful if you could send the following:\nDevice you\'re using:\nIssue or improvement:\n\nFeel free to add any other questions :)',
      name: 'menu_email_body',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred.\nPlease try again later.`
  String get menu_delete_user_failure {
    return Intl.message(
      'An error occurred.\nPlease try again later.',
      name: 'menu_delete_user_failure',
      desc: '',
      args: [],
    );
  }

  /// `{month} Tigs`
  String menu_month_tigs(Object month) {
    return Intl.message(
      '$month Tigs',
      name: 'menu_month_tigs',
      desc: '',
      args: [month],
    );
  }

  /// `Subscribe`
  String get menu_subscribe {
    return Intl.message(
      'Subscribe',
      name: 'menu_subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Unsubscribe`
  String get menu_subscribe_cancel {
    return Intl.message(
      'Unsubscribe',
      name: 'menu_subscribe_cancel',
      desc: '',
      args: [],
    );
  }

  /// `{price} / month`
  String menu_price_per_month(Object price) {
    return Intl.message(
      '$price / month',
      name: 'menu_price_per_month',
      desc: '',
      args: [price],
    );
  }

  /// `When you subscribe, all ads will be removed 😊`
  String get menu_subscribe_get1 {
    return Intl.message(
      'When you subscribe, all ads will be removed 😊',
      name: 'menu_subscribe_get1',
      desc: '',
      args: [],
    );
  }

  /// `You can use widgets to track your monthly and daily progress 😊`
  String get menu_subscribe_get2 {
    return Intl.message(
      'You can use widgets to track your monthly and daily progress 😊',
      name: 'menu_subscribe_get2',
      desc: '',
      args: [],
    );
  }

  /// `You’ll help developers improve the app 😊`
  String get menu_subscribe_get3 {
    return Intl.message(
      'You’ll help developers improve the app 😊',
      name: 'menu_subscribe_get3',
      desc: '',
      args: [],
    );
  }

  /// `Unsubscribe, and ads will return 🥲`
  String get menu_subscribe_lose1 {
    return Intl.message(
      'Unsubscribe, and ads will return 🥲',
      name: 'menu_subscribe_lose1',
      desc: '',
      args: [],
    );
  }

  /// `You’ll lose the widget that tracks your progress 🥲`
  String get menu_subscribe_lose2 {
    return Intl.message(
      'You’ll lose the widget that tracks your progress 🥲',
      name: 'menu_subscribe_lose2',
      desc: '',
      args: [],
    );
  }

  /// `You won’t be able to access upcoming features 🥲`
  String get menu_subscribe_lose3 {
    return Intl.message(
      'You won’t be able to access upcoming features 🥲',
      name: 'menu_subscribe_lose3',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon.`
  String get menu_update_intro {
    return Intl.message(
      'Coming soon.',
      name: 'menu_update_intro',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get menu_contact_us {
    return Intl.message(
      'Contact us',
      name: 'menu_contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get menu_withdrawal_text {
    return Intl.message(
      'Delete account',
      name: 'menu_withdrawal_text',
      desc: '',
      args: [],
    );
  }

  /// `Account Deletion Guide`
  String get menu_withdrawal_title {
    return Intl.message(
      'Account Deletion Guide',
      name: 'menu_withdrawal_title',
      desc: '',
      args: [],
    );
  }

  /// `All your data will be deleted.\nDo you want to proceed?`
  String get menu_withdrawal_content {
    return Intl.message(
      'All your data will be deleted.\nDo you want to proceed?',
      name: 'menu_withdrawal_content',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get menu_logout_text {
    return Intl.message('Logout', name: 'menu_logout_text', desc: '', args: []);
  }

  /// `Logout Guide`
  String get menu_logout_title {
    return Intl.message(
      'Logout Guide',
      name: 'menu_logout_title',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to log out?`
  String get menu_logout_content {
    return Intl.message(
      'Do you want to log out?',
      name: 'menu_logout_content',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tag_title {
    return Intl.message('Tags', name: 'tag_title', desc: '', args: []);
  }

  /// `Add tag`
  String get tag_add {
    return Intl.message('Add tag', name: 'tag_add', desc: '', args: []);
  }

  /// `Enter a tag`
  String get tag_add_input {
    return Intl.message(
      'Enter a tag',
      name: 'tag_add_input',
      desc: '',
      args: [],
    );
  }

  /// `Enter a tag to add`
  String get tag_empty {
    return Intl.message(
      'Enter a tag to add',
      name: 'tag_empty',
      desc: '',
      args: [],
    );
  }

  /// `You can't add the same tag twice.`
  String get tag_duplicated {
    return Intl.message(
      'You can\'t add the same tag twice.',
      name: 'tag_duplicated',
      desc: '',
      args: [],
    );
  }

  /// `Delete Confirmation`
  String get tag_delete_title {
    return Intl.message(
      'Delete Confirmation',
      name: 'tag_delete_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this tag?`
  String get tag_delete_content {
    return Intl.message(
      'Are you sure you want to delete this tag?',
      name: 'tag_delete_content',
      desc: '',
      args: [],
    );
  }

  /// `{item} has been deleted.`
  String tag_delete_completed(Object item) {
    return Intl.message(
      '$item has been deleted.',
      name: 'tag_delete_completed',
      desc: '',
      args: [item],
    );
  }

  /// `No tig is available right now.\nTry adding one and restart 😊`
  String get tig_mode_empty_tig {
    return Intl.message(
      'No tig is available right now.\nTry adding one and restart 😊',
      name: 'tig_mode_empty_tig',
      desc: '',
      args: [],
    );
  }

  /// `Start time: {startTime}`
  String tig_mode_start_time(Object startTime) {
    return Intl.message(
      'Start time: $startTime',
      name: 'tig_mode_start_time',
      desc: '',
      args: [startTime],
    );
  }

  /// `End time: {endTime}`
  String tig_mode_end_time(Object endTime) {
    return Intl.message(
      'End time: $endTime',
      name: 'tig_mode_end_time',
      desc: '',
      args: [endTime],
    );
  }

  /// `Waiting`
  String get tig_mode_waiting {
    return Intl.message(
      'Waiting',
      name: 'tig_mode_waiting',
      desc: '',
      args: [],
    );
  }

  /// `Remaining time`
  String get tig_mode_remain_time {
    return Intl.message(
      'Remaining time',
      name: 'tig_mode_remain_time',
      desc: '',
      args: [],
    );
  }

  /// `{minute} : {second}`
  String tig_mode_count_down(Object minute, Object second) {
    return Intl.message(
      '$minute : $second',
      name: 'tig_mode_count_down',
      desc: '',
      args: [minute, second],
    );
  }

  /// `Displayed in 12-hour format.\n(1:00 PM ... 12:00 PM)`
  String get option_explain_twelve {
    return Intl.message(
      'Displayed in 12-hour format.\n(1:00 PM ... 12:00 PM)',
      name: 'option_explain_twelve',
      desc: '',
      args: [],
    );
  }

  /// `Displayed in 24-hour format.\n(13:00 ... 24:00)`
  String get option_explain_twentyFour {
    return Intl.message(
      'Displayed in 24-hour format.\n(13:00 ... 24:00)',
      name: 'option_explain_twentyFour',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
