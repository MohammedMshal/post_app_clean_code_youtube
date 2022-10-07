import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/core/utils/app_strings.dart';
import 'package:posts_app/features/posts/data/model/posts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BasePostLocaleDataSource {
  Future<Unit> saveCachedPosts(SaveCachedPostsParameters parameters);

  Future<List<PostsModel>> getCachedPosts();
}

class PostLocaleDataSource implements BasePostLocaleDataSource {
  final SharedPreferences sharedPreferences;

  PostLocaleDataSource({required this.sharedPreferences});

  @override
  Future<Unit> saveCachedPosts(SaveCachedPostsParameters parameters) async {
    //لحفظ الليست داخل الهاتف لابد من تحويلها لجاثون من خلال الدالة تو جاثون
    List potsModelsToJson = parameters.postModel
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    //ومن ثم تم حفظها بإستخدام شيرد برفرنس
    sharedPreferences.setString(
      AppStrings.cachedPosts,
      //لابد من عمل ان كود للجاثون لكى يتم حفظه بطريقة سليمة داخل الهاتف
      json.encode(potsModelsToJson),
    );
    return Future.value(unit);
  }

  @override
  Future<List<PostsModel>> getCachedPosts() {
    final getDataFromJsonToString =
        sharedPreferences.getString(AppStrings.cachedPosts);
    if (getDataFromJsonToString != null) {
      //هنا العكس يتم عمل دى كود لكى تعمل على الأبليكشن بشكل صحيح ومن ثم عكس العملية
      List decodeJsonData = json.decode(getDataFromJsonToString);
      //ومن ثم تحويل الجاثون القادم من ذاكرة الهاتف لنفس نوع المودل الخاص بنا
      List<PostsModel> jsonToPostModel = decodeJsonData
          .map<PostsModel>((jsonPost) => PostsModel.fromJson(jsonPost))
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException(message: 'Empty cache exception');
    }
  }
}

class SaveCachedPostsParameters extends Equatable {
  final List<PostsModel> postModel;

  const SaveCachedPostsParameters({required this.postModel});

  @override
  List<Object> get props => [postModel];
}
