import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupnotes/core/extensions/context/context_extension.dart';
import 'package:groupnotes/services/auth/auth_exceptions.dart';
import 'package:groupnotes/services/auth/bloc/auth_bloc.dart';
import 'package:groupnotes/services/auth/bloc/auth_event.dart';
import 'package:groupnotes/services/auth/bloc/auth_state.dart';
import 'package:groupnotes/utilities/dialogs/error_dialog.dart';
import 'package:groupnotes/views/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:groupnotes/views/auth/login/viewmodel/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends LoginViewModel {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, 'Cannot find a user with the entered credentials!');
          } else if (state.exception is WrongPasswordAuthExpection) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Please log in to your account in order to interact with and create notes and talk friends',
                ),
                Padding(
                  padding: context.paddingOnlyTopSmall,
                  child: CustomTextFormField(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    hintText: 'email',
                  ),
                ),
                Padding(
                  padding: context.paddingOnlyTopSmall,
                  child: CustomTextFormField(
                    controller: passwordController,
                    textInputType: TextInputType.name,
                    obscureText: true,
                    hintText: 'password',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final emailText = emailController.text;
                    final passwordText = passwordController.text;
                    // buraya event yolluyoruz, o event kendi içinde stateleri yolluyor, flutterda o statelere göre maindeki olayları yapıyor
                    context.read<AuthBloc>().add(
                          AuthEventLogIn(emailText, passwordText),
                        );
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventForgotPassword(),
                        );
                  },
                  child: const Text('I forgot my password'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventShouldRegister(),
                        );
                  },
                  child: const Text('Not registered yet? Register here!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
