import 'package:flutter/material.dart';

TextFormField formReguler({TextEditingController? controller, String? labelText}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    decoration: InputDecoration(labelText: labelText),
    keyboardType: TextInputType.text,
    validator: (value) {
      if (value == null || value.isEmpty) return 'Kolom wajib diisi';
      return null;
    },
  );
}

TextFormField formPhone({TextEditingController? controller, String? labelText}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    decoration: InputDecoration(labelText: labelText, hintText: '0812xxxx'),
    keyboardType: TextInputType.phone,
    validator: (value) {
      if (value == null || value.isEmpty) return 'Kolom wajib diisi';

      // if (!RegExp(r'^[0-9]*$').hasMatch(value)) return 'Hanya angka';
      if (!RegExp(r'^\d+$').hasMatch(value)) return 'Hanya angka';

      if (value.length < 10 || value.length > 13) return 'Masukan nomor whatsapp dengan benar';

      return null;
    },
  );
}

TextFormField formEmail({TextEditingController? controller, String? labelText}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    decoration: InputDecoration(labelText: labelText),
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      if (value == null || value.isEmpty) return 'Kolom wajib diisi';

      // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Masukan email dengan benar';
      if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(value)) return 'Masukan email dengan benar';

      return null;
    },
  );
}

TextFormField formPasswd({String? labelText, TextEditingController? controller, bool obscureText = true, required VoidCallback onPressed}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      suffixIcon: IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility), onPressed: onPressed),
    ),
    textCapitalization: TextCapitalization.sentences,
    obscureText: obscureText,
    keyboardType: TextInputType.visiblePassword,
    validator: (value) {
      // if (GetUtils.isNullOrBlank(value) == true) return 'Kolom wajib diisi';
      if (value == null || value.isEmpty) return 'Kolom wajib diisi';

      // if (GetUtils.isLengthLessThan(value, 8)) return 'Password minimal 8 karakter';
      if (value.length < 8) return 'Password minimal 8 karakter';

      return null;
    },
  );
}
