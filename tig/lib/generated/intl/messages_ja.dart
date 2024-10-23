// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja';

  static String m0(error) => "Google ログインに失敗しました\nERROR：${error}";

  static String m1(error) => "カカオログイン失敗\nERROR：${error}";

  static String m2(error) => "アプリを再起動してください。\nERROR：${error}";

  static String m3(month) => "${month}月のTigs";

  static String m4(price) => "${price}/月";

  static String m5(item) => "${item}が削除されました。";

  static String m6(minute, second) => "${minute}分 : ${second}秒";

  static String m7(endTime) => "終了時間：${endTime}";

  static String m8(startTime) => "開始時間：${startTime}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "auth_elon_musk": MessageLookupByLibrary.simpleMessage("イーロン・マスク"),
        "auth_for_time_box_planner":
            MessageLookupByLibrary.simpleMessage("目標を達成するために、"),
        "auth_google_login":
            MessageLookupByLibrary.simpleMessage("Google ログイン"),
        "auth_google_login_failure": m0,
        "auth_google_login_success":
            MessageLookupByLibrary.simpleMessage("Google ログイン成功"),
        "auth_kakao_login": MessageLookupByLibrary.simpleMessage("カカオログイン"),
        "auth_kakao_login_failure": m1,
        "auth_kakao_login_success":
            MessageLookupByLibrary.simpleMessage("カカオログイン成功"),
        "auth_palnner": MessageLookupByLibrary.simpleMessage("プランナーを選びました。"),
        "auth_pick_best": MessageLookupByLibrary.simpleMessage("最高の"),
        "auth_with_timebox_planner":
            MessageLookupByLibrary.simpleMessage("TimeBox Plannerに参加しましょう。"),
        "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "delete": MessageLookupByLibrary.simpleMessage("削除"),
        "end": MessageLookupByLibrary.simpleMessage("終了"),
        "end_time": MessageLookupByLibrary.simpleMessage("終了時間"),
        "exit": MessageLookupByLibrary.simpleMessage("出る"),
        "home_activity_placeholder":
            MessageLookupByLibrary.simpleMessage("やるべきことを書いてください。"),
        "home_arrange_title": MessageLookupByLibrary.simpleMessage("表示オプション"),
        "home_braindump_placeholder":
            MessageLookupByLibrary.simpleMessage("今思い浮かぶすべての考えを書いてください！"),
        "home_save_completed": MessageLookupByLibrary.simpleMessage("保存完了"),
        "home_save_completed_desc":
            MessageLookupByLibrary.simpleMessage("保存が完了しました。"),
        "home_save_desc": MessageLookupByLibrary.simpleMessage("保存する"),
        "home_tig_mode_prepare": MessageLookupByLibrary.simpleMessage(
            "ティグモードのためにデータを準備しています。\n準備中に広告が表示されます。\nしばらくお待ちください。🙏"),
        "main_restart": m2,
        "menu_contact_us": MessageLookupByLibrary.simpleMessage("お問い合わせ"),
        "menu_delete_user_failure": MessageLookupByLibrary.simpleMessage(
            "エラーが発生しました。\nしばらくしてからもう一度お試しください。"),
        "menu_email_body": MessageLookupByLibrary.simpleMessage(
            "以下の情報をお送りいただけると助かります。\n使用中のデバイス：\nエラーまたは改善点：\n\n他にご質問があれば、お気軽にご記入ください。:)"),
        "menu_email_subject": MessageLookupByLibrary.simpleMessage("お問い合わせ"),
        "menu_logout_content":
            MessageLookupByLibrary.simpleMessage("ログアウトしますか？"),
        "menu_logout_text": MessageLookupByLibrary.simpleMessage("ログアウト"),
        "menu_logout_title": MessageLookupByLibrary.simpleMessage("ログアウトガイド"),
        "menu_month_tigs": m3,
        "menu_price_per_month": m4,
        "menu_subscribe": MessageLookupByLibrary.simpleMessage("購読する"),
        "menu_subscribe_cancel":
            MessageLookupByLibrary.simpleMessage("購読をキャンセルする"),
        "menu_subscribe_get1":
            MessageLookupByLibrary.simpleMessage("購読すると広告が削除されます😊"),
        "menu_subscribe_get2": MessageLookupByLibrary.simpleMessage(
            "購読すると月別、日別の進行状況を確認できるウィジェットを提供します😊"),
        "menu_subscribe_get3": MessageLookupByLibrary.simpleMessage(
            "購読により開発者をサポートし、より良いアプリを作成するお手伝いができます😊"),
        "menu_subscribe_lose1":
            MessageLookupByLibrary.simpleMessage("購読をキャンセルすると、広告が再表示されます🥲"),
        "menu_subscribe_lose2": MessageLookupByLibrary.simpleMessage(
            "購読をキャンセルすると、進行状況を確認するウィジェットが削除されます🥲"),
        "menu_subscribe_lose3": MessageLookupByLibrary.simpleMessage(
            "購読をキャンセルすると、今後の機能が利用できなくなります🥲"),
        "menu_withdrawal_content": MessageLookupByLibrary.simpleMessage(
            "会員脱退時にすべての情報が削除されます。\nそれでも進めますか？"),
        "menu_withdrawal_text": MessageLookupByLibrary.simpleMessage("会員脱退"),
        "menu_withdrawal_title": MessageLookupByLibrary.simpleMessage("会員脱退案内"),
        "next": MessageLookupByLibrary.simpleMessage("次"),
        "ok": MessageLookupByLibrary.simpleMessage("確認"),
        "setting": MessageLookupByLibrary.simpleMessage("設定"),
        "success": MessageLookupByLibrary.simpleMessage("成功"),
        "tag_add": MessageLookupByLibrary.simpleMessage("タグを追加"),
        "tag_add_input":
            MessageLookupByLibrary.simpleMessage("追加するタグを入力してください。"),
        "tag_delete_completed": m5,
        "tag_delete_content":
            MessageLookupByLibrary.simpleMessage("このタグを削除してもよろしいですか？"),
        "tag_delete_title": MessageLookupByLibrary.simpleMessage("削除ガイド"),
        "tag_duplicated": MessageLookupByLibrary.simpleMessage("同じタグは登録できません。"),
        "tag_empty": MessageLookupByLibrary.simpleMessage("追加するタグを入力してください。"),
        "tag_title": MessageLookupByLibrary.simpleMessage("タグ"),
        "tig_mode": MessageLookupByLibrary.simpleMessage("ティグモード"),
        "tig_mode_count_down": m6,
        "tig_mode_empty_tig": MessageLookupByLibrary.simpleMessage(
            "現時点ではティグは存在しません。\nTigを登録して再起動してください😊"),
        "tig_mode_end_time": m7,
        "tig_mode_remain_time": MessageLookupByLibrary.simpleMessage("残り時間"),
        "tig_mode_start_time": m8,
        "tig_mode_waiting": MessageLookupByLibrary.simpleMessage("待機中")
      };
}
