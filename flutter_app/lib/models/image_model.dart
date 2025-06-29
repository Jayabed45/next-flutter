class ImageModel {
  final String id;
  final String filename;
  final String originalName;
  final String path;
  final int size;
  final DateTime uploadDate;
  final String description;

  ImageModel({
    required this.id,
    required this.filename,
    required this.originalName,
    required this.path,
    required this.size,
    required this.uploadDate,
    required this.description,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['_id'],
      filename: json['filename'],
      originalName: json['originalName'],
      path: json['path'],
      size: json['size'],
      uploadDate: DateTime.parse(json['uploadDate']),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'filename': filename,
      'originalName': originalName,
      'path': path,
      'size': size,
      'uploadDate': uploadDate.toIso8601String(),
      'description': description,
    };
  }
} 