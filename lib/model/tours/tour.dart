class Tour {
  int id;
  String slug;
  String nameEn;
  String nameAr;
  String imageName;

  Tour(this.id, this.slug, this.nameEn, this.nameAr, this.imageName);

  Tour.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];
    this.slug = jsonObject['slug'];
    this.nameEn = jsonObject['name_en'];

    this.nameAr = jsonObject['name_ar'];
    this.imageName = jsonObject['image_name'];
  }
}
