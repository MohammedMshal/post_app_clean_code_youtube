import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/services_locator/services_locator.dart';
import 'package:posts_app/my_app.dart';
import 'config/routes/app_routes.dart';
import 'core/utils/app_strings.dart';
import 'features/posts/presentation/controller/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'features/posts/presentation/controller/posts/posts_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp( const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) =>
        sl<PostsBloc>()
          ..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => sl<AddDeleteUpdatePostsBloc>()),
      ],
      child: const MaterialApp(
          title: AppStrings.titleApp,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: HomeMyApp()
      ),
    );
  }

}