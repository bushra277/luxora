import 'package:task_flutter/core/api/api_client.dart';
import 'package:task_flutter/features/product/models/product_model.dart';

class ProductService {
  Future<List<ProductModel>> getProducts() async {
    try {
      final dio = await ApiClient.getDio();
      final response = await dio.get("/products");
      return (response.data as List).map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch products: $e");
    }
  }

  Future<ProductModel> getProduct(int id) async {
    try {
      final dio = await ApiClient.getDio();
      final response = await dio.get("/products/$id");
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to fetch product: $e");
    }
  }

  Future<ProductModel> addProduct(ProductModel product) async {
  try {
    final dio = await ApiClient.getDio();

    final response = await dio.post(
      "/products/", data:product.toCreateJson()
    );

    return ProductModel.fromJson(response.data);
  } catch (e) {
    throw Exception("Failed to add product: $e");
  }
}


  Future<ProductModel> updateProduct(int id, ProductModel product) async {
    try {
      final dio = await ApiClient.getDio();
      final response = await dio.put("/products/$id", data: product.toCreateJson());
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to update product: $e");
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final dio = await ApiClient.getDio();
      await dio.delete("/products/$id");
    } catch (e) {
      throw Exception("Failed to delete product: $e");
    }
  }
}
