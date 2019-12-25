class Category {
  int id;
  String catSlug;

  String nameEn;
  String nameAr;
  String descriptionEn;
  String descriptionAr;
  String status;
  String image;

  Category(this.id, this.catSlug, this.nameEn, this.nameAr, this.descriptionEn,
      this.descriptionAr, this.status, this.image);

  Category.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];
    this.catSlug = jsonObject['slug'];
    this.nameEn = jsonObject['name_en'];
    this.nameAr = jsonObject['name_ar'];
    this.descriptionEn = jsonObject['description_en'];
    this.descriptionAr = jsonObject['description_ar'];
    this.status = jsonObject['active'];
    this.image = jsonObject['image_name'];
  }
}
