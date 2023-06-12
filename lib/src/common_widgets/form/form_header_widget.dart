import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  final String image, title, subtitle;
  final CrossAxisAlignment crossAxisAlignment;
  final double imageHeight;
  final double heightBetweenImgTxt;
  final TextAlign? textAlign;

  const FormHeaderWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.crossAxisAlignment,
    required this.imageHeight,
    required this.heightBetweenImgTxt,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
          image: AssetImage(image),
          height: size.height * imageHeight,
        ),
        SizedBox(
          height: heightBetweenImgTxt,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          subtitle,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
