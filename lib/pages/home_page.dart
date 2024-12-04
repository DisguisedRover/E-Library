import 'package:flutter/material.dart';
import 'package:book_library/pages/book_page.dart';
import 'package:book_library/models/books.dart';
import '/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        centerTitle: true,
        backgroundColor: const Color(0xFF42A5F5),
      ),
      drawer: const Mydrawer(),
      body: Column(
        children: [
          // Welcome Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            color: const Color(0xFFE3F2FD),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'E-Book Library',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select a faculty to view the available books.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueGrey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const Divider(thickness: 2),

          // Faculty Options
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: [
                FacultyOption(
                  faculty: BookFaculty.BIM,
                  icon: Icons.computer,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BookPage(faculty: BookFaculty.BIM),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                FacultyOption(
                  faculty: BookFaculty.BHM,
                  icon: Icons.restaurant,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BookPage(faculty: BookFaculty.BHM),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FacultyOption extends StatelessWidget {
  final BookFaculty faculty;
  final IconData icon;
  final VoidCallback onTap;

  const FacultyOption({
    super.key,
    required this.faculty,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue[800],
          size: 36.0,
        ),
        title: Text(
          faculty.displayName, // Use the display name from the extension
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: onTap,
      ),
    );
  }
}
