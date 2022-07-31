import 'package:flutter/material.dart';

typedef CloseDialog = void Function();

// void function dönen bir fonksiyon
CloseDialog showLoadingDialog({
  required BuildContext context,
  required String text,
}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          height: 10.0,
        ),
        Text(text),
      ],
    ),
  );

  showDialog(
      barrierDismissible: false, // tıklamasını gerekli kılıyoruz _?? galiba
      context: context,
      builder: (context) => dialog);

  return () => Navigator.of(context).pop();
}
