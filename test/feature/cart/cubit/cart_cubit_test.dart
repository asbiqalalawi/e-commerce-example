import 'package:e_commerce_example/feature/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_example/feature/cart/model/cart_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartCubit', () {
    test('set and removing a product', () {
      final cartCubit = CartCubit();
      const productIdToRemove = 1;
      final initialCartModel = CartModel(
        id: 1,
        userId: 1,
        date: DateTime.now(),
        products: [
          ProductCartModel(productId: 1, quantity: 2), // Product to remove
          ProductCartModel(productId: 2, quantity: 3),
          ProductCartModel(productId: 3, quantity: 1),
        ],
        v: 1,
      );
      cartCubit.setProductCart(initialCartModel);

      cartCubit.removeProduct(productIdToRemove);

      expect(cartCubit.state.products.length, equals(initialCartModel.products.length - 1));
    });

    test('updates quantity of a product', () {
      final cartCubit = CartCubit();
      const productIdToUpdate = 1;
      const newQuantity = 5;
      final initialCartModel = CartModel(
        id: 1,
        userId: 1,
        date: DateTime.now(),
        products: [
          ProductCartModel(productId: 1, quantity: 2), // Product to update
          ProductCartModel(productId: 2, quantity: 3),
          ProductCartModel(productId: 3, quantity: 1),
        ],
        v: 1,
      );

      cartCubit.setProductCart(initialCartModel);

      cartCubit.updateQuantity(productIdToUpdate, newQuantity);

      final updatedCartModel = cartCubit.state;
      final expectedCartModel = CartModel(
        id: 1,
        userId: 1,
        date: DateTime.now(),
        products: [
          ProductCartModel(productId: 1, quantity: newQuantity),
          ProductCartModel(productId: 2, quantity: 3),
          ProductCartModel(productId: 3, quantity: 1),
        ],
        v: 1,
      );

      expect(
        updatedCartModel.products.first.quantity,
        equals(expectedCartModel.products.first.quantity),
      );
    });
  });
}
