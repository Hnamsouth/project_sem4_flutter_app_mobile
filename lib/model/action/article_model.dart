class ArticleModel {
  int? id;
  String? title;
  String? content;
  String? url;
  List<String>? articleImageUrls;
  DateTime? createdAt;
  List<LikeModel>? likeList;
  List<CommentModel>? commentList;



  ArticleModel(
      {this.id,
      this.title,
      this.content,
      this.url,
      this.articleImageUrls,
      this.createdAt});


  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    content = json['content'] ?? '';
    url = json['url'] ?? '';
    if (json['articleImageUrls'] != null) {
      articleImageUrls = List<String>.from(json['articleImageUrls']);
    } else {
      articleImageUrls = [];
    }
    createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;


    if (json['likeList'] != null) {
      likeList = <LikeModel>[];
      json['likeList'].forEach((v) {
        likeList!.add(new LikeModel.fromJson(v));
      });
    }
    if (json['commentList'] != null) {
      commentList = <CommentModel>[];
      json['commentList'].forEach((v) {
        commentList!.add(new CommentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt?.toIso8601String();
    data['url'] = this.url;
    data['articleImageUrls'] = this.articleImageUrls;
    if (this.likeList != null) {
      data['likeList'] = this.likeList!.map((v) => v.toJson()).toList();
    }
    if (this.commentList != null) {
      data['commentList'] = this.commentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LikeModel {
  int? id;
  int? articleId;
  int? userId;
  bool? status;
  DateTime? createdAt;
  LikeModel({this.id, this.status, this.createdAt,this.userId,this.articleId});

  LikeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    articleId = json['articleId'];
    userId = json['userId'];
    status = json['status'];
    createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['articleId'] = this.articleId;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt?.toIso8601String();
    return data;
  }
}

class CommentModel {
  int? id;
  int? articleId;
  int? userId;
  String? content;
  DateTime? createdAt;


  CommentModel({this.id, this.content, this.createdAt,this.userId,this.articleId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    articleId = json['articleId'];
    userId = json['userId'];
    createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['articleId'] = this.articleId;
    data['userId'] = this.userId;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt?.toIso8601String();
    return data;
  }
}
