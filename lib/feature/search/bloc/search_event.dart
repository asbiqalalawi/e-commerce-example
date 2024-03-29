part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class GetSearchEvent extends SearchEvent {
  final String? search;

  GetSearchEvent({this.search});
}
