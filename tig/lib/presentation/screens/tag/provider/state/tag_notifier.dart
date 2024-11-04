import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';

import 'tag_state.dart';

class TagNotifier extends StateNotifier<TagState> {
  TagNotifier() : super(const TagState()) {
    _fetchTags();
  }

  void _fetchTags() {
    List<String> tags =
        SharedPreferenceManager().getPref<List<String>>(PrefsType.tags) ?? [];
    state = state.copyWith(tags: tags);
  }

  Future<void> saveTags() async {
    await SharedPreferenceManager().setPref(PrefsType.tags, state.tags);
  }

  Future<void> addTag(String newTag) async {
    List<String> newTags = state.tags + [newTag];
    state = state.copyWith(tags: newTags, errorMessage: "");
    await saveTags();
  }

  Future<void> relocateTag(int oldIndex, int newIndex) async {
    final relocatedTag = state.tags.removeAt(oldIndex);
    state.tags.insert(newIndex, relocatedTag);
    state = state.copyWith(tags: state.tags, errorMessage: "");
    await saveTags();
  }

  Future<void> removeTag(int index) async {
    state.tags.removeAt(index);
    state = state.copyWith(tags: state.tags, errorMessage: "");
    await saveTags();
  }

  void setErrorMessage(String errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }

  void resetErrorMessage() {
    state = state.copyWith(errorMessage: "");
  }
}
