import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  // T? binevi generic demek her şeyi alabililir diyoruz
  // böylece bir şeye bağlı olmuyor yaptığımız şey
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: options.keys.map((optionTitle) {
            final value =
                options[optionTitle]; // value yukarıdaki mapdeki Stringin value'ları ve bunu geriye döndürebiliyoruz
            return TextButton(
                onPressed: () {
                  // geriye dönüdürüp true veya false, ya da hiç bir şey sadece geri at diyebiliyoruz
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(optionTitle));
          }).toList(),
        );
      });
}
