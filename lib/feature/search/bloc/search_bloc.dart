import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_example/feature/home/model/product_model.dart';
import 'package:e_commerce_example/feature/home/service/home_service.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final HomeService _service;

  SearchBloc(this._service) : super(SearchInitial()) {
    on<GetSearchEvent>((event, emit) async {
      try {
        emit(SearchInitial());
        emit(SearchLoading());
        if ((event.search ?? '').isEmpty) {
          emit(SearchSuccess(products: const []));
        } else {
          final products = await _service.getProducts();
          var searchedProduct = products.where((product) {
            return product.title.toLowerCase().contains(event.search!.toLowerCase());
          }).toList();
          emit(SearchSuccess(products: searchedProduct));
        }
      } on DioException catch (e) {
        emit(SearchError(error: e.toString()));
      } catch (e) {
        emit(SearchError(error: e.toString()));
      }
    });
  }
}
