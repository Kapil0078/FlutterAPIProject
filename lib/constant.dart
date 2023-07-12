import 'package:flutter/material.dart';

class StringConstant {
  // API
  static const String apiUrl = "https://sahil-flutter.vercel.app/api/v1/";
  // User
  static const readUser = "users";
  static const createUser = "users";
  static String deleteUser({required int userID}) => "users/$userID";

  // ErrorMsg
  static const initialErrorMsg = "Something went wrong";
  static const error400 = "Bad request";
  static const error404 = "404 Data not found";
  static const error409 = "Duplicate record found";
  static const error500 = "Internal server error";
}

const fieldHeight = SizedBox(height: 12);
