import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_project/color_constatnt.dart';
import 'package:flutter_api_project/helper_function/email_validator.dart';
import 'package:flutter_api_project/helper_function/my_text_style.dart';
import 'package:flutter_api_project/helper_function/validators.dart';
import 'package:flutter_api_project/widgets/my_text_form_field.dart';
import '../../constant.dart';
import '../../widgets/leading_btn.dart';

class CreateUpdateUser extends StatefulWidget {
  static const String pageName = "/create-update-user";
  const CreateUpdateUser({super.key});

  @override
  State<CreateUpdateUser> createState() => _CreateUpdateUserState();
}

class _CreateUpdateUserState extends State<CreateUpdateUser> {
  // keys
  final _key = GlobalKey<FormState>();
  // controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final urlController = TextEditingController();
  final addressController = TextEditingController();

  // focusNodes
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final ageFocus = FocusNode();
  final urlFocus = FocusNode();
  final addressFocus = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    ageController.dispose();
    urlController.dispose();
    addressController.dispose();

    // focus
    phoneFocus.dispose();
    emailFocus.dispose();
    ageFocus.dispose();
    urlFocus.dispose();
    addressFocus.dispose();
    super.dispose();
  }

  // nextFocus
  void nextFocus(FocusNode node) => node.requestFocus();

  void onSave() {
    print('pressed');
    if (_key.currentState != null && _key.currentState!.validate()) {
      // TODO : API
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New User"),
        automaticallyImplyLeading: false,
        leadingWidth: 55,
        leading: const LeadingBtn(),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: appPrimary,
        ),
        onPressed: onSave,
        child: Text(
          "Save",
          style: MyTextStyle.medium.copyWith(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFormField(
                  controller: nameController,
                  onFieldSubmitted: (_) => nextFocus(phoneFocus),
                  label: "Name",
                  hintText: "Enter name",
                  validator: (name) {
                    if (name != null && name.trim().isNotEmpty) return null;
                    return "Please enter name";

                    // if (name == null || name.trim().isEmpty) {
                    //   return "Please enter name";
                    // } else {
                    //   return null;
                    // }
                  },
                ),
                fieldHeight,
                MyTextFormField(
                  controller: phoneController,
                  focusNode: phoneFocus,
                  onFieldSubmitted: (_) => nextFocus(emailFocus),
                  label: "Mobile",
                  hintText: "Enter mobile number",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  maxLength: 10,
                  validator: mobileValidate,
                ),
                fieldHeight,
                MyTextFormField(
                  controller: emailController,
                  focusNode: emailFocus,
                  onFieldSubmitted: (_) => nextFocus(ageFocus),
                  label: "Email",
                  hintText: "Enter email",
                  validator: emailValidator,
                ),
                fieldHeight,
                MyTextFormField(
                  controller: ageController,
                  focusNode: ageFocus,
                  onFieldSubmitted: (_) => nextFocus(urlFocus),
                  label: "Age",
                  hintText: "Enter age",
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // FilteringTextInputFormatter.allow(
                    //   RegExp(r"^\d{0,10}(\.\d{0,2})?"),
                    // ),

                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  validator: ageValidation,
                ),
                fieldHeight,
                MyTextFormField(
                  controller: urlController,
                  focusNode: urlFocus,
                  onFieldSubmitted: (_) {
                    nextFocus(addressFocus);
                  },
                  label: "Image Url",
                  hintText: "Enter image url",
                  validator: urlValidation,
                ),
                fieldHeight,
                MyTextFormField(
                  controller: addressController,
                  focusNode: addressFocus,
                  onFieldSubmitted: (_) => onSave(),
                  textInputAction: TextInputAction.done,
                  label: "Address",
                  hintText: "Enter address",
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
