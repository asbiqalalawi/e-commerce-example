import 'package:e_commerce_example/feature/cart/cubit/checkout_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CheckoutCubit', () {
    test('addPrice amd minPrice', () {
      final checkoutCubit = CheckoutCubit();
      final initialPrice = checkoutCubit.state;

      const addedPrice = 10.0;
      final expectedPrice = initialPrice + addedPrice;
      checkoutCubit.addPrice(addedPrice);
      expect(checkoutCubit.state, equals(expectedPrice));

      const subtractedPrice = 5.0;
      final lastExpectedPrice = expectedPrice - subtractedPrice;

      checkoutCubit.minPrice(subtractedPrice);
      expect(checkoutCubit.state, equals(lastExpectedPrice));
    });

    test('resetPrice', () {
      final checkoutCubit = CheckoutCubit();

      const initialPrice = 10.0;
      checkoutCubit.emit(initialPrice);

      checkoutCubit.resetPrice();

      expect(checkoutCubit.state, equals(0));
    });
  });
}
