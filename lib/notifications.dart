import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 255, 251),
              Colors.white,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Padding(
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
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 9, 0, 103),
                    size: 30,
                  ),
                ),
              ),
            ),
            centerTitle: true,
            title: Text(
              'Notifications',
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
          ),
          body: Center(
            child: Text('No Notifications Are There'),
          ),
        ));
  }
}
