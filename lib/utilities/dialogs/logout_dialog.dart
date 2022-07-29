import 'package:flutter/cupertino.dart';
import 'package:groupnotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Log out',
      content: 'Are you sure you want to log out?',
      optionsBuilder: () => {
            'Cancel': false,
            'Log out': true,
          }).then((value) => value ?? false); // true yada false dönmemişse yani null ise false döndür
  // bunu android gibi cihazlarda yan ekrana tıkladığın
} // zaman errordialogu kapatabilme seçeneği olduğu için yapıyoruz
