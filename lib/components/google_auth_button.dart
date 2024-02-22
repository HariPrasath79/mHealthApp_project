import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleAuthButton extends StatelessWidget {
  final void Function()? onPressed;
  final String hint;

  const GoogleAuthButton({super.key, this.onPressed, required this.hint});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)))),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 20)),
            backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
            foregroundColor: const MaterialStatePropertyAll(Colors.black)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 27,
                child: Image.asset('assets/images/logo_google_g.png')),
            const SizedBox(width: 8),
            Text(
              hint,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            )
          ],
        ));
  }
}
