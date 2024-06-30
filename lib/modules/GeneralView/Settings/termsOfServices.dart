import 'package:flutter/material.dart';
import 'package:flutter_code/modules/GeneralView/Settings/settingsPage.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class TermsOfServices extends StatelessWidget {
  const TermsOfServices({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/arrowLeft.svg"),
          onPressed: () {
            navigateToPage(context, const SettingsPage());
          },
        ),
        title: StrokeText(
          text: "Terms of Services",
          textStyle: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
            color: HexColor("296E6F"),
          ),
          strokeWidth: 1.0,
          strokeColor: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: screenWidth / 20,
          top: screenHeight / 30,
          end: screenWidth / 20,
        ),
        child: ListView(
          children: [
            const Row(
              children: [
                Text(
                  'Welcome to ',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: "Roboto",
                  ),
                ),
                Text(
                  'VolunHero Website ',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: defaultColor,
                    fontFamily: "Roboto",
                  ),
                ),
                Text(
                  'By using our app,',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: "Roboto",
                  ),
                ),
              ],
            ),
            const Text(
              'you agree'
              'to comply with and be bound by the following '
              'Terms of Service. Please read them carefully.\n',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight / 100),
            const SectionTitle('1. Acceptance of Terms'),
            SizedBox(height: screenHeight / 80),
            const SectionContent(
              'By accessing or using VolunHero, you agree to be bound by these '
              'Terms of Service and our Privacy Policy. If you do not agree'
              ' with any part of these terms, you may not use the app.\n',
            ),
            const SectionTitle('2. Eligibility'),
            SizedBox(height: screenHeight / 80),
            const SectionContent(
              'You must be at least 18 years old to use VolunHero. By using'
              ' the app, you represent and warrant that you meet'
              ' this requirement.\n',
            ),
            const SectionTitle('3. Registration'),
            SizedBox(height: screenHeight / 80),
            const SectionContent(
              'To use certain features of the app, you may be required to '
              'register for an account. You agree to provide accurate, '
              'current, and complete information during the registration '
              'process and to update such information as necessary.\n',
            ),
            const SectionTitle('4. Use of the App'),
            SizedBox(height: screenHeight / 80),
            const SectionContent(
              'You agree to use the app only for lawful purposes and in '
              'accordance with these Terms of Service. You agree not to use'
              ' the app:',
            ),
            const SectionListItem(
              'In any way that violates any applicable federal, state, local, '
              'or international law or regulation.',
            ),
            const SectionListItem(
              'To exploit, harm, or attempt to exploit or harm minors in any'
              ' way by exposing them to inappropriate content or'
              ' otherwise.',
            ),
            const SectionListItem(
              'To impersonate or attempt to impersonate VolunHero, a VolunHero'
              ' employee, another user, or any other person or entity.\n',
            ),
            const SectionTitle('5. User Content'),
            SizedBox(height: screenHeight / 80),
            const SectionContent(
              'You are responsible for any content you post, upload, or'
              ' otherwise make available through the app. You agree not to '
              'post any content that:',
            ),
            SizedBox(height: screenHeight / 80),
            const SectionListItem(
              'Is unlawful, harmful, threatening, abusive, harassing, '
              'defamatory, vulgar, obscene, invasive of another\'s privacy,'
              ' hateful, or racially, ethnically, or otherwise'
              ' objectionable.',
            ),
            const SectionListItem(
              'Infringes on any patent, trademark, trade secret,'
              ' copyright, or other proprietary rights of any party.',
            ),
            const SectionListItem(
              'Contains any viruses, Trojan horses, worms, time bombs,'
              ' or other harmful programs.\n',
            ),
            const SectionTitle('6. Termination'),
            SizedBox(height: screenHeight / 80),
            const SectionContent(
              'We reserve the right to terminate or suspend your account and '
              'access to the app at our sole discretion, without notice, for'
              ' conduct that we believe violates these Terms of Service or '
              'is harmful to other users of the app, us, or third parties,'
              ' or for any other reason.\n',
            ),
            const SectionTitle('7. Modifications to the Service'),
            SizedBox(height: screenHeight / 80),
            const SectionContent(
              'We reserve the right to modify or discontinue, temporarily or'
              ' permanently, the app or any service to which it connects'
              ', with or without notice and without liability to you.\n',
            ),
            const SectionTitle('8. Disclaimer of Warranties'),
            SizedBox(height: screenHeight / 80),
            const SectionContent(
              'The app is provided on an "as-is" and "as available" basis.'
              ' VolunHero makes no representations or warranties of any '
              'kind, express or implied, as to the operation of the app or '
              'the information, content, or materials included on the app.\n',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontFamily: "Roboto",
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String content;

  const SectionContent(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        fontFamily: "Roboto",
      ),
    );
  }
}

class SectionListItem extends StatelessWidget {
  final String content;

  const SectionListItem(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Text(
        '• $content',
        style: const TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
          fontFamily: "Roboto",
        ),
      ),
    );
  }
}
