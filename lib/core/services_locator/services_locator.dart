import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/data_sources/post_locale_data_source.dart';
import 'package:posts_app/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_app/features/posts/data/repository/post_repository.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';
import 'package:posts_app/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:posts_app/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:posts_app/features/posts/domain/use_cases/get_all_posts_use_case.dart';
import 'package:posts_app/features/posts/domain/use_cases/update_post_use_case.dart';
import 'package:posts_app/features/posts/presentation/controller/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/controller/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! features posts
  // Bloc
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(
    () => AddDeleteUpdatePostsBloc(
      addPostUseCase: sl(),
      deletePostUseCase: sl(),
      updatePostUseCase: sl(),
    ),
  );
  // use cases
  sl.registerLazySingleton(() => GetAllPostsUseCase(basePostsRepository: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(basePostsRepository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(basePostsRepository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(basePostsRepository: sl()));
  // Repositories
  sl.registerLazySingleton<BasePostsRepository>(
    () => PostsRepository(
      basePostRemoteDataSource: sl(),
      basePostLocaleDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //Data Sources
  sl.registerLazySingleton<BasePostRemoteDataSource>(() => PostRemoteDataSource(httpClientInit: sl()));
  sl.registerLazySingleton<BasePostLocaleDataSource>(() => PostLocaleDataSource(sharedPreferences: sl()));
  //! core
  sl.registerLazySingleton<BaseNetworkInfo>(() => NetworkInfo(connectionChecker: sl()));
  //! External
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
