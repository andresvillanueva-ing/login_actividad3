import 'package:flutter/material.dart';
import 'package:login_actividad3/components/colors.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback press;
  const Button({super.key, required this.label, required this.press});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: size.width *.9,
      height: 55,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),

      child: TextButton(
        onPressed: press,
        child:Text( label,
        style: TextStyle( color: Colors.white ),
        )
      ),
    );
  }
}