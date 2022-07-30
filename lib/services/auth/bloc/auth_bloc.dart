import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupnotes/services/auth/auth_provider.dart';
import 'package:groupnotes/services/auth/bloc/auth_event.dart';
import 'package:groupnotes/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    // initialize, anladığım kadarıyla event ve stateleer yaratıyoruz sonra evente göre nasıl bir durumda hangi state'yi takınmalı diye işaretliyoruz
    on<AuthEventitialize>(
      (event, emit) async {
        await provider.initialize();
        final user = provider.currentUser;

        if (user == null) {
          emit(const AuthStateLoggedOut());
        } else if (!user.isEmailVerified) {
          emit(const AuthStateNeedsVerification());
        } else {
          emit(AuthStateLoggedIn(user));
        }
      },
    );

    // logIn
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoading());

      final email = event.email;

      final password = event.password;

      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );

        emit(AuthStateLoggedIn(user!)); // burası forcelanmamıştı
      } on Exception catch (e) {
        // catch olarak her şey yakalanabilir "object" o yüzden fırlayan şeyin bir Exception olduğunu belirtmek zorundayız
        emit(AuthStateLoginFailure(e));
      }
    });

    //log out
    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(const AuthStateLoading());
        await provider.logOut();
        emit(const AuthStateLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLogoutFailure(e));
      }
    });
  }
}
