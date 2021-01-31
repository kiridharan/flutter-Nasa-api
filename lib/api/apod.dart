class Apod {
  String date;
  String explanation;
  String url;
  String title;
  String copyright;
  Apod({
    this.date,
    this.explanation,
    this.url,
    this.title,
    this.copyright,
  });

  factory Apod.fromJson(Map<String, dynamic> json) {
    return Apod(
        copyright: json['copyright'],
        explanation: json['explanation'],
        url: json['url'],
        title: json['title'],
        date: json['date']);
  }
}
