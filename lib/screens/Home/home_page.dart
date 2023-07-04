import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_project/color_constatnt.dart';
import 'package:flutter_api_project/helper_function/my_text_style.dart';
import 'package:flutter_api_project/screens/Home/create_update_user.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/custom_icon.dart';

class HomePage extends StatelessWidget {
  static const String pageName = "/home";
  const HomePage({super.key});

  final btnList = const [
    {
      'title': "Update",
      'path': "assets/icons/edit2.svg",
    },
    {
      'title': "Delete",
      'path': "assets/icons/delete.svg",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, CreateUpdateUser.pageName);
        },
        icon: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
          size: 15,
        ),
        label: Text(
          "Add User",
          style: MyTextStyle.medium.copyWith(
            color: Colors.white,
            fontSize: 12.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: appPrimary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: ListView.builder(
          itemCount: 5,
          padding: const EdgeInsets.only(bottom: 30),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: background,
                    border: Border.all(
                      color: appPrimary,
                      width: 0.20,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 90,
                          height: 130,
                          child: Image.asset(
                            "assets/images/placeholder.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomIcon(
                                svgPath: "assets/icons/person.svg",
                                text: "Sandip",
                              ),
                              const SizedBox(height: 5),
                              CustomIcon(
                                text: "9988776655",
                                svg: Image.asset(
                                  "assets/images/callPng.png",
                                  width: 21,
                                  height: 21,
                                  color: appPrimary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const CustomIcon(
                                text: "example@gmail.com",
                                svgPath: "assets/icons/email.svg",
                              ),
                              const SizedBox(height: 5),
                              CustomIcon(
                                text: "20",
                                svg: Image.asset(
                                  "assets/images/age.png",
                                  width: 21,
                                  height: 21,
                                  color: appPrimary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const CustomIcon(
                                text: "303-Creative institute",
                                svgPath: "assets/icons/location.svg",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: PopupMenuButton(
                    constraints: const BoxConstraints(
                      maxWidth: 125,
                      // maxHeight: 120,
                    ),
                    padding: EdgeInsets.zero,
                    tooltip: "Update-Delete",
                    offset: const Offset(-15, 45),
                    elevation: 1.5,
                    itemBuilder: (context) {
                      return btnList.map(
                        (e) {
                          final index = btnList.indexOf(e);
                          return PopupMenuItem(
                            value: index,
                            child: CustomBtn(
                              svgPath: e['path']!,
                              text: e['title']!,
                              color: index == 1 ? Colors.redAccent : black,
                              svgHeight: index == 1 ? 23 : 20,
                              svgWidth: index == 1 ? 23 : 20,
                            ),
                            onTap: () {},
                          );
                        },
                      ).toList();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CustomBtn extends StatelessWidget {
  final String text, svgPath;
  final double svgWidth, svgHeight;
  final Color color;
  const CustomBtn({
    super.key,
    required this.text,
    required this.svgPath,
    this.svgHeight = 20,
    this.svgWidth = 20,
    this.color = black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          svgPath,
          width: svgWidth,
          height: svgHeight,
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: MyTextStyle.medium.copyWith(
            fontSize: 14.5,
            color: color,
          ),
        ),
      ],
    );
  }
}
