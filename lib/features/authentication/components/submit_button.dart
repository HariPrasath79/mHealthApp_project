import 'package:flutter/material.dart';

class SubmitButtonComponent extends StatelessWidget {
  final void Function()? onPressed;
  const SubmitButtonComponent({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
          padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 20)),
          backgroundColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 162, 119, 237)),
          foregroundColor: MaterialStatePropertyAll(Colors.white)),
      child: const Text('Submit'),
    );
  }
}
