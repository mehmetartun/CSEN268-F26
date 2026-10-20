import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Provide Google Maps API key before registering plugins
    GMSServices.provideAPIKey("AIzaSyC_A1p3t0viwh9-hziCby1Fs1lj7UXuhmA")
    
    // Register Flutter plugins (only called ONCE here)
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}