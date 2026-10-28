// This is an enhanced enum

enum MyNavigatorRoute {
  home("/", "home"),
  images("images", "images"),
  map("map", "map"),
  contacts("contacts", "contacts"),
  signIn("signIn", "signIn"),
  dialogs("dialogs", "dialogs"),
  database("database", "database"),
  messaging("messaging", "messaging");

  const MyNavigatorRoute(this.path, this.name);

  final String path;
  final String name;
}

enum StandardEnum { large, medium, small }
