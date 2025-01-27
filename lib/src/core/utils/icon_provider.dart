enum IconProvider {
  splash(imageName: 'splash.png'),
  logo(imageName: 'logo.png'),
  back(imageName: 'back.svg'),
  achievements(imageName: 'achievements.svg'),
  coin(imageName: 'coin.png'),
  background(imageName: 'background.png'),
  backgroundHome(imageName: 'background_home.png'),
  tips(imageName: 'tips.png'),
  mainBall(imageName: 'main_ball.png'),
  dailyChallenge(imageName: 'daily_challenge.png'),
  start(imageName: 'start.png'),
  articles(imageName: 'articles.png'),
  iconBack(imageName: 'icon_back.png'),
  homeButtonBack(imageName: 'home_button_back.png'),
  titleBack(imageName: 'title_back.png'),
  articlesButton(imageName: 'articles_button.png'),
  alertDialogBack(imageName: 'alert_dialog_back.png'),
  close(imageName: 'close.svg'),
  hexagons(imageName: 'hexagons.png'),
  ball(imageName: 'ball.png'),
  balloon0(imageName: 'balloon0.png'),
  balloon1(imageName: 'balloon1.png'),
  balloon2(imageName: 'balloon2.png'),
  balloon3(imageName: 'balloon3.png'),
  balloon4(imageName: 'balloon4.png'),
  gift(imageName: 'gift.png'),
  detecter(imageName: 'detecter.png'),
  unknown(imageName: '');

  const IconProvider({
    required this.imageName,
  });

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
