import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void manageHtttpResponse({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, json.decode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, json.decode(response.body)['error']);
      break;
    case 201: //source created successfully
      onSuccess();
      break;
  }
}

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}
