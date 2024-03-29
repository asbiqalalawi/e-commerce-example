import 'package:e_commerce_example/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  const Input({
    super.key,
    this.labelText,
    this.isPassword = false,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.autoFocus = false,
    this.textInputAction,
    this.fontSize,
    this.onSaved,
    this.validator,
    this.onEditingComplete,
    this.suffixIcon,
    this.hintText,
  });

  final String? labelText;
  final bool isPassword;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final void Function(String)? onChanged;
  final bool autoFocus;
  final TextInputAction? textInputAction;
  final double? fontSize;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final Widget? suffixIcon;
  final String? hintText;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: hide && widget.isPassword ? true : false,
      decoration: InputDecoration(
        label: Text(widget.labelText ?? ''),
        labelStyle: const TextStyle(
          color: ColorStyle.subtitleColor,
        ),
        floatingLabelStyle: const TextStyle(
          color: ColorStyle.mainColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorStyle.mainColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorStyle.mainColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorStyle.mainColor),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() {
                  hide = !hide;
                }),
                icon: const Icon(
                  Icons.remove_red_eye_sharp,
                  color: ColorStyle.subtitleColor,
                ),
              )
            : widget.suffixIcon,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: ColorStyle.subtitleColor,
        ),
      ),
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      onEditingComplete: widget.onEditingComplete,
      autofocus: widget.autoFocus,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
    );
  }
}
