part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartModel cart;

  CartSuccess({required this.cart});
}

final class CartError extends CartState {
  final String error;

  CartError({required this.error});
}

final class CartQuantity extends CartState {
  final int quantity;

  CartQuantity({required this.quantity});
}
