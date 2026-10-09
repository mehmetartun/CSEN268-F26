// This is an enhanced enum

enum MyNavigatorRoute {
  home("/", "home"),
  images("images", "images"),
  map("map", "map");

  const MyNavigatorRoute(this.path, this.name);

  final String path;
  final String name;
}
