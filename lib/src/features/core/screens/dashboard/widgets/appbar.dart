import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_string.dart';
import '../../../../../constants/text_strings.dart';

class DashboardAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: const Icon(
      //   Icons.menu,
      //   color: Colors.black,
      // ),
      title: Text(
        tAppName,
        style:
            Theme.of(context).textTheme.titleSmall?.apply(color: Colors.white),
      ),
      centerTitle: true,
      elevation: 0,
      //backgroundColor: Colors.transparent,
      actions: [
        Container(
          margin: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                print("Je me présente");
              },
              icon: const Image(
                image: AssetImage(tUserProfileImage),
                height: 24,
                width: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
