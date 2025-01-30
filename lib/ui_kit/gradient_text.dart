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
    required this.gradientColor,
    required this.shaderColor,
    required this.borderColor,
  });

  final String text;
  final List<Color> gradientColor;
  final Color shaderColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: gradientColor,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            fontFamily: 'Atop',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = borderColor,
          ),
        ),
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
                blurRadius: 6.5,
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
              letterSpacing: 1.50,
            ),
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
            fontFamily: fontFamily ?? 'Atop',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
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
            fontFamily: fontFamily ?? 'Atop',
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
