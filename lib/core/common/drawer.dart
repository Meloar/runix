import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:runix_project/features/auth/controller/auth_controller.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void navigateToHomeScreen(BuildContext context) {
    Routemaster.of(context).replace('/');
  }

  void navigateToCategory(BuildContext context, String category) {
    Routemaster.of(context).pop();
    Routemaster.of(context).push('/$category');
  }

  void navigateToCart(BuildContext context) {
    Routemaster.of(context).pop();
    Routemaster.of(context).push('/cart');
  }

  void navigateToSettings(BuildContext context) {
    Routemaster.of(context).pop();
    Routemaster.of(context).push('/settings');
  }

  void navigateToProfile(BuildContext context, String uid) {
    Routemaster.of(context).pop();
    Routemaster.of(context).push('/profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const UnderlineTabIndicator(
                borderSide: BorderSide(),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Üdvözöllek, ${user.name}',
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () => Routemaster.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text(
                'Profil',
              ),
              onTap: () => navigateToProfile(context, user.uid),
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Cipő',
              ),
              onTap: () => navigateToCategory(context, 'Shoe'),
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Pulóver',
              ),
              onTap: () => navigateToCategory(context, 'Sweater'),
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Kabát',
              ),
              onTap: () => navigateToCategory(context, 'Jacket'),
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Póló',
              ),
              onTap: () => navigateToCategory(context, 'Polo'),
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Kosár',
              ),
              onTap: () => navigateToCart(context),
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Beállítások',
              ),
              onTap: () => navigateToSettings(context),
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () => logOut(ref),
              child: const Text(
                'Kijelentkezés',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
