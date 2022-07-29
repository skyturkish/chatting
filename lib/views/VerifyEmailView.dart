import 'package:groupnotes/constants/routes.dart';
import 'package:groupnotes/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verifiy email',
        ),
      ),
      body: Column(
        children: [
          const Text('we\'ve sent you an email... Please open it to verify your account'),
          const Text('If you haven\'t received a verification email yet, press the buton below'),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text('Send email verification')),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text(
              'Restart',
            ),
          )
        ],
      ),
    );
  }
}
