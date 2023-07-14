// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_project/color_constatnt.dart';
import 'package:flutter_api_project/helper_function/my_text_style.dart';
import 'package:flutter_api_project/helper_function/validators.dart';
import 'package:flutter_api_project/models/user_model.dart';
import 'package:flutter_api_project/providers/user_provider.dart';
import 'package:flutter_api_project/widgets/my_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
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
  UserModel? userModel;
  bool isUpdate = false;
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

  //InitState
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final myUser = ModalRoute.of(context)?.settings.arguments as UserModel?;

        if (myUser != null) {
          isUpdate = true;
          userModel = myUser;
          _setControllerValues(myUser);
        }
      },
    );
    super.initState();
  }

  void _setControllerValues(UserModel model) {
    nameController.text = model.name;
    phoneController.text = model.mobileNumber;
    emailController.text = model.email;
    ageController.text = '${model.age ?? ""}';
    urlController.text = model.image ?? "";
    addressController.text = model.address ?? "";
  }

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

  void onSave(BuildContext context) async {
    bool validImage = true;
    if (urlController.text.trim().isNotEmpty) {
      final image = await isImage(uri: urlController.text.trim());
      validImage = image;
      if (image == false) {
        Fluttertoast.showToast(msg: "Invalid Image link");
      }
    }

    if (_key.currentState != null &&
        _key.currentState!.validate() &&
        validImage) {
      final json = {
        "name": nameController.text.trim(),
        "mobile_number": phoneController.text.trim(),
        "email": emailController.text.trim(),
        if (urlController.text.trim().isNotEmpty)
          "image": urlController.text.trim(),
        if (ageController.text.trim().isNotEmpty)
          "age": int.parse(ageController.text.trim()),
        if (addressController.text.trim().isNotEmpty)
          "address": addressController.text.trim(),
      };

      if (isUpdate) {
        context
            .read<UserProvider>()
            .updateUser(
              userID: userModel!.id,
              json: json,
            )
            .then(
          (value) async {
            if (value.success) {
              await context.read<UserProvider>().readUser();
              Navigator.pop(context);
            }
          },
        );
      } else {
        // createUser
        context.read<UserProvider>().createUser(json: json).then(
          (value) async {
            if (value.success) {
              await context.read<UserProvider>().readUser();
              Navigator.pop(context);
            }
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    final loading = isUpdate
        ? provider.isLoadingForUpdateUser
        : provider.isLoadingForCreateUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? "Update User" : "Add New User",
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 55,
        leading: const LeadingBtn(),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: appPrimary,
        ),
        onPressed: () => onSave(context),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: loading
              ? const SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  isUpdate ? "Update" : "Save",
                  style: MyTextStyle.medium.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                  ),
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
                ),
                fieldHeight,
                MyTextFormField(
                  controller: addressController,
                  focusNode: addressFocus,
                  onFieldSubmitted: (_) => onSave(context),
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
