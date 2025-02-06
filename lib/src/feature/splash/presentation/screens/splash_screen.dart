import 'package:advertising_id/advertising_id.dart';
import 'package:core_logic/core_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../routes/route_value.dart';
import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/icon_provider.dart';
import '../../../../core/utils/size_utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitializationCubit()..initialize(context),
      child: BlocListener<InitializationCubit, InitializationState>(
        listener: (context, state) {
          if (state is InitializedState) {
            context.go(state.startRoute);
          }
        },
        child: Stack(
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
              top: getHeight(context, baseSize: 138),
              child: AppIcon(
                asset: IconProvider.logo.buildImageUrl(),
                width: getWidth(context, percent: 1),
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              bottom: getHeight(context, baseSize: 51),
              child: LoadingAnimationWidget.hexagonDots(
                  color: Color(0xFFFF5711), size: 120),
            )
          ],
        ),
      ),
    );
  }
}
