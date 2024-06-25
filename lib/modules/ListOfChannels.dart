import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo_fi_radio_app/Main_Screen.dart';
import 'package:lo_fi_radio_app/modules/Home_Screen_Cubit/cubit.dart';
import 'package:lo_fi_radio_app/modules/Home_Screen_Cubit/states.dart';
import 'package:lo_fi_radio_app/shared/components/components.dart';
import 'package:lo_fi_radio_app/shared/components/constants.dart';
import 'package:lo_fi_radio_app/shared/network/local/Cache_Helper.dart';
import 'package:lo_fi_radio_app/shared/styles/colors.dart';

List<String> titles = ['Chill Lo-Fi', 'HipHop Lo-Fi', 'Sad Lo-Fi', 'Rap Lo-Fi'];

List<String> images = [
  'assets/images/chill.gif',
  'assets/images/hiphop.gif',
  'assets/images/sad.gif',
  'assets/images/rap.gif',
];

class List_Of_Channels extends StatefulWidget {
  @override
  _List_Of_ChannelsState createState() => _List_Of_ChannelsState();
}

class _List_Of_ChannelsState extends State<List_Of_Channels> {
  @override
  initState() {
    LayoutCubit.get(context).createDir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 20,
            backgroundColor: ThemeColors.transparent,
            title: Text(
              'Channels',
              style: TextStyle(fontFamily: 'Vcr', color: Colors.white),
            ),
            centerTitle: true,
            actions: [
              Material(
                color: ThemeColors.transparent,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: ThemeColors.background,
                            insetPadding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Container(
                              width: 500,
                              height: 370,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'Select Your Favourite Channel:',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/chill.gif'),
                                              fit: BoxFit.cover,
                                              height: 80,
                                              width: 80,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              CacheHelper.PutData(
                                                  key: 'fav', value: 1);
                                              CacheHelper.PutData(
                                                  key: 'channel', value: 0);
                                              DefaultToast(
                                                  message:
                                                      'Favourite Channel Set!',
                                                  fontsize: 13,
                                                  Backgroundcolor:
                                                      LayoutCubit.get(context)
                                                          .getThemeColor());
                                              Navigator.pop(context);
                                            });
                                          },
                                        ),
                                        SizedBox(width: 370 / 10),
                                        InkWell(
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/hiphop.gif'),
                                              fit: BoxFit.cover,
                                              height: 80,
                                              width: 80,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              CacheHelper.PutData(
                                                  key: 'fav', value: 2);
                                              CacheHelper.PutData(
                                                  key: 'channel', value: 1);
                                              DefaultToast(
                                                  message:
                                                      'Favourite Channel Set!',
                                                  fontsize: 13,
                                                  Backgroundcolor:
                                                      LayoutCubit.get(context)
                                                          .getThemeColor());
                                              Navigator.pop(context);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/sad.gif'),
                                              fit: BoxFit.cover,
                                              height: 80,
                                              width: 80,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              CacheHelper.PutData(
                                                  key: 'fav', value: 3);
                                              CacheHelper.PutData(
                                                  key: 'channel', value: 2);
                                              DefaultToast(
                                                  message:
                                                      'Favourite Channel Set!',
                                                  fontsize: 13,
                                                  Backgroundcolor:
                                                      LayoutCubit.get(context)
                                                          .getThemeColor());
                                              Navigator.pop(context);
                                            });
                                          },
                                        ),
                                        SizedBox(width: 370 / 10),
                                        InkWell(
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/rap.gif'),
                                              fit: BoxFit.cover,
                                              height: 80,
                                              width: 80,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              CacheHelper.PutData(
                                                  key: 'fav', value: 4);
                                              CacheHelper.PutData(
                                                  key: 'channel', value: 3);
                                              DefaultToast(
                                                  message:
                                                      'Favourite Channel Set!',
                                                  fontsize: 13,
                                                  Backgroundcolor:
                                                      LayoutCubit.get(context)
                                                          .getThemeColor());
                                              Navigator.pop(context);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: defaultButton(
                                      context: context,
                                      text: 'Clear Your Favourite Channel',
                                      function: () {
                                        if (CacheHelper.GetData(key: 'fav') !=
                                            null) {
                                          setState(() {
                                            CacheHelper.sharedPreferences
                                                .remove('fav');
                                            DefaultToast(
                                                message: 'Cleared',
                                                fontsize: 12,
                                                Backgroundcolor:
                                                    LayoutCubit.get(context)
                                                        .getThemeColor());
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          DefaultToast(
                                              message:
                                                  'You Haven\'t Set A Channel To Clear',
                                              fontsize: 12,
                                              Backgroundcolor:
                                                  LayoutCubit.get(context)
                                                      .getThemeColor());
                                        }
                                      },
                                      color: LayoutCubit.get(context)
                                          .getThemeColor()
                                          .withOpacity(0.2),
                                      elevation: 10,
                                      radius: 7,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.favorite,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: ThemeColors.transparent,
          body: Stack(
            children: [
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    image: new AssetImage(
                      "assets/images/background.gif",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onTap: () {
                              if (index == 0) {
                                chooseChannel(0);
                              } else if (index == 1) {
                                chooseChannel(1);
                              } else if (index == 2) {
                                chooseChannel(2);
                              } else {
                                chooseChannel(3);
                              }
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        images[index],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  titles[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Vcr',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(55.0),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[500],
                      ),
                    );
                  },
                  itemCount: titles.length),
            ],
          ),
        );
      },
    );
  }

  void chooseChannel(int channel) {
    setState(() {
      Constants.isLiked = null;
    });
    setState(() {
      CacheHelper.PutData(key: 'channel', value: channel);
      LayoutCubit()..playAudio();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Main_Screen(Constants.audioPlayer)));
      LayoutCubit.get(context).messages = [];
    });
  }
}
