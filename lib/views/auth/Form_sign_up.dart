import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Form_sign_up extends StatefulWidget {
  const Form_sign_up({Key? key}) : super(key: key);

  @override
  State<Form_sign_up> createState() => _Form_sign_upState();
}

class _Form_sign_upState extends State<Form_sign_up> {
  var email = TextEditingController();
  var password = TextEditingController();
  var confirm_password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var age = TextEditingController();
  var adress = TextEditingController();
  var national_id = TextEditingController();
  var data_email;
  var data_name;
  var data_phone;
  var data_age;
  var data_national_id;
  var data_password;
  var data_confirm_password;
  var data_adress;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.all(35),
        child: Form(
            child: Column(
          children: [
            TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 7, 7, 7), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 12, 12, 12), width: 3)),
                ),
                keyboardType: TextInputType.name),
            SizedBox(height: 20),
            TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 7, 7, 7), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 12, 12, 12), width: 3)),
                ),
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: 20),
            TextFormField(
                controller: phone,
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 7, 7, 7), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 12, 12, 12), width: 3)),
                ),
                keyboardType: TextInputType.phone),
            SizedBox(height: 20),
            TextFormField(
                controller: national_id,
                decoration: const InputDecoration(
                  hintText: "National Id",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 7, 7, 7), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 12, 12, 12), width: 3)),
                ),
                keyboardType: TextInputType.number),
            SizedBox(height: 20),
            TextFormField(
                controller: age,
                decoration: const InputDecoration(
                  hintText: "Age",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 7, 7, 7), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 12, 12, 12), width: 3)),
                ),
                keyboardType: TextInputType.number),
            SizedBox(height: 20),
            TextFormField(
                controller: adress,
                decoration: const InputDecoration(
                  hintText: "Age",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 7, 7, 7), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 12, 12, 12), width: 3)),
                ),
                keyboardType: TextInputType.number),
            SizedBox(height: 20),
            TextFormField(
                controller: password,
                decoration: const InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 13, 13), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 13, 13), width: 3)),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true),
            SizedBox(height: 20),
            TextFormField(
                controller: confirm_password,
                decoration: const InputDecoration(
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 13, 13), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 13, 13), width: 3)),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () async {
                data_password = password.text;
                data_confirm_password = confirm_password.text;
                data_name = name.text;
                data_phone = phone.text;
                data_age = age.text;
                data_adress = adress.text;
                data_national_id = national_id.text;
                print(data_email);
                print(data_password);
                print(data_confirm_password);
                print(data_name);
                print(data_phone);
                print(data_age);
                print(data_national_id);
                if (data_confirm_password == data_password) {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: data_email, password: data_password);
                    User? user = userCredential.user;
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(user?.uid)
                        .set({
                      "name": data_name,
                      "phone": data_phone,
                      "age": data_age,
                      "national_id": data_national_id,
                      "adress": data_adress
                    });
                    Navigator.of(context).pushReplacementNamed("Home");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The Password is very weak');
                    } else if (e.code == 'email-aleady-in-use') {
                      print('The account is already exits for that email');
                    }
                  }
                } else {
                  print("Password Not Match");
                }
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              minWidth: 400,
              color: Color.fromARGB(255, 94, 142, 181),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("LOGIN");
                },
                child: Text(
                  'Sorry Iam joke with you Hahahahahahaha, I have Account !',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        )),
      ),
    ]);
  }
}
