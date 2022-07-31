import 'package:flutter_test/flutter_test.dart';
import 'package:groupnotes/services/auth/auth_exceptions.dart';
import 'package:groupnotes/services/auth/auth_provider.dart';
import 'package:groupnotes/services/auth/auth_user.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('Should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });
    test('Cannot log out if not initialized', () {
      expect(provider.logOut(), throwsA(const TypeMatcher<NotInitializedException>()));
    });
    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initalization', () {
      expect(provider.currentUser, null);
    });

    test(
      'Should be able to initialize in less than 2 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('Create user should delegate to logIn function', () async {
      final badEmailUser = provider.createUser(
        email: 'nofound@gmail.com',
        password: 'anypassword',
      );
      expect(badEmailUser, throwsA(const TypeMatcher<UserNotFoundAuthException>()));

      final badPassword = provider.createUser(
        email: 'anygmail@gmail.com',
        password: 'nopassword',
      );
      expect(badPassword, throwsA(const TypeMatcher<WrongPasswordAuthExpection>()));

      final user = await provider.createUser(
        email: 'any',
        password: 'pass',
      );
      expect(provider.currentUser, user);
      expect(user!.isEmailVerified, false);
    });
    test('Logged in user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('Should be albe to log out and log in again', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'email',
        password: 'password',
      );

      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;

  bool get isInitialized => _isInitialized;
  @override
  Future<AuthUser?> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser?> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'nofound@gmail.com') throw UserNotFoundAuthException();
    if (password == 'nopassword') throw WrongPasswordAuthExpection();
    const user = AuthUser(
      id: 'my_id',
      isEmailVerified: false,
      email: 'nofound@gmail.com',
    );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(
      id: 'my_id',
      isEmailVerified: true,
      email: 'nofound@gmail.com', // emailleri ekledikten sonra hata veriyor
    );
    _user = newUser;
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) {
    throw UnimplementedError();
  }
}
