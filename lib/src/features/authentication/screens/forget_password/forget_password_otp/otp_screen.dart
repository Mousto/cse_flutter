import 'package:cse_talant_valmy/src/constants/sizes.dart';
import 'package:cse_talant_valmy/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tOtpTitle,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 80.0,
                ),
              ),
              Text(
                tOtpSubTitle.toLowerCase(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                '${tOtpMessage}bediaraye-w@yahoo.fr',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: OtpTextField(
                  numberOfFields: 6,
                  //fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  onSubmit: (leCodeSaisi) {
                    print("OTP is => $leCodeSaisi");
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(tNext),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
