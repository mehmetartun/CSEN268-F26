// This is an enhanced enum

enum MyNavigatorRoute {
  home("/", "home"),
  images("images", "images"),
  map("map", "map"),
  contacts("contacts", "contacts"),
  database("database", "database");

  const MyNavigatorRoute(this.path, this.name);

  final String path;
  final String name;
}

enum StandardEnum { large, medium, small }
