// import 'package:flutter/services.dart';
// import 'package:logger/logger.dart';
// import 'package:mental_mat_app/components/sesound.dart';
// import 'package:mental_mat_app/constant/config.dart';

// Logger logger = Logger(filter: MyFilter(), printer: SimplePrinter());

// class MyFilter extends LogFilter {
//   @override
//   bool shouldLog(LogEvent event) {
//     return (event.level.index >= Logger.level.index);
//   }
// }

// SeSound se = SeSound();
// void onTap() {
//   if (Config.isVibration == true) {
//     HapticFeedback.lightImpact();
//   }
//   if (Config.isSound == true) {
//     se.playSe(SeSoundIds.button1);
//   }
// }
