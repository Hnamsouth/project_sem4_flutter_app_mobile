
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;
  final ValueChanged<String>? onChanged;

  const MyTextField(
      {super.key,
        required this.hintText,
        required this.obscureText,
         this.prefixIcon,
        this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: HexColor("#4f4f4f"),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: HexColor("#f0f3f1"),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        hintStyle: GoogleFonts.poppins(
          fontSize: 15,
          color: HexColor("#8d8d8d"),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: HexColor("#4f4f4f"),
        filled: true,
      ),
    );
  }
}