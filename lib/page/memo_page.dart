import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// リスト一覧画面用Widget
class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {

  final _controller = TextEditingController();
  List<String> _MemoList = [];
  String _memo = '';

  @override
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

  Future _updateItem(List<String> memos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ④保存
    await prefs.setStringList('listData', memos);
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('add list'),
              content: TextField(
                //自動的にキーボードを開く
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    _memo = value;
                  });
                },
                controller: _controller,
                decoration: InputDecoration(hintText: "What are you up to?"),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.black,
                  ),
                  child: Text('Add'),
                  onPressed: _memo.isEmpty
                      ? null
                      : () {
                    setState(() {
                      _MemoList.add(_memo);
                      _updateItem(_MemoList);
                      _controller.clear();
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            );
          });
        });
  }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: Text(
//           'Memo',
//           style: TextStyle(
//             fontSize: 20.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0.0,
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30.0),
//             topRight: Radius.circular(30.0),
//           ),
//         ),
//         child: ListView.builder(
//
//
//           ///きっちりスクロールできるやつ/////
//             physics: ClampingScrollPhysics(),
//             itemCount: _MemoList.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: index == 0
//                     ? EdgeInsets.only(top: 30)
//                     : EdgeInsets.only(top: 10),
//                 child: Slidable(
//                     actionPane: SlidableDrawerActionPane(),
//                     //actionExtentRatio: 0.25,
//                     secondaryActions: [
//                       IconSlideAction(
//                         caption: '削除',
//                         color: Colors.red,
//                         icon: Icons.delete_outline,
//                         onTap: () {
//                           setState(() {
//                             _MemoList.remove(_MemoList[index]);
//                             _updateItem(_MemoList);
//                           });
//                         },
//                       ),
//                     ],
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       margin: EdgeInsets.only(right: 20.0),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 20.0, vertical: 10.0),
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(20.0),
//                           bottomRight: Radius.circular(20.0),
//                         ),
//                       ),
//                       child: Text(
//                         _MemoList[index],
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     )),
//               );
//             }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _displayTextInputDialog(context);
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }


  @override
  Widget build(BuildContext context) {
  // Todoリストのデータ
    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: Text('メモ一覧'),
      ),
      // データを元にListViewを作成
      body: ListView.builder(
        itemCount: _MemoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_MemoList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // "push"で新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          final newListText =  await showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
              // 遷移先の画面としてリスト追加画面を指定
              return MemoAddPage();
              }
          );
          if (newListText != null) {
            // キャンセルした場合は newListText が null となるので注意

            setState(() {
              // リスト追加
              _MemoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



class MemoAddPage extends StatefulWidget {
  @override
  _MemoAddPageState createState() => _MemoAddPageState();
}

class _MemoAddPageState extends State<MemoAddPage> {

  String _text = '';

  // データを元に表示するWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモを追加'),
      ),
      body: Container(
        // 余白を付ける
        padding: EdgeInsets.all(64),
        child: ListView(
          children: <Widget>[
            // 入力されたテキストを表示
            // Text(_text, style: TextStyle(color: Colors.blue)),
            // const SizedBox(height: 8),
            // テキスト入力
            TextField(
              enabled: true,
              minLines: 3, // 10行分かけるようにする
              maxLines: null,
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                hintText: "ここに記入",
                labelText: "メモの内容",
              ),
              // 入力されたテキストの値を受け取る（valueが入力されたテキスト）
              onChanged: (String value) {
                // データが変更したことを知らせる（画面を更新する）
                setState(() {
                  // データを変更
                  _text = value;
                });
              },
            ),
            const SizedBox(height: 5),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: () async {
                  // "pop"で前の画面に戻る
                  // "pop"の引数から前の画面にデータを渡す
                    Navigator.of(context).pop(_text);
                },
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
