import 'package:task_flutter/core/api/api_client.dart';
import 'package:task_flutter/features/category/models/category_model.dart';

class CategoryService {
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final dio = await ApiClient.getDio();
      final response = await dio.get("/categories");

      return (response.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch categories: $e");
    }
  }
}
