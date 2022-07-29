import 'package:flutter/material.dart';
import './memo_page.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({Key? key}) : super(key: key);

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ヘッダーバーを消す
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      // コンテンツ内容
      body: Container(
        width: double.infinity, // 横幅を端末サイズに合わせる
        color: Colors.white,
        // 縦にウィジェットを配置する
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // タイトル
            Container(
              // 外側の余白
              margin: EdgeInsets.only(
                top: 300,
                bottom: 10,
              ),
              //// 内側の余白
              //padding: EdgeInsets.only(
              //  top: 300,
              //  bottom: 10,
              //),
              child: Column(
                children: [
                  // タイトルテキスト
                  Text(
                    "メモ帳",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 64,
                    ),
                  ),
                  // サブタイトルテキスト
                  Text(
                    "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            // スタートボタン
            Container(
              // 外側の余白
              margin: EdgeInsets.only(
                top: 0,
                bottom: 0,
              ),
              width: 300,
              height: 50,
              child: OutlinedButton(
                child: Text(
                  "はじめる",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                onPressed: () async {
                  // メモページに移動する
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MemoPage()));
                },
              ),
            ),
            // 著作権表示
            Container(
              // 外側の余白
              margin: EdgeInsets.only(
                top: 0,
                bottom: 25,
              ),
              child: Text(
                "Flutter 勉強中...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
