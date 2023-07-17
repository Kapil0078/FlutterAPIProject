import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_project/color_constatnt.dart';

import '../helper_function/my_text_style.dart';

class MyTextFormField extends StatelessWidget {
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? hintText;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
final void Function(String)? onChanged;
  const MyTextFormField({
    Key? key,
    this.label,
    this.inputFormatters,
    this.controller,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType,
    this.hintText,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.contentPadding, this.onChanged,
  }) : super(key: key);

  OutlineInputBorder border({Color color = appPrimary, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              "$label",
              style: MyTextStyle.semiBold.copyWith(
                fontSize: 15,
                color: black,
              ),
            ),
          ),
        Theme(
          data: ThemeData(
            useMaterial3: false,
          ),
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            cursorColor: appPrimary,
            validator: validator,
            maxLength: maxLength,
            maxLines: maxLines,
            keyboardType: keyboardType,
            onFieldSubmitted: onFieldSubmitted,
            style: MyTextStyle.regular.copyWith(
              fontSize: 18,
              color: appPrimary,
            ),
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
              hintText: hintText,
              hintMaxLines: 1,
              hintStyle: MyTextStyle.regular.copyWith(
                color: grey,
                fontSize: 15,
              ),
              border: border(
                width: 0.75,
              ),
              focusedBorder: border(
                color: appPrimary,
                width: 1.2,
              ),
              disabledBorder: border(
                width: 0.75,
              ),
              enabledBorder: border(
                width: 0.75,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
