import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz animal',
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0; // เพิ่มตัวแปรเก็บคะแนน

  List<Map<String, dynamic>> questions = [
    {
      "question": "สัตว์ชนิดใดมีลักษณะหูแหลมสลับสีขาวดำบนหลังตัว?",
      "options": [" หมาป่า ", " แมวป่า ", " แมวเปอร์เซีย ", " สุนัขพันธุ์ใด "],
      "correctAnswer": 1
    },
    {
      "question": "สัตว์ชนิดใดมีหางที่ยาวเกือบมากเท่ากับความยาวของร่างกาย?",
      "options": [" ช้าง ", " โลมา ", " อินทรีย์ ", " ไก่ "],
      "correctAnswer": 3
    },
    {
      "question": "สัตว์ชนิดใดเป็นสัตว์ผู้ป่าที่ใหญ่ที่สุดในโลก?",
      "options": [" สิงโต ", " เสือ ", " ช้าง ", " ยีราฟ "],
      "correctAnswer": 2
    },
    {
      "question": "สัตว์ชนิดใดมีจิตใจที่มั่นคงและมีความสามารถในการจดจำสิ่งต่าง ๆ ได้ดี?",
      "options": [" หมี ", " ช้าง ", " ม้า ", " สิงโต "],
      "correctAnswer": 1
    },
    {
      "question": "สัตว์ชนิดใดมีเสียงร้องที่สามารถได้ยินไกลมากและต่ำลึก?",
      "options": [" กวาง ", " แมวป่า ", " วาฬ ", " หมี "],
      "correctAnswer": 2
    },
    {
      "question": "สัตว์ชนิดใดเป็นสัตว์น้ำที่ใหญ่ที่สุดในโลก?",
      "options": [" ปลากระโห้ ", " ปลานิล ", " ปลาวาฬ ", " ปลาฉลาม "],
      "correctAnswer": 3
    },
    {
      "question": "สัตว์ชนิดใดมีสมองที่เกี่ยวข้องกับการเรียนรู้และความสามารถในการแก้ไขปัญหา?",
      "options": [" นก ", " หมู ", " ปลา ", " กบ "],
      "correctAnswer": 0
    },
    {
      "question": "สัตว์ชนิดใดมีความสามารถในการล่าเหยื่อโดยใช้เสียงระดับสูง?",
      "options": [" สิงโต ", " นกอินทรีย์ ", " ค้างคาว ", " สิงห์น้ำทะเล "],
      "correctAnswer": 2
    },
    {
      "question": "สัตว์ชนิดใดมีชีวิตอยู่บนบกมากที่สุดในโลก?",
      "options": [" แมว ", " แมงป่องตัวเลือกที่ ", " ปลา ", " มด "],
      "correctAnswer": 3
    },
    {
      "question": "สัตว์ชนิดใดมีหางที่ยาวที่สุดในโลก?",
      "options": [" ช้าง", " จิ้งจก", "ยีราฟ", "ไก่นกกระจอก"],
      "correctAnswer": 2
    },
    // เพิ่มคำถามต่อไปตามต้องการ
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Text(
      questions[currentQuestionIndex]["question"],
      style: TextStyle(fontSize: 20.0),
    ),
    SizedBox(height: 20.0),
    ...(questions[currentQuestionIndex]["options"] as List<String>).map((option) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: OutlinedButton(
          onPressed: () {
            checkAnswer(option);
          },
          style: ButtonStyle(
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
                return BorderSide(
                  color: states.contains(MaterialState.pressed) ? Colors.grey : Theme.of(context).primaryColor,
                  width: 2.0,
                );
              },
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(option),
          ),
        ),
      );
    }).toList(),
    SizedBox(height: 20.0),
    ElevatedButton(
      onPressed: nextQuestion,
      child: Text('Next'),
    ),
  ],
),

      ),
    );
  }

 void checkAnswer(String selectedOption) {
  int correctAnswerIndex = questions[currentQuestionIndex]["correctAnswer"];
  if (selectedOption == questions[currentQuestionIndex]["options"][correctAnswerIndex]) {
    setState(() {
      correctAnswers++; // เพิ่มคะแนนเมื่อตอบถูก
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Correct!'),
          content: Text('Your answer is correct.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                goToNextQuestion();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Incorrect!'),
          content: Text('Your answer is incorrect.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                goToNextQuestion(); // ไปยังคำถามถัดไปโดยไม่เพิ่มคะแนน
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


  void goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('End of Quiz'),
              content: Text('You have finished the quiz. Your score: $correctAnswers/10'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('End of Quiz'),
              content: Text('You have finished the quiz. Your score: $correctAnswers/10'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }
}