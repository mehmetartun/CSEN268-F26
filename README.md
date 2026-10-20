# Lecture 9 - 02

## iOS permissions for camera and gallery usage

To use the functionality of image picker for `iOS` we need to add the camera, image gallery and audio recording permissions in the [Info.plist](/ios/Runner/Info.plist)
```xml
<dict>
  ...
	<key>NSCameraUsageDescription</key>
	<string>Used to demonstrate image picker plugin</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>Used to capture audio for image picker plugin</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>Used to demonstrate image picker plugin</string>
  ...
</dict>
```
## iOS Minimum version

The Google Maps Flutter package requires iOS version `14` or higher. Therefore in the `Podfile` we make the following change
```
# Uncomment this line to define a global platform for your project
platform :ios, '14.0'
```


