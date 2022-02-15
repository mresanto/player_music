class Song {
  final int id;
  final String singer;
  final String title;
  final String url;
  final String coverUrl;
  final String color;

  Song(
      {required this.id,
      required this.singer,
      required this.title,
      required this.url,
      required this.coverUrl,
      required this.color});

  factory Song.fromJson(Map<String, dynamic> data) {
    return Song(
        id: data["id"],
        singer: data["singer"],
        title: data["title"],
        url: data["url"],
        coverUrl: data["coverUrl"],
        color: data["color"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "singer": singer,
      "title": title,
      "url": url,
      "coverUrl": coverUrl,
      "color": color,
    };
  }
}
