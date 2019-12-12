class Images {
  int id;

  String imagePath;

  Images(this.id, this.imagePath);

  Images.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject["id"];
    this.imagePath = jsonObject["image_filename"];
  }
}
