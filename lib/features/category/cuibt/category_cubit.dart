import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/features/category/cuibt/category_state.dart';
import 'package:task_flutter/features/category/repository/category_reposity.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository repository;

  CategoryCubit(this.repository) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await repository.getCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
