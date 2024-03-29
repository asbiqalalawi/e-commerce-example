part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<ProductModel> products;

  SearchSuccess({required this.products});
}

final class SearchError extends SearchState {
  final String error;

  SearchError({required this.error});
}
