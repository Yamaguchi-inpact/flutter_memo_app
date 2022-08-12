class StringsConfig {
  static Map<int, String> syohinBunrui = {
    10: "メンタルマット料",
    30: "ムレーズカバー料",
    31: "ファーストムーン料",
    32: "エアマット料"
  };
  static List<String> strBillKbnNames = ["定期(完納)", "随時"];
}

String sharedKeyTantoCD = "tantouCD";
String sharedKeyTokuisakiCD = "tokuisakiCD";
String sharedKeyZissiDate = "zissiDate";

String splitString(String str) {
  return str.substring(0, 3) +
      "-" +
      str.substring(3, 6) +
      "-" +
      str.substring(6, 8);
}

String needCheckTitle = "入力チェック";
String buttonTextconfirm = "確認";

String buttonTextYes = "はい";
String buttonTextNo = "いいえ";
String syncConfirm = "同期処理を開始します。\n\n処理が正常に完了され次第、メニュー画面に遷移します。";

String tbG6sgtf30RonriName = "レンタル商品本数変更伝票ファイル(在庫)";

String tbG6zzmf25RonriName = "担当者マスタ";
