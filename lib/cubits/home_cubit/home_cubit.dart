import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/helper/api.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/views/categories_view.dart';
import 'package:shop_app/views/favorites_view.dart';
import 'package:shop_app/views/products_view.dart';
import 'package:shop_app/views/settings_view.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = const [
    ProductsView(),
    CategoriesView(),
    FavoritesView(),
    SettingsView(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(HomeBottomNav());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(HomeLoading());

    ApiHelper().get(url: homeUrl, token: token).then((value) {
      homeModel = HomeModel.fromJson(value);
      for (var element in homeModel!.data.products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      emit(HomeSuccess());
    }).catchError((error) {
      emit(HomeFailure(toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    ApiHelper().get(url: categoriesUrl, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value);
      emit(CategoriesSuccess());
    }).catchError((error) {
      emit(CategoriesFailure(error.toString()));
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

  LoginModel? userModel;
  void getUserData() {
    emit(UserDataLoading());
    ApiHelper().get(url: profilesUrl, token: token).then((value) {
      userModel = LoginModel.fromJson(value);
      emit(UserDataSuccess());
    }).catchError((error) {
      emit(UserDataFailure(error.toString()));
    });
  }

  void updateUserData({
    required String? email,
    required String? phone,
    required String? name,
  }) {
    emit(UpdateUserDataLoading());
    ApiHelper()
        .put(
            url: updateProfileUrl,
            token: token,
            body: jsonEncode({'name': name, 'phone': phone, 'email': email}))
        .then((value) {
      userModel = LoginModel.fromJson(value);

      emit(UpdateUserDataSuccess(userModel!));
    }).catchError((error) {
      emit(UpdateUserDataFailure(error.toString()));
    });
  }
}
