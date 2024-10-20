import 'package:flutter/material.dart';
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
              title: const Center(child: Text('태그 추가')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    focusNode: focusNode,
                    controller: tagController,
                    decoration: const InputDecoration(
                      hintText: '태그를 입력하세요',
                    ),
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            errorMessage!,
                            style: const TextStyle(color: Colors.red),
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
                  child: const Text('취소'),
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
                      setStateDialog(() {
                        errorMessage = "동일한 태그는 등록이 불가능해요.";
                      });
                    }
                  },
                  child: const Text('확인'),
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
        title: const Text(
          "태그",
          style: TextStyle(
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
                    title: const Text('삭제 확인'),
                    content: const Text('이 태그를 삭제하시겠습니까?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('취소'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('삭제'),
                      ),
                    ],
                  ),
                );
              },
              onDismissed: (direction) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${tags[index]}가 삭제되었습니다.'),
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
