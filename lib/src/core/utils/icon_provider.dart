enum IconProvider {
  splash(imageName: 'splash.png'),
  logo(imageName: 'logo.png'),
  button(imageName: 'button.png'),
  buttonA(imageName: 'button_a.png'),
  background(imageName: 'background.png'),
  box(imageName: 'box.png'),
  papper(imageName: 'papper.png'),

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
