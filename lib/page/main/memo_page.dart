import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// リスト一覧画面用Widget
class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);
  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {

  List<String> _MemoList = [];
  // メモ追加画面
  final _ctr = TextEditingController();
  String _memo = '';
  // メモ編集画面
  final _editCtl = TextEditingController();
  String _editMemo = '';
  bool isMod = false;

  @override
  // 初期化処理
  void initState() {
    super.initState();
    init();
  }
  // 画面起動時に読み込むメソッド
  void init() async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('listData');
    if (result != null) {
      setState(() {
        _MemoList = result;
      });
    }
  }

  // リストの更新を保存
  Future _updateItem(List<String> memos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 保存
    await prefs.setStringList('listData', memos);
  }

  /// メモ一覧ページ  ///
  @override
  Widget build(BuildContext context) {
    // Todoリストのデータ
    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: const Text('メモ一覧'),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          // ソートボタン
          IconButton(
            onPressed: () async {

              setState(() {
                // _MemoList.reversed.toList();
                _MemoList.sort((a, b) => -a.compareTo(b));
              });

              // final docs = _displayTextEditDialog;

              // シートを表示する
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return EditPage();
              //   },
              // );
            },
            icon: const Icon(Icons.swap_vert_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children:[
            Expanded(
              child: _listMemo(context),
            ),
            FloatingActionButton(
              onPressed: () {
                // メモを追加後に画面を更新
                final docs = _displayTextInputDialog(context);
                docs.then((value) {
                  setState(() {});
                });
              },
              tooltip: 'メモを追加',
              child: const Icon(Icons.add),
            ),
        ],)
      ) ,
    );
  }

  // メモ一覧
  _listMemo(BuildContext context) {
    // デバイスの高さを取得する
    final double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth,
      child: ListView.builder(
        // reverse: true,
        itemCount: _MemoList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // タップするとメモ編集画面へ
              _editCtl.text = _MemoList[index];

              final docs = _displayTextEditDialog(context);
              docs.then((value) {
                if (isMod) {
                  _MemoList[index] = _editCtl.text;
                }
                setState(() {
                  _updateItem(_MemoList); // リストを更新
                  _editCtl.clear(); //
                  _editMemo = ''; //
                  isMod = false;
                });
              });
            },
            onLongPress: () {},
            child: Card(
              child: ListTile(
                title: Text(_MemoList[index]),
                trailing: GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () {
                    // タップすると削除
                    setState(() {
                      _MemoList.remove(_MemoList[index]);
                      _updateItem(_MemoList);
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }



  /// メモ追加画面 ///
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('メモを追加'),
              content: TextField(
                //自動的にキーボードを開く
                autofocus: true,
                // 入力を感知
                onChanged: (value) {
                  setState(() {
                    _memo = value;
                  });
                },
                enabled: true,
                minLines: 3, // 10行分かけるようにする
                maxLines: null,
                controller: _ctr,
                decoration: const InputDecoration(hintText: "ここに記入してください"),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  onPressed: _memo.isEmpty
                      ? null
                      : () {
                          setState(() {
                            _MemoList.add(_memo);
                            _updateItem(_MemoList);
                            _ctr.clear();
                            _memo = '';
                            Navigator.pop(context);
                          });
                        },
                  child: const Text('追加'),
                ),
              ],
            );
          });
        });
  }

  /// メモ編集画面 ///
  Future<void> _displayTextEditDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                title: const Text('メモを編集'),
                content: TextField(
                  //自動的にキーボードを開く
                  autofocus: true,

                  onChanged: (value) {
                    setState(() {
                      _editMemo = value;
                      // _editCtl.text = value;
                    });
                  },
                  enabled: true,
                  minLines: 3, // 10行分かけるようにする
                  maxLines: null,
                  controller: _editCtl,
                  decoration: const InputDecoration(hintText: "文字を入れてください"),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                    onPressed: _editMemo.isEmpty
                        ? null
                        : () {
                            setState(() {
                              _editCtl.text = _editMemo;
                              isMod = true;
                              Navigator.pop(context);
                            });
                          },
                    child: const Text('編集'),
                  )
                ]);
          });
        });
  }
}
