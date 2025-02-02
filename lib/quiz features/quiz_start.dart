// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, must_be_immutable, prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:to_do_app/my%20widgets/my_button.dart';
import 'package:to_do_app/quiz%20features/quiz.dart';
import 'package:to_do_app/quiz%20features/stt_tts.dart';

import 'gemini_services.dart';

class QuizStart extends StatefulWidget {
  String topic;
  String value;
  String difficulty;
  QuizStart({
    super.key,
    required this.topic,
    required this.value,
    required this.difficulty,
  });

  @override
  State<QuizStart> createState() => _QuizStartState();
}

class _QuizStartState extends State<QuizStart> {
  String? question;
  String? my_answer;
  String? gemini_ans;
  int total_questions = 0;
  int current_question = 0;
  bool islistening = false;
  SpeechToText stt = SpeechToText();
  int total_time = 30;
  bool isquiz_ended = false;

  Future<void> get_question_from_gemini() async {
    String ans = await gemini_api.getgeminidata(
        'Just ask me a single theory question on ${widget.topic} for interview preparation without answer and no options of ${widget.difficulty}');
    setState(() {
      question = ans;
    });
  }
  //asking the question to user

  Future ask_question() async {
    await get_question_from_gemini();
    await speak(question);
  }

  //answer checking of user
  Future<void> check_answer() async {
    String ans = await gemini_api.getgeminidata(
        '$question and my answer to the question is $my_answer. Rate my answer out of 10 and suggest me some required improvements in my answer in short and precise answer.');
    setState(() {
      gemini_ans = ans.replaceAll("*", "");
    });
  }

  //passng into the quiz flow
  Future validate_answer() async {
    await check_answer();
    await speak(gemini_ans);
  }

  //user time to give answer
  Future user_answer() async {
    var available = await stt.initialize();
    if (available) {}
  }

  // start flow of the quiz
  Future startQuiz() async {
    for (int i = 0; i < total_questions; i++) {
      //asking the qestion to user
      await ask_question();
      setState(() {
        total_time = 30;
      });

      //waiting for 30 seconds to give answer to user
      start_contdown();
      await Future.delayed(Duration(seconds: 30));

      //checking of answer;
      await validate_answer();
      setState(() {
        gemini_ans = "";
      });
    }
    setState(() {
      isquiz_ended = true;
    });
  }

  Future speak_intro() async {
    await speak(
        "Hello user, I am Arya your A.I. assistant for learning about new things  , I love to helping you on learning ${widget.topic} ,  so let's start , you have 30 seconds to answer every question, Here are your questions on ${widget.topic} is as follows");
  }

  @override
  void initState() {
    super.initState();
    speak_intro();
    setState(() {
      total_questions = int.parse(widget.value);
    });
    Future.delayed(Duration(seconds: 12), () {
      startQuiz();
    });
  }

  void start_contdown() {
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (total_time > 0) {
          setState(() {
            total_time--;
          });
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!islistening) {
              var available = await stt.initialize();
              if (available) {
                setState(() {
                  islistening = true;
                  stt.listen(
                    onResult: (result) {
                      setState(() {
                        my_answer = result.recognizedWords;
                        print(my_answer);
                      });
                    },
                  );
                });
              }
            } else {
              setState(() {
                islistening = false;
                stt.stop();
              });
            }
          },
          child: islistening == true ? Icon(Icons.pause) : Icon(Icons.mic),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.green[100]!,
                  Colors.green[200]!,
                  Colors.green[300]!,
                  Colors.green[400]!,
                  Colors.green[500]!,
                ])),
            child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      total_time.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    current_question < total_questions
                        ? Text(
                            'Question ${current_question + 1} / $total_questions')
                        : Text('Quiz completed'),
                    question != null ? Text(question!) : Container(),
                    gemini_ans != null ? Text(gemini_ans!) : Container(),
                    isquiz_ended == true ? my_button(
                        text: 'end quiz',
                        color: Colors.transparent,
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizGenerator(),
                              ));
                        }) : Container()
                  ],
                ))));
  }
}
