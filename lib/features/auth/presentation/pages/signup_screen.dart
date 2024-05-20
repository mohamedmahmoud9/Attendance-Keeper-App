import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/auth/injection_container.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      
      create: (context) => sl<UserCubit>(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (BuildContext context, state) {
        final UserCubit userCubit = context.watch<UserCubit>();
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 25.0),
                  child: Form(
                    key: userCubit.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                            child: Text('Sign Up',
                                style:
                                    Theme.of(context).textTheme.headlineLarge)),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: userCubit.nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: userCubit.jobController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Job Title',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: userCubit.emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          obscureText: true,
                          controller: userCubit.passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          obscureText: true,
                          controller: userCubit.confirmPasswordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            if (!userCubit.formKey.currentState!.validate()) {
                              return;
                            }
                            context.read<UserCubit>().submitSignUp(
                                  user: UserEntity(
                                    name: userCubit.nameController.text,
                                    jobTitle: userCubit.jobController.text,
                                    email: userCubit.emailController.text,
                                    password: userCubit.passwordController.text,
                                  ),
                                );
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
