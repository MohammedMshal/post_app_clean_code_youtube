import 'package:posts_app/features/posts/domain/entities/posts.dart';

class PostsModel extends Posts {
  const PostsModel({
    int? id,
    required String title,
    required String body,
  }) : super(id: id, body: body, title: title);

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
      };
}
