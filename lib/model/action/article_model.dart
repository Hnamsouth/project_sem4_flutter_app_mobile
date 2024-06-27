class ArticleModel {
  final int id;
  final String title;
  final String content;
  final List<ImageModel> images; // Assuming you have an ImageModel class

  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.images,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    var imagesJson = json['images'] as List;
    List<ImageModel> imagesList = imagesJson.map((image) => ImageModel.fromJson(image)).toList();

    return ArticleModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      images: imagesList,
    );
  }
}

class ImageModel {
  final String url;

  ImageModel({required this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'],
    );
  }
}
