import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/utils/form_field.dart' show Formulir;
import '../cubit/profile_cubit.dart';

class UpdateProfileScreen extends HookWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Pantau state dari ProfileCubit agar widget build ulang saat data selesai di-load
    final state = context.watch<ProfileCubit>().state;

    // Text editing controllers
    final name = useTextEditingController();
    final tempatLahir = useTextEditingController();
    final divisi = useTextEditingController();
    final whatsapp = useTextEditingController();
    final email = useTextEditingController();

    // Update text field ketika state berubah menjadi ProfileLoaded
    useEffect(() {
      if (state is ProfileLoaded) {
        name.text = state.userData.nama;
        tempatLahir.text = state.userData.tempLahir;
        divisi.text = state.userData.divisi;
        whatsapp.text = state.userData.wa;
        email.text = state.userData.email;
      }
      // Saat update berhasil, populate form dengan data terbaru
      if (state is ProfileUpdateSuccess) {
        name.text = state.userData.nama;
        tempatLahir.text = state.userData.tempLahir;
        divisi.text = state.userData.divisi;
        whatsapp.text = state.userData.wa;
        email.text = state.userData.email;
      }
      return null;
    }, [state]);

    // Form key untuk validasi
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Apakah sedang dalam proses update
    final isUpdating = state is ProfileUpdating;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profil berhasil diperbarui!'),
              backgroundColor: Colors.green,
            ),
          );
          // Kembali ke halaman profil
          Navigator.of(context).pop();
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
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

              // Email Field — read-only, tidak bisa diubah
              Formulir.formReguler(
                labelText: 'Email',
                controller: email,
                readOnly: true,
              ),
              const SizedBox(height: 15),

              // Submit Button
              ElevatedButton(
                onPressed: isUpdating
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          context.read<ProfileCubit>().updateProfile(
                            nama: name.text,
                            tempLahir: tempatLahir.text,
                            divisi: divisi.text,
                            wa: whatsapp.text,
                          );
                        }
                      },
                child: isUpdating
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          backgroundColor: Colors.amber,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Update Profil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
