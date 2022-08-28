import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:groupnotes/services/auth/bloc/auth_bloc.dart';
import 'package:groupnotes/services/auth/bloc/auth_event.dart';
import 'package:groupnotes/views/auth/login/view/login_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  bool isLogout = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    const AuthEventLogOut(),
                  );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Builder(
          // Here the magic happens
          // this builder function will generate a new BuilContext for you
          builder: (BuildContext newContext) {
        return ElevatedButton(
          child: const Text(
            "test",
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()));
          },
        );
      }),
    );
  }
}
