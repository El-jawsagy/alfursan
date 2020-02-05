class Video {
  int id;
  String titleAR;
  String titleEN;
  String linkAR;
  String linkEN;

  Video(this.id, this.titleAR, this.titleEN, this.linkAR, this.linkEN);

  Video.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject["id"];
    this.titleAR = jsonObject["title_ar"];
    this.titleEN = jsonObject["title_en"];
    this.linkAR = jsonObject["link_ar"];
    this.linkEN = jsonObject["link_en"];
  }
}


