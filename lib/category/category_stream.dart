import 'dart:async';

import 'package:al_fursan/utilities/disposable.dart';

import 'category.dart';
import 'category_api.dart';
//class AllCategoryBloc implements Disposable {
//  CategoryApi categoryApi;
//  List<Category> allCategory;
//  final StreamController<List<Category>> _categoriesController =
//  StreamController<List<Category>>.broadcast();
//
//
//  Stream<List<Category>> get categoryStream => _categoriesController.stream;
//  StreamSink<List<Category>> get categorySink => _categoriesController.sink;
//
//
//  AllCategoryBloc() {
//    categoryApi =CategoryApi();
//    allCategory = [];
//    _categoriesController.add(allCategory);
//    _categoriesController.stream.listen( fetchCategoriesFromApi );
//
//  }
//
// Future<List<AllCategoryBloc>> fetchCategoriesFromApi() async{
//    this.allCategory =await categoryApi.fetchCategory();
//    _categoriesController.add(this.allCategory);
//  }
//
//  @override
//  void dispose() {
//    _categoriesController.close();
//    // TODO: implement dispose
//  }
//}

class AllCategoryBloc implements Disposable {
  CategoryApi categoryApi;
  List<Category> allCategory;
  final StreamController<List<Category>> _allCategoriesController =
      StreamController<List<Category>>.broadcast();
  final StreamController<String> _demoController =
      StreamController<String>.broadcast();

  Stream<List<Category>> get categoryStream => _allCategoriesController.stream;

  StreamSink<String> get fetchAllCategory => _demoController.sink;

  Stream<String> get categories => _demoController.stream;

  AllCategoryBloc() {
    categoryApi =CategoryApi();
    allCategory = [];
    _allCategoriesController.add(allCategory);
    _demoController.stream.listen(_fetchCategoriesFromApi);
  }

  Future<void> _fetchCategoriesFromApi(String string) async {
    this.allCategory =await categoryApi.fetchCategory();
    _allCategoriesController.add(this. allCategory);
  }

  @override
  void dispose() {
    _allCategoriesController.close();
    _demoController.close();
    // TODO: implement dispose
  }
}
