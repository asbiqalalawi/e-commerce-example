import 'package:e_commerce_example/app/service/service_const.dart';
import 'package:e_commerce_example/feature/home/model/product_model.dart';

class HomeService {
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('$baseURL/products');
      final products = (response.data as List).map((e) {
        return ProductModel.fromJson(e);
      }).toList();
      return products;
    } catch (_) {
      rethrow;
    }
  }
}
