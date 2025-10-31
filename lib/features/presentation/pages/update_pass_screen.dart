// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:laker/domain/utils/snackbar.dart';

// import '../../domain/utils/form_field.dart';
// import '../status.dart';
// import 'controllers/update_password.controller.dart';

// class UpdatePasswordScreen extends GetView<UpdatePasswordController> {
//   const UpdatePasswordScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     final passwordSekarang = TextEditingController();
//     final passwordBaru = TextEditingController();
//     final passwordKonfirm = TextEditingController();
//     final toglePaswdSekarang = true.obs;
//     final toglePaswdBaru = true.obs;
//     final toglePaswdKonfirm = true.obs;
//     return Scaffold(
//       appBar: AppBar(title: const Text('UPDATE PASSWORD')),
//       body: Form(
//         key: formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(15),
//           children: [
//             Obx(
//               () => Formulir.formPasswd(
//                 labelText: 'Password Sekarang',
//                 controller: passwordSekarang,
//                 obscureText: toglePaswdSekarang.value,
//                 onPressed: () => toglePaswdSekarang.toggle(),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Obx(
//               () => Formulir.formPasswd(
//                 labelText: 'Password Baru',
//                 controller: passwordBaru,
//                 obscureText: toglePaswdBaru.value,
//                 onPressed: () => toglePaswdBaru.toggle(),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Obx(
//               () => Formulir.formPasswd(
//                 labelText: 'Konfirmasi Password Baru',
//                 controller: passwordKonfirm,
//                 obscureText: toglePaswdKonfirm.value,
//                 onPressed: () => toglePaswdKonfirm.toggle(),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Obx(
//               () => ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     if (passwordBaru.text == passwordKonfirm.text) {
//                       snackbarSukses('Berhasil', 'Berhasil mengganti password');
//                     } else {
//                       snackbarEror('Peringatan',
//                           'Password Konfirmasi dengan Password Baru berbeda');
//                     }
//                     // controller.funcRegister(
//                     //   name: name.text,
//                     //   email: email.text,
//                     //   password: password.text,
//                     //   tempatLahir: tempatLahir.text,
//                     //   whatsapp: whatsapp.text,
//                     //   divisi: divisi.text,
//                     // );
//                   }
//                 },
//                 child: controller.statusButton.value != Status.loading
//                     ? const Text("Sign Up")
//                     : const CircularProgressIndicator(
//                         backgroundColor: Colors.amber,
//                         color: Colors.white,
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ============================================================================
// KONVERSI KE FLUTTER MODERN + FLUTTER HOOKS
// ============================================================================
// Perubahan utama:
// 1. GetView → HookWidget untuk modern state management
// 2. Reactive state (obs) → useState() dari flutter_hooks
// 3. TextEditingController() → useTextEditingController() dari flutter_hooks
// 4. Obx(...) → langsung gunakan state value dari useState()
// 5. Get.snackbar() → ScaffoldMessenger.showSnackBar()
// 6. UI tetap identik, hanya state management yang berubah
// 7. Form validation tetap sama menggunakan GlobalKey<FormState>
// 8. Password visibility toggle tetap sama pattern-nya

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/utils/form_field.dart' show Formulir;

class UpdatePasswordScreen extends HookWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Form key untuk validasi
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Text editing controllers untuk ketiga password fields
    final passwordSekarang = useTextEditingController();
    final passwordBaru = useTextEditingController();
    final passwordKonfirm = useTextEditingController();

    // Password visibility state untuk ketiga password fields
    final isPasswordSekarangVisible = useState(false);
    final isPasswordBaruVisible = useState(false);
    final isPasswordKonfirmVisible = useState(false);

    // Cleanup controllers saat widget di-dispose
    useEffect(() {
      return () {
        passwordSekarang.dispose();
        passwordBaru.dispose();
        passwordKonfirm.dispose();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('UPDATE PASSWORD')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            // Password Sekarang Field
            Formulir.formPasswd(
              labelText: 'Password Sekarang',
              controller: passwordSekarang,
              obscureText: !isPasswordSekarangVisible.value,
              onPressed: () => isPasswordSekarangVisible.value =
                  !isPasswordSekarangVisible.value,
            ),
            const SizedBox(height: 15),

            // Password Baru Field
            Formulir.formPasswd(
              labelText: 'Password Baru',
              controller: passwordBaru,
              obscureText: !isPasswordBaruVisible.value,
              onPressed: () =>
                  isPasswordBaruVisible.value = !isPasswordBaruVisible.value,
            ),
            const SizedBox(height: 15),

            // Password Konfirmasi Field
            Formulir.formPasswd(
              labelText: 'Konfirmasi Password Baru',
              controller: passwordKonfirm,
              obscureText: !isPasswordKonfirmVisible.value,
              onPressed: () => isPasswordKonfirmVisible.value =
                  !isPasswordKonfirmVisible.value,
            ),
            const SizedBox(height: 15),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (passwordBaru.text == passwordKonfirm.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Berhasil mengganti password'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // TODO: Panggil update password use case/cubit di sini
                    // context.read<UpdatePasswordCubit>().updatePassword(
                    //   currentPassword: passwordSekarang.text,
                    //   newPassword: passwordBaru.text,
                    // );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password Konfirmasi dengan Password Baru berbeda',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
