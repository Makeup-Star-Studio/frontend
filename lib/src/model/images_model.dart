class ImageModel {
   String? id; // This corresponds to the _id field in MongoDB
   String filename; // The filename of the image
   String url; // The URL of the image

  ImageModel({
    this.id,
    required this.filename,
    required this.url,
  });

  // Factory method to create an ImageModel from JSON
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['_id'] ?? '', // If id is not provided, assign a placeholder value
      filename: json['filename'],
      url: json['url'],
    );
  }

  // Method to convert ImageModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id ?? '', // If id is not provided, assign a placeholder value
      'filename': filename,
      'url': url,
    };
  }
}

class RandomImagesModel {
  final List<ImageModel> imagesUrl; // A list of ImageModel objects

  RandomImagesModel({
    required this.imagesUrl,
  });

  // Factory method to create RandomImagesModel from JSON
  factory RandomImagesModel.fromJson(Map<String, dynamic> json) {
    return RandomImagesModel(
      imagesUrl: (json['imagesUrl'] as List)
          .map((image) => ImageModel.fromJson(image))
          .toList(),
    );
  }

  // Method to convert RandomImagesModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'imagesUrl': imagesUrl.map((image) => image.toJson()).toList(),
    };
  }
}
