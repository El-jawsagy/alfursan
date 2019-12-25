import 'dart:async';

import 'package:al_fursan/tours/tour.dart';
import 'package:al_fursan/utilities/disposable.dart';

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
