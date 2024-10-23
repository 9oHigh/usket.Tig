// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(error) => "Google login failed\nERROR: ${error}";

  static String m1(error) => "Kakao login failed\nERROR: ${error}";

  static String m2(error) => "Please restart the app.\nERROR: ${error}";

  static String m3(month) => "${month} Tigs";

  static String m4(price) => "${price}/month";

  static String m5(item) => "${item} has been deleted.";

  static String m6(minute, second) => "${minute} : ${second}";

  static String m7(endTime) => "End time: ${endTime}";

  static String m8(startTime) => "Start time: ${startTime}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "auth_elon_musk": MessageLookupByLibrary.simpleMessage("Elon Musk "),
        "auth_for_time_box_planner":
            MessageLookupByLibrary.simpleMessage("To achieve your goals,"),
        "auth_google_login":
            MessageLookupByLibrary.simpleMessage("Google Login"),
        "auth_google_login_failure": m0,
        "auth_google_login_success":
            MessageLookupByLibrary.simpleMessage("Google login successful"),
        "auth_kakao_login": MessageLookupByLibrary.simpleMessage("Kakao Login"),
        "auth_kakao_login_failure": m1,
        "auth_kakao_login_success":
            MessageLookupByLibrary.simpleMessage("Kakao login successful"),
        "auth_palnner": MessageLookupByLibrary.simpleMessage("planner."),
        "auth_pick_best":
            MessageLookupByLibrary.simpleMessage("chose the best "),
        "auth_with_timebox_planner":
            MessageLookupByLibrary.simpleMessage("join TimeBox Planner."),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "end": MessageLookupByLibrary.simpleMessage("End"),
        "end_time": MessageLookupByLibrary.simpleMessage("End time"),
        "exit": MessageLookupByLibrary.simpleMessage("Exit"),
        "home_activity_placeholder":
            MessageLookupByLibrary.simpleMessage("Enter an activity"),
        "home_arrange_title":
            MessageLookupByLibrary.simpleMessage("View Options"),
        "home_braindump_placeholder": MessageLookupByLibrary.simpleMessage(
            "Write down all the thoughts going through your mind right now!"),
        "home_save_completed":
            MessageLookupByLibrary.simpleMessage("Save Completed"),
        "home_save_completed_desc": MessageLookupByLibrary.simpleMessage(
            "Your data has been saved successfully."),
        "home_save_desc": MessageLookupByLibrary.simpleMessage("Save"),
        "home_tig_mode_prepare": MessageLookupByLibrary.simpleMessage(
            "Preparing data for Tig Mode.\nYou will see an ad while it is being prepared.\nPlease wait 🙏"),
        "main_restart": m2,
        "menu_contact_us": MessageLookupByLibrary.simpleMessage("Contact us"),
        "menu_delete_user_failure": MessageLookupByLibrary.simpleMessage(
            "An error occurred.\nPlease try again later."),
        "menu_email_body": MessageLookupByLibrary.simpleMessage(
            "It would be helpful if you could send the following:\nDevice you\'re using:\nIssue or improvement:\n\nFeel free to add any other questions :)"),
        "menu_email_subject":
            MessageLookupByLibrary.simpleMessage("I have a question"),
        "menu_logout_content":
            MessageLookupByLibrary.simpleMessage("Do you want to log out?"),
        "menu_logout_text": MessageLookupByLibrary.simpleMessage("Logout"),
        "menu_logout_title":
            MessageLookupByLibrary.simpleMessage("Logout Guide"),
        "menu_month_tigs": m3,
        "menu_price_per_month": m4,
        "menu_subscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
        "menu_subscribe_cancel":
            MessageLookupByLibrary.simpleMessage("Unsubscribe"),
        "menu_subscribe_get1": MessageLookupByLibrary.simpleMessage(
            "When you subscribe, all ads will be removed 😊"),
        "menu_subscribe_get2": MessageLookupByLibrary.simpleMessage(
            "You can use widgets to track your monthly and daily progress 😊"),
        "menu_subscribe_get3": MessageLookupByLibrary.simpleMessage(
            "You’ll help developers improve the app 😊"),
        "menu_subscribe_lose1": MessageLookupByLibrary.simpleMessage(
            "Unsubscribe, and ads will return 🥲"),
        "menu_subscribe_lose2": MessageLookupByLibrary.simpleMessage(
            "You’ll lose the widget that tracks your progress 🥲"),
        "menu_subscribe_lose3": MessageLookupByLibrary.simpleMessage(
            "You won’t be able to access upcoming features 🥲"),
        "menu_withdrawal_content": MessageLookupByLibrary.simpleMessage(
            "All your data will be deleted.\nDo you want to proceed?"),
        "menu_withdrawal_text":
            MessageLookupByLibrary.simpleMessage("Delete account"),
        "menu_withdrawal_title":
            MessageLookupByLibrary.simpleMessage("Account Deletion Guide"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "setting": MessageLookupByLibrary.simpleMessage("Settings"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "tag_add": MessageLookupByLibrary.simpleMessage("Add tag"),
        "tag_add_input": MessageLookupByLibrary.simpleMessage("Enter a tag"),
        "tag_delete_completed": m5,
        "tag_delete_content": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this tag?"),
        "tag_delete_title":
            MessageLookupByLibrary.simpleMessage("Delete Confirmation"),
        "tag_duplicated": MessageLookupByLibrary.simpleMessage(
            "You can\'t add the same tag twice."),
        "tag_empty": MessageLookupByLibrary.simpleMessage("Enter a tag to add"),
        "tag_title": MessageLookupByLibrary.simpleMessage("Tags"),
        "tig_mode": MessageLookupByLibrary.simpleMessage("Tig Mode"),
        "tig_mode_count_down": m6,
        "tig_mode_empty_tig": MessageLookupByLibrary.simpleMessage(
            "No tig is available right now.\nTry adding one and restart 😊"),
        "tig_mode_end_time": m7,
        "tig_mode_remain_time":
            MessageLookupByLibrary.simpleMessage("Remaining time"),
        "tig_mode_start_time": m8,
        "tig_mode_waiting": MessageLookupByLibrary.simpleMessage("Waiting")
      };
}
