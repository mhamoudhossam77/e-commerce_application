import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/model/Favourit_Model.dart';
import 'package:ecommerce/model/cart-model.dart';
import 'package:ecommerce/model/categories-detaiels-model.dart';
import 'package:ecommerce/model/categories-model.dart';
import 'package:ecommerce/model/home-model.dart';
import 'package:ecommerce/model/user-model.dart';
import 'package:ecommerce/shared/network/local/cache-helper/Cache_Helper.dart';
import 'package:ecommerce/shared/network/local/cache-keys/Cache_Keys.dart';
import 'package:ecommerce/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:ecommerce/shared/network/remote/endpoints/endpoints.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  AppCubitCubit() : super(AppCubitInitial());

  static AppCubitCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  category_model? categories;
  UserModel? userModel;
  Categories_Detalies? categories_detalies;
  Map<int, bool> favmap = {};
  FavouriteModel? favouriteModel;
  Map<int, bool> Cartmap = {};
  CartModel? cartModel;

  void getHomeData() async {
    print(CacheHelper.getStringFromCache("token"));
    emit(GetHomeDataLoading());

    try {
      Response response = await DioHelper.getRequest(
        endpoint: HOME,
        token: CacheHelper.getStringFromCache("token"),
      );

      homeModel = HomeModel.fromJson(response.data);
      if (homeModel?.status == true) {
        for (var Element in homeModel!.data!.products!) {
          favmap.addAll({
            Element.id!: Element.inFavorites!,
          });
        }
        emit(GetHomeDataSucess());
      } else {
        emit(GetHomeDataError());
      }
    } catch (error) {
      emit(GetHomeDataError());
    }
  }

  void getCategoriesData() async {
    print(CacheHelper.getStringFromCache("token"));
    emit(GetcategoriesDataLoading());

    try {
      Response response = await DioHelper.getRequest(endpoint: CATEGORES);

      categories = category_model.fromJson(response.data);

      if (categories!.status == true) {
        emit(GetUserDataLSucess());
      } else {
        print(categories!.message);
        emit(GetcategoriesDataError());
      }
    } catch (error) {
      print(error);
      emit(GetcategoriesDataError());
    }
  }

  void getUserData() async {
    emit(GetUserDataLoading());

    try {
      Response response = await DioHelper.getRequest(
        endpoint: USER,
        token: CacheHelper.getStringFromCache("token"),
      );

      userModel = UserModel.fromJson(response.data);

      if (userModel?.status == true) {
        emit(GetUserDataLSucess());
      } else {
        emit(GetUserDataError());
      }
    } catch (error) {
      emit(GetUserDataError());
    }
  }

  void Logout() async {
    emit(LogoutLoading());

    try {
      print(TOKEN);

      Response response = await DioHelper.getRequest(
        endpoint: LOGOUT,
        token: CacheHelper.getStringFromCache("token"),
      );

      if (userModel?.status == true) {
        emit(Logoutsucess());
      } else {
        emit(LogoutError());
      }
    } catch (error) {
      emit(LogoutError());
    }
  }

  void getCategoryElectronicDevice() async {
    emit(GetCategoryesElectronicDeviceLoading());

    try {
      Response response = await DioHelper.getRequest(
        endpoint: CATEGORES_ElectronicDevice,
        token: CacheHelper.getStringFromCache("token"),
      );

      categories_detalies = Categories_Detalies.fromJson(response.data);

      if (categories_detalies?.status == true) {
        emit(GetCategoryElectronicDeviceSucess());
      } else {
        emit(GetCategoryElectronicDeviceError());
      }
    } catch (error) {
      emit(GetCategoryElectronicDeviceError());
    }
  }

  void getCategoryFightingCorona() async {
    emit(GetCategoryFlightingCoronaLoading());

    try {
      Response response = await DioHelper.getRequest(
        endpoint: CATEGORES_FlightingCorona,
        token: CacheHelper.getStringFromCache("token"),
      );

      categories_detalies = Categories_Detalies.fromJson(response.data);

      if (categories_detalies?.status == true) {
        emit(GetCategoryFlightingCoronaSucess());
      } else {
        emit(GetCategoryFlightingCoronaError());
      }
    } catch (error) {
      emit(GetCategoryFlightingCoronaError());
    }
  }

  void getCategorySport() async {
    emit(GetCategorySportLoading());

    try {
      Response response = await DioHelper.getRequest(
        endpoint: CATEGORES_Sport,
        token: CacheHelper.getStringFromCache("token"),
      );

      categories_detalies = Categories_Detalies.fromJson(response.data);

      if (categories_detalies?.status == true) {
        emit(GetCategorySportSucess());
      } else {
        emit(GetCategorySportError());
      }
    } catch (error) {
      emit(GetCategorySportError());
    }
  }

  void getCategoryLightingtools() async {
    emit(GetCategorySportLoading());

    try {
      Response response = await DioHelper.getRequest(
        endpoint: CATEGORES_Lightingtools,
        token: CacheHelper.getStringFromCache("token"),
      );

      categories_detalies = Categories_Detalies.fromJson(response.data);

      if (categories_detalies?.status == true) {
        emit(GetCategorySportSucess());
      } else {
        emit(GetCategorySportError());
      }
    } catch (error) {
      emit(GetCategorySportError());
    }
  }

  void getCategoryClothes() async {
    emit(GetCategoryClothesLoading());

    try {
      Response response = await DioHelper.getRequest(
        endpoint: CATEGORES_Clothes,
        token: CacheHelper.getStringFromCache("token"),
      );

      categories_detalies = Categories_Detalies.fromJson(response.data);

      if (categories_detalies?.status == true) {
        emit(GetCategoryClothesSucess());
      } else {
        emit(GetCategoryClothesError());
      }
    } catch (error) {
      emit(GetCategoryClothesError());
    }
  }

  void getCategoryGroceries() async {
    emit(GetCategoryGroceriesLoading());

    try {
      Response response = await DioHelper.getRequest(
        endpoint: CATEGORES_Groceries,
        token: CacheHelper.getStringFromCache("token"),
      );

      categories_detalies = Categories_Detalies.fromJson(response.data);

      if (categories_detalies?.status == true) {
        emit(GetCategoryGroceriesSucess());
      } else {
        emit(GetCategoryLightingtoolsError());
      }
    } catch (error) {
      emit(GetCategoryGroceriesError());
    }
  }

  void changeProductFavourite({
    required int id,
  }) async {
    favmap[id] = !favmap[id]!;

    try {
      Response response = await DioHelper.postRequest(
        endpoint: FAVOURITES,
        token: CacheHelper.getStringFromCache("token"),
        data: {
          "product_id": id,
        },
      );

      if (response.data["status"] == true) {
        emit(ChangeProductFavouriteSuccessfully());
      } else {
        favmap[id] = !favmap[id]!;
        emit(ChangeProductFavouriteError());
      }
    } catch (error) {
      print("Error in changeProductFavourite: $error");
      favmap[id] = !favmap[id]!;
      emit(ChangeProductFavouriteError());
    }
  }

  void getallfavourit() async {
    emit(GetFavouritesLoading());
    Response r = await DioHelper.getRequest(
      endpoint: "favorites",
      token: CacheHelper.getStringFromCache("token"),
    );
    favouriteModel = FavouriteModel.fromJson(r.data);
    if (favouriteModel!.status!) {
      emit(GetFavouritesSuccess());
    } else {
      emit(GetFavouritesError());
    }
  }

  void changeProductCart({required int id}) async {
    Cartmap[id] = Cartmap[id] ?? false;

    Cartmap[id] = !Cartmap[id]!;

    try {
      Response response = await DioHelper.postRequest(
        endpoint: CART,
        token: CacheHelper.getStringFromCache("token"),
        data: {
          "product_id": id,
        },
      );

      if (response.data["status"] == true) {
        emit(ChangeProductCartSuccessfully());
      } else {
        Cartmap[id] = !Cartmap[id]!;
        emit(ChangeProductCartError());
      }
    } catch (error) {
      print("Error in changeProductCart: $error");

      Cartmap[id] = !Cartmap[id]!;
      emit(ChangeProductFavouriteError());
    }
  }

  void getallCarts() async {
    emit(GetCartLoading());

    try {
      Response r = await DioHelper.getRequest(
        endpoint: "carts",
        token: CacheHelper.getStringFromCache("token"),
      );

      cartModel = CartModel.fromJson(r.data);

      if (cartModel?.status == true) {
        emit(GetCartSucess());
      } else {
        emit(GetCartError());
      }
    } catch (error) {
      print("Error in getallCarts: $error");
      emit(GetCartError());
    }
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(UpdateUserDataLoading());

    try {
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'phone': phone,
      };

      Response response = await DioHelper.putRequest(
        endpoint: UPADATED_PROFILE,
        token: CacheHelper.getStringFromCache("token"),
        data: data,
      );

      var responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      userModel = UserModel.fromJson(responseData);

      emit(UpdateUserDataSuccess(userModel));
    } catch (error) {
      emit(UpdateUserDataError(error.toString()));
    }
  }
}
