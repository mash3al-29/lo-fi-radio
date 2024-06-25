import 'package:flutter/material.dart';
import 'package:lo_fi_radio_app/modules/Home_Screen_Cubit/cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lo_fi_radio_app/shared/components/components.dart';
import 'package:lo_fi_radio_app/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.background,
      appBar: AppBar(
        leading: Material(
          color: ThemeColors.transparent,
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 25,
            ),
          ),
        ),
        title: Text(
          'About Me',
          style: TextStyle(fontFamily: 'Vcr'),
        ),
        centerTitle: true,
        elevation: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CircleAvatar(
                radius: 45.0,
                backgroundImage: AssetImage('assets/images/abdelrahman.jpg'),
                backgroundColor: ThemeColors.transparent,
              ),
              SizedBox(
                height: 17,
              ),
              buildAboutMeText('Hi there!'),
              SizedBox(
                height: 8,
              ),
              buildAboutMeText('My name is Abdelrahman Mashaal!'),
              SizedBox(
                height: 8,
              ),
              Center(
                child: buildAboutMeText('I\'m the developer and designer'),
              ),
              SizedBox(
                height: 8,
              ),
              buildAboutMeText('of Lo-Fi Radio!'),
              SizedBox(
                height: 8,
              ),
              buildAboutMeSecondaryText(
                  'My passion is Android and Game development and I have other apps and games that I have developed before and are on the google play and the galaxy store!'),
              SizedBox(
                height: 8,
              ),
              buildAboutMeSecondaryText(
                  'You could check out these apps and games through my website and get to know their usage before downloading!'),
              SizedBox(
                height: 8,
              ),
              buildAboutMeSecondaryText(
                  'I am also a freelancer on freelancer.com and any business queries on apps or games that you need to be built may be sent there.'),
              SizedBox(
                height: 8,
              ),
              buildAboutMeText(
                  'That\'s all I wanted to say. Any social links or ways to contact me will be mentioned down below! Thanks for reading!'),
              SizedBox(
                height: 8,
              ),
              buildAboutMeText(
                'Bye for now and enjoy the app!',
              ),
              SizedBox(
                height: 18,
              ),
              buildAboutMeButton(
                  'https://www.instagram.com/abdelrahman_mash3al/',
                  'Instagram',
                  FontAwesomeIcons.instagram,
                  context),
              buildAboutMeButton(
                  'https://www.facebook.com/abdelrahman.mashal.58',
                  'Facebook',
                  FontAwesomeIcons.facebook,
                  context),
              buildAboutMeButton('https://twitter.com/AbdelrahmanMas9',
                  'Twitter', FontAwesomeIcons.twitter, context),
              buildAboutMeButton('https://www.freelancer.com/u/Mash3al',
                  'Freelancer', Icons.business_center, context),
              InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                onTap: () async {
                  final mailtoLink = Mailto(
                    to: ['abdelrahmanmashaal@gmail.com'],
                    subject: 'Lo-Fi Radio Inquiry',
                    body: '',
                  );
                  await launch('$mailtoLink');
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: LayoutCubit.get(context).getThemeColor(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Gmail',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Vcr'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text('2024 \u00a9 Abdelrahman Mashaal',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial')),
            ],
          ),
        ),
      ),
    );
  }
}
