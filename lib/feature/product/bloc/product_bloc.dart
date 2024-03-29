import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_example/feature/home/model/product_model.dart';
import 'package:e_commerce_example/feature/product/service/product_service.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _service;

  ProductBloc(this._service) : super(ProductInitial()) {
    on<GetProductEvent>((event, emit) async {
      try {
        emit(ProductInitial());
        emit(ProductLoading());
        final product = await _service.getProduct(event.id);
        emit(ProductSuccess(product: product));
      } on DioException catch (e) {
        emit(ProductError(error: e.toString()));
      } catch (e) {
        emit(ProductError(error: e.toString()));
      }
    });
  }
}
