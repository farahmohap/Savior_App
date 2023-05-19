import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../models/authclass.dart';
import '../../models/getdata.dart';

class TeamMembersView extends StatelessWidget {
  TeamMembersView({super.key});
  final storage = FirebaseStorage.instance;
  GetAuth getAuth = GetAuth();
  List images_URL = [];

  // get_images_url() async {
  //   final ref = storage.ref().child('images');
  //   final ListResult result = await ref.listAll();
  //   final List All_files = result.items;
  //   for (final ref in All_files) {
  //     final url = await ref.getDownloadURL();
  //     images_URL.add(url);
  //   }
  //   print(images_URL);
  // }
  getAllNames() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    final URL = await querySnapshot.docs
        .map((doc) => doc.data()['image'] as String)
        .toList();
    images_URL = URL as List;
  }

  @override
  void initState() {
    // GetData.getData();
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userId = user?.uid;

    GetAuth getAuth = GetAuth();
    getAuth.get_data_user(userId);

    // Future.delayed(Duration.zero, () {
    //   GetData.hrate(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllNames(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images_URL.length,
              itemBuilder: ((context, index) {
                return Row(
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              image: new NetworkImage(images_URL[index]),
                            ))),
                    SizedBox(
                      width: 5,
                    )
                  ],
                );
              }));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
