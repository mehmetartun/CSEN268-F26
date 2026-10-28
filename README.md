# Lecture 14 - Flutter Web, WebView 

## Navigation Delegate
With `NavigationDelegate` one can prevent certain websites being visited.
```dart
  @override
  void initState() {
    controller = TextEditingController(text: "google.com");
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (request) {
        if (request.url.contains("youtube")) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("This destination is not allowed")));
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }));
    super.initState();
  }
```
You can modify this also to ensure that customer stays in your domain.

The resulting effect is shown here:

<img src="assets/gifs/NavigationDelegate.gif" alt="Navigation Delegate" width="300">