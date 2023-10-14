part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeBottomNav extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {}
class HomeFailure extends HomeState {
  final String errorMessage;
  HomeFailure(this.errorMessage);
}
class CategoriesSuccess extends HomeState {}
class CategoriesFailure extends HomeState {
  final String errorMessage;
  CategoriesFailure(this.errorMessage);
}

class ChangeFavorite extends HomeState {}
class ChangeFavoriteSuccess extends HomeState {
  final ChangeFavoritesModel ? model;

  ChangeFavoriteSuccess({required this.model});
}
class ChangeFavoriteFailure extends HomeState {
  final String errorMessage;
  ChangeFavoriteFailure(this.errorMessage);
}
class FavoritesLoading extends HomeState {}
class FavoritesSuccess extends HomeState {}
class FavoritesFailure extends HomeState {
  final String errorMessage;
  FavoritesFailure(this.errorMessage);
}

class UserDataLoading extends HomeState {}
class UserDataSuccess extends HomeState {}
class UserDataFailure extends HomeState {
  final String errorMessage;
  UserDataFailure(this.errorMessage);
}

class UpdateUserDataLoading extends HomeState {}
class UpdateUserDataSuccess extends HomeState {
  final LoginModel loginModel;
  UpdateUserDataSuccess(this.loginModel);
}
class UpdateUserDataFailure extends HomeState {
  final String errorMessage;
  UpdateUserDataFailure(this.errorMessage);
}


