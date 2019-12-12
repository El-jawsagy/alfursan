import 'package:al_fursan/model/category/category.dart';

class CategoryController {
  List<Category> allCategory;

  CategoryController(this.allCategory);

  CategoryController.fromjson(List<Map<String,dynamic>> jsonObject) {
    allCategory=[];
    for(var category in jsonObject){
      this.allCategory.add(Category.fromJson(category));
    }
  }

}
