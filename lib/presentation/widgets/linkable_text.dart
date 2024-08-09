import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/app_utils/app_utility.dart';

class LinkableText extends StatelessWidget {
  const LinkableText({
    this.text,
    this.maxLines,
    this.style1,
    this.style2,
  });

  final String? text;
  final int? maxLines;
  final TextStyle? style1;
  final TextStyle? style2;

  @override
  Widget build(BuildContext context) {
    final linkRegExp = RegExp(
      r'((https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(\/\S*)?)',
      caseSensitive: false,
    );

    final spans = <TextSpan>[];
    String content = text ?? '';
    int start = 0;

    // Find all matches and build TextSpan list
    for (final match in linkRegExp.allMatches(content)) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: content.substring(start, match.start),
          // style: Theme.of(context).textTheme.bodySmall?.copyWith(
          //       color: Theme.of(context).colorScheme.onSurface,
          //     ),
          style: style1,
        ));
      }
      final url = content.substring(match.start, match.end);
      spans.add(
        TextSpan(
          text: url,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.lightBlueAccent,
                decoration: TextDecoration.underline,
                overflow: TextOverflow.ellipsis,
              ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                print('Could not launch $url');
                AppUtility(context).error('Could not launch the URL.');
              }
            },
        ),
      );
      start = match.end;
    }

    // Add the remaining text if there's any
    if (start < content.length) {
      spans.add(TextSpan(
        text: content.substring(start),
        // style: Theme.of(context).textTheme.bodySmall?.copyWith(
        //       color: Theme.of(context).colorScheme.onSurface,
        //     ),
        style: style2,
      ));
    }

    return RichText(
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: spans),
    );
  }
}
