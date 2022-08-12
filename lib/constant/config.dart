class Config {
  /// アプリケーションのバージョン情報
  static String version = "0.0.0";

  /// sqfliteのバージョン情報
  static int sqfliteVersion = 1;

  /// 振動の制御
  static const bool _isVibration = true;

  static bool get isVibration => _isVibration;

  /// 音の制御
  static const bool _isSound = false;

  static bool get isSound => _isSound;
}
