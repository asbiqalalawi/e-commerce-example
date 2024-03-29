import 'package:e_commerce_example/app/widget/button.dart';
import 'package:e_commerce_example/app/widget/input.dart';
import 'package:e_commerce_example/app/widget/loadable.dart';
import 'package:e_commerce_example/feature/login/bloc/login_bloc.dart';
import 'package:e_commerce_example/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.go('/home');
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        } else {}
      },
      builder: (context, state) {
        return Loadable(
          loading: state is LoginLoading,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Tokopakedi',
                    style: TextStyle(
                      color: ColorStyle.mainColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Shop now for better life',
                    style: TextStyle(
                      color: ColorStyle.subtitleColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 120),
                  Input(
                    labelText: 'Username',
                    controller: _usernameController,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Username cannot be empty';
                      }
                      return null;
                    },
                    hintText: 'Enter username here',
                  ),
                  const SizedBox(height: 20),
                  Input(
                    labelText: 'Password',
                    controller: _passwordController,
                    isPassword: true,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Password cannot be empty';
                      } else if ((value ?? '').length < 6) {
                        return 'Password must be more than 5 characters';
                      }
                      return null;
                    },
                    hintText: 'Enter password here',
                  ),
                  const SizedBox(height: 20),
                  Button(
                    text: 'Sign In',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(
                              LoginWithUsernameEvent(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
