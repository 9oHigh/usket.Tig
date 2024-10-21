import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  List<String> tags = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  Future<void> _saveTags() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('tags', tags);
  }

  Future<void> _loadTags() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      tags = pref.getStringList('tags') ?? [];
    });
  }

  void _addTag() {
    final tagController = TextEditingController();
    final focusNode = FocusNode();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
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
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              errorMessage!,
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
                    setStateDialog(() {
                      errorMessage = null;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(Intl.message('cancel')),
                ),
                TextButton(
                  onPressed: () {
                    if (tagController.text.isNotEmpty &&
                        !tags.contains(tagController.text)) {
                      setState(() {
                        tags.add(tagController.text);
                        _saveTags();
                      });
                      errorMessage = null;
                      Navigator.of(context).pop();
                    } else {
                      if (tagController.text.isEmpty) {
                        setStateDialog(() {
                          errorMessage = Intl.message('tag_empty');
                        });
                      } else {
                        setStateDialog(() {
                          errorMessage = Intl.message('tag_duplicated');
                        });
                      }
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          Intl.message('tag_title'),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _addTag,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReorderableListView.builder(
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            setState(() {
              final item = tags.removeAt(oldIndex);
              tags.insert(newIndex, item);
            });
            _saveTags();
          },
          itemCount: tags.length,
          proxyDecorator:
              (Widget child, int index, Animation<double> animation) {
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;
            return Material(
              elevation: 1,
              color: isDarkMode
                  ? Colors.black.withAlpha(200)
                  : Colors.white.withAlpha(200),
              child: child,
            );
          },
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(tags[index]),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(Intl.message('tag_delete_title')),
                    content: Text(Intl.message('tag_delete_content')),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(Intl.message('cancel')),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(Intl.message('delete')),
                      ),
                    ],
                  ),
                );
              },
              onDismissed: (direction) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(Intl.message('tag_delete_completed',
                        args: [(tags[index].toString())])),
                  ),
                );
                setState(() {
                  tags.removeAt(index);
                  _saveTags();
                });
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
