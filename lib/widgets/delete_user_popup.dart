// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_api_project/color_constatnt.dart';
import 'package:flutter_api_project/helper_function/my_text_style.dart';
import 'package:flutter_api_project/providers/user_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserDeletePopup extends StatefulWidget {
  final int userID;
  const UserDeletePopup({super.key, required this.userID});

  @override
  State<UserDeletePopup> createState() => _UserDeletePopupState();
}

class _UserDeletePopupState extends State<UserDeletePopup> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    return AlertDialog(
      title: Text(
        "Delete User",
        style: MyTextStyle.semiBold.copyWith(
          fontSize: 22,
          color: appPrimary,
        ),
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset("assets/icons/warning.svg"),
              ),
              const SizedBox(height: 10),
              Text(
                "Are you sure you want to delete this user?, all data regarding this user will be deleted",
                style: MyTextStyle.medium.copyWith(
                  fontSize: 13,
                  color: black,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: appPrimary),
          onPressed: () async {
            provider.deleteUser(userID: widget.userID).then(
              (value) async {
                if (value.success) {
                  provider.readUser();
                  Navigator.pop(context);
                }
              },
            );
          },
          child: provider.isLoadingForDeleteUser
              ? const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : Text(
                  "Delete",
                  style: MyTextStyle.medium.copyWith(
                    fontSize: 13.5,
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );
  }
}
