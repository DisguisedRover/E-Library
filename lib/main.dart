import 'package:flutter/material.dart';
import 'blocImplementation/book_bloc.dart';
import 'pages/intro_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/api_service.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ApiService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookBloc(
              apiService: context.read<ApiService>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
        cardTheme: CardTheme(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF42A5F5),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        dividerTheme: const DividerThemeData(
          thickness: 2,
          space: 32,
        ),
      ),
      home: const IntroPage(),
    );
  }
}
