// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(error) => "Falha no login do Google\nERRO: ${error}";

  static String m1(error) => "Falha no login do Kakao\nERRO: ${error}";

  static String m2(error) => "Reinicie o aplicativo.\nERRO: ${error}";

  static String m3(month) => "${month} Tigs";

  static String m4(price) => "${price}/mês";

  static String m5(item) => "${item} foi removido.";

  static String m6(minute, second) => "${minute}: ${second}";

  static String m7(endTime) => "Horário de término: ${endTime}";

  static String m8(startTime) => "Hora de início: ${startTime}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "auth_elon_musk": MessageLookupByLibrary.simpleMessage("Elon Musk "),
        "auth_for_time_box_planner": MessageLookupByLibrary.simpleMessage(
            "Para alcançar seus objetivos,"),
        "auth_google_login":
            MessageLookupByLibrary.simpleMessage("login do Google"),
        "auth_google_login_failure": m0,
        "auth_google_login_success":
            MessageLookupByLibrary.simpleMessage("Sucesso no login do Google"),
        "auth_kakao_login": MessageLookupByLibrary.simpleMessage("Login Kakao"),
        "auth_kakao_login_failure": m1,
        "auth_kakao_login_success":
            MessageLookupByLibrary.simpleMessage("Sucesso no login do Kakao"),
        "auth_palnner": MessageLookupByLibrary.simpleMessage("planejador."),
        "auth_pick_best":
            MessageLookupByLibrary.simpleMessage("escolheu o melhor "),
        "auth_with_timebox_planner": MessageLookupByLibrary.simpleMessage(
            "junte-se ao TimeBox Planner."),
        "cancel": MessageLookupByLibrary.simpleMessage("cancelamento"),
        "delete": MessageLookupByLibrary.simpleMessage("excluir"),
        "end": MessageLookupByLibrary.simpleMessage("fim"),
        "end_time": MessageLookupByLibrary.simpleMessage("hora de término"),
        "exit": MessageLookupByLibrary.simpleMessage("Saída"),
        "home_activity_placeholder":
            MessageLookupByLibrary.simpleMessage("Escreva sua lista"),
        "home_arrange_title":
            MessageLookupByLibrary.simpleMessage("Ver opções"),
        "home_braindump_placeholder": MessageLookupByLibrary.simpleMessage(
            "Anote todos os pensamentos que vierem à mente agora!"),
        "home_save_completed":
            MessageLookupByLibrary.simpleMessage("Salvamento concluído"),
        "home_save_completed_desc":
            MessageLookupByLibrary.simpleMessage("O salvamento foi concluído."),
        "home_save_desc": MessageLookupByLibrary.simpleMessage("Salvar"),
        "home_tig_mode_prepare": MessageLookupByLibrary.simpleMessage(
            "Os dados estão sendo preparados para o modo TIG.\nAnúncios aparecerão enquanto a preparação está ocorrendo.\nAguarde um momento 🙏"),
        "main_restart": m2,
        "menu_contact_us": MessageLookupByLibrary.simpleMessage("Contate-nos"),
        "menu_delete_user_failure": MessageLookupByLibrary.simpleMessage(
            "Ocorreu um erro.\nTente novamente mais tarde."),
        "menu_email_body": MessageLookupByLibrary.simpleMessage(
            "Seria de grande ajuda se você nos enviasse as seguintes informações.\nDispositivo em uso:\nErros ou melhorias:\n\nSe você tiver alguma outra dúvida, sinta-se à vontade para escrever:)"),
        "menu_email_subject":
            MessageLookupByLibrary.simpleMessage("Eu gostaria de perguntar."),
        "menu_logout_content":
            MessageLookupByLibrary.simpleMessage("Você quer sair?"),
        "menu_logout_text": MessageLookupByLibrary.simpleMessage("sair"),
        "menu_logout_title":
            MessageLookupByLibrary.simpleMessage("Instruções de logout"),
        "menu_month_tigs": m3,
        "menu_price_per_month": m4,
        "menu_subscribe": MessageLookupByLibrary.simpleMessage("Inscrever-se"),
        "menu_subscribe_cancel":
            MessageLookupByLibrary.simpleMessage("Cancelar assinatura"),
        "menu_subscribe_get1": MessageLookupByLibrary.simpleMessage(
            "Todos os anúncios que aparecem na sua tela serão removidos😊"),
        "menu_subscribe_get2": MessageLookupByLibrary.simpleMessage(
            "Nós fornecemos um widget \n onde você pode verificar seu progresso mensal e diário😊"),
        "menu_subscribe_get3": MessageLookupByLibrary.simpleMessage(
            "Você pode dar aos desenvolvedores a força motriz😊\npara criar aplicativos melhores Com certeza vou retribuir!"),
        "menu_subscribe_lose1": MessageLookupByLibrary.simpleMessage(
            "Os anúncios aparecerão na sua tela novamente🥲"),
        "menu_subscribe_lose2": MessageLookupByLibrary.simpleMessage(
            "Não fornecemos mais o \nwidget para verificar seu progresso mensal e diário🥲"),
        "menu_subscribe_lose3": MessageLookupByLibrary.simpleMessage(
            "Você não poderá usar os recursos\nque virão no futuro🥲"),
        "menu_withdrawal_content": MessageLookupByLibrary.simpleMessage(
            "Quando você cancelar sua assinatura, todas as informações serão removidas.\nVocê ainda deseja prosseguir?"),
        "menu_withdrawal_text":
            MessageLookupByLibrary.simpleMessage("Retirada de adesão"),
        "menu_withdrawal_title": MessageLookupByLibrary.simpleMessage(
            "Informações sobre retirada de associação"),
        "next": MessageLookupByLibrary.simpleMessage("próximo"),
        "ok": MessageLookupByLibrary.simpleMessage("verificar"),
        "setting": MessageLookupByLibrary.simpleMessage("contexto"),
        "success": MessageLookupByLibrary.simpleMessage("sucesso"),
        "tag_add": MessageLookupByLibrary.simpleMessage("Adicionar etiqueta"),
        "tag_add_input": MessageLookupByLibrary.simpleMessage(
            "Insira a tag que deseja adicionar."),
        "tag_delete_completed": m5,
        "tag_delete_content": MessageLookupByLibrary.simpleMessage(
            "Tem certeza de que deseja excluir esta tag?"),
        "tag_delete_title":
            MessageLookupByLibrary.simpleMessage("Instruções de exclusão"),
        "tag_duplicated": MessageLookupByLibrary.simpleMessage(
            "Tags idênticas não podem ser registradas."),
        "tag_empty": MessageLookupByLibrary.simpleMessage(
            "Insira a tag que deseja adicionar."),
        "tag_title": MessageLookupByLibrary.simpleMessage("marcação"),
        "tig_mode": MessageLookupByLibrary.simpleMessage("modo tig"),
        "tig_mode_count_down": m6,
        "tig_mode_empty_tig": MessageLookupByLibrary.simpleMessage(
            "O TIG não existe no momento.\nRegistre o TIG e comece de novo😊"),
        "tig_mode_end_time": m7,
        "tig_mode_remain_time":
            MessageLookupByLibrary.simpleMessage("tempo restante"),
        "tig_mode_start_time": m8,
        "tig_mode_waiting": MessageLookupByLibrary.simpleMessage("esperando")
      };
}
