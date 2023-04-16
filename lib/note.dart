class Note {
  late int id;
  late String title;
  late String? content;
  late DateTime dateTime;
  late String color;

  Note({
    required this.id,
    required this.title,
    this.content,
    required this.dateTime,
    required this.color,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: int.parse(json['id']),
      title: json['title'],
      content: json['content'],
      dateTime: DateTime.parse(json['dateTime']),
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateTime': dateTime.toIso8601String(),
      'color': color,
    };
  }

  Note copyWith({
    int? id,
    String? title,
    DateTime? dateTime,
    String? content,
    String? color,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      dateTime: dateTime ?? this.dateTime,
      color: color ?? this.color,
    );
  }
}
