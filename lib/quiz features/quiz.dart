// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do_app/my%20widgets/my_button.dart';
import 'package:to_do_app/my%20widgets/my_textfield.dart';
import 'package:to_do_app/quiz%20features/quiz_start.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuizGenerator(),
  ));
}

class QuizGenerator extends StatefulWidget {
  const QuizGenerator({super.key});

  @override
  State<QuizGenerator> createState() => _QuizGeneratorState();
}

class _QuizGeneratorState extends State<QuizGenerator> {
  TextEditingController topic = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController level = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 50),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.brown[100]!,
                Colors.brown[200]!,
                Colors.brown[300]!,
                Colors.brown[300]!,
                Colors.brown[400]!
              ])),
          child: Column(
            children: [
              //field for topic
              my_textfield(
                  controller: topic,
                  display_text: 'Enter your topic',
                  obs_text: false,
                  icon: Icon(Icons.topic)),
              SizedBox(
                height: 20,
              ),

              //field for number of questions
              my_textfield(
                  controller: number,
                  display_text: 'Enter the number of questions',
                  obs_text: false,
                  icon: Icon(Icons.numbers)),
              SizedBox(
                height: 20,
              ),

              //field for diffculty level
              my_textfield(
                  controller: level,
                  display_text:
                      'Enter the level of questions , ex:- easy,medium',
                  obs_text: false,
                  icon: Icon(Icons.construction)),
              SizedBox(
                height: 20,
              ),
              my_button(
                  text: 'Start Quiz',
                  color: Colors.grey,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizStart(difficulty: level.text,topic: topic.text,value: number.text,),
                        ));
                  })
            ],
          )),
    );
  }
}
