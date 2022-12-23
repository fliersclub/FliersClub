import 'package:fliersclub/screens/ClubScreens/tournament_list.dart';
import 'package:fliersclub/screens/ClubScreens/tournament_screen1.dart';
import 'package:fliersclub/screens/ClubScreens/umpire_approved.dart';
import 'package:fliersclub/screens/ClubScreens/umpire_pending.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClubAdminHome extends StatefulWidget {
  const ClubAdminHome({super.key});

  @override
  State<ClubAdminHome> createState() => _ClubAdminHomeState();
}

class _ClubAdminHomeState extends State<ClubAdminHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: TabBar(tabs: [
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
          body: TabBarView(children: [
            TournamentList(),
            UmpireApproved(),
            UmpirePending(),
          ]),
        ),
      ),
    );
  }
}
