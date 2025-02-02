// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

// var islistening = false;

// Future<String> speech_to_text() async {
// SpeechToText stt = SpeechToText();

//   String words = "";

//   var available = await stt.initialize();
//   if (available) {
//     // islistening = true;
//     stt.listen(
//       onResult: (result)  {

//       },
//     );
//   }
//   // stt.stop();
//   // islistening = false;
//   return words;
// }

Future speak(message) async {
  FlutterTts tts = FlutterTts();
  await tts.speak(message);

  await tts.setSpeechRate(0.4);
  await tts.setPitch(1);
  await tts.awaitSpeakCompletion(true);
}
