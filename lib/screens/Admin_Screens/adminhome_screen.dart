import 'package:carousel_slider/carousel_slider.dart';
import 'package:fliersclub/screens/Admin_Screens/approved_screen.dart';
import 'package:fliersclub/screens/Admin_Screens/dash_screen.dart';
import 'package:fliersclub/screens/Admin_Screens/pending_screen.dart';
import 'package:fliersclub/widgets/dashboard_card.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: TabBar(
              indicatorColor: Colors.blueGrey,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.dashboard_rounded,
                    color: Colors.teal,
                  ),
                  text: 'Dashboard',
                ),
                Tab(
                  text: 'Approved',
                  icon: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.pending_actions_outlined,
                    color: Colors.red,
                  ),
                  text: 'Pending',
                )
              ]),
          body: TabBarView(
            children: [DashScreen(), ApprovedScreen(), PendingScreen()],
          )),
    );
  }
}
