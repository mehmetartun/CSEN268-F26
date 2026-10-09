# Lecture 9 - 01

## Enhanced Enum

We explore the concept of enhanced `enum` in the router names defined by:

```dart
enum MyNavigatorRoute {
  home("/", "home"),
  images("images", "images"),
  map("map", "map");

  const MyNavigatorRoute(this.path, this.name);

  final String path;
  final String name;
}
```
such that `MyNavigatorRoute.home.path` resolves to `'/'` and `MyNavigatorRoute.home.name` resolves to `'home'`.


## Images

In this lecture we implement image picker and saving images onto the device. The key here is that web and mobile work differently in displaying images. Therefore we employ conditional imports

## Conditional Imports

For saving images and displaying images, we implemented two classes `SaveImage` and `DisplayImage`
which needs a separate implementation for Web and Android/iOS. Primarily this is due to the fact
that **Flutter Web** uses the `dart:html` library and for all other platforms `dart:io` library is used.

Packages like `image_picker` uses the cross-platform file package `cross_file` with the object `XFile` returned
as the file object. This has to be handled differently in Web vs Android/iOS (and also MacOS, Windows, etc).

Therefore the typical conditional import structure is as follows:

    save_image.dart
    save_image_other.dart
    save_image_web.dart
    save_image_io.dart

the purpose of `save_image.dart` will be to simply expose one of the specific implementations depending on the platform
where the program is running.

```dart
export 'save_image_other.dart'
    if (dart.library.io) 'save_image_io.dart'
    if (dart.library.html) 'save_image_web.dart'
```

This way the platform specific imports such as `dart:html` or `dart:io` can be hidden in the  files
`save_image_web.dart` and `save_image_io.dart` respectively.

The same goes for displaying images. A file on the local device in **Flutter Web** can be displayed using `Image.network` whereas 
a file  in the local device in all others can be displayed with `Image.file`. A similar conditional import structure is shown here in the definition of the class `DisplayImage`.
