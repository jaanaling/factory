import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:balloon_puzzle_factory/ui_kit/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:privacy_plugin/privacy_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = PrivacyController();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: getWidth(context, baseSize: 21), top: MediaQuery.of(context).padding.top+16, bottom: 16),
          child: Row(
            children: [
              AnimatedButton(
                onPressed: () {
                  context.pop();
                },
                child: AppIcon(
                  asset: IconProvider.back.buildImageUrl(),
                  width: getWidth(
                    context,
                    baseSize: 76,
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Spacer(),
              Text('Privacy Policy'),
              Spacer()
            ],
          ),
        ),
        Expanded(
          child: PrivacyScreen(
              initialUrl: 'https://balloonpuzzlefactory.com/privacy',
              controller: _controller,
              color: '#00bfff'),
        )
      ],
    );
  }
}
