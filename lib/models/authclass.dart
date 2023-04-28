
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAuth{
  List data_user = [];
  var user_id;
  var data_name;
  var profile_url;
 
  List data = [];
  get_data_user(id) async {
    DocumentReference users =
        FirebaseFirestore.instance.collection('users').doc(id);
    var response = await users.get();
    user_id = id;
   
      data_user.add(response.data());
      data_name = data_user[0]['name'];     
      profile_url = data_user[0]['image'];
   
  }

 


}