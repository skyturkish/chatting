import 'package:flutter/material.dart';
import 'package:groupnotes/core/constants/navigation/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Home',
        style: TextStyle(color: Colors.red),
      )),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('GroupNotes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(NavigationConstants.personalNotes);
            },
            child: const Text('notes'),
          ),
        ],
      ),
    );
  }
}
