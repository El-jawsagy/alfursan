import 'package:al_fursan/model/tours/tour.dart';
import 'package:flutter/material.dart';

class SingleTourScreen extends StatefulWidget {
  Tour singleTour;

  SingleTourScreen(this.singleTour);

  @override
  _SingleTourScreenState createState() => _SingleTourScreenState();
}

class _SingleTourScreenState extends State<SingleTourScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(widget.singleTour.nameAr),
        ),
      ),
    );
  }
}
