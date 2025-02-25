import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:runix_project/core/common/auth_textfield.dart';
import 'package:runix_project/core/common/loader.dart';
import 'package:runix_project/features/auth/controller/auth_controller.dart';
import 'package:runix_project/theme/pallete.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  void signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    ref.read(authControllerProvider.notifier).signUpWithEmailAndPassword(
        email: email, password: password, context: context);
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    final currentTheme = ref.watch(themeNotifierProvider.notifier).mode;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.005,
              right: MediaQuery.of(context).size.width * 0.3,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: currentTheme == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.005,
              right: MediaQuery.of(context).size.width * -0.08,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: currentTheme == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.2,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: currentTheme == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.width * -0.07,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: currentTheme == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            isLoading
                ? const Loader()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Regisztráció',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 50),
                        AuthTextfield(
                          hintText: 'EMAIL',
                          icon: Icon(Icons.mail_outline),
                          controller: _emailController,
                          obsecureText: false,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        AuthTextfield(
                          hintText: 'JELSZÓ',
                          icon: Icon(Icons.lock_outline),
                          controller: _passwordController,
                          obsecureText: true,
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () => signUpWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text),
                              child: const Text('Regisztráció'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Már van fiókja? '),
                            GestureDetector(
                              onTap: () => Routemaster.of(context).pop(),
                              child: Text(
                                'Jelentkezzen be',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
