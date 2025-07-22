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
    return RichText(
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: _buildTextSpans(context, text ?? ''),
        style: style1,
      ),
    );
  }

  List<TextSpan> _buildTextSpans(BuildContext context, String text) {
    final List<TextSpan> textSpans = [];

    // Combined regex for links, emails, and phone numbers
    final RegExp combinedRegExp = RegExp(
      r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?|' // Link pattern
      r'[\w.%+-]+@[\w.-]+\.[\w]{2,4}|' // Email pattern
      r'[\d-]{9,}', // Phone pattern
    );

    text.splitMapJoin(
      combinedRegExp,
      onMatch: (Match match) {
        final matchedText = match[0]!;
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: TextStyle(
              color: Colors.lightBlueAccent,
              decoration: TextDecoration.underline,
              overflow: TextOverflow.ellipsis,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (RegExp(r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?').hasMatch(matchedText)) {
                  // Handle URLs
                  final Uri url = Uri.parse(matchedText);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    print('Could not launch URL: $matchedText');
                    AppUtility(context).error('Could not launch the URL.');
                  }
                } else if (RegExp(r'[\w.%+-]+@[\w.-]+\.[\w]{2,4}').hasMatch(matchedText)) {
                  // Handle emails
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: matchedText,
                  );
                  if (await canLaunchUrl(emailLaunchUri)) {
                    await launchUrl(emailLaunchUri);
                  } else {
                    print('Could not launch mailto link: $matchedText');
                    AppUtility(context).error('Could not launch the email client.');
                  }
                } else if (RegExp(r'[\d-]{9,}').hasMatch(matchedText)) {
                  // Handle phone numbers
                  final Uri phoneLaunchUri = Uri(
                    scheme: 'tel',
                    path: matchedText,
                  );
                  if (await canLaunchUrl(phoneLaunchUri)) {
                    await launchUrl(phoneLaunchUri);
                  } else {
                    print('Could not launch tel link: $matchedText');
                    AppUtility(context).error('Could not launch the phone dialer.');
                  }
                }
              },
          ),
        );
        return '';
      },
      onNonMatch: (String nonMatch) {
        textSpans.add(
          TextSpan(
            text: nonMatch,
            style: style2,
          ),
        );
        return nonMatch;
      },
    );

    return textSpans;
  }
}
