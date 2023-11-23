// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:nfc_manager/nfc_manager.dart';

class MyCards extends StatefulWidget {
  static int businessId = 0;
  static bool cardSelected = false;
  static String title = '';
  MyCards({super.key});

  @override
  State<MyCards> createState() => _MyCardsState();
}

bool containerMain = true;

class _MyCardsState extends State<MyCards> with SingleTickerProviderStateMixin {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Share NFC Card App',
        text: 'Share NFC Card App',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Share NFC Card App');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showMoreMenu() async {
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    showSnackBar('This device doesnt support NFC');
                  },
                  child: const Center(
                    child: Text(
                      'Write Physical Card',
                      style: TextStyle(
                          fontFamily: 'Times New Roman',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Divider(),
                SimpleDialogOption(
                  onPressed: () {
                    print(MyCards.businessId);
                  },
                  child: const Center(
                    child: Text(
                      'Delete Card',
                      style: TextStyle(
                          fontFamily: 'Times New Roman',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          });
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'My Cards',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 2, 54),
                fontSize: 24,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.w500),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Card Label : ',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 2, 54),
                    fontSize: 15,
                    fontFamily: 'Times New Roman',
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Card',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 42, 0),
                    fontSize: 15,
                    fontFamily: 'Times New Roman',
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                border: Border.all(color: Colors.black),
                color: Colors.black),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 225,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 0, 30, 255),
                              Color.fromARGB(255, 79, 79, 79),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(21),
                          color: Colors.grey,
                        ),
                      ),
                      MyCards.cardSelected
                          ? Text(
                              MyCards.title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'No profile is active on card',
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: IconButton(
                                      onPressed: () {
                                        share();
                                      },
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                        size: 27,
                                      ))),
                            ),
                            const Text('Share',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: IconButton(
                                      onPressed: () {
                                        NfcManager.instance.startSession(
                                            onDiscovered: (NfcTag tag) async {
                                          var ndef = Ndef.from(tag);
                                          if (ndef == null ||
                                              !ndef.isWritable) {
                                            showSnackBar(
                                                'Tag is not ndef writable');
                                            NfcManager.instance.stopSession(
                                                errorMessage:
                                                    'Tag is not ndef writable');
                                            return;
                                          }

                                          String link = 'www.youtube.com';

                                          NdefMessage message = NdefMessage([
                                            NdefRecord.createUri(
                                                Uri.parse(link)),
                                          ]);

                                          try {
                                            await ndef.write(message);
                                            showSnackBar(
                                                'Success writing link to NFC');
                                            NfcManager.instance.stopSession();
                                          } catch (e) {
                                            showSnackBar(
                                                'Error writing to NFC: $e');
                                            NfcManager.instance.stopSession(
                                                errorMessage:
                                                    'Error writing to NFC: $e');
                                            return;
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.nfc,
                                        color: Colors.white,
                                        size: 27,
                                      ))),
                            ),
                            const Text(
                              'NFC',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Times New Roman',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: IconButton(
                                      onPressed: () {
                                        showMoreMenu();
                                      },
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                        size: 27,
                                      ))),
                            ),
                            const Text('More',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Active Profile on this card.',
                      style: TextStyle(
                          color: Colors.amber[900],
                          fontFamily: 'Times New Roman',
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  MyCards.cardSelected
                      ? Padding(
                          padding: EdgeInsets.all(1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Profile selected: ${MyCards.title}',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 195, 187, 181),
                                    fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No profile selected ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 195, 187, 181),
                                    fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  showSnackBar(String message) {
    var SnackBarVariable = SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        behavior: SnackBarBehavior.floating,
        width: 300,
        duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(SnackBarVariable);
  }
}
