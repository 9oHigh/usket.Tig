import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/core/di/injector.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/domain/usecases/tig_usecase.dart';
import 'package:tig/presentation/screens/home/provider/state/home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final TigUsecase _tigUsecase = injector.get<TigUsecase>();

  HomeNotifier() : super(HomeState(currentDateTime: DateTime.now())) {
    _initialize();
  }

  void _initialize() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ??
        SharedPreferenceManager().getPref<String>(PrefsType.userId) ??
        "";
    state = state.copyWith(userId: userId);
    await loadPreference();
    await loadTags();
    await loadTig();
  }

  Future<void> loadPreference() async {
    final bool isOnDaily =
        SharedPreferenceManager().getPref<bool>(PrefsType.isOnDaily) ?? true;
    final bool isOnBraindump =
        SharedPreferenceManager().getPref(PrefsType.isOnBraindump) ?? true;
    state = state.copyWith(isOnDaily: isOnDaily, isOnBraindump: isOnBraindump);
  }

  Future<void> loadTags() async {
    final tags =
        SharedPreferenceManager().getPref<List<String>>(PrefsType.tags) ?? [];
    state = state.copyWith(tags: tags);
  }

  Future<void> loadTig() async {
    var tig = await _tigUsecase.getTigData(state.userId, state.currentDateTime);
    tig ??= Tig(date: state.currentDateTime);
    state = state.copyWith(tig: tig);
  }

  Future<void> saveTig() async {
    await _tigUsecase.saveTigData(state.userId, state.tig!);
  }

  Future<void> setDateTime(DateTime newDate) async {
    state = state.copyWith(currentDateTime: newDate);
    await loadTig();
  }

  void loadAd() {
    state = state.copyWith(isAdLoading: true);
  }

  void quitLoadAd() {
    state = state.copyWith(isAdLoading: false);
  }

  void updateBraindump(String braindump) {
    state.tig?.brainDump = braindump;
  }

  void updateDayPriority(int index, String priority) {
    state.tig?.dayTopPriorities[index].priority = priority;
  }

  void updateDayPriorityIsSucceed(int index, bool isSucceed) {
    state.tig?.dayTopPriorities[index].isSucceed = isSucceed;
    state = state.copyWith();
  }

  void updateActivityIsSucceed(int index, bool isSucced) {
    state.tig?.timeTable[index].isSucceed = isSucced;
    state = state.copyWith();
  }
}
