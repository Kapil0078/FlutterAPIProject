import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_project/color_constatnt.dart';
import 'package:flutter_api_project/helper_function/my_text_style.dart';
import 'package:flutter_api_project/models/user_model.dart';
import 'package:flutter_api_project/providers/user_provider.dart';
import 'package:flutter_api_project/screens/Home/create_update_user.dart';
import 'package:flutter_api_project/widgets/delete_user_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_icon.dart';

class HomePage extends StatefulWidget {
  static const String pageName = "/home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<UserProvider>().readUser();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
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
      body: userProvider.isLoadingForReadUser
          ? const Center(
              child: CircularProgressIndicator(
                color: appPrimary,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: ListView.builder(
                itemCount: userProvider.users.length,
                padding: const EdgeInsets.only(bottom: 30),
                itemBuilder: (context, index) {
                  final UserModel user = userProvider.users.elementAt(index);
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
                                child:
                                    user.image != null && user.image!.isNotEmpty
                                        ? Image.network(
                                            user.image!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/images/person.jpg",
                                            fit: BoxFit.cover,
                                          ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomIcon(
                                      svgPath: "assets/icons/person.svg",
                                      text: user.name,
                                    ),
                                    const SizedBox(height: 5),
                                    CustomIcon(
                                      text: user.mobileNumber,
                                      svg: Image.asset(
                                        "assets/images/callPng.png",
                                        width: 21,
                                        height: 21,
                                        color: appPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    CustomIcon(
                                      text: user.email,
                                      svgPath: "assets/icons/email.svg",
                                    ),
                                    const SizedBox(height: 5),
                                    CustomIcon(
                                      text: "${user.age ?? "-"}",
                                      svg: Image.asset(
                                        "assets/images/age.png",
                                        width: 21,
                                        height: 21,
                                        color: appPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    CustomIcon(
                                      text: user.address ?? "-",
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
                          onSelected: (i) => i == 0
                              ? null
                              : showDialog(
                                  context: context,
                                  builder: (context) =>
                                      UserDeletePopup(userID: user.id),
                                ),
                          itemBuilder: (context) {
                            return btnList.map(
                              (e) {
                                final index = btnList.indexOf(e);
                                return PopupMenuItem(
                                  value: index,
                                  child: CustomBtn(
                                    svgPath: e['path']!,
                                    text: e['title']!,
                                    color:
                                        index == 1 ? Colors.redAccent : black,
                                    svgHeight: index == 1 ? 23 : 20,
                                    svgWidth: index == 1 ? 23 : 20,
                                  ),
                                  // onTap: () {
                                  //   if (index == 0) {
                                  //   } else {
                                  //     onDelete(
                                  //         userID: user.id, context: context);
                                  //   }
                                  // },
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

// Future<void> onDelete(
//     {required int userID, required BuildContext context}) async {
//   Future.delayed(
//     const Duration(seconds: 0),
//     () {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return UserDeletePopup();
//         },
//       );
//     },
//   );
// }
