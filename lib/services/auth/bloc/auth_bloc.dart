import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupnotes/services/auth/auth_provider.dart';
import 'package:groupnotes/services/auth/bloc/auth_event.dart';
import 'package:groupnotes/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUnInitialized()) {
    //send email verification
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(
          state); // aynı state'i yolluluyoruz çünkü sendEmaiLVerifcation kısmında ekranda herhangi bir değişiklik olmuyor, o yüzden aynı sate kalmalı
    });
    // Register
    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;

      try {
        await provider.createUser(email: email, password: password);
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerification());
      } on Exception catch (e) {
        emit(
          AuthStateRegistering(e),
        );
      }
    });

    // initialize, anladığım kadarıyla event ve stateleer yaratıyoruz sonra evente göre nasıl bir durumda hangi state'yi takınmalı diye işaretliyoruz
    on<AuthEventitialize>(
      (event, emit) async {
        await provider.initialize();
        final user = provider.currentUser;

        if (user == null) {
          emit(
            const AuthStateLoggedOut(exception: null, isLoading: false),
          );
        } else if (!user.isEmailVerified) {
          emit(const AuthStateNeedsVerification());
        } else {
          emit(AuthStateLoggedIn(user));
        }
      },
    );

    // logIn
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(exception: null, isLoading: true));

      final email = event.email;

      final password = event.password;

      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );

        if (!user!.isEmailVerified) {
          // burası forcelanmamıştı
          emit(
            const AuthStateLoggedOut(exception: null, isLoading: false),
          );

          emit(const AuthStateNeedsVerification());
        } else {
          emit(
            const AuthStateLoggedOut(exception: null, isLoading: false),
          );
          emit(AuthStateLoggedIn(user));
        }

        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        // catch olarak her şey yakalanabilir "object" o yüzden fırlayan şeyin bir Exception olduğunu belirtmek zorundayız
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    //log out
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
  }
}
