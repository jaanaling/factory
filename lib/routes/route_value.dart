enum RouteValue {
  splash(
    path: '/',
  ),
  home(
    path: '/home',
  ),
  collection(
    path: 'collection',
  ),
  select(
    path: 'select',
  ),

  game(
    path: 'game',
  ),

  achievements(
    path: 'achievements',
  ),

  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
