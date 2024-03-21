import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Main(),
    );
  }
}

class _Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

enum SendState {
  disabled,
  question,
  questionComplete,
}

class _MainState extends State<_Main> {
  final TextEditingController _controller = TextEditingController();
  String _displayText = '';

  var sendState = SendState.disabled;

  static const List<String> generalAnswer = [
    "당장 시작해.",
    "좋아.",
    "그래.",
    "나중에 해.",
    "다시 한번 물어봐.",
    "안돼.",
    "놉.",
    "하지마.",
    "최.악.",
    "가만히 있어.",
    "그것도 안돼.",
    "진행시켜.",
    "고고.",
    "오 좋은데?"
  ];

  static const List<String> foodAnswer = [
    "먹지마.",
    "먹어.",
    "굶어.",
    "응, 먹지마.",
    "다시 한번 물어봐.",
    "그래.",
    "조금만 먹어"
  ];

  static const List<String> suicideAnswer = [
    "그러지 마.",
    "난 니가 좋아.",
    "좀만 더 버텨봐.",
    "내일 다시 물어봐.",
    "살아있으면\n곧 좋아질거야."
  ];

  String questionBtnTitle = "질문하기";
  String imageName = 'images/btnQuestion.png';

  @override
  void dispose() {
    _controller.dispose(); // 위젯이 소멸될 때 컨트롤러를 정리
    super.dispose();
  }

  void _updateDisplayText() {
    setState(() {
      var txtStr = _controller.text;

      if (sendState == SendState.questionComplete) {
        _controller.text = '';
        sendState = SendState.disabled;
        _modifyChangeState();
        return;
      }

      sendState = SendState.question;
      _modifyChangeState();

      if (txtStr.isEmpty) {
        sendState = SendState.disabled;
      } else {
        if (txtStr.contains("먹어") || txtStr.contains("먹을")) {
          _displayText = foodAnswer[Random().nextInt(foodAnswer.length)];
        } else if (txtStr.contains("자살") ||
            txtStr.contains("죽을") ||
            txtStr.contains("죽어") ||
            txtStr.contains("죽고")) {
          _displayText = suicideAnswer[Random().nextInt(suicideAnswer.length)];
        } else {
          _displayText = generalAnswer[Random().nextInt(generalAnswer.length)];
        }
        sendState = SendState.questionComplete;

        _modifyChangeState();
      }
    });
  }

  void _handelChangeTf() {
    setState(() {
      if (_controller.text.isEmpty) {
        sendState = SendState.disabled;
      } else {
        sendState = SendState.question;
      }

      _modifyChangeState();
    });
  }

  void _modifyChangeState() {
    switch (sendState) {
      case SendState.question:
        questionBtnTitle = '질문하기';
        imageName = 'images/btnQuestion.png';
        break;

      case SendState.questionComplete:
        questionBtnTitle = '다시하기';
        imageName = 'images/btnRefresh.png';
        break;

      case SendState.disabled:
        questionBtnTitle = '질문하기';
        imageName = 'images/btnDisable.png';
        break;

      default:
        questionBtnTitle = '질문하기';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => {FocusScope.of(context).unfocus()},
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/bgImgNight.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "소라고둥님께 물어봐",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 42,
                        right: 42,
                        top: 22,
                        bottom: 24,
                      ),
                      child: TextField(
                        onTap: () {
                          setState(() {
                            sendState = SendState.question;
                          });
                        },
                        onChanged: (text) {
                          _handelChangeTf();
                        },
                        controller: _controller,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          labelText: '',
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.4),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: Colors.transparent),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _updateDisplayText();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            imageName,
                            width: 80,
                            height: 80,
                          ),
                          Text(
                            questionBtnTitle,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'images/conchBacklight.png',
                          width: 285,
                          height: 314,
                        ),
                        Image.asset(
                          'images/conchNormal.png',
                          width: 285,
                          height: 314,
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: const Offset(0, -83),
                      child: sendState == SendState.questionComplete
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'images/imgBubble.png',
                                  width: 237,
                                  height: 116,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text(
                                    _displayText,
                                    style: const TextStyle(
                                        fontSize: 22, color: Color(0xFF0a071f)),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(
                              width: 237,
                              height: 116,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
