import 'package:flutter/material.dart';

import 'models/change_favorites_model.dart';
import 'models/favourites_model.dart';

const kPrimaryColor = Colors.blue;
const loginUrl = 'https://student.valuxapps.com/api/login';
const registerUrl = 'https://student.valuxapps.com/api/register';
const homeUrl = 'https://student.valuxapps.com/api/home';
const categoriesUrl = 'https://student.valuxapps.com/api/categories';
const favoritesUrl = 'https://student.valuxapps.com/api/favorites';
const profilesUrl = 'https://student.valuxapps.com/api/profile';
const updateProfileUrl = 'https://student.valuxapps.com/api/update-profile';
const searchUrl = 'https://student.valuxapps.com/api/products/search';
String? token;
Map<int, bool> favorites = {};
ChangeFavoritesModel? changeFavoriteModel;
FavoritesModel? favoritesModel;