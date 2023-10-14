import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/helper/api.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/search_model.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);
  SearchModel? model;
  void search(String text) {
    emit(SearchLoading());
    ApiHelper()
        .post(url: searchUrl, body: jsonEncode({'text': text}), token: token)
        .then((value) {
      model?.data?.data?.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      model = SearchModel.fromJson(value);
      emit(SearchSuccess());
    }).catchError((error) {
      emit(SearchFailure(error.toString()));
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavorite());
    ApiHelper()
        .post(
            url: favoritesUrl,
            body: jsonEncode({'product_id': productId}),
            token: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoritesModel.fromJson(value);
      if (changeFavoriteModel?.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ChangeFavoriteSuccess(model: changeFavoriteModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(
        ChangeFavoriteFailure(
          error.toString(),
        ),
      );
    });
  }

  void getFavoritesData() {
    emit(FavoritesLoading());
    ApiHelper().get(url: favoritesUrl, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value);
      emit(FavoritesSuccess());
    }).catchError((error) {
      emit(FavoritesFailure(error.toString()));
    });
  }
}
