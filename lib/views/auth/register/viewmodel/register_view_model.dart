import 'package:flutter/material.dart';
import 'package:groupnotes/views/auth/register/view/register_view.dart';

abstract class RegisterViewModel extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
