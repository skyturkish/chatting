import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupnotes/core/constants/navigation/routes.dart';
import 'package:groupnotes/helpers/loading/loading_screen.dart';
import 'package:groupnotes/services/auth/bloc/auth_bloc.dart';
import 'package:groupnotes/services/auth/bloc/auth_event.dart';
import 'package:groupnotes/services/auth/bloc/auth_state.dart';
import 'package:groupnotes/services/auth/firebase_auth_provider.dart';
import 'package:groupnotes/views/auth/forgotpassword/view/forgot_password_view.dart';
import 'package:groupnotes/views/auth/login/view/login_view.dart';
import 'package:groupnotes/views/auth/register/view/register_view.dart';
import 'package:groupnotes/views/auth/verifyemail/view/VerifyEmailView.dart';
import 'package:groupnotes/views/home/createcharacter/view/create_character_view.dart';
import 'package:groupnotes/views/home/notes/create_update_note_view.dart';
import 'package:groupnotes/views/home/notes/notes_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        NavigationConstants.createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
        NavigationConstants.personalNotes: (context) => const NotesView()
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventitialize());
    // buraya tanımlıyoruz diğer yerlerde sadece state değişimini yolluyoruz
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Plese wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const CreateCharacterView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
