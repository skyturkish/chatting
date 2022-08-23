import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupnotes/services/auth/bloc/auth_bloc.dart';
import 'package:groupnotes/services/auth/bloc/auth_event.dart';
import 'package:groupnotes/views/auth/login/view/login_view.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  bool isLogout = false;
  @override
  Widget build(BuildContext context) {
    return isLogout == true
        ? Scaffold(
            appBar: AppBar(
              title: const Text('noluyo '),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.red),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    isLogout = true;
                    setState(() {});
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
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
              );
            }),
          );
  }
}
