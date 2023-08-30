import 'package:flutter/material.dart';
import 'package:quran/to_arabic_no_converter.dart';

class ArabicSuraNumbers extends StatelessWidget {
  const ArabicSuraNumbers({Key? key, required this.i, this.color, this.size})
      : super(key: key);

  final int i;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(
      '\uFD3E' + (i + 1).toString().toArabicNumbers + '\uFD3F',
      style: TextStyle(
          color: color ?? Color.fromARGB(255, 0, 0, 0),
          fontFamily: 'me_quran',
          fontSize: size ?? 18,
          shadows: [
            Shadow(
              offset: Offset(.5, .5),
              blurRadius: 1.0,
              color: color ?? Colors.amberAccent,
            ),
          ]),
    );
  }
}
