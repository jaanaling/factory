enum IconProvider {
  splash(imageName: 'splash.webp'),
  logo(imageName: 'logo.webp'),
  logoHome(imageName: 'logo_home.webp'),
  button(imageName: 'button.png'),
  buttonA(imageName: 'button_a.png'),
  coins(imageName: 'coins.png'),
  backgroundA(imageName: 'background_1.webp'),
  backgroundB(imageName: 'background_2.webp'),
  backgroundC(imageName: 'background_3.webp'),
  gift(imageName: 'gift.webp'),
  giftGrey(imageName: 'gift_grey.webp'),
  buttonGrey(imageName: 'button_grey.webp'),
  chain(imageName: 'chain.webp'),
  alertDialog(imageName: 'alert_dialog.webp'),
  close(imageName: 'close.webp'),
  box(imageName: 'box.png'),
  papper(imageName: 'papper.png'),
  timer(imageName: 'timer.png'),
  back(imageName: "back.png"),
  eiffelTower(imageName: 'eiffelTower.svg'),
  bigBen(imageName: 'bigBen.svg'),
  statueOfLiberty(imageName: 'statueOfLiberty.svg'),
  colosseum(imageName: 'colosseum.svg'),
  leaningTowerOfPisa(imageName: 'leaningTowerOfPisa.svg'),
  kremlin(imageName: 'kremlin.svg'),
  tajMahal(imageName: 'tajMahal.png'),
  sydneyOperaHouse(imageName: 'sydneyOperaHouse.png'),
  greatPyramidOfGiza(imageName: 'greatPyramidOfGiza.png'),
  machuPicchu(imageName: 'machuPicchu.png'),
  roll(imageName: "roll.png"),
  notice(imageName: "notice.png"),
  b1(imageName: 'b1.png'),
  b2(imageName: 'b2.png'),
  b3(imageName: 'b3.png'),
  b4(imageName: 'b4.png'),
  b5(imageName: 'b5.png'),
  b6(imageName: 'b6.png'),
  b7(imageName: 'b7.png'),

  unknown(imageName: '');

  const IconProvider({
    required this.imageName,
  });

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
