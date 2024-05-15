import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickly/quickly.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;
  final ValueChanged<String>? onChanged;
  void Function()? onTap;
   MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
        this.onTap,
      this.prefixIcon,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: TextField(
        onTap: onTap,
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
      ),
    );
  }
}
