import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_example/feature/home/model/product_model.dart';
import 'package:e_commerce_example/feature/home/service/home_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService _service;

  HomeBloc(this._service) : super(HomeInitial()) {
    on<GetHomeEvent>((event, emit) async {
      try {
        emit(HomeInitial());
        emit(HomeLoading());
        final products = await _service.getProducts();
        emit(HomeSuccess(products: products));
      } on DioException catch (e) {
        emit(HomeError(error: e.toString()));
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    });
  }
}
