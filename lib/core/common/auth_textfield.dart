import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:runix_project/theme/pallete.dart';

class AuthTextfield extends ConsumerWidget {
  final String hintText;
  final Icon icon;
  final TextEditingController controller;
  final bool obsecureText;
  final TextInputType textInputType;
  const AuthTextfield({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.obsecureText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider.notifier).mode;

    return TextField(
      controller: controller,
      obscureText: obsecureText,
      keyboardType: textInputType,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: currentTheme == ThemeMode.light
              ? Colors.grey.shade900
              : Colors.white,
        ),
        prefixIcon: icon,
        prefixIconColor: currentTheme == ThemeMode.light
            ? Colors.grey.shade900
            : Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: currentTheme == ThemeMode.light
                ? Colors.grey.shade900
                : Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: currentTheme == ThemeMode.light
                ? Colors.grey.shade900
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
