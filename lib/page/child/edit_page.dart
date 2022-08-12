import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  // const EditPage({Key? key}) : super(key: key);
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _ctl = TextEditingController();
  List<String> _MemoList = [];
  String _newMemo = '';

  Future _updateItem(List<String> memos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ④保存
    await prefs.setStringList('listData', memos);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('メモを編集'),
      content: TextField(
        //自動的にキーボードを開く
        autofocus: true,
        onChanged: (value) {
          setState(() {
            _newMemo = value;
          });
        },
        enabled: true,
        minLines: 3, // 10行分かけるようにする
        maxLines: null,
        controller: _ctl,
        decoration: const InputDecoration(hintText: "What are you up to?"),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
          ),
          // 削除ボタン
          onPressed: _newMemo.isEmpty
          ? null : () {
            setState(() {
              _MemoList.add(_newMemo);
              _updateItem(_MemoList);
              _ctl.clear();
              _newMemo = '';
              Navigator.pop(context);
            });
          },
          child: const Text('Add'),
        )
      ]
    );
  }
}
