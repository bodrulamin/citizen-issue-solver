import 'dart:convert';
import 'package:citizen_issue_solver_flutter/constant/apiconfig.dart';
import 'package:citizen_issue_solver_flutter/models/user.dart';
import 'package:citizen_issue_solver_flutter/models/user_payload.dart';
import 'package:http/http.dart' as http;

Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
};

Future<http.Response> getIssues() async {
  final response = await http.get(Uri.parse(shoutGetAllApi),
      headers: requestHeaders );


    return response;


}


