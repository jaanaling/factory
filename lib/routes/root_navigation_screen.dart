
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';


import '../src/core/utils/icon_provider.dart';

class RootNavigationScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const RootNavigationScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  State<RootNavigationScreen> createState() => _RootNavigationScreenState();
}

class _RootNavigationScreenState extends State<RootNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final route = widget.navigationShell.shellRouteContext.routerState.matchedLocation;

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                  getBackground(route),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          widget.navigationShell,
         
        ],
      ),
    );
  }

  String getBackground(String path){
    switch (path){
      case '/home':
        return IconProvider.backgroundA.buildImageUrl();
      case '/home/select':
        return IconProvider.backgroundC.buildImageUrl();
      case '/achievements':
        return IconProvider.backgroundC.buildImageUrl();
      default:
        return IconProvider.backgroundB.buildImageUrl();
    }
  }
}
