import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.red.shade900,
          borderRadius: BorderRadius.circular(30),

        ),
        child: Center(child: Text(text,
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),)),
      ),
    );
  }
}
