import 'dart:async';

import 'package:al_fursan/model/category/category.dart';
import 'package:al_fursan/model/disposable.dart';
import 'package:al_fursan/model/tours/tour.dart';

class AllCategoryBloc implements Disposable {
  String typeOfCategory;
  List<Tour> allTours;
  final StreamController<List<Tour>> _toursController =
  StreamController<List<Tour>>();
  final StreamController<String> _categoryController =
  StreamController<String>();

  Stream<List<Tour>> get categoryStream =>_toursController.stream;
  @override
  void dispose() {
    _toursController.close();
    _categoryController.close();
    // TODO: implement dispose
  }
}
