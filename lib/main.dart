import 'package:estudo_ui_flutter/pages/list_with_state/list_data_with_state.dart';
import 'package:estudo_ui_flutter/pages/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const LearnApp());
}

class LearnApp extends StatelessWidget {
  const LearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListPages(),
    );
  }
}

class ListPages extends StatelessWidget {
  const ListPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text('My profile with stack'),
            trailing: const Icon(FontAwesomeIcons.chevronRight),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyProfilePage()),
              );
            },
          ),
          ListTile(
            title: const Text('List with state'),
            trailing: const Icon(FontAwesomeIcons.chevronRight),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyListDataWithStatePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
