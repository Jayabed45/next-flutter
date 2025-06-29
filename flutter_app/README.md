# Flutter Image Upload App

A Flutter mobile application for uploading, viewing, and deleting images. This app connects to the Express.js API backend and provides a native mobile experience.

## Features

- 📱 **Native Mobile UI**: Beautiful Material Design interface
- 📸 **Image Upload**: Select images from gallery with compression
- 🖼️ **Image Gallery**: View all uploaded images with details
- 🗑️ **Image Deletion**: Delete images with confirmation dialog
- 🔄 **Real-time Updates**: Immediate UI updates after operations
- 📊 **Image Details**: File size, upload date, and descriptions
- 🌐 **Network Handling**: Proper error handling and loading states

## Prerequisites

- Flutter SDK (v3.0 or higher)
- Android Studio / Xcode
- Android Emulator or iOS Simulator
- Running API server (Express.js backend)

## Setup Instructions

### 1. Install Flutter Dependencies

```bash
cd flutter_app
flutter pub get
```

### 2. Configure API URL

Edit `lib/services/api_service.dart` and update the `baseUrl`:

```dart
// For Android Emulator
static const String baseUrl = 'http://10.0.2.2:5000/api';

// For iOS Simulator
// static const String baseUrl = 'http://localhost:5000/api';

// For Physical Device (replace with your computer's IP)
// static const String baseUrl = 'http://192.168.1.100:5000/api';
```

### 3. Run the App

```bash
# Check available devices
flutter devices

# Run on Android emulator
flutter run

# Run on iOS simulator (macOS only)
flutter run -d ios

# Run on specific device
flutter run -d <device-id>
```

## App Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── image_model.dart      # Image data model
├── screens/
│   └── home_screen.dart      # Main app screen
├── services/
│   └── api_service.dart      # API communication
└── widgets/
    ├── upload_widget.dart    # Upload UI component
    └── image_gallery_widget.dart # Gallery UI component
```

## Key Components

### ImageModel
Data model for image objects with JSON serialization.

### ApiService
Handles all API communication:
- `getImages()` - Fetch all images
- `uploadImage()` - Upload new image
- `deleteImage()` - Delete image

### HomeScreen
Main app screen that manages:
- Image list state
- Upload functionality
- Delete operations
- Loading states

### UploadWidget
UI component for image upload with:
- Upload button
- Loading indicator
- Progress feedback

### ImageGalleryWidget
Displays image gallery with:
- Image thumbnails
- File details
- Delete functionality
- Empty state

## Permissions

The app requires the following permissions:

### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to photo library to select images for upload.</string>
```

## Dependencies

- `http`: API communication
- `image_picker`: Image selection from gallery
- `cached_network_image`: Efficient image loading and caching
- `permission_handler`: Handle permissions (if needed)
- `flutter_staggered_grid_view`: Grid layout (if needed)

## Troubleshooting

### Common Issues

1. **Network Error**
   - Ensure API server is running
   - Check API URL configuration
   - Verify network connectivity

2. **Image Not Loading**
   - Check image URL format
   - Verify server is serving static files
   - Check CORS configuration

3. **Upload Fails**
   - Check file size limits
   - Verify image format
   - Check server logs

4. **Permission Denied**
   - Grant photo library access
   - Check app permissions in device settings

### Debug Mode

Run with verbose logging:
```bash
flutter run --verbose
```

### Hot Reload

During development, use hot reload for quick iterations:
```bash
# Press 'r' in terminal for hot reload
# Press 'R' for hot restart
```

## Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Contributing

1. Follow Flutter coding conventions
2. Add proper error handling
3. Test on both Android and iOS
4. Update documentation as needed

## License

MIT License - see main README for details 