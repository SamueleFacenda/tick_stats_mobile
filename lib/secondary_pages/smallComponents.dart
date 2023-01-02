import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HyperLink extends StatelessWidget {
  const HyperLink({super.key, required this.text, required this.hypertext, required this.onPressed});

  final String text;
  final VoidCallback onPressed;
  final String hypertext;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    final bodyTextStyle =
    textTheme.bodyMedium!;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            style: bodyTextStyle,
            text: text,
          ),
          TextSpan(
            style: bodyTextStyle.copyWith(
              color: colorScheme.primary,
            ),
            text: hypertext,
            recognizer: TapGestureRecognizer()
              ..onTap = onPressed,
          ),
        ],
      ),
    );
  }
}