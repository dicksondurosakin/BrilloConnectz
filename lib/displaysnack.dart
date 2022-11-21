import 'package:flutter/material.dart';

void displaySnack(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
    ),
    action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }),
  ));
}

String removeParenthesis(error) {
  String res = error.substring(
    error.indexOf('] ') + 1,
  );
  return res;
}
