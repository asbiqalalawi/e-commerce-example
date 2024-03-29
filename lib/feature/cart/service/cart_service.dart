import 'package:e_commerce_example/app/service/service_const.dart';
import 'package:e_commerce_example/feature/cart/model/cart_model.dart';

class CartService {
  Future<CartModel> getCart() async {
    try {
      final response = await dio.get('$baseURL/carts/1');
      final cart = CartModel.fromJson(response.data);
      return cart;
    } catch (_) {
      rethrow;
    }
  }
}
