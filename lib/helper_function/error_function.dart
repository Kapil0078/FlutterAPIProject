import 'package:flutter_api_project/constant.dart';

String errorMessage(int? statusCode) {
  if (statusCode == 400) {
    return StringConstant.error400;
  } else if (statusCode == 404) {
    return StringConstant.error404;
  } else if (statusCode == 409) {
    return StringConstant.error409;
  } else if (statusCode == 500) {
    return StringConstant.error500;
  } else {
    return StringConstant.initialErrorMsg;
  }
}
