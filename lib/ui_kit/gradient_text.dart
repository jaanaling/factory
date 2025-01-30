import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final bool isCenter;
  final double fontSize;
  const GradientText(
    this.text, {
    this.isCenter = false,
    this.fontSize = 30,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColor = [Color(0xFFFFC700), Color(0xFFDC8400), Color(0xFF744B00)];
    final Color shaderColor = Color(0xFF744B00);
    final Color borderColor = Colors.white;
    final gradient = LinearGradient(
      colors: gradientColor,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0, 0.7,0.8]
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          textAlign: isCenter ? TextAlign.center : null,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'Atop',
            fontWeight: FontWeight.w400,
            color: Colors.transparent,
            shadows: [
              BoxShadow(
                color: shaderColor,
                spreadRadius: 15,
                offset: Offset(
                  2,
                  2,
                ),
              ),
            ],
          ),
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => gradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            text,
            textAlign: isCenter ? TextAlign.center : null,
            style: TextStyle(
              color: gradientColor.first,
              fontSize: fontSize,
              fontFamily: 'Atop',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            fontFamily: 'Atop',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = borderColor,

          ),
        ),
      ],
    );
  }
}

class TextWithBorder extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color? color;
  final double fontSize;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final String? fontFamily;
  final TextOverflow? overflow;

  const TextWithBorder({
    super.key,
    required this.text,
    required this.borderColor,
    required this.fontSize,
    this.letterSpacing,
    this.textAlign,
    this.fontFamily,
    this.color,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: textAlign,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            letterSpacing: letterSpacing,
            fontFamily: fontFamily ?? 'Alfa Slab One',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = borderColor,
          ),
        ),
        Text(
          text,
          textAlign: textAlign,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            letterSpacing: letterSpacing,
            fontFamily: fontFamily ?? 'Alfa Slab One',
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
