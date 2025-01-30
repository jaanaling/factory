import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/ui_kit/animated_button.dart';
import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';

final player = AudioPlayer();
ValueNotifier<bool> isPlaying = ValueNotifier(true);

class SoundButton extends StatefulWidget {
  const SoundButton({super.key});

  @override
  State<SoundButton> createState() => _SoundButtonState();
}

class _SoundButtonState extends State<SoundButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isPlaying,
      builder: (context, value, child) {
        return AnimatedButton(
          onPressed: () {
            setState(() {
              if (value) {
                stopMusic();
                isPlaying.value = false;
              } else {
                playMusic();
                isPlaying.value = true;
              }
            });
          },
          child: Icon(
            value ? Icons.volume_up : Icons.volume_off,
            size: 24,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

void playMusic() async {
  await player.setAsset('assets/images/music.mp3');
  await player.setLoopMode(LoopMode.one);
  await player.play();
}

void stopMusic() async {
  await player.stop();
}
