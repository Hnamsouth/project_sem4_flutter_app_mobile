import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final double btnWidth;
  final double btnHeight;

  const MyButton(
      {super.key, required this.onPressed, required this.buttonText,
        required this.btnHeight,required this.btnWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          height: btnHeight,
          width: btnWidth,
          decoration: BoxDecoration(
            border:Border.all(color: Colors.green,width:1.0,style: BorderStyle.solid),
            color: Color(0xFFBFECD9),
            // color: HexColor('#44564a'),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
