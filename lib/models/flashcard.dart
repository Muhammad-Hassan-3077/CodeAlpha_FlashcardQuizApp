class Flashcard {
  final int? id;
  final String question;
  final String answer;
  final String category;

  Flashcard({
    this.id,
    required this.question,
    required this.answer,
    this.category = 'General',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'category': category,
    };
  }

  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map['id'] as int?,
      question: map['question'] as String,
      answer: map['answer'] as String,
      category: map['category'] as String? ?? 'General',
    );
  }

  Flashcard copyWith({
    int? id,
    String? question,
    String? answer,
    String? category,
  }) {
    return Flashcard(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      category: category ?? this.category,
    );
  }
}