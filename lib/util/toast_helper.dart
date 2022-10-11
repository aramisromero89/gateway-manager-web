import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg) {
  EasyLoading.showToast(msg, toastPosition: EasyLoadingToastPosition.bottom);
  // Fluttertoast.showToast(
  //   msg: "Something wrong happened",
  //   timeInSecForIosWeb: 4,
  // );
}
