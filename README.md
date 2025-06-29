# Next.js + Express.js + MongoDB + Flutter Image Upload App

A full-stack image upload application with Next.js frontend, Express.js API backend, MongoDB database, and Flutter mobile app.

## Features

- **Image Upload**: Upload images with descriptions
- **Image Gallery**: View all uploaded images with details
- **Image Deletion**: Delete images with confirmation
- **Responsive Design**: Works on web and mobile
- **Real-time Updates**: Immediate UI updates after operations
- **File Validation**: Size and type validation for uploads

## Project Structure

```
next-flutter/
├── api/                    # Express.js API server
│   └── server.js          # Main API server
├── app/                   # Next.js frontend
│   ├── components/        # React components
│   ├── globals.css        # Global styles
│   ├── layout.tsx         # Root layout
│   └── page.tsx           # Main page
├── flutter_app/           # Flutter mobile app
│   ├── lib/
│   │   ├── models/        # Data models
│   │   ├── screens/       # App screens
│   │   ├── services/      # API services
│   │   ├── widgets/       # UI widgets
│   │   └── main.dart      # App entry point
│   └── pubspec.yaml       # Flutter dependencies
├── uploads/               # Uploaded images storage
├── package.json           # Node.js dependencies
├── next.config.js         # Next.js configuration
├── tailwind.config.ts     # Tailwind CSS configuration
└── env.example            # Environment variables template
```

## Prerequisites

- Node.js (v16 or higher)
- MongoDB (local or cloud)
- Flutter SDK (v3.0 or higher)
- Android Studio / Xcode (for mobile development)

## Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd next-flutter
```

### 2. Install Dependencies

```bash
# Install Node.js dependencies
npm install

# Install Flutter dependencies
cd flutter_app
flutter pub get
cd ..
```

### 3. Environment Configuration

Copy the environment template and configure your settings:

```bash
cp env.example .env.local
```

Edit `.env.local` with your configuration:

```env
# MongoDB Configuration
MONGODB_URI=mongodb://localhost:27017/image-app

# API Configuration
API_PORT=5000
NEXT_PUBLIC_API_URL=http://localhost:5000/api
```

### 4. Start MongoDB

Make sure MongoDB is running on your system:

```bash
# Start MongoDB (if installed locally)
mongod

# Or use MongoDB Atlas (cloud)
# Update MONGODB_URI in .env.local
```

### 5. Start the API Server

```bash
# Start the Express.js API server
npm run dev:api
```

The API server will run on `http://localhost:5000`

### 6. Start the Next.js Frontend

```bash
# In a new terminal, start the Next.js app
npm run dev
```

The web app will run on `http://localhost:3000`

### 7. Run the Flutter App

```bash
# Navigate to Flutter app directory
cd flutter_app

# Run on Android emulator
flutter run

# Run on iOS simulator (macOS only)
flutter run -d ios
```

## API Endpoints

- `GET /api/images` - Get all images
- `POST /api/upload` - Upload a new image
- `DELETE /api/images/:id` - Delete an image
- `GET /api/images/:id` - Get a specific image
- `GET /api/health` - Health check

## Usage

### Web App (Next.js)
1. Open `http://localhost:3000` in your browser
2. Use the upload form to select and upload images
3. View uploaded images in the gallery
4. Click delete button to remove images

### Mobile App (Flutter)
1. Launch the Flutter app on your device/emulator
2. Tap "Select Image" to choose from gallery
3. Add optional description
4. View images in the list
5. Tap delete icon to remove images

## Development

### Adding New Features

1. **Backend**: Add new routes in `api/server.js`
2. **Frontend**: Create new components in `app/components/`
3. **Mobile**: Add new screens in `flutter_app/lib/screens/`

### Database Schema

The image schema includes:
- `filename`: Generated filename
- `originalName`: Original file name
- `path`: File path on server
- `size`: File size in bytes
- `uploadDate`: Upload timestamp
- `description`: Optional description

## Troubleshooting

### Common Issues

1. **MongoDB Connection Error**
   - Ensure MongoDB is running
   - Check connection string in `.env.local`

2. **Port Already in Use**
   - Change port in `.env.local`
   - Kill existing processes on the port

3. **Flutter Network Error**
   - Update API URL in `flutter_app/lib/services/api_service.dart`
   - Use `10.0.2.2` for Android emulator
   - Use `localhost` for iOS simulator

4. **Image Upload Fails**
   - Check file size (max 10MB)
   - Ensure file is an image (jpg, png, gif, webp)
   - Verify uploads directory exists

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

MIT License - see LICENSE file for details # next-flutter
