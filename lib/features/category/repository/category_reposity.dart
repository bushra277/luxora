import 'package:task_flutter/features/category/models/category_model.dart';
import 'package:task_flutter/features/category/services/category_service.dart';

class CategoryRepository {
  final CategoryService service;
  CategoryRepository(this.service);

  Future<List<CategoryModel>> getCategories() => service.fetchCategories();
}
