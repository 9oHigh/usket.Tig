// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(error) => "구글 로그인에 실패했습니다.\n오류: ${error}";

  static String m1(error) => "카카오 로그인에 실패했습니다.\n오류: ${error}";

  static String m2(error) => "앱을 다시 시작해 주세요.\n오류: ${error}";

  static String m3(month) => "${month}월 Tigs";

  static String m4(price) => "${price} / 월";

  static String m5(item) => "${item}가 삭제되었습니다.";

  static String m6(minute, second) => "${minute}분 : ${second}초";

  static String m7(endTime) => "종료 시간: ${endTime}";

  static String m8(startTime) => "시작 시간: ${startTime}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "auth_elon_musk": MessageLookupByLibrary.simpleMessage("일론 머스크"),
        "auth_for_time_box_planner":
            MessageLookupByLibrary.simpleMessage("목표 달성을 위해"),
        "auth_google_login": MessageLookupByLibrary.simpleMessage("구글 로그인"),
        "auth_google_login_failure": m0,
        "auth_google_login_success":
            MessageLookupByLibrary.simpleMessage("구글 로그인에 성공했습니다."),
        "auth_kakao_login": MessageLookupByLibrary.simpleMessage("카카오 로그인"),
        "auth_kakao_login_failure": m1,
        "auth_kakao_login_success":
            MessageLookupByLibrary.simpleMessage("카카오 로그인에 성공했습니다."),
        "auth_palnner": MessageLookupByLibrary.simpleMessage("플래너."),
        "auth_pick_best": MessageLookupByLibrary.simpleMessage("가 선택한 최고의 "),
        "auth_with_timebox_planner":
            MessageLookupByLibrary.simpleMessage("타임박스 플래너와 함께 해요."),
        "cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "delete": MessageLookupByLibrary.simpleMessage("삭제"),
        "end": MessageLookupByLibrary.simpleMessage("종료"),
        "end_time": MessageLookupByLibrary.simpleMessage("종료 시간"),
        "exit": MessageLookupByLibrary.simpleMessage("나가기"),
        "home_activity_placeholder":
            MessageLookupByLibrary.simpleMessage("할 일을 적어 주세요."),
        "home_arrange_title": MessageLookupByLibrary.simpleMessage("보기 옵션"),
        "home_braindump_placeholder":
            MessageLookupByLibrary.simpleMessage("지금 떠오르는 모든 생각들을 적어보세요!"),
        "home_save_completed": MessageLookupByLibrary.simpleMessage("저장 완료"),
        "home_save_completed_desc":
            MessageLookupByLibrary.simpleMessage("티그들이 정상적으로 저장되었습니다."),
        "home_save_desc": MessageLookupByLibrary.simpleMessage("저장하기"),
        "home_tig_mode_prepare": MessageLookupByLibrary.simpleMessage(
            "티그 모드를 위해 데이터를 준비 중입니다.\n준비되는 동안 광고가 표시됩니다.\n잠시만 기다려 주세요 🙏"),
        "main_restart": m2,
        "menu_contact_us": MessageLookupByLibrary.simpleMessage("문의하기"),
        "menu_delete_user_failure": MessageLookupByLibrary.simpleMessage(
            "오류가 발생했습니다.\n잠시 후 다시 시도해 주세요."),
        "menu_email_body": MessageLookupByLibrary.simpleMessage(
            "아래 내용을 함께 보내주시면 큰 도움이 됩니다.\n사용 중인 기기:\n오류 또는 개선 사항:\n\n추가 문의 사항이 있으시면 편하게 작성해 주세요 :)"),
        "menu_email_subject": MessageLookupByLibrary.simpleMessage("문의드립니다."),
        "menu_logout_content":
            MessageLookupByLibrary.simpleMessage("로그아웃 하시겠습니까?"),
        "menu_logout_text": MessageLookupByLibrary.simpleMessage("로그아웃"),
        "menu_logout_title": MessageLookupByLibrary.simpleMessage("로그아웃 안내"),
        "menu_month_tigs": m3,
        "menu_price_per_month": m4,
        "menu_subscribe": MessageLookupByLibrary.simpleMessage("구독하기"),
        "menu_subscribe_cancel":
            MessageLookupByLibrary.simpleMessage("구독 취소하기"),
        "menu_subscribe_get1":
            MessageLookupByLibrary.simpleMessage("구독하시면 모든 광고가 제거됩니다😊"),
        "menu_subscribe_get2": MessageLookupByLibrary.simpleMessage(
            "구독하시면 월별 및 일별 진행 상황을 확인할 수 있는\n위젯들을 제공합니다😊"),
        "menu_subscribe_get3": MessageLookupByLibrary.simpleMessage(
            "구독을 통해 더 멋진 앱을 만드는 데\n도움을 주실 수 있습니다.\n항상 감사합니다😊"),
        "menu_subscribe_lose1":
            MessageLookupByLibrary.simpleMessage("구독을 취소하면 광고가 다시 표시됩니다🥲"),
        "menu_subscribe_lose2": MessageLookupByLibrary.simpleMessage(
            "구독을 취소하면 진행 상황을 확인할 수 있는 위젯이 사라집니다🥲"),
        "menu_subscribe_lose3": MessageLookupByLibrary.simpleMessage(
            "구독을 취소하면 향후 추가될 기능을 사용할 수 없습니다🥲"),
        "menu_withdrawal_content": MessageLookupByLibrary.simpleMessage(
            "회원 탈퇴 시 모든 정보가 삭제됩니다.\n그래도 진행하시겠습니까?"),
        "menu_withdrawal_text": MessageLookupByLibrary.simpleMessage("회원 탈퇴"),
        "menu_withdrawal_title":
            MessageLookupByLibrary.simpleMessage("회원 탈퇴 안내"),
        "next": MessageLookupByLibrary.simpleMessage("다음"),
        "ok": MessageLookupByLibrary.simpleMessage("확인"),
        "setting": MessageLookupByLibrary.simpleMessage("설정"),
        "success": MessageLookupByLibrary.simpleMessage("성공"),
        "tag_add": MessageLookupByLibrary.simpleMessage("태그 추가"),
        "tag_add_input": MessageLookupByLibrary.simpleMessage("추가할 태그를 입력하세요."),
        "tag_delete_completed": m5,
        "tag_delete_content":
            MessageLookupByLibrary.simpleMessage("이 태그를 삭제하시겠습니까?"),
        "tag_delete_title": MessageLookupByLibrary.simpleMessage("삭제 안내"),
        "tag_duplicated":
            MessageLookupByLibrary.simpleMessage("동일한 태그는 등록할 수 없습니다."),
        "tag_empty": MessageLookupByLibrary.simpleMessage("추가할 태그를 입력해 주세요."),
        "tag_title": MessageLookupByLibrary.simpleMessage("태그"),
        "tig_mode": MessageLookupByLibrary.simpleMessage("티그 모드"),
        "tig_mode_count_down": m6,
        "tig_mode_empty_tig": MessageLookupByLibrary.simpleMessage(
            "현재 시간에는 티그가 존재하지 않습니다.\n티그를 등록하고 다시 시작해 주세요😊"),
        "tig_mode_end_time": m7,
        "tig_mode_remain_time": MessageLookupByLibrary.simpleMessage("남은 시간"),
        "tig_mode_start_time": m8,
        "tig_mode_waiting": MessageLookupByLibrary.simpleMessage("대기 중")
      };
}
