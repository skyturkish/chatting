import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupnotes/services/auth/bloc/auth_bloc.dart';
import 'package:groupnotes/services/auth/bloc/auth_event.dart';
import 'package:groupnotes/services/auth/bloc/auth_state.dart';
import 'package:groupnotes/utilities/dialogs/error_dialog.dart';
import 'package:groupnotes/utilities/dialogs/password_reset_email_send_dialog.dart';
import 'package:groupnotes/views/auth/forgotpassword/viewmodel/forgot_password_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends ForgotPasswordViewModel {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            // buradaki state.exception türlerine göre geiştirebilirsin
            await showErrorDialog(
              context,
              'We could not process your request, Please make sure that you are a registered user, or if not, register a user now by going back one step',
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'If you forgot your password, simply enter your email and we will send you a password',
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  autofocus: true,
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Your email adres....',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final email = controller.text;
                    context.read<AuthBloc>().add(AuthEventForgotPassword(email: email));
                  },
                  child: const Text('Send me password reset link'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  child: const Text('Back to login page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
