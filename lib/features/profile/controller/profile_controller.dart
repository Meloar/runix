import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:runix_project/core/utils.dart';
import 'package:runix_project/features/auth/controller/auth_controller.dart';
import 'package:runix_project/features/profile/repository/profile_repository.dart';
import 'package:runix_project/models/user_model.dart';

final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>(
  (ref) {
    final profileRepository = ref.watch(profileRepositoryProvider);
    return ProfileController(profileRepository: profileRepository, ref: ref);
  },
);

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _profileRepository;
  final Ref _ref;
  ProfileController({
    required ProfileRepository profileRepository,
    required Ref ref,
  })  : _profileRepository = profileRepository,
        _ref = ref,
        super(false);

  void editProfile({
    required BuildContext context,
    required String name,
    required String address,
  }) async {
    state = true;
    UserModel user = _ref.read(userProvider)!;
    user = user.copyWith(name: name, address: address);
    final res = await _profileRepository.editProfile(user);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      _ref.read(userProvider.notifier).update((state) => user);
      Routemaster.of(context).pop();
      showSnackBar(context, 'Sikeresen megváltoztattad az adatokat!');
    });
  }
}
