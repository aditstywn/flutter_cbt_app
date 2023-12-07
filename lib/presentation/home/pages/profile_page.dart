import 'package:flutter/material.dart';
import 'package:flutter_cbt/core/extensions/build_context_ext.dart';

import '../../../data/datasource/auth/auth_local_datasource.dart';
import '../../auth/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Halaman Profile'),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  AuthLocalDatasource().removeAuthData();
                  context.pushReplacement(const LoginPage());
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
