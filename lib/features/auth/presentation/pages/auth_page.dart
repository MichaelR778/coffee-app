import 'package:coffee_app/features/auth/presentation/pages/login_page.dart';
import 'package:coffee_app/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _loginPage = true;

  void togglePage() {
    setState(() {
      _loginPage = !_loginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loginPage
        ? LoginPage(togglePage: togglePage)
        : RegisterPage(togglePage: togglePage);
  }
}
