// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../domain/utils/form_field.dart';
// import '../../infrastructure/navigation/routes.dart';
// import '../status.dart';
// import 'controllers/sign_up.controller.dart';

// class SignUpScreen extends GetView<SignUpController> {
//   const SignUpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     final name = TextEditingController();
//     final tempatLahir = TextEditingController();
//     final divisi = TextEditingController();
//     final whatsapp = TextEditingController();
//     final email = TextEditingController();
//     final password = TextEditingController();
//     final toglePaswd = true.obs;
//     return Scaffold(
//       body: Center(
//         child: Form(
//           key: formKey,
//           child: ListView(
//             padding: const EdgeInsets.all(15),
//             shrinkWrap: true,
//             children: [
//               Text("Sign Up", style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
//               const SizedBox(height: 15),
//               Formulir.formReguler(labelText: "Nama", controller: name),
//               const SizedBox(height: 15),
//               Formulir.formReguler(labelText: "Tempat Lahir", controller: tempatLahir),
//               const SizedBox(height: 15),
//               Formulir.formReguler(labelText: "Divisi", controller: divisi),
//               const SizedBox(height: 15),
//               Formulir.formPhone(labelText: "Whatsapp", controller: whatsapp),
//               const SizedBox(height: 15),
//               Formulir.formEmail(labelText: "Email", controller: email),
//               const SizedBox(height: 15),
//               Obx(
//                 () => Formulir.formPasswd(
//                     labelText: "Password", controller: password, obscureText: toglePaswd.value, onPressed: () => toglePaswd.toggle()),
//               ),
//               const SizedBox(height: 15),
//               Obx(
//                 () => ElevatedButton(
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       controller.funcRegister(
//                         name: name.text,
//                         email: email.text,
//                         password: password.text,
//                         tempatLahir: tempatLahir.text,
//                         whatsapp: whatsapp.text,
//                         divisi: divisi.text,
//                       );
//                     }
//                   },
//                   child: controller.statusButton.value != Status.loading
//                       ? const Text("Sign Up")
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
//                   const Text("Have an account yet? "),
//                   GestureDetector(
//                     onTap: () => Get.offNamed(Routes.SIGN_IN),
//                     child: Text(
//                       'Sign In',
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

import '../../../core/utils/form_field.dart' show Formulir;
import '../cubit/signup_cubit.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // State lokal menggunakan Flutter Hooks
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final name = useTextEditingController();
    final tempatLahir = useTextEditingController();
    final divisi = useTextEditingController();
    final whatsapp = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();
    final isPasswordVisible = useState(false);

    // Cleanup controllers saat widget di-dispose
    useEffect(() {
      return () {
        name.dispose();
        tempatLahir.dispose();
        divisi.dispose();
        whatsapp.dispose();
        email.dispose();
        password.dispose();
      };
    }, []);

    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(15),
            shrinkWrap: true,
            children: [
              Text(
                "Sign Up",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Formulir.formReguler(labelText: "Nama", controller: name),
              const SizedBox(height: 15),
              Formulir.formReguler(
                labelText: "Tempat Lahir",
                controller: tempatLahir,
              ),
              const SizedBox(height: 15),
              Formulir.formReguler(labelText: "Divisi", controller: divisi),
              const SizedBox(height: 15),
              Formulir.formPhone(
                labelText: "Whatsapp",
                controller: whatsapp,
              ),
              const SizedBox(height: 15),
              Formulir.formEmail(labelText: "Email", controller: email),
              const SizedBox(height: 15),
              Formulir.formPasswd(
                labelText: "Password",
                controller: password,
                obscureText: !isPasswordVisible.value,
                onPressed: () =>
                    isPasswordVisible.value = !isPasswordVisible.value,
              ),
              const SizedBox(height: 15),
              BlocConsumer<SignupCubit, SignupState>(
                listener: (context, state) {
                  if (state is SignupSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    // TODO: Navigate ke signin screen
                    Navigator.pushNamed(context, '/signin');
                  } else if (state is SignupError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is SignupLoading;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              context.read<SignupCubit>().signup(
                                    email: email.text,
                                    name: name.text,
                                    division: divisi.text,
                                    birthDate: DateTime.now(),
                                    whatsapp: whatsapp.text,
                                    password: password.text,
                                  );
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            backgroundColor: Colors.amber,
                            color: Colors.white,
                          )
                        : const Text("Sign Up"),
                  );
                },
              ),
              const SizedBox(height: 58),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have an account yet? "),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/signin'),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        decorationColor: Colors.black54,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
