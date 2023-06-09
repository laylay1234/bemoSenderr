import 'package:flutter/services.dart';

class ZipCodeInputFormatter extends TextInputFormatter {
  String? countryIso;
  ZipCodeInputFormatter({this.countryIso});
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // double value = double.parse(newValue.text);
    //1234
    switch (countryIso) {
      case 'CA':
        String newText = formatZipForCanada(newValue.text);
        return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
      default:
        return newValue.copyWith(text: newValue.text, selection: TextSelection.collapsed(offset: newValue.text.length));
    }
  }

  String formatZipForCanada(String oldValue) {
    if (oldValue.length == 6 && !oldValue.contains(' ')) {
      String firtPart = oldValue.substring(0, 3).toUpperCase();
      String secondPart = oldValue.substring(3, 6).toUpperCase();
      return (firtPart + ' ' + secondPart);
    } else if (oldValue.length == 7 && oldValue.contains(' ')) {
      return oldValue.toUpperCase();
    }
    return oldValue;
  }
}
