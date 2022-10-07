import 'package:equatable/equatable.dart';

class Posts extends Equatable {
  final int? id;
  final String title;
  final String body;

  const Posts({
    this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, title, body];
}
