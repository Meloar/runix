import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:runix_project/core/common/auth_textfield.dart';
import 'package:runix_project/features/auth/controller/auth_controller.dart';
import 'package:runix_project/theme/pallete.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  void navigateToSignUpScreen() {
    Routemaster.of(context).push('/sign-up');
  }

  void signInWithEmailAndPassword(
      {required String email,
      required String password,
      required WidgetRef ref}) {
    ref.read(authControllerProvider.notifier).signInWithEmailAndPassword(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bejelentkezés',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Kérlek jelentkezz be a folytatáshoz',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
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
                          backgroundColor: currentTheme == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          foregroundColor: currentTheme == ThemeMode.light
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () => signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                            ref: ref),
                        child: const Text('Bejelentkezés'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nincs fiókja? '),
                      GestureDetector(
                        onTap: () => navigateToSignUpScreen(),
                        child: Text(
                          'Regisztráljon most',
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
