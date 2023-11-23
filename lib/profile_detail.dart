import 'package:flutter/material.dart';

class ProfileDetails extends StatefulWidget {
  static int userId = 0;
  static int businessId = 0;
  ProfileDetails({super.key, required int userId, required businessId}) {
    ProfileDetails.businessId = businessId;
    ProfileDetails.userId = userId;
  }

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(
          "UserId : " + ProfileDetails.userId.toString(),
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "BusinessId : " + ProfileDetails.businessId.toString(),
          style: TextStyle(fontSize: 20),
        )
      ],
    ));
  }
}
