// String? Function(String?)?

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_project/helper_function/email_validator.dart';

String? emailValidator(String? email) {
  // case : 1 -> Copy
  if (email != null && email.trim().isNotEmpty) {
    final bool isEmail = EmailValidator.validate(email);
    if (isEmail) return null;
    return "Invalid email";
  } else {
    return "Please enter email";
  }

  // case : 2
  // if (email == null || email.trim().isEmpty) {
  //   return "Please enter email";
  // } else {
  //   Pattern pattern =
  //       r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
  //   RegExp regexp = RegExp(pattern.toString());
  //   if (regexp.hasMatch(email.trim())) {
  //     return null;
  //   } else {
  //     return "Please enter valid email";
  //   }
  // }
}

String? mobileValidate(String? mobile) {
  if (mobile == null || mobile.trim().isEmpty) {
    return "Please enter mobile number";
  } else {
    if (mobile.trim().length != 10) {
      return "Invalid number";
    } else {
      return null;
    }
  }
}

String? ageValidation(String? age) {
  if (age == null || age.trim().isEmpty) {
    return null;
  } else {
    final i = int.parse(age);
    if (i == 0 || i >= 150) {
      return "Invalid age";
    } else {
      return null;
    }
  }
}

Future<bool> isImage({required String uri}) async {
  final type = [
    "image/jpeg",
    "image/jpg",
    "image/png",
    "binary/octet-stream",
  ];
  final dio = Dio();
  try {
    final Response response = await dio.head(uri);
    debugPrint("statusCode : ${response.statusCode}");
    debugPrint("Type : ${response.headers["content-type"]?[0]}");
    if (response.statusCode == 200) {
      final image = response.headers["content-type"]![0];

      final res = type.any((e) => e == image.toLowerCase());
      return res;
    } else {
      return false;
    }
  } on DioException catch (e) {
    debugPrint("DioCatch : $e");
    return false;
  } catch (e) {
    debugPrint("Catch : $e");
    return false;
  }
}
