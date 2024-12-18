import 'package:coffee_app/common/my_button.dart';
import 'package:coffee_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final String email;

  @override
  void initState() {
    super.initState();
    email = supabase.auth.currentUser!.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(email),
            const SizedBox(height: 24),
            MyButton(
              text: 'Logout',
              onTap: () => context.read<AuthCubit>().logout(),
            ),
          ],
        ),
      ),
    );
  }
}
