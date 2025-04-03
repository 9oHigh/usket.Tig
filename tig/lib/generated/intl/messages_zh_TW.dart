// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_TW locale. All the
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
  String get localeName => 'zh_TW';

  static String m0(error) => "Google 登入失敗\n錯誤：${error}";

  static String m1(error) => "Kakao 登入失敗\n錯誤：${error}";

  static String m2(date) => "更改的日期是 ${date}。";

  static String m3(error) => "請重新啟動應用程式。\n錯誤：${error}";

  static String m4(month) => "${month}月提格";

  static String m5(price) => "${price} / 月";

  static String m6(item) => "${item} 已刪除。";

  static String m7(minute, second) => "${minute} : ${second}";

  static String m8(endTime) => "結束時間：${endTime}";

  static String m9(startTime) => "開始時間：${startTime}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "auth_elon_musk": MessageLookupByLibrary.simpleMessage("埃隆·馬斯克 "),
    "auth_for_time_box_planner": MessageLookupByLibrary.simpleMessage(
      "為了實現你的目標，",
    ),
    "auth_google_login": MessageLookupByLibrary.simpleMessage("Google 登入"),
    "auth_google_login_failure": m0,
    "auth_google_login_success": MessageLookupByLibrary.simpleMessage(
      "Google 登入成功",
    ),
    "auth_kakao_login": MessageLookupByLibrary.simpleMessage("Kakao 登入"),
    "auth_kakao_login_failure": m1,
    "auth_kakao_login_success": MessageLookupByLibrary.simpleMessage(
      "Kakao 登入成功",
    ),
    "auth_palnner": MessageLookupByLibrary.simpleMessage("計劃工具。"),
    "auth_pick_best": MessageLookupByLibrary.simpleMessage("選擇了最好的 "),
    "auth_with_timebox_planner": MessageLookupByLibrary.simpleMessage(
      "加入TimeBox Planner吧。",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "delete": MessageLookupByLibrary.simpleMessage("刪除"),
    "end": MessageLookupByLibrary.simpleMessage("結束"),
    "end_time": MessageLookupByLibrary.simpleMessage("結束時間"),
    "exit": MessageLookupByLibrary.simpleMessage("退出"),
    "home_activity_placeholder": MessageLookupByLibrary.simpleMessage(
      "請寫下您的待辦事項。",
    ),
    "home_arrange_title": MessageLookupByLibrary.simpleMessage("查看選項"),
    "home_braindump_placeholder": MessageLookupByLibrary.simpleMessage(
      "寫下您想到的所有想法！",
    ),
    "home_save_completed": MessageLookupByLibrary.simpleMessage("儲存完成"),
    "home_save_completed_desc": MessageLookupByLibrary.simpleMessage("儲存已完成。"),
    "home_save_desc": MessageLookupByLibrary.simpleMessage("儲存"),
    "home_swipe_date": m2,
    "home_tig_mode_prepare": MessageLookupByLibrary.simpleMessage(
      "正在為提格模式準備資料。\n準備過程中會顯示廣告。\n請稍等 🙏",
    ),
    "main_restart": m3,
    "menu_contact_us": MessageLookupByLibrary.simpleMessage("聯絡我們"),
    "menu_delete_user_failure": MessageLookupByLibrary.simpleMessage(
      "發生錯誤。\n請稍後重試。",
    ),
    "menu_email_body": MessageLookupByLibrary.simpleMessage(
      "請提供以下資訊以便我們幫助您。\n使用的設備：\n錯誤或改進意見：\n\n如果您有其他問題，請隨時聯繫：)",
    ),
    "menu_email_subject": MessageLookupByLibrary.simpleMessage("諮詢請求"),
    "menu_logout_content": MessageLookupByLibrary.simpleMessage("您確定要退出嗎？"),
    "menu_logout_text": MessageLookupByLibrary.simpleMessage("註銷"),
    "menu_logout_title": MessageLookupByLibrary.simpleMessage("註銷說明"),
    "menu_month_tigs": m4,
    "menu_price_per_month": m5,
    "menu_subscribe": MessageLookupByLibrary.simpleMessage("訂閱"),
    "menu_subscribe_cancel": MessageLookupByLibrary.simpleMessage("取消訂閱"),
    "menu_subscribe_get1": MessageLookupByLibrary.simpleMessage(
      "訂閱後，螢幕上的所有廣告將被刪除😊",
    ),
    "menu_subscribe_get2": MessageLookupByLibrary.simpleMessage(
      "訂閱後，您將獲得一個小工具，以查看每月和每日的進度😊",
    ),
    "menu_subscribe_get3": MessageLookupByLibrary.simpleMessage(
      "訂閱將支持開發者，幫助我們創造更好的應用😊",
    ),
    "menu_subscribe_lose1": MessageLookupByLibrary.simpleMessage(
      "如果您取消訂閱，廣告將重新出現在螢幕上🥲",
    ),
    "menu_subscribe_lose2": MessageLookupByLibrary.simpleMessage(
      "如果您取消訂閱，您將不再獲得查看進度的小工具🥲",
    ),
    "menu_subscribe_lose3": MessageLookupByLibrary.simpleMessage(
      "如果您取消訂閱，您將無法使用將來創建的功能🥲",
    ),
    "menu_update_intro": MessageLookupByLibrary.simpleMessage("即將推出。"),
    "menu_withdrawal_content": MessageLookupByLibrary.simpleMessage(
      "您取消會員資格時，所有資訊將被刪除。\n您是否確定要繼續？",
    ),
    "menu_withdrawal_text": MessageLookupByLibrary.simpleMessage("取消會員資格"),
    "menu_withdrawal_title": MessageLookupByLibrary.simpleMessage("退會資訊"),
    "next": MessageLookupByLibrary.simpleMessage("下一個"),
    "ok": MessageLookupByLibrary.simpleMessage("確認"),
    "option_explain_twelve": MessageLookupByLibrary.simpleMessage(
      "以12小時制顯示。(1:00 PM ... 12:00 PM)",
    ),
    "option_explain_twentyFour": MessageLookupByLibrary.simpleMessage(
      "以24小時制顯示。(13:00 ... 24:00)",
    ),
    "setting": MessageLookupByLibrary.simpleMessage("設定"),
    "success": MessageLookupByLibrary.simpleMessage("成功"),
    "tag_add": MessageLookupByLibrary.simpleMessage("添加標籤"),
    "tag_add_input": MessageLookupByLibrary.simpleMessage("請輸入要新增的標籤。"),
    "tag_delete_completed": m6,
    "tag_delete_content": MessageLookupByLibrary.simpleMessage("您確定要刪除此標籤嗎？"),
    "tag_delete_title": MessageLookupByLibrary.simpleMessage("刪除說明"),
    "tag_duplicated": MessageLookupByLibrary.simpleMessage("不能添加相同的標籤。"),
    "tag_empty": MessageLookupByLibrary.simpleMessage("請輸入要新增的標籤。"),
    "tag_title": MessageLookupByLibrary.simpleMessage("標籤"),
    "tig_mode": MessageLookupByLibrary.simpleMessage("提格模式"),
    "tig_mode_count_down": m7,
    "tig_mode_empty_tig": MessageLookupByLibrary.simpleMessage(
      "目前沒有提格。\n請註冊提格並重新啟動😊",
    ),
    "tig_mode_end_time": m8,
    "tig_mode_remain_time": MessageLookupByLibrary.simpleMessage("剩餘時間"),
    "tig_mode_start_time": m9,
    "tig_mode_waiting": MessageLookupByLibrary.simpleMessage("等待中"),
  };
}
