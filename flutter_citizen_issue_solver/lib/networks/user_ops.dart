import 'dart:convert';
import 'package:citizen_issue_solver_flutter/models/user.dart';
import 'package:citizen_issue_solver_flutter/models/user_payload.dart';
import 'package:http/http.dart' as http;

Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
};

Future<http.Response> signUp(User user) async {
  final response = await http.post(Uri.parse('http://localhost:8080/signup'),
      headers: requestHeaders, body: jsonEncode(user.toMap()));

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<http.Response> signIn(UserPayload user) async {
  final response = await http.post(Uri.parse('http://localhost:8080/signin'),
      headers: requestHeaders, body: jsonEncode(user.toMap()));

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load album');
  }
}
