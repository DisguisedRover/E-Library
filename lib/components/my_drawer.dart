import 'package:flutter/material.dart';
import 'drawer_tile.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 66, 165, 245),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset('lib/images/logo.png', height: 100),
                  )
                ],
              )),
          MyDrawerTile(
            text: 'Home',
            icon: Icons.home,
            onTap: () {
              Navigator.pop(context); // Close drawer when Home is clicked
            },
          ),
          MyDrawerTile(
            text: 'Settings',
            icon: Icons.settings,
            onTap: () {
              Navigator.pushNamed(context, '/settings'); // Example navigation
            },
          ),
          MyDrawerTile(
            text: 'About',
            icon: Icons.info,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('About'),
                  content: const Text(''),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
