// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(error) =>
      "Error al iniciar sesión en Google.\nERROR: ${error}";

  static String m1(error) =>
      "Error al iniciar sesión en Kakao.\nERROR: ${error}";

  static String m2(error) => "Reinicie la aplicación.\nERROR: ${error}";

  static String m3(month) => "Tigs de ${month}";

  static String m4(price) => "${price} / mes";

  static String m5(item) => "${item} ha sido eliminado.";

  static String m6(minute, second) => "${minute} : ${second}";

  static String m7(endTime) => "Hora de finalización: ${endTime}";

  static String m8(startTime) => "Hora de inicio: ${startTime}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "auth_elon_musk": MessageLookupByLibrary.simpleMessage("Elon Musk "),
        "auth_for_time_box_planner": MessageLookupByLibrary.simpleMessage(
            "Para alcanzar tus objetivos,"),
        "auth_google_login":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión con Google"),
        "auth_google_login_failure": m0,
        "auth_google_login_success": MessageLookupByLibrary.simpleMessage(
            "Inicio de sesión en Google exitoso."),
        "auth_kakao_login":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión con Kakao"),
        "auth_kakao_login_failure": m1,
        "auth_kakao_login_success": MessageLookupByLibrary.simpleMessage(
            "Inicio de sesión en Kakao exitoso."),
        "auth_palnner": MessageLookupByLibrary.simpleMessage("planificador."),
        "auth_pick_best":
            MessageLookupByLibrary.simpleMessage("eligió el mejor "),
        "auth_with_timebox_planner":
            MessageLookupByLibrary.simpleMessage("únete a TimeBox Planner."),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "end": MessageLookupByLibrary.simpleMessage("Finalizar"),
        "end_time":
            MessageLookupByLibrary.simpleMessage("Hora de finalización"),
        "exit": MessageLookupByLibrary.simpleMessage("Salir"),
        "home_activity_placeholder":
            MessageLookupByLibrary.simpleMessage("Escribe tus tareas."),
        "home_arrange_title":
            MessageLookupByLibrary.simpleMessage("Opciones de vista"),
        "home_braindump_placeholder": MessageLookupByLibrary.simpleMessage(
            "¡Escribe todos los pensamientos que te vengan a la mente ahora mismo!"),
        "home_save_completed":
            MessageLookupByLibrary.simpleMessage("Guardado completado."),
        "home_save_completed_desc":
            MessageLookupByLibrary.simpleMessage("¡Guardado exitoso!"),
        "home_save_desc": MessageLookupByLibrary.simpleMessage("Guardar"),
        "home_tig_mode_prepare": MessageLookupByLibrary.simpleMessage(
            "Preparando datos para el modo TIG.\nSe mostrarán anuncios durante la preparación.\nPor favor, espera un momento 🙏"),
        "main_restart": m2,
        "menu_contact_us": MessageLookupByLibrary.simpleMessage("Contáctanos"),
        "menu_delete_user_failure": MessageLookupByLibrary.simpleMessage(
            "Se produjo un error.\nInténtalo de nuevo más tarde."),
        "menu_email_body": MessageLookupByLibrary.simpleMessage(
            "Sería de gran ayuda si nos envías la siguiente información:\nDispositivo en uso:\nErrores o mejoras:\n\nSi tienes alguna otra consulta, no dudes en escribirnos :)"),
        "menu_email_subject":
            MessageLookupByLibrary.simpleMessage("Quisiera consultar."),
        "menu_logout_content":
            MessageLookupByLibrary.simpleMessage("¿Quieres cerrar sesión?"),
        "menu_logout_text":
            MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
        "menu_logout_title": MessageLookupByLibrary.simpleMessage(
            "Instrucciones para cerrar sesión"),
        "menu_month_tigs": m3,
        "menu_price_per_month": m4,
        "menu_subscribe": MessageLookupByLibrary.simpleMessage("Suscribirse"),
        "menu_subscribe_cancel":
            MessageLookupByLibrary.simpleMessage("Cancelar suscripción"),
        "menu_subscribe_get1": MessageLookupByLibrary.simpleMessage(
            "Se eliminarán todos los anuncios 😊"),
        "menu_subscribe_get2": MessageLookupByLibrary.simpleMessage(
            "Ofrecemos un widget donde puedes verificar tu progreso mensual y diario 😊"),
        "menu_subscribe_get3": MessageLookupByLibrary.simpleMessage(
            "Puedes ayudar a los desarrolladores a crear mejores aplicaciones 😊"),
        "menu_subscribe_lose1": MessageLookupByLibrary.simpleMessage(
            "Los anuncios volverán a aparecer en tu pantalla 🥲"),
        "menu_subscribe_lose2": MessageLookupByLibrary.simpleMessage(
            "Ya no proporcionaremos un widget para verificar tu progreso mensual y diario 🥲"),
        "menu_subscribe_lose3": MessageLookupByLibrary.simpleMessage(
            "No podrás usar las funciones que se añadirán en el futuro 🥲"),
        "menu_update_intro":
            MessageLookupByLibrary.simpleMessage("Próximamente."),
        "menu_withdrawal_content": MessageLookupByLibrary.simpleMessage(
            "Al cancelar tu membresía, se eliminará toda la información.\n¿Aún deseas continuar?"),
        "menu_withdrawal_text":
            MessageLookupByLibrary.simpleMessage("Cancelación de membresía"),
        "menu_withdrawal_title": MessageLookupByLibrary.simpleMessage(
            "Información de cancelación de membresía"),
        "next": MessageLookupByLibrary.simpleMessage("Siguiente"),
        "ok": MessageLookupByLibrary.simpleMessage("Aceptar"),
        "setting": MessageLookupByLibrary.simpleMessage("Configuración"),
        "success": MessageLookupByLibrary.simpleMessage("Éxito"),
        "tag_add": MessageLookupByLibrary.simpleMessage("Agregar etiqueta"),
        "tag_add_input": MessageLookupByLibrary.simpleMessage(
            "Ingrese la etiqueta a agregar."),
        "tag_delete_completed": m5,
        "tag_delete_content": MessageLookupByLibrary.simpleMessage(
            "¿Estás seguro de que deseas eliminar esta etiqueta?"),
        "tag_delete_title": MessageLookupByLibrary.simpleMessage(
            "Instrucciones de eliminación"),
        "tag_duplicated": MessageLookupByLibrary.simpleMessage(
            "No se pueden registrar etiquetas idénticas."),
        "tag_empty": MessageLookupByLibrary.simpleMessage(
            "Ingresa la etiqueta a agregar."),
        "tag_title": MessageLookupByLibrary.simpleMessage("Etiqueta"),
        "tig_mode": MessageLookupByLibrary.simpleMessage("Modo Tig"),
        "tig_mode_count_down": m6,
        "tig_mode_empty_tig": MessageLookupByLibrary.simpleMessage(
            "No hay TIG en este momento.\nRegistra un TIG y comienza de nuevo 😊"),
        "tig_mode_end_time": m7,
        "tig_mode_remain_time":
            MessageLookupByLibrary.simpleMessage("Tiempo restante"),
        "tig_mode_start_time": m8,
        "tig_mode_waiting": MessageLookupByLibrary.simpleMessage("Esperando")
      };
}
