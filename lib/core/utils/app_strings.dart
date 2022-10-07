class AppStrings {
 static const String titleApp = 'Posts App';
 static const String titleEditeScreen = 'Edite Post';
 static const String titleAddScreen = 'add Post';
 static const String titleDetailsScreen = 'Details Post';
 static const String editButton = 'Edit';
 static const String deleteButton = 'Delete';
 //cached shard preferences
 static const String cachedPosts = 'CachedPosts';
 //api strings
  static const String baseUrl = "https://jsonplaceholder.typicode.com";
  static const String postsUrl = "https://jsonplaceholder.typicode.com/posts";
  static String deletePostsUrl({required int id }) => "https://jsonplaceholder.typicode.com/posts/$id";
}