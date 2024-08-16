class Note {
  final int? id;
  final String title;
  final String description;
  final String content;
  final DateTime creationDate;
  final DateTime updateDate;
  final int priority;
  // final String color;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.creationDate,
    required this.updateDate,
    required this.priority,
    // required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
      'priority': priority,
      // 'color':color
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        content: map['content'],
        creationDate: DateTime.parse(map['creationDate']),
        updateDate: DateTime.parse(map['updateDate']),
        priority: map['priority'],
        // color: map['color']
        );
  }

  // Método copyWith para crear una copia del Note con cambios específicos.
  Note copyWith({
    int? id,
    String? title,
    String? description,
    String? content,
    DateTime? creationDate,
    DateTime? updateDate,
    int? priority,
    // String? color,
  }) {
    return Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        content: content ?? this.content,
        creationDate: creationDate ?? this.creationDate,
        updateDate: updateDate ?? this.updateDate,
        priority: priority ?? this.priority,
        // color: color ?? this.color
        );
  }
}
