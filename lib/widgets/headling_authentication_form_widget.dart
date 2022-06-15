import 'package:flutter/material.dart';

class HeadlineAuthenticationFormWidget extends StatelessWidget {
  final String title;
  final String? subtitle1;
  final String? subtitle2;

  const HeadlineAuthenticationFormWidget({
    Key? key,
    required this.title,
    this.subtitle1,
    this.subtitle2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        if (subtitle1 != null && subtitle1!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            strutStyle: const StrutStyle(
              height: 2.0,
            ),
            text: TextSpan(
              text: subtitle1,
              style: Theme.of(context).textTheme.headlineSmall!,
              children: subtitle2 != null && subtitle2!.isNotEmpty
                  ? [
                      TextSpan(
                        text: "\n$subtitle2",
                      ),
                    ]
                  : [],
            ),
          )
      ],
    );
  }
}
