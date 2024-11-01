import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.errorText,
    this.obscureText,
    this.keyboardType,
    this.trailing,
    this.onChanged,
    this.colorText,
    this.borderColor,
    this.cursorColor,
  });

  final String label;
  final String? errorText;
  final bool? obscureText;
  final Color? colorText;
  final TextInputType? keyboardType;
  final Widget? trailing;
  final Function(String)? onChanged;
  final Color? borderColor;
  final Color? cursorColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // Titulo do campo
                widget.label,
                style: TextStyle(
                  color: widget.colorText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              widget.trailing ?? Container(),
            ],
          ),
        ),
        TextField(
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ?? false,
          cursorColor: widget.cursorColor,
          style: TextStyle(
              color: widget.colorText, decorationColor: widget.colorText),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isDense: true,
            errorText: widget.errorText,
            //suffixIcon: widget.trailing,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor ?? Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
