import 'package:book_library/pages/upload_book.dart';
import 'package:flutter/material.dart';
import 'package:book_library/pages/book_page.dart';
import 'package:book_library/models/books.dart';
import '/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          _WelcomeBanner(),
          const Divider(thickness: 2),
          // Faculty Options
          _FacultyList(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UploadBookPage(),
                ),
              );
            },
            child: const Text('Upload Book'),
          ),
        ],
      ),
    );
  }
}

class _WelcomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'E-book Library',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select a faculty to view the available books',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FacultyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: const [
          FacultyOption(
            faculty: BookFaculty.BIM,
            icon: Icons.computer,
            description: 'Browse BIM course materials and textbooks',
          ),
          SizedBox(height: 16),
          FacultyOption(
            faculty: BookFaculty.BHM,
            icon: Icons.restaurant,
            description: 'Access BHM reference materials and guides',
          ),
        ],
      ),
    );
  }
}

class FacultyOption extends StatelessWidget {
  final BookFaculty faculty;
  final IconData icon;
  final String description;

  const FacultyOption({
    super.key,
    required this.faculty,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () => _navigateToFacultyBooks(context),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: theme.primaryColor,
                size: 36.0,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      faculty.displayName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: theme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToFacultyBooks(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookPage(faculty: faculty),
      ),
    );
  }
}
