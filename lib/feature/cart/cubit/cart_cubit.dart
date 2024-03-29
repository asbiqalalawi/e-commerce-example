import 'package:bloc/bloc.dart';
import 'package:e_commerce_example/feature/cart/model/cart_model.dart';

class CartCubit extends Cubit<CartModel> {
  CartCubit() : super(CartModel(id: 1, userId: 1, date: DateTime.now(), products: [], v: 1));

  setProductCart(CartModel product) {
    emit(product);
  }

  updateQuantity(int productId, int newQuantity) {
    emit(state.copyWith(
      products: state.products.map((product) {
        if (product.productId == productId) {
          return product.copyWith(quantity: newQuantity);
        } else {
          return product;
        }
      }).toList(),
    ));
  }

  removeProduct(int productId) {
    emit(state.copyWith(
      products: state.products.where((product) => product.productId != productId).toList(),
    ));
  }
}
