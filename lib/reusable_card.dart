import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({this.cardChild});

  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF171717),
          //color: Colors.grey[900],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: cardChild,
          ),
        ),
      ),
    );
  }
}
