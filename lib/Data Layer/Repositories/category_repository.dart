import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';

class CategoryRepository {
  final NonAuthenticatedApiProvider _provider = NonAuthenticatedApiProvider();

  Future<List<Category>> fetchCatgegories() async {
    List<Category> categories = [];

    final response = await _provider.get('api/categories/');
    for (var incomingcategory in response) {
      categories.add(Category.fromJson(incomingcategory));
    }
    return categories;
  }

  Future<Category> fetchCategory(int id) async {
    final response = await _provider.get('api/categories/$id/');
    return Category.fromJson(response);
  }
}
