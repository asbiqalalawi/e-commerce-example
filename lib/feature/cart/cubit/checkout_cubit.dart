import 'package:bloc/bloc.dart';

class CheckoutCubit extends Cubit<double> {
  CheckoutCubit() : super(0);

  addPrice(double price) {
    emit(state + price);
  }

  minPrice(double price) {
    emit(state - price);
  }

  resetPrice() {
    emit(0);
  }
}
