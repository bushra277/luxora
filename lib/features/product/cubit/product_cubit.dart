import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/features/product/cubit/product_state.dart';
import 'package:task_flutter/features/product/models/product_model.dart';
import 'package:task_flutter/features/product/service/product_service.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService _service;

  ProductCubit(this._service) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await _service.getProducts();
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> addProduct(ProductModel product) async {
    emit(ProductLoading());
    try {
      await _service.addProduct(product);
      await fetchProducts(); 
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> updateProduct(int id, ProductModel product) async {
    emit(ProductLoading());
    try {
      await _service.updateProduct(id, product);
      await fetchProducts();
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> deleteProduct(int id) async {
    emit(ProductLoading());
    try {
      await _service.deleteProduct(id);
      await fetchProducts();
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
