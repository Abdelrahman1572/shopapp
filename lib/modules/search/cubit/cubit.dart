import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/component/Constants.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  List<SearchModel> allSearchProducets = [];

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      value.data["data"]["data"].forEach((element) {
        allSearchProducets.add(SearchModel.fromJson(element));
      });
      print("🐱‍👤 the lenght of the lest is : ${allSearchProducets.length}");
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
