import 'package:flutter/material.dart';

import '../../../../../constants/text_strings.dart';

class Search extends StatelessWidget {
  const Search({
    super.key,
    required this.txtTheme,
  });

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(width: 4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tDashboardSearch,
            style: txtTheme.headlineSmall?.apply(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          const Icon(Icons.mic, size: 25),
        ],
      ),
    );
  }
}
