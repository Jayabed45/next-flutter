import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/image_model.dart';
import '../services/api_service.dart';
import '../widgets/image_gallery_widget.dart';
import '../widgets/upload_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ImageModel> images = [];
  bool isLoading = true;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      setState(() {
        isLoading = true;
      });
      
      final loadedImages = await ApiService.getImages();
      setState(() {
        images = loadedImages;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar('Failed to load images: $e');
    }
  }

  Future<void> _uploadImage() async {
    try {
      print('Starting image upload process...');
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image == null) {
        print('No image selected');
        return;
      }

      print('Image selected: ${image.path}');
      print('Image name: ${image.name}');

      setState(() {
        isUploading = true;
      });

      final description = await _showDescriptionDialog();
      if (description == null) {
        print('Upload cancelled by user');
        setState(() {
          isUploading = false;
        });
        return;
      }

      print('Description entered: $description');
      print('Creating File object...');
      
      final file = File(image.path);
      print('File exists: ${await file.exists()}');
      print('File size: ${await file.length()} bytes');

      print('Calling ApiService.uploadImage...');
      final uploadedImage = await ApiService.uploadImage(
        file,
        description,
      );

      print('Upload successful! Image ID: ${uploadedImage.id}');

      setState(() {
        images.insert(0, uploadedImage);
        isUploading = false;
      });

      _showSuccessSnackBar('Image uploaded successfully!');
    } catch (e) {
      print('Upload error in HomeScreen: $e');
      setState(() {
        isUploading = false;
      });
      _showErrorSnackBar('Failed to upload image: $e');
    }
  }

  Future<String?> _showDescriptionDialog() async {
    String description = '';
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Description'),
          content: TextField(
            decoration: const InputDecoration(
              hintText: 'Enter image description (optional)',
            ),
            onChanged: (value) {
              description = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(description),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteImage(String imageId) async {
    try {
      await ApiService.deleteImage(imageId);
      setState(() {
        images.removeWhere((image) => image.id == imageId);
      });
      _showSuccessSnackBar('Image deleted successfully!');
    } catch (e) {
      _showErrorSnackBar('Failed to delete image: $e');
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadImages,
          ),
        ],
      ),
      body: Column(
        children: [
          // Upload Section
          UploadWidget(
            onUpload: _uploadImage,
            isUploading: isUploading,
          ),
          
          const Divider(),
          
          // Gallery Section
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ImageGalleryWidget(
                    images: images,
                    onDelete: _deleteImage,
                  ),
          ),
        ],
      ),
    );
  }
} 