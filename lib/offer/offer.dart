class Offer {
  int id;
  String slug;
  String nameEn;
  String nameAr;
  String imageName;
  String informationAr;
  String informationEn;
  String programAr;
  String programEn;
  String offerAR;
  String offerEn;
  String file;
  int ticketSinglePrice;
  int ticketTreblePrice;
  int ticketChd2Price;
  int ticketChd6Price;
  int ticketInfantPrice;
  String visaPrice;
  String includeAr;
  String includeEn;
  String excludeAr;
  String excludeEn;

  Offer(
      this.id,
      this.slug,
      this.nameEn,
      this.nameAr,
      this.offerAR,
      this.offerEn,
      this.imageName,
      this.informationAr,
      this.informationEn,
      this.programAr,
      this.programEn,
      this.file,
      this.ticketSinglePrice,
      this.ticketTreblePrice,
      this.ticketChd2Price,
      this.ticketChd6Price,
      this.ticketInfantPrice,
      this.visaPrice,
      this.excludeAr,
      this.excludeEn,
      this.includeAr,
      this.includeEn,
      );

  Offer.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];
    this.slug = jsonObject['slug'];
    this.nameEn = jsonObject['name_en'];
    this.nameAr = jsonObject['name_ar'];
    this.offerAR = jsonObject['offer_title_ar'];
    this.offerEn = jsonObject['offer_title_en'];
    this.imageName = jsonObject['image_name'];
    this.informationAr = jsonObject['info_ar'];
    this.informationEn = jsonObject['info_en'];
    this.programAr = jsonObject['program_ar'];
    this.programEn = jsonObject['program_en'];
    this.file =jsonObject['file'];
    this.ticketSinglePrice = jsonObject['tkt_single_price'];
    this.ticketTreblePrice = jsonObject['tkt_trible_price'];
    this.ticketChd2Price = jsonObject['tkt_chd2_price'];
    this.ticketChd6Price = jsonObject['tkt_chd6_price'];
    this.ticketInfantPrice = jsonObject['tkt_enf_price'];
    this.visaPrice =jsonObject['price'];
    this.includeAr =jsonObject['include_ar'];
    this.includeEn =jsonObject['exclude_ar'];
    this.excludeAr =jsonObject['exclude_ar'];
    this.excludeAr =jsonObject['exclude_en'];
  }
}
