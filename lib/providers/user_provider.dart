import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_project/constant.dart';
import 'package:flutter_api_project/helper_function/error_function.dart';
import 'package:flutter_api_project/models/response_class.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final dio = Dio();
  // function
  //Read -> GetData

  bool isLoadingForReadUser = false;
  List<UserModel> users = [];
  Future<ResponseClass<List<UserModel>>> readUser() async {
    const uri = "${StringConstant.apiUrl}${StringConstant.readUser}";

    ResponseClass<List<UserModel>> responseClass = ResponseClass(
      success: false,
      message: StringConstant.initialErrorMsg,
    );

    try {
      isLoadingForReadUser = true;
      notifyListeners();
      Response response = await dio.get(uri);
      debugPrint("readUser : responseCode : ${response.statusCode}");
      if (response.statusCode == 200) {
        responseClass.success = true;
        responseClass.message = response.data['msg'];
        responseClass.data = List.from(
          response.data['data'].map(
            (json) => UserModel.fromJson(json),
          ),
        );

        users = responseClass.data!;

        isLoadingForReadUser = false;
        notifyListeners();
        return responseClass;
      } else {
        responseClass.success = false;
        responseClass.message = errorMessage(response.statusCode);
        Fluttertoast.showToast(msg: responseClass.message);
        isLoadingForReadUser = false;
        users = [];
        notifyListeners();
        return responseClass;
      }
    } on DioException catch (e) {
      debugPrint("readUser : DioCatchError : $e");
      Fluttertoast.showToast(msg: responseClass.message);
      isLoadingForReadUser = false;
      users = [];
      notifyListeners();
      return responseClass;
    } catch (e) {
      debugPrint("readUser : CatchError : $e");
      Fluttertoast.showToast(msg: responseClass.message);
      isLoadingForReadUser = false;
      users = [];
      notifyListeners();
      return responseClass;
    }
  }

  // CreateUser
  bool isLoadingForCreateUser = false;
  Future<ResponseClass> createUser({
    required Map<String, dynamic> json,
  }) async {
    const uri = "${StringConstant.apiUrl}${StringConstant.createUser}";

    ResponseClass responseClass = ResponseClass(
      success: false,
      message: StringConstant.initialErrorMsg,
    );

    try {
      isLoadingForCreateUser = true;

      notifyListeners();

      Response response = await dio.post(
        uri,
        data: json,
      );

      debugPrint('createUser url : $uri');
      debugPrint('createUser json : $json');
      debugPrint('createUser StatusCode : ${response.statusCode}');

      if (response.statusCode == 201) {
        responseClass.success = true;
        isLoadingForCreateUser = false;
        responseClass.message = response.data["msg"];
        responseClass.data = response.data["data"];
        notifyListeners();
        return responseClass;
      } else {
        responseClass.success = false;
        isLoadingForCreateUser = false;
        responseClass.message = errorMessage(response.statusCode);
        Fluttertoast.showToast(msg: responseClass.message);
        notifyListeners();
        return responseClass;
      }
    } on DioException catch (e) {
      debugPrint('createUser DioCatchError : $e');
      Fluttertoast.showToast(msg: responseClass.message);
      isLoadingForCreateUser = false;
      notifyListeners();
      return responseClass;
    } catch (e) {
      debugPrint('createUser catch : $e');
      Fluttertoast.showToast(msg: responseClass.message);
      isLoadingForCreateUser = false;
      notifyListeners();
      return responseClass;
    }
  }

  // DeleteUser
  bool isLoadingForDeleteUser = false;
  Future<ResponseClass> deleteUser({
    required int userID,
  }) async {
    final uri =
        "${StringConstant.apiUrl}${StringConstant.deleteUser(userID: userID)}";
    ResponseClass responseClass = ResponseClass(
      success: false,
      message: StringConstant.initialErrorMsg,
    );

    try {
      isLoadingForDeleteUser = true;
      notifyListeners();
      Response response = await dio.delete(uri);
      debugPrint("deleteUser responseCode : ${response.statusCode}");
      if (response.statusCode == 200) {
        responseClass.success = true;
        isLoadingForDeleteUser = false;
        responseClass.message = response.data['msg'];
        notifyListeners();
        return responseClass;
      } else {
        responseClass.success = false;
        isLoadingForDeleteUser = false;
        responseClass.message = errorMessage(response.statusCode);
        Fluttertoast.showToast(msg: responseClass.message);
        notifyListeners();
        return responseClass;
      }
    } on DioException catch (e) {
      debugPrint("deleteUser DioCatchError : $e");
      responseClass.success = false;
      isLoadingForDeleteUser = false;
      Fluttertoast.showToast(msg: responseClass.message);
      notifyListeners();
      return responseClass;
    } catch (e) {
      debugPrint("deleteUser CatchError : $e");
      responseClass.success = false;
      isLoadingForDeleteUser = false;
      Fluttertoast.showToast(msg: responseClass.message);
      notifyListeners();
      return responseClass;
    }
  }
}
