import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt/core/extensions/build_context_ext.dart';
import 'package:flutter_cbt/data/models/request/auth/login_request_model.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasource/auth/auth_local_datasource.dart';
import '../../home/pages/dashboard_page.dart';
import '../bloc/login/login_bloc.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Log in'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          CustomTextField(
            controller: emailController,
            label: 'Email Address',
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 42.0),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                  orElse: () {},
                  success: (state) {
                    AuthLocalDatasource().saveAuthData(state);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: AppColors.lightGreen,
                        content: Text(
                          'Login Success',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                    context.pushReplacement(const DashboardPage());
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.lightRed,
                        content: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  });
            },
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return Button.filled(
                  onPressed: () {
                    final dataRequest = LoginRequestModel(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    context
                        .read<LoginBloc>()
                        .add(LoginEvent.login(dataRequest));

                    emailController.clear();
                    passwordController.clear();
                  },
                  label: 'LOG IN',
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
            },
          ),
          const SizedBox(height: 24.0),
          GestureDetector(
            onTap: () {
              context.pushReplacement(const RegisterPage());
            },
            child: const Text.rich(
              TextSpan(
                text: 'Don\'t have an account? ',
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
