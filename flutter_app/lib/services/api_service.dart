import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/image_model.dart';

class ApiService {
  // For Physical Device (using your computer's IP)
  static const String baseUrl = 'http://192.168.1.80:5000/api';
  
  // For Android Emulator (uncomment if using Android emulator)
  // static const String baseUrl = 'http://10.0.2.2:5000/api';
  
  // For iOS Simulator (uncomment if using iOS simulator)
  // static const String baseUrl = 'http://localhost:5000/api';

  // Get all images
  static Future<List<ImageModel>> getImages() async {
    try {
      print('Fetching images from: $baseUrl/images');
      final response = await http.get(Uri.parse('$baseUrl/images'));
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => ImageModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load images: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching images: $e');
      throw Exception('Error: $e');
    }
  }

  // Upload image
  static Future<ImageModel> uploadImage(File imageFile, String description) async {
    try {
      print('Starting upload to: $baseUrl/upload');
      print('File path: ${imageFile.path}');
      print('File size: ${await imageFile.length()} bytes');
      print('Description: $description');
      
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload'),
      );

      // Add the image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      // Add the description
      request.fields['description'] = description;

      print('Sending request...');
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      
      print('Upload response status: ${response.statusCode}');
      print('Upload response body: $responseData');

      if (response.statusCode == 201) {
        final imageData = json.decode(responseData);
        return ImageModel.fromJson(imageData);
      } else {
        print('Upload failed with status: ${response.statusCode}');
        print('Error response: $responseData');
        throw Exception('Failed to upload image: ${response.statusCode} - $responseData');
      }
    } catch (e) {
      print('Upload error: $e');
      throw Exception('Upload failed: $e');
    }
  }

  // Delete image
  static Future<void> deleteImage(String imageId) async {
    try {
      print('Deleting image: $imageId');
      final response = await http.delete(
        Uri.parse('$baseUrl/images/$imageId'),
      );

      print('Delete response status: ${response.statusCode}');

      if (response.statusCode != 200) {
        print('Delete error response: ${response.body}');
        throw Exception('Failed to delete image: ${response.statusCode}');
      }
    } catch (e) {
      print('Delete error: $e');
      throw Exception('Error: $e');
    }
  }
} 