import 'package:flutter/material.dart';

import '../../../../constants/image_string.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import 'login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1
                Image(
                  image: const AssetImage(tWelcomeStringImage),
                  height: screenSize.height * 0.2,
                ),
                Text(
                  tLoginTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  tLoginSubTitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                //Fin section 1

                //Section 2: [Form]
                const LoginForm(),
                //Fin Section 2: [Form]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
