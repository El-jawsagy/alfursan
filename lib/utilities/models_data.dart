import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemes {
  ThemeData appTheme = ThemeData();
}

class AppColors {
  static const Color witheBG = Colors.white;
  static const Color grey = Colors.grey;
  static const Color darkBG = Color(0xff01082F);

  static const Color darkWithOpen1BG = Color(0xff614ad3);
  static const Color blueToWhite = Color(0xffEDF2FA);
  static const Color darkWithOpen2BG = Color(0xff01082F);

  static const Color shadow = Colors.black12;
  static const Color darkShadow = Colors.black45;
  static const Color s = Colors.black12;
}

//model to built list form it
class Page {
  String pageName;
  String pageRout;
  IconData icon;

  Page(this.pageName, this.pageRout, this.icon);
}

//function to built list of pages and return it in Drawer screen to use it
List<Page> allAppPages(bool language) {
  List<Page> pages = [];
  pages.add(Page(
      language ? "الصفحة الرئيسية" : "Home", '/home', FontAwesomeIcons.home));

  pages.add(
      Page(language ? "الرحلات" : "Tours", '/tours', FontAwesomeIcons.plane));
  pages.add(Page(
      language ? "تاشيرات الدخول" : "Visa", '/visa', FontAwesomeIcons.ccVisa));
  pages.add(Page(language ? "اتصل بنا" : "Contact Us", '/contactUs',
      FontAwesomeIcons.solidEnvelope));
  pages.add(Page(language ? "معلومات عنا" : "About US", '/aboutUs',
      FontAwesomeIcons.solidQuestionCircle));
  pages.add(Page(language ? "معرض" : "Gallery", '/gallery',
      FontAwesomeIcons.photoVideo));
  return pages;
}

// list of string in arabic to used in About us screen
List<Map<String, String>> aboutUsAr = [
  {
    'Title': "شركتنا",
    'description': "أن شركتنا ليست الشركة الوحيدة العاملة في هذا المجال"
        " ولاكنا نفتخر بأننا من الشركات المتميزة في مصداقيتها بالعمل والالتزام العالي في تأديه أفضل الخدمات للزبائن"
  },
  {
    'Title': "تأسيس الشركة",
    'description':
        "شركة الفرسان للسفر والسياحة إحدى الشركات العاملة في قطاع السفر والسياحة والنقل في جمهورية العراق تأسست الشركة في تاريخ 11 أيار 2004 من وزارة التجارة قسم مسجل الشركات واستحصلت على أجازة مزاولة المهنة من وزارة السياحة والآثار / هيئة السياحة في تاريخ 2 تشرين الثاني 2005 وأصبحت عضوا في رابطة مكاتب السفر والسياحة في نفس السنة تم فتح فرع جديد للشركة وتم ذلك بتأسيس فرعها الجديد في تاريخ 16 أيار 2012 لتقديم الخدمات بشكل أوسع ولخدمة رقعة جغرافية اكبر في العاصمة بغداد"
  },
  {
    'Title': "كادر الشركة",
    'description':
        "تتمتع الشركة بكادر اكثر من مميز يمتلك خبرة ممتازة على صعيد التسويق والمبيعات وعلى مستوى عالي من المهنية (وفقا لعملية وانظمة المحاسبة الحديثة بشكل متطور يلائم IATA استطلاع اراء المسافرين) حيث اكملو دورات متقدمة على انظمة الحجز الالي ُودورات حركة النقل والطيران وصناعة السياحة التي تشهد نمو متواصل في داخل جمهورية العراق وخارجه وللعلم ان مالك الشركة هو .نفسه المدير المفوض لها وبالتالي انعكس هذا على الشركة بالاستقرار الاداري والأستراتيجية للتطور والتصاعد في الأداء"
  },
];

// list of string in english to used in About us screen
List<Map<String, String>> aboutUsEn = [
  {
    'Title': "our company",
    'description':
        "Our company is not the only company working in this field but we are proud to be one of the companies which are known for their credibility in work and high commitment in performing best customer services"
  },
  {
    'Title': "Establishment of the company",
    'description':
        "Al Fursan Travel and Tourism is one of the companies that works in the tourism and transport sector in the Republic of Iraq. The company was founded in 11 May 2004 and it was approved by Ministry of Commerce, Department of Company Registry who offered them to practice the profession of the Ministry of Tourism and Antiquities / Tourism Authority on November 2, 2005 and became a member of the Association of offices of travel and tourism in the same year . After that we create a new branch for the company that was established on May 16, 2012 that provides services in a wider geographical area and mostly in the capital Baghdad"
  },
  {
    'Title': "Company Staff",
    'description':
        "The company has a more distinguished cadre with excellent marketing, sales and professional experience (according to the Passenger Survey), where they completed advanced courses on automated booking systems, IATA courses and modern accounting systems in a sophisticated manner suitable for transport, aviation and tourism industry which is witnessing continuous growth in Inside and outside the Republic of Iraq, knowing that the owner of the company is the same as the authorized director and therefore reflected on the company's administrative stability and strategic development and the rise in performance."
  },
];

// list of image to used in homePage screen

List<String> image = [
  'assets/images/img01.jpg',
  'assets/images/img02.jpg',
  'assets/images/img03.jpg',
];

Map<String, dynamic> contactFirstAr = {
  'Branch': "الفرع الرئيسي",
  'address':
      " جمهورية العراق – بغداد – الكاظمية –شارع 17 – مجاور الجامع الهاشمي",
  "number": "+964 7702 756666",
  "email": "info@alfursantravel.com",
};
Map<String, dynamic> contactSecondAR = {
  'Branch': "الفرع الثاني",
  'address': "جمهورية العراق – بغداد – المنصور – مقابل مول المنصور",
  "number": " +964 7801 750800",
  "email": "info@alfursantravel.com",
};

Map<String, dynamic> contactFirstEN = {
  'Branch': "Main Branch",
  'address': "Alkadhumia, 17th Street, Baghdad, Iraq",
  "number": "+964 7702 756666",
  "email": "info@alfursantravel.com",
};
Map<String, dynamic> contactSecondEN = {
  'Branch': "2nd Branch:",
  'address': "Almansour in front of Almansour Mall Baghdad, Iraq",
  "number": " +964 790 1335216",
  "email": "info@alfursantravel.com",
};
