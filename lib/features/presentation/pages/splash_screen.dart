// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../domain/constant/constants.dart';
// import 'controllers/splash.controller.dart';

// class SplashScreen extends GetView<SplashController> {
//   const SplashScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     controller.onInit();
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           width: Get.width / 2,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(child: Image.asset(AppTexts.logoPMII)),
//                   const SizedBox(width: 10),
//                   Image.asset(AppTexts.logo, width: Get.width / 3),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const LinearProgressIndicator(
//                 backgroundColor: Colors.transparent,
//                 color: Colors.amber,
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Text('@unustudents ${DateTime.now().year}'),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
//     );
//   }
// }

// ============================================================================
// KONVERSI KE FLUTTER MODERN + HOOKS + BLOC
// ============================================================================
// Perubahan utama:
// 1. GetView → HookWidget + BlocListener untuk modern state management
// 2. controller.onInit() → useEffect() untuk initialization via SplashCubit
// 3. Get.width → MediaQuery.of(context).size.width
// 4. SystemChrome.setEnabledSystemUIMode() → dipindahkan ke SplashCubit.initializeSplash()
// 5. Firebase auth state changes → dipindahkan ke SplashCubit
// 6. Navigation (Get.offAllNamed) → dipindahkan ke BlocListener
// 7. UI tetap identik, state management dan logic sudah di-refactor

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:laker_2/gen/assets.gen.dart';
import 'package:laker_2/routes/app_router.dart';

import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentYear = DateTime.now().year;

    // Initialize splash logic saat widget pertama kali di-mount
    useEffect(() {
      // Trigger splash initialization via Cubit
      Future.microtask(() => context.read<SplashCubit>().initializeSplash());
      return null;
    }, []);

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        // if (state is SplashUpdateStatus) {
        //   state.updateStatus == UpdateStatus.available
        //       ? ScaffoldMessenger.of(context).showSnackBar(
        //           const SnackBar(
        //             content: Text('Update available! Downloading...'),
        //           ),
        //         )
        //       : state.updateStatus == UpdateStatus.downloaded
        //       ? ScaffoldMessenger.of(context).showSnackBar(
        //           const SnackBar(
        //             content: Text('Update downloaded! Restart app to apply.'),
        //           ),
        //         )
        //       : null;
        //   // Handle update status changes if needed
        // } else
        if (state is SplashNavigateToHome) {
          HomeRoute().pushReplacement(context);
        } else if (state is SplashNavigateToSignIn) {
          SigninRoute().pushReplacement(context);
        } else if (state is SplashError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
        }
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: screenWidth / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Aset.images.logoPmii.image()),
                    const SizedBox(width: 10),
                    Aset.images.logoPng.image(width: screenWidth / 3),
                  ],
                ),
                const SizedBox(height: 20),
                const LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Text('@unustudents $currentYear'),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}
