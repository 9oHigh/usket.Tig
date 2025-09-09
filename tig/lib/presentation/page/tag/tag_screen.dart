import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tig/presentation/page/tag/provider/state/tag_state.dart';
import 'package:tig/presentation/page/tag/provider/tag_notifier_provider.dart';
import 'provider/state/tag_notifier.dart';

class TagScreen extends ConsumerStatefulWidget {
  const TagScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TagScreenState();
}

class _TagScreenState extends ConsumerState<TagScreen> {
  void _showAddTagDialog() {
    final TextEditingController tagController = TextEditingController();
    final FocusNode focusNode = FocusNode();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            final TagState tagState = ref.watch(tagNotifierProvider);
            final TagNotifier tagNotifier =
                ref.read(tagNotifierProvider.notifier);
            final String errorMessage = tagState.errorMessage;
            final List<String> tags = tagState.tags;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              focusNode.requestFocus();
            });
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              title: Center(child: Text(Intl.message('tag_add'))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    focusNode: focusNode,
                    controller: tagController,
                    decoration: InputDecoration(
                      hintText: Intl.message('tag_add_input'),
                    ),
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              errorMessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    tagNotifier.resetErrorMessage();
                    Navigator.of(context).pop();
                  },
                  child: Text(Intl.message('cancel')),
                ),
                TextButton(
                  onPressed: () {
                    if (tagController.text.isNotEmpty &&
                        !tags.contains(tagController.text)) {
                      tagNotifier.addTag(tagController.text);
                      Navigator.of(context).pop();
                    } else {
                      if (tagController.text.isEmpty) {
                        tagNotifier.setErrorMessage(Intl.message('tag_empty'));
                      } else {
                        tagNotifier
                            .setErrorMessage(Intl.message('tag_duplicated'));
                      }
                      setStateDialog(() {});
                    }
                  },
                  child: Text(Intl.message('ok')),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TagState tagState = ref.watch(tagNotifierProvider);
    final TagNotifier tagNotifier = ref.read(tagNotifierProvider.notifier);
    final List<String> tags = tagState.tags;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          Intl.message('tag_title'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => _showAddTagDialog(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReorderableListView.builder(
          itemCount: tags.length,
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) newIndex -= 1;
            tagNotifier.relocateTag(oldIndex, newIndex);
          },
          proxyDecorator:
              (Widget child, int index, Animation<double> animation) {
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;
            return Material(
              elevation: 1,
              color: isDarkMode
                  ? Colors.black.withAlpha(200)
                  : Colors.white.withAlpha(200),
              borderRadius: BorderRadius.circular(8),
              child: child,
            );
          },
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(tags[index]),
              direction: DismissDirection.endToStart,
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 216, 118, 111),
                ),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(Intl.message('tag_delete_title')),
                    content: Text(Intl.message('tag_delete_content')),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(Intl.message('cancel'))),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(Intl.message('delete'))),
                    ],
                  ),
                );
              },
              onDismissed: (direction) {
                tagNotifier.removeTag(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(Intl.message('tag_delete_completed',
                        args: [(tags[index].toString())])),
                  ),
                );
              },
              child: ListTile(
                title: Text(tags[index]),
                trailing: ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_handle),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
