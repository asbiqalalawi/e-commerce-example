import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_example/feature/cart/model/cart_model.dart';
import 'package:e_commerce_example/feature/cart/service/cart_service.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService _service;

  CartBloc(this._service) : super(CartInitial()) {
    on<GetCartEvent>((event, emit) async {
      try {
        emit(CartInitial());
        emit(CartLoading());
        final cart = await _service.getCart();
        emit(CartSuccess(cart: cart));
      } on DioException catch (e) {
        emit(CartError(error: e.toString()));
      } catch (e) {
        emit(CartError(error: e.toString()));
      }
    });
  }
}
