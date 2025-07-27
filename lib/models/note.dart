class Note {
  final String? title;
  final String? content;
  final int createdAt;
  final int updatedAt;
  final List<String>? tags;

  Note({
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.tags,
  });
}
