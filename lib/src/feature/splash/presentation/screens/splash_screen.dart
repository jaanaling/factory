import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';


import '../../../../../routes/route_value.dart';
import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/icon_provider.dart';
import '../../../../core/utils/size_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startLoading(context);
  }

  Future<void> startLoading(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    context.go(RouteValue.home.path);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: AppIcon(
            asset: IconProvider.splash.buildImageUrl(),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: getHeight(context, baseSize: 204),
          child: AppIcon(
            asset: IconProvider.logo.buildImageUrl(),
            width: 304,
            fit: BoxFit.fitWidth,
          ),
        ),
        const Positioned(
          bottom: 51,
          child: CircularProgressIndicator(
            color: Color(0xFFFF00FB),
          ),
        )
      ],
    );
  }
}
