import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupnotes/core/constants/enums/locale_keys_enum.dart';
import 'package:groupnotes/core/init/cache/locale_manager.dart';
import 'package:groupnotes/core/init/navigation/navigation_route.dart';
import 'package:groupnotes/helpers/loading/loading_screen.dart';
import 'package:groupnotes/services/auth/auth_service.dart';
import 'package:groupnotes/services/auth/bloc/auth_bloc.dart';
import 'package:groupnotes/services/auth/bloc/auth_event.dart';
import 'package:groupnotes/services/auth/bloc/auth_state.dart';
import 'package:groupnotes/services/auth/firebase_auth_provider.dart';
import 'package:groupnotes/views/auth/forgotpassword/view/forgot_password_view.dart';
import 'package:groupnotes/views/auth/login/view/login_view.dart';
import 'package:groupnotes/views/auth/register/view/register_view.dart';
import 'package:groupnotes/views/auth/verifyemail/view/VerifyEmailView.dart';
import 'package:groupnotes/views/createcharacter/view/create_character_view.dart';
import 'package:groupnotes/views/home/home_view.dart';

void main() async {
  await _init();
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
      onGenerateRoute: generateRoute,
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.preferencesInit();
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached || state == AppLifecycleState.inactive) return;

    final isBackground = state == AppLifecycleState.paused; // detached dene olmazsa

    if (isBackground) {
      if (LocaleManager.instance.getStringValue(PreferencesKeys.USERID) == '') {
        await AuthService.firebase().logOut();
      }
    }
  }

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
        if (LocaleManager.instance.getStringValue(PreferencesKeys.USERID) != '') {
          return const HomeView();
        } else if (state is AuthStateLoggedIn) {
          return const CreateUserView();
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
