import 'dart:async';

import 'package:al_fursan/model/category/category.dart';
import 'package:al_fursan/model/disposable.dart';

class AllCategoryBloc implements Disposable {
  String typeOfCategory;
  List<Category> allCategory;
  final StreamController<List<Category>> _categoriesController =
      StreamController<List<Category>>();
  final StreamController<String> _categoryTypeController =
      StreamController<String>();

  Stream<List<Category>> get categoryStream => _categoriesController.stream;

  StreamSink<String> get fetchCategory => _categoryTypeController.sink;

  Stream<String> get categories => _categoryTypeController.stream;

  AllCategoryBloc(String categoryPath) {
    this.typeOfCategory = categoryPath;
    allCategory = [];
    _categoriesController.add(allCategory);
    _categoryTypeController.add(this.typeOfCategory);
    _categoryTypeController.stream.listen(_fetchCategoriesFromApi);
  }

  void _fetchCategoriesFromApi(String category) {}
  
  @override
  void dispose() {
    _categoriesController.close();
    _categoryTypeController.close();
    // TODO: implement dispose
  }
}
