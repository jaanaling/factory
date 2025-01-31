import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcon extends StatelessWidget {
  final String asset;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppIcon({
    super.key,
    required this.asset,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return asset.contains('.svg')
        ? Opacity(
            opacity: 0.97,
            child: SvgPicture.asset(
              asset,
              width: width,
              height: height,
              fit: fit,
              allowDrawingOutsideViewBox: true,
              colorFilter: color != null ? colorFilterFromColor(color!) : null,
            ),
          )
        : asset.contains('assets')
            ? color != null
                ? ColorFiltered(
                    colorFilter: colorFilterFromColor(color!),
                    child: Image.asset(
                      asset,
                      width: width,
                      height: height,
                      fit: fit,
                    ),
                  )
                : Image.asset(
                    asset,
                    width: width,
                    height: height,
                    fit: fit,
                  )
            : Image.file(
                File(asset),
                width: width,
                height: height,
                fit: fit,
              );
  }
}

ColorFilter colorFilterFromColor(Color color) {
  return ColorFilter.matrix([
    color.red / 255,
    0,
    0,
    0,
    0,
    0,
    color.green / 255,
    0,
    0,
    0,
    0,
    0,
    color.blue / 255,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
}
