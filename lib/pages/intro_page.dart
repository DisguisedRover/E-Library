import 'package:flutter/material.dart';
import '/components/my_button.dart';
//import 'package:google_fonts/google_fonts.dart';
import '/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 69, 165, 224),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start, // Remove spaceEvenly
            children: [
              const SizedBox(height: 25),
              const Text(
                "E-BOOK LIBRARY",
                style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 232, 196, 231),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset('lib/images/logo2.png'),
              ),
              const SizedBox(height: 25),
              const Text(
                'Find all your books in one place',
                style: TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 239, 192, 239),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Library but in your pocket',
                style: TextStyle(
                  color: Color.fromARGB(255, 239, 192, 239),
                  height: 2,
                ),
              ),
              const SizedBox(height: 25),
              MyButton(
                text: 'Start',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
