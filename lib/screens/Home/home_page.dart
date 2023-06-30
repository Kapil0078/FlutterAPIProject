import 'package:flutter/material.dart';
import 'package:flutter_api_project/color_constatnt.dart';
import 'package:flutter_api_project/helper_function/my_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget iconTitle({
    required String svgPath,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          svgPath,
          width: 22,
          height: 22,
          colorFilter: const ColorFilter.mode(
            appPrimary,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: MyTextStyle.medium.copyWith(
            color: black,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 150,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          iconTitle(
                            svgPath: "assets/icons/person.svg",
                            text: "Sandip",
                          ),
                          iconTitle(
                            svgPath: "assets/icons/Phone2.svg",
                            text: "9988776655",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
