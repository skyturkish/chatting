import 'package:flutter/material.dart';

class CreateUserView extends StatefulWidget {
  const CreateUserView({Key? key}) : super(key: key);

  @override
  State<CreateUserView> createState() => CreateUserViewState();
}

class CreateUserViewState extends State<CreateUserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'CreateUser',
        style: TextStyle(color: Colors.red),
      )),
    );
  }
}
