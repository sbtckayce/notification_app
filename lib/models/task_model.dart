import 'dart:convert';

class Task {
  final int? id;
  final String? title;
  final String? note;
  final int? isCompleted;
  final String? date;
  final String? startDate;
  final String? endDate;
  final int? color;
  final int? remind;
  final String? repeat;
  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startDate,
    this.endDate,
    this.color,
    this.remind,
    this.repeat,
  });

  Task copyWith({
    int? id,
    String? title,
    String? note,
    int? isCompleted,
    String? date,
    String? startDate,
    String? endDate,
    int? color,
    int? remind,
    String? repeat,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      color: color ?? this.color,
      remind: remind ?? this.remind,
      repeat: repeat ?? this.repeat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startDate': startDate,
      'endDate': endDate,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      isCompleted: json['isCompleted'],
      date: json['date'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      color: json['color'],
      remind: json['remind'],
      repeat: json['repeat'],
    );
  }

  String toJson() => json.encode(toMap());

 

  @override
  String toString() {
    return 'Task(id: $id, title: $title, note: $note, isCompleted: $isCompleted, date: $date, startDate: $startDate, endDate: $endDate, color: $color, remind: $remind, repeat: $repeat)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.note == note &&
        other.isCompleted == isCompleted &&
        other.date == date &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.color == color &&
        other.remind == remind &&
        other.repeat == repeat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        note.hashCode ^
        isCompleted.hashCode ^
        date.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        color.hashCode ^
        remind.hashCode ^
        repeat.hashCode;
  }
}
