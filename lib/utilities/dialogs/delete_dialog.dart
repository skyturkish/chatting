import 'package:flutter/cupertino.dart';
import 'package:groupnotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Delete',
      content: 'Are you sure you want to delete this item?',
      optionsBuilder: () => {
            'Cancel': false,
            'Yes': true,
          }).then((value) => value ?? false); // true yada false dönmemişse yani null ise false döndür
  // bunu android gibi cihazlarda yan ekrana tıkladığın
} // zaman errordialogu kapatabilme seçeneği olduğu için yapıyoruz
