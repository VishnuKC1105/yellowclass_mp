class VideoDataModel {
  int? id;
  String? title;
  String? videoUrl;
  String? coverPicture;

  VideoDataModel({
    this.id,
    this.title,
    this.videoUrl,
    this.coverPicture,
  });

  VideoDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    coverPicture = json['coverPicture'];
  }
}
