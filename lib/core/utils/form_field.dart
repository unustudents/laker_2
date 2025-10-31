import 'package:flutter/material.dart';

/// Utility class untuk reusable form fields
/// Migrated from GetX to native Dart/Flutter implementation
class Formulir {
  // Private regex patterns
  static const String _emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String _numericPattern = r'^\d+$';

  /// Helper method - Check if string is null or empty
  static bool _isNullOrBlank(String? value) {
    return value == null || value.isEmpty;
  }

  /// Helper method - Check if email is valid
  static bool _isValidEmail(String email) {
    return RegExp(_emailPattern).hasMatch(email);
  }

  /// Helper method - Check if string contains only numbers
  static bool _isNumericOnly(String value) {
    return RegExp(_numericPattern).hasMatch(value);
  }

  /// Helper method - Check if string length is between min and max
  static bool _isLengthBetween(String value, int min, int max) {
    return value.length >= min && value.length <= max;
  }

  /// Helper method - Check if string length is less than target
  static bool _isLengthLessThan(String value, int target) {
    return value.length < target;
  }

  /// Form field untuk email input
  static TextFormField formEmail({
    String? labelText,
    TextEditingController? controller,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (_isNullOrBlank(value)) return 'Kolom wajib diisi';

        if (!_isValidEmail(value!)) return 'Masukan email dengan benar';

        return null;
      },
    );
  }

  /// Form field untuk password input dengan visibility toggle
  static TextFormField formPasswd({
    String? labelText,
    TextEditingController? controller,
    bool obscureText = true,
    required VoidCallback onPressed,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: onPressed,
        ),
      ),
      textCapitalization: TextCapitalization.sentences,
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (_isNullOrBlank(value)) return 'Kolom wajib diisi';

        if (_isLengthLessThan(value!, 8)) return 'Password minimal 8 karakter';

        return null;
      },
    );
  }

  /// Form field untuk phone number input (WhatsApp format)
  static TextFormField formPhone({
    String? labelText,
    TextEditingController? controller,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(labelText: labelText, hintText: '0812xxxx'),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (_isNullOrBlank(value)) return 'Kolom wajib diisi';

        if (!_isNumericOnly(value!)) return 'Hanya angka';

        if (!_isLengthBetween(value, 10, 13))
          return 'Masukan nomor whatsapp dengan benar';

        return null;
      },
    );
  }

  /// Form field untuk regular text input (name, address, etc)
  static TextFormField formReguler({
    String? labelText,
    TextEditingController? controller,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      minLines: 1,
      maxLines: 5,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (_isNullOrBlank(value)) return 'Kolom wajib diisi';

        return null;
      },
    );
  }

  /// Form field untuk ID input (limited to 11 characters)
  static TextFormField formID({
    String? labelText,
    TextEditingController? controller,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      textCapitalization: TextCapitalization.sentences,
      maxLength: 11,
      validator: (value) {
        if (_isNullOrBlank(value)) return 'Kolom wajib diisi';

        return null;
      },
    );
  }
}
