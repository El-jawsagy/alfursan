class Notifications {
  int id;
  String titleEn;
  String titleAR;
  String type;
  String seen;


  Notifications(
      this.id,
      this.titleEn,
      this.titleAR,
      this.type,
      this.seen,
      );

  Notifications.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];
    this.titleEn = jsonObject['title_en'];
    this.titleAR = jsonObject['title_ar'];
    this.type = jsonObject['type'];
    this.seen= jsonObject['seen'];

  }
}
