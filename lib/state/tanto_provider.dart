// ///*******************************************************************************
// /// システム名称　  ：メンタルマットアプリ
// /// プロジェクト名称：担当者情報状態管理
// /// 機能概要　　　  ：担当者情報状態を管理する。
// ///
// /// 改訂履歴　　　：2022/07/29 新規 INP)yamada
// ///
// ///*******************************************************************************
// import 'package:flutter/material.dart';
// import 'package:mental_mat_app/components/shared_prefs.dart';
// import 'package:mental_mat_app/constant/strings.dart';
// import 'package:sqflite/sqflite.dart' as sql;

// import '../model/tb_G6zzmf25.dart';
// import 'create_table.dart';

// class TantoProvider extends ChangeNotifier {
//   TantoProvider() {
//     //初期化
//     init();
//   }

//   //初期処理
//   init() {
//     SharedPrefs.getSharedPreferences(sharedKeyTantoCD).then(
//       (value) {
//         if (value != "") {
//           _tantouCD = value;
//           searchTanto(int.parse(value));
//         }
//       },
//     );
//   }

//   // 担当者一覧
//   List<TantoItem> _tantoItemList = [];
//   List<TantoItem> get tantoItemList => _tantoItemList;

//   // 画面に表示する担当者コード
//   String _tantouCD = "00000";
//   String get tantouCD => _tantouCD;

//   // 指定された担当者情報
//   TantoItem _tantoItem = TantoItem();
//   TantoItem get tantoItem => _tantoItem;

//   void loadAllTanto() async {
//     _tantoItemList = await TantoProvider.getItems();
//     notifyListeners();
//   }

//   //担当者コードの変更時処理
//   void changeTantoCD(String tantouCD) {
//     _tantouCD = tantouCD;
//     SharedPrefs.setSharedPreferences(sharedKeyTantoCD, tantouCD);
//     searchTanto(int.parse(tantouCD));
//     notifyListeners();
//   }

//   // 指定された担当者コードの情報を取得する
//   void searchTanto(int tantouCD) async {
//     _tantoItemList = await TantoProvider.getItem(tantouCD);
//     if (_tantoItemList.isNotEmpty) {
//       _tantoItem = _tantoItemList[0];
//     } else {
//       _tantoItem = TantoItem();
//     }
//     notifyListeners();
//   }

//   // 担当者マスタに新規登録する。
//   static Future<int> createItem(TantoItem item) async {
//     final db = await CreateTable.db();
//     final data = item.toJson();
//     final id = await db.insert('tb_G6zzmf25', data,
//         conflictAlgorithm: sql.ConflictAlgorithm.replace);

//     return id;
//   }

//   // 担当者マスタ全項目取得
//   static Future<List<TantoItem>> getItems() async {
//     final sql.Database db = await CreateTable.db();
//     // db.query('tb_G6zzmf25', orderBy: "tantouCD");
//     final List<Map<String, dynamic>> result = await db.rawQuery('''
//           SELECT
//               A.TantouCD
//               , A.TantouName
//               , A.EigyosyoCD
//               , A.EigyosyoName
//               , A.TelNo 
//           FROM
//               tb_G6zzmf25 AS A 
//           WHERE
//               HaisouTantouKbn = 1 
//           ORDER BY
//               TantouKana
//               , TantouCD
//               , TantouName
//           ''');
//     return List.generate(result.length, (i) {
//       return TantoItem.fromJson(result[i]);
//     });
//   }

//   // 担当者マスタ単一項目取得
//   static Future<List<TantoItem>> getItem(int id) async {
//     final db = await CreateTable.db();
//     final List<Map<String, dynamic>> result = await db.query('tb_G6zzmf25',
//         where: "tantouCD = ?", whereArgs: [id], limit: 1);
//     return List.generate(result.length, (i) {
//       return TantoItem.fromJson(result[i]);
//     });
//   }

//   // 担当者マスタ更新処理
//   static Future<int> updateItem(TantoItem item) async {
//     final db = await CreateTable.db();

//     final data = item.toJson();

//     final result = await db.update('tb_G6zzmf25', data,
//         where: "tantouCD = ?", whereArgs: [item.tantouCD]);
//     return result;
//   }

//   // 担当者マスタ削除処理
//   static Future<void> deleteItem(int id) async {
//     final db = await CreateTable.db();
//     try {
//       await db.delete("tb_G6zzmf25", where: "tantouCD = ?", whereArgs: [id]);
//     } catch (err) {}
//   }

//   // 担当者マスタ全削除処理
//   static Future<void> deleteAllItem() async {
//     final db = await CreateTable.db();
//     try {
//       await db.delete("tb_G6zzmf25");
//     } catch (err) {}
//   }
// }
