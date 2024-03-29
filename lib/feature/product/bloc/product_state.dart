part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final ProductModel product;

  ProductSuccess({required this.product});
}

final class ProductError extends ProductState {
  final String error;

  ProductError({required this.error});
}
