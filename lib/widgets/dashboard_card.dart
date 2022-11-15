import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DashboardCard extends StatelessWidget {
  String title;
  String count;
  DashboardCard({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan[50],
      shadowColor: Colors.black,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          count,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
