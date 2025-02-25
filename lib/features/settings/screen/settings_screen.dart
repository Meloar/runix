import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:runix_project/theme/pallete.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Runix'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: ref.watch(themeNotifierProvider.notifier).mode ==
                ThemeMode.dark,
            onChanged: (val) => toggleTheme(ref),
            title: Text(
              'Sötét mód',
            ),
          )
        ],
      ),
    );
  }
}
