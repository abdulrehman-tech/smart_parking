import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget{
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  get kPrimaryColor => null;

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextButton( 
        style: TextButton.styleFrom(
          primary : kPrimaryColor,
          padding: EdgeInsets.all(20),
          shape : RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFF7C99AC),
        ),

        onPressed: press,
        child: Row(children: [
          SvgPicture.asset(
          icon,
          color: Colors.white,
          width: 22,
        ),
        SizedBox(width: 20),
        Expanded(child: Text((text),
        style: TextStyle(color: Colors.white) )),
        Icon((Icons.arrow_forward), color: Colors.white)
        ],),
      ));
  }
}