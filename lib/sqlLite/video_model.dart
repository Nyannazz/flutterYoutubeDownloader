import 'dart:convert';

Video videoFromJson(String str) {
  final jsonData = json.decode(str);
  return Video.fromJson(jsonData);
}

String videoToJson(Video data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Video {
  final int id;
  final String name;
  final String url;
  final String downloadUrl;
  final String thumbnailPath;
  final String filePath;
  final String formatSelected;

  Video({
      this.id,
      this.name,
      this.url,
      this.downloadUrl,
      this.thumbnailPath,
      this.filePath,
      this.formatSelected
    });

  factory Video.fromJson(Map<String, dynamic> json) => new Video(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        downloadUrl: json["downloadUrl"],
        thumbnailPath: json["thumbnailPath"],
        filePath: json["filePath"],
        formatSelected: json["formatSelected"],
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "url": url,
      "downloadUrl": downloadUrl,
      "thumbnailPath": thumbnailPath,
      "filePath": filePath,
      "formatSelected": formatSelected
    };
  }
}
