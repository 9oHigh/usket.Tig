// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(error) =>
      "Google-Anmeldung fehlgeschlagen\nFEHLER: ${error}";

  static String m1(error) => "Kakao-Anmeldung fehlgeschlagen\nFEHLER: ${error}";

  static String m2(error) => "Bitte starten Sie die App neu.\nFEHLER: ${error}";

  static String m3(month) => "${month} Tigs";

  static String m4(price) => "${price} / Monat";

  static String m5(item) => "${item} wurde gelöscht.";

  static String m6(minute, second) => "${minute} : ${second}";

  static String m7(endTime) => "Endzeit: ${endTime}";

  static String m8(startTime) => "Startzeit: ${startTime}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "auth_elon_musk": MessageLookupByLibrary.simpleMessage("Elon Musk "),
        "auth_for_time_box_planner":
            MessageLookupByLibrary.simpleMessage("Um Ihre Ziele zu erreichen,"),
        "auth_google_login":
            MessageLookupByLibrary.simpleMessage("Google-Login"),
        "auth_google_login_failure": m0,
        "auth_google_login_success": MessageLookupByLibrary.simpleMessage(
            "Google-Anmeldung erfolgreich"),
        "auth_kakao_login": MessageLookupByLibrary.simpleMessage("Kakao-Login"),
        "auth_kakao_login_failure": m1,
        "auth_kakao_login_success":
            MessageLookupByLibrary.simpleMessage("Kakao-Anmeldung erfolgreich"),
        "auth_palnner": MessageLookupByLibrary.simpleMessage("Planer."),
        "auth_pick_best":
            MessageLookupByLibrary.simpleMessage("wählte den besten "),
        "auth_with_timebox_planner": MessageLookupByLibrary.simpleMessage(
            "treten Sie dem TimeBox Planner bei."),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "end": MessageLookupByLibrary.simpleMessage("Ende"),
        "end_time": MessageLookupByLibrary.simpleMessage("Endzeit"),
        "exit": MessageLookupByLibrary.simpleMessage("Beenden"),
        "home_activity_placeholder": MessageLookupByLibrary.simpleMessage(
            "Geben Sie eine Aktivität ein"),
        "home_arrange_title":
            MessageLookupByLibrary.simpleMessage("Ansichtsoptionen"),
        "home_braindump_placeholder": MessageLookupByLibrary.simpleMessage(
            "Schreiben Sie alle Gedanken auf, die Ihnen gerade durch den Kopf gehen!"),
        "home_save_completed":
            MessageLookupByLibrary.simpleMessage("Speichern abgeschlossen"),
        "home_save_completed_desc": MessageLookupByLibrary.simpleMessage(
            "Ihre Daten wurden erfolgreich gespeichert."),
        "home_save_desc": MessageLookupByLibrary.simpleMessage("Speichern"),
        "home_tig_mode_prepare": MessageLookupByLibrary.simpleMessage(
            "Daten für den Tig-Modus werden vorbereitet.\nWährend der Vorbereitung wird eine Anzeige gezeigt.\nBitte warten Sie 🙏"),
        "main_restart": m2,
        "menu_contact_us":
            MessageLookupByLibrary.simpleMessage("Kontaktieren Sie uns"),
        "menu_delete_user_failure": MessageLookupByLibrary.simpleMessage(
            "Ein Fehler ist aufgetreten.\nBitte versuchen Sie es später erneut."),
        "menu_email_body": MessageLookupByLibrary.simpleMessage(
            "Es wäre hilfreich, wenn Sie uns Folgendes mitteilen könnten:\nVerwendetes Gerät:\nProblem oder Verbesserungsvorschlag:\n\nFügen Sie gerne weitere Fragen hinzu :)"),
        "menu_email_subject":
            MessageLookupByLibrary.simpleMessage("Ich habe eine Frage"),
        "menu_logout_content":
            MessageLookupByLibrary.simpleMessage("Möchten Sie sich abmelden?"),
        "menu_logout_text": MessageLookupByLibrary.simpleMessage("Abmelden"),
        "menu_logout_title":
            MessageLookupByLibrary.simpleMessage("Abmeldeanleitung"),
        "menu_month_tigs": m3,
        "menu_price_per_month": m4,
        "menu_subscribe": MessageLookupByLibrary.simpleMessage("Abonnieren"),
        "menu_subscribe_cancel":
            MessageLookupByLibrary.simpleMessage("Abo kündigen"),
        "menu_subscribe_get1": MessageLookupByLibrary.simpleMessage(
            "Durch ein Abo werden alle Anzeigen entfernt 😊"),
        "menu_subscribe_get2": MessageLookupByLibrary.simpleMessage(
            "Sie können Widgets verwenden, um Ihren monatlichen und täglichen Fortschritt zu verfolgen 😊"),
        "menu_subscribe_get3": MessageLookupByLibrary.simpleMessage(
            "Sie unterstützen die Entwickler bei der Verbesserung der App 😊"),
        "menu_subscribe_lose1": MessageLookupByLibrary.simpleMessage(
            "Wenn Sie das Abo kündigen, werden die Anzeigen wieder erscheinen 🥲"),
        "menu_subscribe_lose2": MessageLookupByLibrary.simpleMessage(
            "Sie verlieren das Widget, das Ihren Fortschritt verfolgt 🥲"),
        "menu_subscribe_lose3": MessageLookupByLibrary.simpleMessage(
            "Sie verlieren den Zugriff auf kommende Funktionen 🥲"),
        "menu_update_intro":
            MessageLookupByLibrary.simpleMessage("Demnächst verfügbar."),
        "menu_withdrawal_content": MessageLookupByLibrary.simpleMessage(
            "Alle Ihre Daten werden gelöscht.\nMöchten Sie fortfahren?"),
        "menu_withdrawal_text":
            MessageLookupByLibrary.simpleMessage("Konto löschen"),
        "menu_withdrawal_title":
            MessageLookupByLibrary.simpleMessage("Kontolöschung"),
        "next": MessageLookupByLibrary.simpleMessage("Weiter"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "setting": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "success": MessageLookupByLibrary.simpleMessage("Erfolg"),
        "tag_add": MessageLookupByLibrary.simpleMessage("Tag hinzufügen"),
        "tag_add_input":
            MessageLookupByLibrary.simpleMessage("Geben Sie ein Tag ein"),
        "tag_delete_completed": m5,
        "tag_delete_content": MessageLookupByLibrary.simpleMessage(
            "Sind Sie sicher, dass Sie dieses Tag löschen möchten?"),
        "tag_delete_title":
            MessageLookupByLibrary.simpleMessage("Löschbestätigung"),
        "tag_duplicated": MessageLookupByLibrary.simpleMessage(
            "Tag kann nicht doppelt hinzugefügt werden."),
        "tag_empty":
            MessageLookupByLibrary.simpleMessage("Bitte geben Sie ein Tag ein"),
        "tag_title": MessageLookupByLibrary.simpleMessage("Tags"),
        "tig_mode": MessageLookupByLibrary.simpleMessage("Tig-Modus"),
        "tig_mode_count_down": m6,
        "tig_mode_empty_tig": MessageLookupByLibrary.simpleMessage(
            "Zurzeit gibt es keine Tigs.\nVersuchen Sie, eines hinzuzufügen, und starten Sie erneut 😊"),
        "tig_mode_end_time": m7,
        "tig_mode_remain_time":
            MessageLookupByLibrary.simpleMessage("Verbleibende Zeit"),
        "tig_mode_start_time": m8,
        "tig_mode_waiting": MessageLookupByLibrary.simpleMessage("Warten")
      };
}
