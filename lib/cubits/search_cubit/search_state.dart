part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchSuccess extends SearchState {
}
class SearchFailure extends SearchState {
  final String errorMessage;

  SearchFailure(this.errorMessage);

}
class ChangeFavorite extends SearchState {}
class ChangeFavoriteSuccess extends SearchState {
  final ChangeFavoritesModel ? model;

  ChangeFavoriteSuccess({required this.model});
}
class ChangeFavoriteFailure extends SearchState {
  final String errorMessage;
  ChangeFavoriteFailure(this.errorMessage);
}
class FavoritesLoading extends SearchState {}
class FavoritesSuccess extends SearchState {}
class FavoritesFailure extends SearchState {
  final String errorMessage;
  FavoritesFailure(this.errorMessage);
}
