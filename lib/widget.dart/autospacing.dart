import 'package:flutter/services.dart';

class AutoSpacingPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // If the text starts without a '+', add it
    if (!text.startsWith('+')) {
      text = '+$text';
    }

    // Remove all non-digit characters except '+'
    text = text.replaceAll(RegExp(r'[^\d+]'), '');

    // Format the text to match +92 331 431 7076
    if (text.length > 3) {
      text = '${text.substring(0, 3)} ${text.substring(3)}';  // +92 XXX
    }
    if (text.length > 7) {
      text = '${text.substring(0, 7)} ${text.substring(7)}';  // +92 XXX XXX
    }
    if (text.length > 11) {
      text = '${text.substring(0, 11)} ${text.substring(11)}';  // +92 XXX XXX XXXX
    }

    // Limit to +92 XXX XXX XXXX (16 characters including spaces)
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
