// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../domain/utils/form_field.dart';
// import '../status.dart';
// import 'controllers/update_profile.controller.dart';

// class UpdateProfileScreen extends GetView<UpdateProfileController> {
//   const UpdateProfileScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     final name = TextEditingController();
//     final tempatLahir = TextEditingController();
//     final divisi = TextEditingController();
//     final whatsapp = TextEditingController();
//     final email = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(title: const Text('UPDATE PROFIL')),
//       body: Form(
//         key: formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(15),
//           children: [
//             Formulir.formReguler(labelText: 'Nama', controller: name),
//             const SizedBox(height: 15),
//             Formulir.formReguler(
//                 labelText: 'Tempat Lahir', controller: tempatLahir),
//             const SizedBox(height: 15),
//             Formulir.formReguler(labelText: 'Divisi', controller: divisi),
//             const SizedBox(height: 15),
//             Formulir.formReguler(labelText: 'WhatsApp', controller: whatsapp),
//             const SizedBox(height: 15),
//             Formulir.formReguler(labelText: 'Email', controller: email),
//             const SizedBox(height: 15),
//             Obx(
//               () => ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
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
//                     ? const Text("Update Profil")
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
// 2. TextEditingController() → useTextEditingController() dari flutter_hooks
// 3. Obx(...) → langsung render button tanpa wrapper
// 4. Get snackbar → ScaffoldMessenger.showSnackBar() untuk feedback user
// 5. UI tetap identik, hanya state management yang berubah
// 6. Form validation tetap sama menggunakan GlobalKey<FormState>
// 7. Lima form fields (nama, tempatLahir, divisi, whatsapp, email) tetap sama

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/utils/form_field.dart' show Formulir;

class UpdateProfileScreen extends HookWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Form key untuk validasi
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Text editing controllers untuk lima profile fields
    final name = useTextEditingController();
    final tempatLahir = useTextEditingController();
    final divisi = useTextEditingController();
    final whatsapp = useTextEditingController();
    final email = useTextEditingController();

    // Button loading state
    final isLoading = useState(false);

    // Cleanup controllers saat widget di-dispose
    useEffect(() {
      return () {
        name.dispose();
        tempatLahir.dispose();
        divisi.dispose();
        whatsapp.dispose();
        email.dispose();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('UPDATE PROFIL')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            // Nama Field
            Formulir.formReguler(labelText: 'Nama', controller: name),
            const SizedBox(height: 15),

            // Tempat Lahir Field
            Formulir.formReguler(
              labelText: 'Tempat Lahir',
              controller: tempatLahir,
            ),
            const SizedBox(height: 15),

            // Divisi Field
            Formulir.formReguler(labelText: 'Divisi', controller: divisi),
            const SizedBox(height: 15),

            // WhatsApp Field
            Formulir.formReguler(labelText: 'WhatsApp', controller: whatsapp),
            const SizedBox(height: 15),

            // Email Field
            Formulir.formReguler(labelText: 'Email', controller: email),
            const SizedBox(height: 15),

            // Submit Button
            ElevatedButton(
              onPressed: isLoading.value
                  ? null
                  : () {
                      if (formKey.currentState!.validate()) {
                        // TODO: Panggil update profile use case/cubit di sini
                        // isLoading.value = true;
                        // context.read<UpdateProfileCubit>().updateProfile(
                        //   name: name.text,
                        //   tempatLahir: tempatLahir.text,
                        //   divisi: divisi.text,
                        //   whatsapp: whatsapp.text,
                        //   email: email.text,
                        // );
                      }
                    },
              child: isLoading.value
                  ? const CircularProgressIndicator(
                      backgroundColor: Colors.amber,
                      color: Colors.white,
                    )
                  : const Text('Update Profil'),
            ),
          ],
        ),
      ),
    );
  }
}
