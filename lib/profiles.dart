import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mu_card/createbusinessprofile.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:mu_card/dashboard.dart';
import 'package:mu_card/mycards.dart';
import 'package:mu_card/profile_detail.dart';
import 'apiConnection/apiConnection.dart';

class Profiles extends StatefulWidget {
  static int userId = 0;
  Profiles({super.key, required int userId}) {
    // ignore: prefer_initializing_formals
    Profiles.userId = userId;
  }

  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  List<Map<String, dynamic>> profiles = [];
  int activeIndex = -1;

  Future<void> createProfile() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  'Select Your Profile Type',
                  style: TextStyle(color: Colors.black, fontSize: 21),
                )),
              ),
              const Center(
                  child: Text(
                'Create your profile and start connecting',
                style: TextStyle(color: Colors.black, fontSize: 15),
              )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.grey),
                                    child: IconButton(
                                        onPressed: () {
                                          Get.to(CreateBusinessProfile(
                                              userId: Profiles.userId));
                                        },
                                        icon: const Icon(
                                          Icons.business_center,
                                          size: 40,
                                        )),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Text(
                                      'Business',
                                      style: TextStyle(
                                          fontFamily: 'Times New Roman',
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    FetchBusiness();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(
                      Icons.business,
                      color: Colors.blue,
                      size: 40,
                    ),
                    title: Text(
                      profiles[index]['businessName'],
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          MyCards.cardSelected = true;
                          MyCards.businessId =
                              int.parse(profiles[index]['businessId']);
                          MyCards.title = profiles[index]['businessName'];
                          activeIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary:
                            activeIndex == index ? Colors.green : Colors.grey,
                        onPrimary: Colors.white,
                      ),
                      child: const Text('Active'),
                    ),
                    onTap: () {
                      Get.to(() => ProfileDetails(
                          userId: Profiles.userId,
                          businessId:
                              int.parse(profiles[index]['businessId'])));
                    },
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: createProfile,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 20, 20, 20),
            foregroundColor: Colors.white,
          ),
          child: const Text(
            '+ Create Profile',
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 20,
              fontFamily: 'Times New Roman',
            ),
          ),
        ),
      ],
    );
  }

  Future<void> FetchBusiness() async {
    print(Profiles.userId);
    final apiUrl = '${API.getBusinessName}?userId=${Profiles.userId}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['businessData'] != null) {
          List<Map<String, dynamic>> extractedProfiles = [];
          for (var item in data['businessData']) {
            extractedProfiles.add({
              'businessId': item['businessId'].toString(),
              'businessName': item['businessName'].toString(),
            });
          }

          setState(() {
            profiles = extractedProfiles;
          });
        } else {
          print('No business names found for the user.');
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
