// // import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../domain/constant/constants.dart';
// import '../../infrastructure/navigation/routes.dart';
// import 'controllers/profile.controller.dart';

// class ProfileScreen extends GetView<ProfileController> {
//   const ProfileScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     List listProfil = [
//       {
//         'title': 'Update Profil',
//         'icon': Icons.person_outline,
//         'onTap': () => Get.toNamed(Routes.UPDATE_PROFILE),
//       },
//       {
//         'title': 'Update Kata Sandi',
//         'icon': Icons.security,
//         'onTap': () => Get.toNamed(Routes.UPDATE_PASSWORD),
//       },
//       {
//         'title': 'Keluar',
//         'icon': Icons.exit_to_app,
//         'onTap': () => controller.signout(),
//       },
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Get.offAllNamed(Routes.HOME),
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Text('PROFILE'),
//       ),
//       body: Stack(
//         alignment: Alignment.topCenter,
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//               borderRadius: BorderRadius.vertical(
//                 bottom: Radius.elliptical(Get.width, 20),
//               ),
//             ),
//             height: 120,
//             width: Get.width,
//           ),
//           Column(
//             children: [
//               Card.filled(
//                 margin: const EdgeInsets.all(20),
//                 child: SizedBox(
//                   width: 350,
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         CircleAvatar(
//                           radius: 55,
//                           backgroundColor: Colors.grey.shade200,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               image: DecorationImage(
//                                 image: AssetImage(AppTexts.logoPMII),
//                                 fit: BoxFit.contain,
//                               ),
//                               shape: BoxShape.circle,
//                             ),
//                             height: 100,
//                             width: 100,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Text(
//                           controller.dataUser['nama'],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 19,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(controller.dataUser['email']),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Column(
//                 children: listProfil
//                     .map(
//                       (e) => profileMenu(
//                         context: context,
//                         title: e['title'],
//                         icon: e['icon'],
//                         onTap: e['onTap'],
//                       ),
//                     )
//                     .toList(),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   InkWell profileMenu({
//     required BuildContext context,
//     required String title,
//     required IconData icon,
//     required Function() onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Theme.of(context).primaryColor,
//           radius: 25,
//           child: Icon(icon, size: 35, color: Colors.white),
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 15,
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//         ),
//       ),
//     );
//   }
// }

// ============================================================================
// KONVERSI KE FLUTTER MODERN (DARI GETX KE CUBIT)
// ============================================================================
// Perubahan:
// 1. GetView<ProfileController> → StatelessWidget + BlocListener & BlocBuilder
// 2. Get.toNamed() → Navigator.pushNamed()
// 3. Get.offAllNamed() → Navigator.pushNamedAndRemoveUntil()
// 4. Get.width → MediaQuery.sizeOf(context).width
// 5. controller.dataUser → ProfileCubit state
// 6. controller.signout() → context.read<ProfileCubit>().signout()
// File: lib/features/presentation/cubit/profile_cubit.dart
// State: lib/features/presentation/cubit/profile_state.dart
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_router.dart';
import '../cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSignoutSuccess) {
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   signin,
          //   (route) => false,
          // );
          SigninRoute().push(context);
        }
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                // onPressed: () => Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   RouteName.home,
                //   (route) => false,
                // ),
                onPressed: () {
                  HomeRoute().push(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text('PROFILE'),
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProfileState state) {
    if (state is ProfileLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ProfileError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(state.message),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<ProfileCubit>().loadUserProfile(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is ProfileLoaded) {
      return _buildProfileBody(
        context,
        userName: state.userData['nama'] ?? 'Unknown User',
        userEmail: state.userData['email'] ?? 'No email',
        isSigningOut: false,
      );
    }

    if (state is ProfileSigningOut) {
      return _buildProfileBody(
        context,
        userName: 'Loading...',
        userEmail: 'Loading...',
        isSigningOut: true,
      );
    }

    return const Center(child: Text('Unknown state'));
  }

  Widget _buildProfileBody(
    BuildContext context, {
    required String userName,
    required String userEmail,
    required bool isSigningOut,
  }) {
    List listProfil = [
      {
        'title': 'Update Profil',
        'icon': Icons.person_outline,
        'onTap': () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update Profil - Coming Soon')),
        ),
      },
      {
        'title': 'Update Kata Sandi',
        'icon': Icons.security,
        'onTap': () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update Kata Sandi - Coming Soon')),
        ),
      },
      {
        'title': 'Keluar',
        'icon': Icons.exit_to_app,
        'onTap': () => _showSignoutDialog(context),
      },
    ];

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(MediaQuery.sizeOf(context).width, 20),
            ),
          ),
          height: 120,
          width: MediaQuery.sizeOf(context).width,
        ),
        Column(
          children: [
            Card.filled(
              margin: const EdgeInsets.all(20),
              child: SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey.shade200,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage('assets/images/logo_pmii.png'),
                              fit: BoxFit.contain,
                            ),
                            shape: BoxShape.circle,
                          ),
                          height: 100,
                          width: 100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(userEmail),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: listProfil
                  .map(
                    (e) => _profileMenu(
                      context: context,
                      title: e['title'] as String,
                      icon: e['icon'] as IconData,
                      onTap: e['onTap'] as Function(),
                      isDisabled: isSigningOut,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showSignoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah anda yakin ingin keluar ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                context.read<ProfileCubit>().signout();
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Iya'),
            ),
          ],
        );
      },
    );
  }

  InkWell _profileMenu({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Function() onTap,
    bool isDisabled = false,
  }) {
    final isSignoutMenu = title == 'Keluar';

    return InkWell(
      onTap: isDisabled && isSignoutMenu ? null : onTap,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 25,
          child: isDisabled && isSignoutMenu
              ? const SizedBox(
                  width: 35,
                  height: 35,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                )
              : Icon(icon, size: 35, color: Colors.white),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
    );
  }
}
