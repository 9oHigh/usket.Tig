// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
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
  String get localeName => 'zh_CN';

  static String m0(error) => "谷歌登录失败\n错误：${error}";

  static String m1(error) => "Kakao 登录失败\n错误：${error}";

  static String m2(error) => "请重新启动应用程序。\n错误：${error}";

  static String m3(month) => "${month}月提格";

  static String m4(price) => "${price} / 月";

  static String m5(item) => "${item} 已删除。";

  static String m6(minute, second) => "${minute} : ${second}";

  static String m7(endTime) => "结束时间：${endTime}";

  static String m8(startTime) => "开始时间：${startTime}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "auth_elon_musk": MessageLookupByLibrary.simpleMessage("埃隆·马斯克 "),
        "auth_for_time_box_planner":
            MessageLookupByLibrary.simpleMessage("为了实现你的目标，"),
        "auth_google_login": MessageLookupByLibrary.simpleMessage("谷歌登录"),
        "auth_google_login_failure": m0,
        "auth_google_login_success":
            MessageLookupByLibrary.simpleMessage("谷歌登录成功"),
        "auth_kakao_login": MessageLookupByLibrary.simpleMessage("Kakao 登录"),
        "auth_kakao_login_failure": m1,
        "auth_kakao_login_success":
            MessageLookupByLibrary.simpleMessage("Kakao 登录成功"),
        "auth_palnner": MessageLookupByLibrary.simpleMessage("计划工具。"),
        "auth_pick_best": MessageLookupByLibrary.simpleMessage("选择了最好的 "),
        "auth_with_timebox_planner":
            MessageLookupByLibrary.simpleMessage("加入TimeBox Planner吧。"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "end": MessageLookupByLibrary.simpleMessage("结束"),
        "end_time": MessageLookupByLibrary.simpleMessage("结束时间"),
        "exit": MessageLookupByLibrary.simpleMessage("退出"),
        "home_activity_placeholder":
            MessageLookupByLibrary.simpleMessage("请写下您的待办事项。"),
        "home_arrange_title": MessageLookupByLibrary.simpleMessage("查看选项"),
        "home_braindump_placeholder":
            MessageLookupByLibrary.simpleMessage("写下您想到的所有想法！"),
        "home_save_completed": MessageLookupByLibrary.simpleMessage("保存完成"),
        "home_save_completed_desc":
            MessageLookupByLibrary.simpleMessage("保存已完成。"),
        "home_save_desc": MessageLookupByLibrary.simpleMessage("保存"),
        "home_tig_mode_prepare": MessageLookupByLibrary.simpleMessage(
            "正在为提格模式准备数据。\n准备过程中会显示广告。\n请稍等 🙏"),
        "main_restart": m2,
        "menu_contact_us": MessageLookupByLibrary.simpleMessage("联系我们"),
        "menu_delete_user_failure":
            MessageLookupByLibrary.simpleMessage("发生错误。\n请稍后重试。"),
        "menu_email_body": MessageLookupByLibrary.simpleMessage(
            "请提供以下信息以便我们帮助您。\n使用的设备：\n错误或改进意见：\n\n如果您有其他问题，请随时联系：)"),
        "menu_email_subject": MessageLookupByLibrary.simpleMessage("咨询请求"),
        "menu_logout_content": MessageLookupByLibrary.simpleMessage("您确定要退出吗？"),
        "menu_logout_text": MessageLookupByLibrary.simpleMessage("注销"),
        "menu_logout_title": MessageLookupByLibrary.simpleMessage("注销说明"),
        "menu_month_tigs": m3,
        "menu_price_per_month": m4,
        "menu_subscribe": MessageLookupByLibrary.simpleMessage("订阅"),
        "menu_subscribe_cancel": MessageLookupByLibrary.simpleMessage("取消订阅"),
        "menu_subscribe_get1":
            MessageLookupByLibrary.simpleMessage("订阅后，屏幕上的所有广告将被删除😊"),
        "menu_subscribe_get2":
            MessageLookupByLibrary.simpleMessage("订阅后，您将获得一个小部件，以查看每月和每日的进度😊"),
        "menu_subscribe_get3":
            MessageLookupByLibrary.simpleMessage("订阅将支持开发者，帮助我们创造更好的应用😊"),
        "menu_subscribe_lose1":
            MessageLookupByLibrary.simpleMessage("如果您取消订阅，广告将重新出现在屏幕上🥲"),
        "menu_subscribe_lose2":
            MessageLookupByLibrary.simpleMessage("如果您取消订阅，您将不再获得查看进度的小部件🥲"),
        "menu_subscribe_lose3":
            MessageLookupByLibrary.simpleMessage("如果您取消订阅，您将无法使用将来创建的功能🥲"),
        "menu_update_intro": MessageLookupByLibrary.simpleMessage("即将推出"),
        "menu_withdrawal_content": MessageLookupByLibrary.simpleMessage(
            "您取消会员资格时，所有信息将被删除。\n您是否确定要继续？"),
        "menu_withdrawal_text": MessageLookupByLibrary.simpleMessage("取消会员资格"),
        "menu_withdrawal_title": MessageLookupByLibrary.simpleMessage("退会信息"),
        "next": MessageLookupByLibrary.simpleMessage("下一个"),
        "ok": MessageLookupByLibrary.simpleMessage("确认"),
        "setting": MessageLookupByLibrary.simpleMessage("设置"),
        "success": MessageLookupByLibrary.simpleMessage("成功"),
        "tag_add": MessageLookupByLibrary.simpleMessage("添加标签"),
        "tag_add_input": MessageLookupByLibrary.simpleMessage("请输入要添加的标签。"),
        "tag_delete_completed": m5,
        "tag_delete_content":
            MessageLookupByLibrary.simpleMessage("您确定要删除此标签吗？"),
        "tag_delete_title": MessageLookupByLibrary.simpleMessage("删除说明"),
        "tag_duplicated": MessageLookupByLibrary.simpleMessage("不能添加相同的标签。"),
        "tag_empty": MessageLookupByLibrary.simpleMessage("请输入要添加的标签。"),
        "tag_title": MessageLookupByLibrary.simpleMessage("标签"),
        "tig_mode": MessageLookupByLibrary.simpleMessage("提格模式"),
        "tig_mode_count_down": m6,
        "tig_mode_empty_tig":
            MessageLookupByLibrary.simpleMessage("当前没有提格。\n请注册提格并重新启动😊"),
        "tig_mode_end_time": m7,
        "tig_mode_remain_time": MessageLookupByLibrary.simpleMessage("剩余时间"),
        "tig_mode_start_time": m8,
        "tig_mode_waiting": MessageLookupByLibrary.simpleMessage("等待中")
      };
}
