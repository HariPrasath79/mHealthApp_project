import 'package:flutter/material.dart';

class InputTextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int? maxLines;
  final int? minLines;
  final Icon? prefIcon;
  final bool expands;
  final String? labeltext;
  final IconButton? suffixIcon;
  final String? errorText;
  final bool obscuredText;
  final TextInputType? inputType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;

  const InputTextFieldComponent({
    super.key,
    required this.controller,
    required this.hint,
    this.prefIcon,
    this.errorText,
    this.labeltext,
    this.onChanged,
    this.expands = false,
    this.inputType,
    this.validator,
    this.suffixIcon,
    this.obscuredText = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      keyboardType: inputType,
      validator: validator,
      obscureText: obscuredText,
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      textInputAction: TextInputAction.previous,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        labelText: labeltext,
        prefixIcon: prefIcon,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Colors.deepPurple)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Colors.grey)),
        hintText: hint,
        errorText: errorText,
        suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8), child: suffixIcon),
      ),
      onChanged: onChanged,
    );
  }
}
