import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/form_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final name = TextEditingController();
    final tempatLahir = TextEditingController();
    final divisi = TextEditingController();
    final whatsapp = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();
    final toglePaswd = ValueNotifier<bool>(true);

    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(15),
            shrinkWrap: true,
            children: [
              Text("Sign Up", style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
              const SizedBox(height: 15),
              formReguler(controller: name, labelText: "Nama"),
              const SizedBox(height: 15),
              formReguler(controller: tempatLahir, labelText: "Tempat Lahir"),
              const SizedBox(height: 15),
              formReguler(controller: divisi, labelText: "Divisi"),
              const SizedBox(height: 15),
              formPhone(controller: whatsapp, labelText: "Whatsapp"),
              const SizedBox(height: 15),
              formEmail(controller: email, labelText: "Email"),
              const SizedBox(height: 15),
              ValueListenableBuilder<bool>(
                valueListenable: toglePaswd,
                builder: (context, value, child) {
                  return formPasswd(labelText: "Password", controller: password, obscureText: value, onPressed: () => toglePaswd.value = !value);
                },
              ),
              const SizedBox(height: 15),
              BlocConsumer<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpSuccess) {
                    // Handle success
                  } else if (state is SignUpFailure) {
                    // Handle failure
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is SignUpLoading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              context.read<SignUpBloc>().add(SignUpSubmitted(
                                    name: name.text,
                                    email: email.text,
                                    password: password.text,
                                    tempatLahir: tempatLahir.text,
                                    whatsapp: whatsapp.text,
                                    divisi: divisi.text,
                                  ));
                            }
                          },
                    child: state is SignUpLoading
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
                    onTap: () => Navigator.pushNamed(context, Routes.SIGN_IN),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          decorationColor: Colors.black54,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
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
