// 'import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../domain/utils/form_field.dart';
// import '../../infrastructure/navigation/routes.dart';
// import '../status.dart';
// import 'controllers/sign_in.controller.dart';

// class SignInScreen extends GetView<SignInController> {
//   const SignInScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final email = TextEditingController();
//     final password = TextEditingController();
//     final toglePaswd = true.obs;
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: ListView(
//             padding: const EdgeInsets.all(20),
//             shrinkWrap: true,
//             children: [
//               Text(
//                 'Welcome !',
//                 style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 25.0,
//                     fontWeight: FontWeight.w500),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 47),
//               Formulir.formEmail(labelText: 'Email', controller: email),
//               const SizedBox(height: 24),
//               Obx(
//                 () => Formulir.formPasswd(
//                   onPressed: () => toglePaswd.toggle(),
//                   labelText: 'Password',
//                   controller: password,
//                   obscureText: toglePaswd.value,
//                 ),
//               ),
//               const SizedBox(height: 14),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   GestureDetector(
//                     onTap: () => Get.snackbar('title', 'message'),
//                     child: Text('Forgot password ?',
//                         style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.w500)),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               Obx(
//                 () => ElevatedButton(
//                   onPressed: () => controller.funcSignIn(
//                       email: email.text, password: password.text),
//                   child: controller.statusButton.value != Status.loading
//                       ? const Text('Login')
//                       : const CircularProgressIndicator(
//                           backgroundColor: Colors.amber,
//                           color: Colors.white,
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 58),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account yet? "),
//                   GestureDetector(
//                     onTap: () => Get.offNamed(Routes.SIGN_UP),
//                     child: Text(
//                       'Register',
//                       style: TextStyle(
//                           color: Theme.of(context).primaryColor,
//                           decorationColor: Colors.black54,
//                           decoration: TextDecoration.underline,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ============================================================================
// KONVERSI KE FLUTTER MODERN + BLOC + FLUTTER HOOKS
// ============================================================================
// Perubahan utama:
// 1. GetX (GetView + Obx) → BLoC (BlocConsumer) untuk state management global
// 2. Stateful/GetView → HookWidget dengan Flutter Hooks untuk state lokal
// 3. TextEditingController() → useTextEditingController() dari flutter_hooks
// 4. Reactive state (obs) → useState() dari flutter_hooks
// 5. Get.offNamed() → Navigator.pushNamed()
// 6. Get.snackbar() → ScaffoldMessenger.showSnackBar()
// 7. UI tetap sama (form_widget digunakan dari features/auth/presentation/widgets)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:laker_2/features/presentation/cubit/signin_cubit.dart';

import '../../../core/utils/form_field.dart' show Formulir;

class SignInScreen extends HookWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // State lokal menggunakan Flutter Hooks
    final email = useTextEditingController();
    final password = useTextEditingController();
    final isPasswordVisible = useState(false);

    // Cleanup controllers saat widget di-dispose
    useEffect(() {
      return () {
        email.dispose();
        password.dispose();
      };
    }, []);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              Text(
                'Welcome !',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 47),
              Formulir.formEmail(labelText: 'Email', controller: email),
              const SizedBox(height: 24),
              Formulir.formPasswd(
                onPressed: () =>
                    isPasswordVisible.value = !isPasswordVisible.value,
                labelText: 'Password',
                controller: password,
                obscureText: !isPasswordVisible.value,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Forgot password feature coming soon'),
                      ),
                    ),
                    child: Text(
                      'Forgot password ?',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              BlocConsumer<SigninCubit, SigninState>(
                listener: (context, state) {
                  if (state is SigninSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login successful')),
                    );
                    // TODO: Navigate ke home screen
                  } else if (state is SigninError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  final isLoading = state is SigninLoading;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () => context.read<SigninCubit>().signin(
                            email: email.text,
                            password: password.text,
                          ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            backgroundColor: Colors.amber,
                            color: Colors.white,
                          )
                        : const Text('Login'),
                  );
                },
              ),
              const SizedBox(height: 58),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account yet? "),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/sign-up'),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        decorationColor: Colors.black54,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
