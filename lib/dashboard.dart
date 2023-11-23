import 'package:flutter/material.dart';
import 'package:mu_card/connection.dart';
import 'package:mu_card/login/welcomename.dart';

import 'package:mu_card/mycards.dart';
import 'package:mu_card/profiles.dart';

import 'drawer.dart';
import 'notifications.dart';

int pageNumber = 0;

class Dashboard extends StatefulWidget {
  static int userId = 0;
  static int businessId = 0;
  Dashboard({super.key, required int userId}) {
    Dashboard.userId = userId;
  }

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        // stops: [0.5, 0.5],
        colors: [
          Color.fromARGB(255, 50, 190, 255),
          Colors.white,
        ],
      )),
      child: Scaffold(
        drawer: DrawerMenu(userId: Dashboard.userId),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(2, 3.5, 0, 3.5),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 167, 167, 167)),
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(26, 39, 39, 39),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.double_arrow_rounded,
                      color: Color.fromARGB(255, 9, 0, 103),
                      size: 30,
                    ),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              );
            },
          ),
          centerTitle: true,
          title: Text(
            'MU CARD APP',
            style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 9, 0, 103)),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: const [
                    Color.fromARGB(255, 169, 255, 255),
                    Color.fromARGB(255, 0, 255, 251),
                  ]),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 3.5, 2, 3.5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Color.fromARGB(255, 167, 167, 167)),
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(26, 39, 39, 39),
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Notifications()),
                          ((route) => true));
                    },
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.amber,
                      size: 30,
                    )),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 90,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (pageNumber == 1) ...[
                  Profiles(userId: Dashboard.userId),
                ],
                if (pageNumber == 2) ...[
                  Connection(),
                ],
                if (pageNumber == 0) ...[
                  MyCards(),
                ],
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 27, 0, 136)),
                        color: Color.fromARGB(55, 111, 255, 236),
                        borderRadius: BorderRadius.circular(12)),
                    height: 70,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (pageNumber == 0) ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromARGB(255, 27, 0, 136)),
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.credit_card,
                                    size: 30,
                                    color: Colors.amber,
                                  ),
                                  label: Text(
                                    'My Cards',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Times New Roman'),
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12)),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pageNumber = 0;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.credit_card,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          if (pageNumber == 1) ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromARGB(255, 27, 0, 136)),
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.perm_contact_calendar_sharp,
                                    size: 30,
                                    color: Colors.amber,
                                  ),
                                  label: Text(
                                    'Profiles',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Times New Roman'),
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12)),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pageNumber = 1;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.perm_contact_calendar_sharp,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          if (pageNumber == 2) ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromARGB(255, 27, 0, 136)),
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.connect_without_contact,
                                    size: 30,
                                    color: Colors.amber,
                                  ),
                                  label: Text(
                                    'Connection',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Times New Roman'),
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12)),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pageNumber = 2;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.connect_without_contact,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
