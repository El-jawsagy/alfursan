class Visa {
  int id;
  String visaSlug;
  String nameEn;
  String nameAr;
  String price;
  String requirementsAr;
  String requirementsEn;
  String descriptionEn;
  String descriptionAr;
  String status;
  String image;

  Visa(
      this.id,
      this.visaSlug,
      this.nameEn,
      this.nameAr,
      this.price,
      this.requirementsAr,
      this.requirementsEn,
      this.descriptionEn,
      this.descriptionAr,
      this.status,
      this.image);

  Visa.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];
    this.visaSlug = jsonObject['slug'];
    this.nameEn = jsonObject['title_en'];
    this.nameAr = jsonObject['title_ar'];
    this.price = jsonObject['price'];
    this.requirementsAr = jsonObject['rquirements_ar'];
    this.requirementsEn = jsonObject['rquirements_en'];
    this.descriptionEn = jsonObject['description_en'];
    this.descriptionAr = jsonObject['description_ar'];
    this.status = jsonObject['status_en'];
    this.image = jsonObject['image_name'];
  }
}
