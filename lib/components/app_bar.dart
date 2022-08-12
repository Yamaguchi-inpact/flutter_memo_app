import 'package:flutter/material.dart';
import 'package:memo_app/constant/colors.dart';

///
/// アプリのタイトルバーのコンポーネント
///
class AppBarText extends StatelessWidget with PreferredSizeWidget {
  const AppBarText(this.text, {Key? key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: Center(
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "＜",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ))),
      title: Text(text),
      backgroundColor: colorBlue,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}
