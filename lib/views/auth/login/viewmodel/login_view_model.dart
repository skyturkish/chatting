import 'package:flutter/material.dart';
import 'package:groupnotes/views/auth/login/view/login_view.dart';

abstract class LoginViewModel extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
