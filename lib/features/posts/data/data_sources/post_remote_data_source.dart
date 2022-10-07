import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/features/posts/data/model/posts_model.dart';
import 'package:posts_app/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:posts_app/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:posts_app/features/posts/domain/use_cases/update_post_use_case.dart';

import '../../../../core/utils/app_strings.dart';

abstract class BasePostRemoteDataSource {
  Future<List<PostsModel>> getAllPosts();

  Future<Unit> addPosts(AddPostParameters parameters);

  Future<Unit> deletePosts(DeletePostParameters parameters);

  Future<Unit> updatePosts(UpdatePostParameters parameters);
}

class PostRemoteDataSource implements BasePostRemoteDataSource {
  final http.Client httpClientInit;

  PostRemoteDataSource({required this.httpClientInit});

  @override
  Future<List<PostsModel>> getAllPosts() async {
    final Response response = await httpClientInit.get(
        Uri.parse(AppStrings.postsUrl),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostsModel> postsModel =
          decodedJson.map<PostsModel>((e) => PostsModel.fromJson(e)).toList();
      return postsModel;
    } else {
      throw ServerException(message: 'error get all posts');
    }
  }

  @override
  Future<Unit> addPosts(AddPostParameters parameters) async {
    final Map<String, dynamic> body = {
      'title': parameters.posts.title,
      'body': parameters.posts.body,
    };
    final Response response =
        await httpClientInit.post(Uri.parse(AppStrings.postsUrl), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException(message: 'error add post!!!');
    }
  }

  @override
  Future<Unit> deletePosts(DeletePostParameters parameters) async {
    final Response response = await httpClientInit.delete(
        Uri.parse(AppStrings.deletePostsUrl(id: parameters.id)),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException(message: 'error delete post server exception');
    }
  }

  @override
  Future<Unit> updatePosts(UpdatePostParameters parameters) async {
    final String postId = parameters.posts.id.toString();
    final Map<String, dynamic> body = {
      'body': parameters.posts.body,
      'title': parameters.posts.title
    };
    final response = await httpClientInit
        .patch(Uri.parse('${AppStrings.baseUrl}/posts/$postId'), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException(message: 'Error update post server exception');
    }
  }
}
