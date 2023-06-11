import 'package:cse_talant_valmy/src/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'widgets/login_form_widget.dart';
import 'widgets/login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1
                LoginHeaderWidget(),
                //Section 2: [Form]
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
