import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:runix_project/core/common/error_text.dart';
import 'package:runix_project/core/common/loader.dart';
import 'package:runix_project/features/auth/controller/auth_controller.dart';
import 'package:runix_project/features/profile/controller/profile_controller.dart';
import 'package:runix_project/theme/pallete.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(userProvider)!.name);
    addressController =
        TextEditingController(text: ref.read(userProvider)!.address);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
  }

  void saveProfile() {
    ref.read(profileControllerProvider.notifier).editProfile(
        context: context,
        name: nameController.text,
        address: addressController.text);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider.notifier).mode;
    final isLoading = ref.watch(profileControllerProvider);
    final user = ref.watch(userProvider);

    return ref.watch(getUserDataProvider(widget.uid)).when(
          data: (data) => Scaffold(
            appBar: AppBar(
              title: const Text('Runix'),
              centerTitle: true,
            ),
            body: isLoading
                ? const Loader()
                : Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Regisztrált e-mail cím: ${user!.email}',
                          style: TextStyle(
                            fontSize: 15,
                            color: currentTheme == ThemeMode.light
                                ? Colors.grey.shade900
                                : Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Felhasználónév megváltoztatása:',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Név',
                            hintStyle: TextStyle(
                              color: currentTheme == ThemeMode.light
                                  ? Colors.grey.shade900
                                  : Colors.white,
                            ),
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
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Cím megváltoztatása:',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                            hintText: 'Cím',
                            hintStyle: TextStyle(
                              color: currentTheme == ThemeMode.light
                                  ? Colors.grey.shade900
                                  : Colors.white,
                            ),
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
                        ),
                        SizedBox(height: 60),
                        Center(
                          child: ElevatedButton(
                            onPressed: () => saveProfile(),
                            child: Text(
                              'Mentés',
                              style: TextStyle(
                                color: currentTheme == ThemeMode.light
                                    ? Colors.grey.shade900
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => Loader(),
        );
  }
}
