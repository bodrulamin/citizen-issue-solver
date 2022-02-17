import 'dart:convert';

import 'package:citizen_issue_solver_flutter/models/api_res.dart';
import 'package:citizen_issue_solver_flutter/networks/user_ops.dart';
import 'package:citizen_issue_solver_flutter/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'issue_feed.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RegistrationBody(),
      appBar: AppBar(
        title: const Text("Citizen Issue Solver"),
      ),
    );
  }
}

class RegistrationBody extends StatefulWidget {
  const RegistrationBody({Key? key}) : super(key: key);

  @override
  _RegistrationBodyState createState() => _RegistrationBodyState();
}

class _RegistrationBodyState extends State<RegistrationBody> {
  var usertypes = ["citizen", "provider"];

  var selectedUserType;

  final _usernameController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var labelText2 = "Username";
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text("Registration"),
          TextFormField(
            controller: _usernameController,
            decoration:  InputDecoration(
              labelText: labelText2,
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
          ),
          const Text("Select UserType"),
          DropdownButtonFormField(
            items: usertypes.map((String usertype) {
              return DropdownMenuItem(
                value: usertype,
                child: Text(usertype),
              );
            }).toList(),
            onChanged: (newValue) {
              // do other stuff with _category
              setState(() => selectedUserType = newValue);
            },
            value: selectedUserType,
          ),
          TextFormField(
            controller: _addressController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
                // labelText: "Address",
                ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  User user = User(
                      username: _usernameController.text,
                      password: _passwordController.text,
                      usertype: selectedUserType,
                      email: "bodrulamin@gmail.com",
                      fullname: _usernameController.text,
                      address: _addressController.text,
                      phone: '017554654');

                  print(user);
                  signUp(user).then((res) {
                    print(res.body);
                    ApiResponse apires = ApiResponse.fromMap(jsonDecode(res.body)) ;

                    SnackBar snackBar = SnackBar(
                      content: Text(apires.msg),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    if(apires.status == 'success'){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>IssueFeed()));
                    }
                  });
                },
                child: const Text('Register'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Already a user? Sign in here'))
            ],
          )
        ],
      ),
    );
  }
}