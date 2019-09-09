class Video {
  final int id;
  final String name;
  final String url;
  final String downloadUrl;
  final String thumbnailPath;
  final String filePath;

  Video(
      {this.id,
      this.name,
      this.url,
      this.downloadUrl,
      this.thumbnailPath,
      this.filePath});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "url": url,
      "downloadUrl": downloadUrl,
      "thumbnailPath": thumbnailPath,
      "filePath": filePath
    };
  }
}
