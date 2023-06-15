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
      leading: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
      title: Text(
        tAppName,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Container(
          margin: const EdgeInsets.only(
            right: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: tCardBgColor,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(tUserProfileImage),
              height: 20,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
