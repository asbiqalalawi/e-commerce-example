import 'package:e_commerce_example/app/service/service_const.dart';
import 'package:e_commerce_example/feature/home/model/product_model.dart';

class ProductService {
  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await dio.get('$baseURL/products/$id');
      final product = ProductModel.fromJson(response.data);
      return product;
    } catch (_) {
      rethrow;
    }
  }
}
