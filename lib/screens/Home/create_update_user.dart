import 'package:flutter/material.dart';
import 'package:flutter_api_project/widgets/custom_icon.dart';
import 'package:flutter_api_project/widgets/my_text_form_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constant.dart';
import '../../widgets/leading_btn.dart';

class CreateUpdateUser extends StatefulWidget {
  static const String pageName = "/create-update-user";
  const CreateUpdateUser({super.key});

  @override
  State<CreateUpdateUser> createState() => _CreateUpdateUserState();
}

class _CreateUpdateUserState extends State<CreateUpdateUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New User"),
        automaticallyImplyLeading: false,
        leadingWidth: 55,
        leading: const LeadingBtn(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextFormField(
                label: "Name",
              ),
              fieldHeight,
              MyTextFormField(
                label: "Mobile",
              ),
              fieldHeight,
              MyTextFormField(
                label: "Email",
              ),
              fieldHeight,
              MyTextFormField(
                label: "Age",
              ),
              fieldHeight,
              MyTextFormField(
                label: "Image Url",
              ),
              fieldHeight,
              MyTextFormField(
                label: "Address",
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
