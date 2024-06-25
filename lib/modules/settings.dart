import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lo_fi_radio_app/modules/about_me.dart';
import 'package:lo_fi_radio_app/shared/components/components.dart';
import 'package:lo_fi_radio_app/shared/components/constants.dart';
import 'package:lo_fi_radio_app/shared/network/local/Cache_Helper.dart';
import 'package:lo_fi_radio_app/shared/styles/colors.dart';
import 'Home_Screen_Cubit/cubit.dart';
import 'package:mailto/mailto.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

TextEditingController controller = TextEditingController();
var formKey = GlobalKey<FormState>();

class Settings_Screen extends StatefulWidget {
  @override
  _Settings_ScreenState createState() => _Settings_ScreenState();
}

class _Settings_ScreenState extends State<Settings_Screen> {
  @override
  Widget build(BuildContext context) {
    controller.text = LayoutCubit.get(context).userModel != null
        ? LayoutCubit.get(context).userModel.name
        : 'Your Name Will Be Here';
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: ThemeColors.background,
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(fontFamily: 'Vcr'),
          ),
          centerTitle: true,
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
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Radio Settings',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial'),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: ThemeColors.background,
                            insetPadding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Container(
                              width: 350,
                              height: 350,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'Select A Color:',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            customBorder:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                                color: ThemeColors.teal,
                                              ),
                                              width: 80,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                CacheHelper.PutData(
                                                    key: 'color', value: 0);
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            customBorder:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(25),
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                                color: ThemeColors.purple,
                                              ),
                                              width: 80,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                CacheHelper.PutData(
                                                    key: 'color', value: 1);
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            customBorder:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(25),
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                                color: ThemeColors.yellow,
                                              ),
                                              width: 80,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                CacheHelper.PutData(
                                                    key: 'color', value: 2);
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            customBorder:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(25),
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                                color: ThemeColors.blue,
                                              ),
                                              width: 80,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                CacheHelper.PutData(
                                                    key: 'color', value: 3);
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            customBorder:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(25),
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                                color: ThemeColors.orange,
                                              ),
                                              width: 80,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                setState(() {
                                                  CacheHelper.PutData(
                                                      key: 'color', value: 4);
                                                  Navigator.pop(context);
                                                });
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            customBorder:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(25),
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                                color: ThemeColors.red,
                                              ),
                                              width: 80,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                setState(() {
                                                  CacheHelper.PutData(
                                                      key: 'color', value: 5);
                                                  Navigator.pop(context);
                                                });
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.brush_outlined,
                        color: Colors.grey[500],
                        size: 25,
                      ),
                      SizedBox(
                        width: 19,
                      ),
                      Text(
                        'Accent Color',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Vcr'),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: LayoutCubit.get(context).getThemeColor(),
                        ),
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.volume_up,
                      color: Colors.grey[500],
                      size: 25,
                    ),
                    SizedBox(
                      width: 19,
                    ),
                    Text(
                      'Volume Control',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Vcr'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Slider(
                  value: CacheHelper.GetData(key: 'volume') != null
                      ? CacheHelper.GetData(key: 'volume')
                      : 1.0,
                  activeColor: LayoutCubit.get(context).getThemeColor(),
                  inactiveColor:
                      LayoutCubit.get(context).getThemeColor().withOpacity(0.5),
                  onChanged: (value) {
                    setState(() {
                      CacheHelper.PutData(key: 'volume', value: value);
                      Constants.mainAudioPlayer.setVolume(value);
                    });
                  },
                  min: 0,
                  max: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Edit Background Gif',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Vcr'),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    defaultButton(
                      context: context,
                      text: 'Change Background Gif',
                      function: () {
                        setState(() {
                          LayoutCubit.get(context).getGif();
                        });
                      },
                      color: LayoutCubit.get(context)
                          .getThemeColor()
                          .withOpacity(0.2),
                      elevation: 10,
                      radius: 7,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                      context: context,
                      text: 'Clear Gif On Current Channel',
                      function: () {
                        setState(() {
                          LayoutCubit.get(context).checkForKeyWithFlags();
                          if (Constants.channelFlagPresent == 'true') {
                            LayoutCubit.get(context).clearOneChannelGif();
                            DefaultToast(
                                message: 'Cleared',
                                fontsize: 14,
                                Backgroundcolor:
                                    LayoutCubit.get(context).getThemeColor());
                            Navigator.pop(context);
                          } else {
                            DefaultToast(
                                message: 'No Gif To Clear',
                                fontsize: 14,
                                Backgroundcolor:
                                    LayoutCubit.get(context).getThemeColor());
                          }
                        });
                      },
                      color: LayoutCubit.get(context)
                          .getThemeColor()
                          .withOpacity(0.2),
                      elevation: 10,
                      radius: 7,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                      context: context,
                      text: 'Clear All Gifs On All Channels',
                      function: () {
                        setState(() {
                          if (LayoutCubit.get(context).checkForKey() == true) {
                            LayoutCubit.get(context).clearAllChannelsGifs();
                            DefaultToast(
                                message: 'Cleared',
                                fontsize: 14,
                                Backgroundcolor:
                                    LayoutCubit.get(context).getThemeColor());
                            Navigator.pop(context);
                          } else {
                            DefaultToast(
                                message: 'No Gifs To Clear',
                                fontsize: 14,
                                Backgroundcolor:
                                    LayoutCubit.get(context).getThemeColor());
                          }
                        });
                      },
                      color: LayoutCubit.get(context)
                          .getThemeColor()
                          .withOpacity(0.2),
                      elevation: 10,
                      radius: 7,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Chat Settings',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial'),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Change Your Name',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Vcr'),
                ),
                SizedBox(
                  height: 15,
                ),
                defaultTextFormField(
                  SubmitFunction: (String value) async {
                    if (formKey.currentState.validate()) {
                      await LayoutCubit.get(context)
                          .updateUser(
                        name: value,
                        uID: CacheHelper.GetData(key: 'uID'),
                      )
                          .then((value) {
                        if (Constants.updateUserFlag == 'Not Available') {
                          DefaultToast(
                              message: 'This Name Is Already Taken',
                              fontsize: 13,
                              Backgroundcolor:
                                  LayoutCubit.get(context).getThemeColor());
                        } else {
                          DefaultToast(
                              message: 'Updated',
                              fontsize: 13,
                              Backgroundcolor:
                                  LayoutCubit.get(context).getThemeColor());
                        }
                      });
                    } else {
                      return null;
                    }
                    return null;
                  },
                  keyboardtype: null,
                  maxlines: 1,
                  enabled: LayoutCubit.get(context).userModel != null &&
                          Constants.internetStatus == 'present'
                      ? true
                      : false,
                  cursor: LayoutCubit.get(context).getThemeColor(),
                  hover: LayoutCubit.get(context).getThemeColor(),
                  controller: controller,
                  validate: (String value) {
                    if (value.isEmpty ||
                        value.trim() == '' ||
                        value.length > 9 ||
                        Constants.filter.hasProfanity(value) == true) {
                      return 'Enter A Valid Name Less Than 9 Characters!';
                    }
                    return null;
                  },
                  SufixIcon: TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(ThemeColors.button),
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          LayoutCubit.get(context)
                              .updateUser(
                            name: controller.text,
                            uID: CacheHelper.GetData(key: 'uID'),
                          )
                              .then((value) {
                            if (Constants.updateUserFlag == 'Not Available') {
                              DefaultToast(
                                  message: 'This Name Is Already Taken',
                                  fontsize: 13,
                                  Backgroundcolor:
                                      LayoutCubit.get(context).getThemeColor());
                            } else {
                              DefaultToast(
                                  message: 'Updated',
                                  fontsize: 13,
                                  Backgroundcolor:
                                      LayoutCubit.get(context).getThemeColor());
                            }
                          });
                        } else {
                          return null;
                        }
                        return null;
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                            fontFamily: 'Vcr',
                            fontSize: 14,
                            color: LayoutCubit.get(context).getThemeColor()),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Hide Developer Message',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Vcr'),
                ),
                SizedBox(
                  height: 15,
                ),
                CupertinoSwitch(
                  value: CacheHelper.GetData(key: 'switch') == null
                      ? Constants.switchValue
                      : CacheHelper.GetData(key: 'switch'),
                  activeColor: LayoutCubit.get(context).getThemeColor(),
                  trackColor:
                      LayoutCubit.get(context).getThemeColor().withOpacity(0.4),
                  onChanged: CacheHelper.GetData(key: 'uID') == null ||
                          Constants.internetStatus == 'not present'
                      ? null
                      : (value) {
                          setState(() {
                            value == true
                                ? CacheHelper.PutData(
                                    key: 'switch', value: true)
                                : CacheHelper.PutData(
                                    key: 'switch', value: false);
                            Constants.switchValue = value;
                            value == true
                                ? CacheHelper.PutData(key: 'hided', value: true)
                                : CacheHelper.PutData(
                                    key: 'hided', value: false);
                          });
                        },
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Delete Your Account',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Vcr'),
                ),
                SizedBox(
                  height: 30,
                ),
                defaultButton(
                  context: context,
                  text: 'Delete Current Account',
                  function: () {
                    setState(() {
                      if (CacheHelper.GetData(key: 'email') != null) {
                        LayoutCubit.get(context).deleteUserAccount();
                        DefaultToast(
                            message: 'Deleted',
                            fontsize: 12,
                            Backgroundcolor:
                                LayoutCubit.get(context).getThemeColor());
                        Navigator.pop(context);
                      } else {
                        DefaultToast(
                            message:
                                'You\'re not logged in to delete your account',
                            fontsize: 14,
                            Backgroundcolor:
                                LayoutCubit.get(context).getThemeColor());
                      }
                    });
                  },
                  color:
                      LayoutCubit.get(context).getThemeColor().withOpacity(0.2),
                  elevation: 10,
                  radius: 7,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Other Settings',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial'),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  onTap: () async {
                    String googleUrl =
                        'https://apps.samsung.com/appquery/AppRating.as?appId=com.lofi.radio.lo_fi_radio_app';
                    if (await canLaunch(googleUrl)) {
                      await launch(googleUrl);
                    } else {
                      DefaultToast(
                          message:
                              'Something Wrong Has Happened! Please Try Again Later',
                          fontsize: 12,
                          Backgroundcolor:
                              LayoutCubit.get(context).getThemeColor());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.star,
                          color: LayoutCubit.get(context).getThemeColor(),
                          size: 25,
                        ),
                        SizedBox(
                          width: 19,
                        ),
                        Text(
                          'Rate This App',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Vcr'),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  onTap: () async {
                    Share.share(
                        "Download Lo-Fi Radio And Chill With The Beats From Here: https://galaxy.store/lofiradio ${Constants.internetStatus == 'present' ? "or Here: ${LayoutCubit.get(context).myGlobalLink.sharedLink}" : ""} ",
                        subject: 'Look At This Great App!');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.share,
                          color: LayoutCubit.get(context).getThemeColor(),
                          size: 25,
                        ),
                        SizedBox(
                          width: 19,
                        ),
                        Text(
                          'Share this app',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Vcr'),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  onTap: () async {
                    final mailtoLink = Mailto(
                      to: ['abdelrahmanmashaal@gmail.com'],
                      subject: 'Bug Report',
                      body: 'Please Include:'
                          '\n1 - A full description of the bug'
                          '\n2 - Screenshots of the bug if possible'
                          '\n3 - A way to reproduce the bug if happened to you multiple times'
                          '\nThanks for making this app better!',
                    );
                    await launch('$mailtoLink');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.bug,
                          color: LayoutCubit.get(context).getThemeColor(),
                          size: 25,
                        ),
                        SizedBox(
                          width: 19,
                        ),
                        Text(
                          'Report Bugs',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Vcr'),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutMe()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.info,
                          color: LayoutCubit.get(context).getThemeColor(),
                          size: 25,
                        ),
                        SizedBox(
                          width: 19,
                        ),
                        Text(
                          'About Me!',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Vcr'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
