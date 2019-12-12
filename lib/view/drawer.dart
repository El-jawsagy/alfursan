import 'package:al_fursan/view/utilities/models_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  bool language;

  DrawerScreen(this.language);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.darkWithOpen1BG,
                AppColors.darkBG,
                AppColors.darkWithOpen1BG,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            ),
            ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: <Widget>[
              _drawRowUser(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              _drawColumnOfButtonsForNav(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawRowUser() {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
          maxHeight: MediaQuery.of(context).size.height * 0.4),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            backgroundImage:
                ExactAssetImage("assets/images/profile-image.jpg", scale: 1),
            radius: 30,
          ),
          Text(
            "VadeCom Organization",
            style: TextStyle(
              color: AppColors.witheBG,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _drawColumnOfButtonsForNav() {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
          maxHeight: MediaQuery.of(context).size.height * 0.85),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.85,
      child: ListView.builder(
        itemBuilder: (context, pos) {
          List<Page> pages = allAppPages(widget.language);
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, pages[pos].pageRout);
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListTile(
                title: Text(
                  pages[pos].pageName,
                  style: TextStyle(color: AppColors.witheBG, fontSize: 18),
                ),
                leading: Icon(
                  pages[pos].icon,
                  color: AppColors.witheBG,
                ),
                trailing: Icon(
                  FontAwesomeIcons.arrowCircleRight,
                  color: AppColors.witheBG,
                ),
              ),
            ),
          );
        },
        itemCount: 6,
      ),
    );
  }
}
