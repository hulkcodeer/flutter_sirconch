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

class _MainState extends State<_Main> {
  final TextEditingController _controller = TextEditingController(); // 컨트롤러 생성
  String _displayText = ''; // 화면에 표시될 텍스트를 저장하는 변수

  @override
  void dispose() {
    _controller.dispose(); // 위젯이 소멸될 때 컨트롤러를 정리
    super.dispose();
  }

  void _updateDisplayText() {
    setState(() {
      _displayText = _controller.text; // 버튼 클릭 시, 컨트롤러에서 텍스트 값을 가져와서 상태를 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: '',
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white.withAlpha(200),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Colors.transparent),
                    onPressed: _updateDisplayText,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'images/btnDisable.png',
                          width: 80,
                          height: 80,
                        ),
                        const Text(
                          '질문하기',
                          style: TextStyle(color: Colors.black),
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
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'images/imgBubble.png',
                          width: 237,
                          height: 116,
                        ),
                        Text(
                          _displayText,
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
