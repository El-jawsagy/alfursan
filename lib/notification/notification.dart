class Notifications {
  int id;
  String titleEn;
  String titleAR;
  String type;
  String seen;
  String time;
  String messageEn;
  String messageAr;

  Notifications(
    this.id,
    this.titleEn,
    this.titleAR,
    this.type,
    this.seen,
    this.time,
    this.messageAr,
    this.messageEn,
  );

  Notifications.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];
    this.titleEn = jsonObject['title_en'];
    this.titleAR = jsonObject['title_ar'];
    this.type = jsonObject['type'];
    this.seen = jsonObject['seen'];
    this.time = jsonObject['created_at'];
    this.messageAr = jsonObject['message_ar'];
    this.messageEn = jsonObject['message_en'];
  }
}
