import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_service/audio_service.dart';
import 'package:lo_fi_radio_app/shared/components/AudioPlayerHandler.dart';
import 'package:lo_fi_radio_app/shared/components/constants.dart';
import 'package:lo_fi_radio_app/shared/network/local/Cache_Helper.dart';
import 'package:lo_fi_radio_app/shared/styles/colors.dart';
import 'modules/Home_Screen.dart';
import 'modules/Home_Screen_Cubit/cubit.dart';
import 'modules/Home_Screen_Cubit/states.dart';
import 'modules/Likes.dart';
import 'modules/chat.dart';

class Main_Screen extends StatefulWidget {
  AudioHandler audioHandlerMainScreen;

  Main_Screen(this.audioHandlerMainScreen);

  @override
  _Main_ScreenState createState() => _Main_ScreenState(audioHandlerMainScreen);
}

class _Main_ScreenState extends State<Main_Screen> {
  AudioHandler audioPlayerMainScreen = AudioPlayerHandler();
  _Main_ScreenState(this.audioPlayerMainScreen);
  int currentIndex = 0;
  PageController _pageController;
  List<Widget> screens = [
    Home_Screen(
      audioHandlerHomeScreen: Constants.audioPlayer,
    ),
    Likes_Screen(),
    Chat_Screen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        LayoutCubit.get(context).audioPlayedSuccessRefresh();
        return BlocConsumer<LayoutCubit, HomeStates>(
          listener: (context, state) {
            if (state is RapAudioChecked) {
              setState(() {
                Constants.isLiked = null;
              });
            }
            if (state is MetaDataUpdated) {
              setState(() {
                Constants.isLiked = null;
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: ThemeColors.transparent,
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                      color: ThemeColors.transparent,
                      image: new DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.6), BlendMode.dstATop),
                        image: CacheHelper.GetData(key: 'chill') != null &&
                                CacheHelper.GetData(key: 'channel') == 0
                            ? Image.memory(Uint8List.fromList(CacheHelper.GetData(key: 'chill').codeUnits))
                                .image
                            : CacheHelper.GetData(key: 'hiphop') != null &&
                                    CacheHelper.GetData(key: 'channel') == 1
                                ? Image.memory(Uint8List.fromList(CacheHelper.GetData(key: 'hiphop').codeUnits))
                                    .image
                                : CacheHelper.GetData(key: 'sad') != null &&
                                        CacheHelper.GetData(key: 'channel') == 2
                                    ? Image.memory(Uint8List.fromList(
                                            CacheHelper.GetData(key: 'sad')
                                                .codeUnits))
                                        .image
                                    : CacheHelper.GetData(key: 'rap') != null &&
                                            CacheHelper.GetData(key: 'channel') ==
                                                3
                                        ? Image.memory(
                                                Uint8List.fromList(CacheHelper.GetData(key: 'rap').codeUnits))
                                            .image
                                        : new AssetImage(
                                            CacheHelper.GetData(
                                                        key: 'channel') ==
                                                    0
                                                ? "assets/images/chill2.gif"
                                                : CacheHelper.GetData(
                                                            key: 'channel') ==
                                                        1
                                                    ? "assets/images/hiphop2.gif"
                                                    : CacheHelper.GetData(
                                                                key:
                                                                    'channel') ==
                                                            2
                                                        ? "assets/images/sad2.gif"
                                                        : "assets/images/rap2.gif",
                                          ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(canvasColor: ThemeColors.transparent),
                    child: PageView(
                        physics: BouncingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => currentIndex = index);
                        },
                        children: screens),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(canvasColor: ThemeColors.transparent),
                      child: BottomNavigationBar(
                        key: Constants.globalKey,
                        backgroundColor: Colors.black12.withOpacity(0.1),
                        elevation: 0,
                        unselectedItemColor: Colors.grey,
                        type: BottomNavigationBarType.fixed,
                        selectedLabelStyle: TextStyle(fontFamily: 'Vcr'),
                        unselectedLabelStyle: TextStyle(fontFamily: 'Arial'),
                        selectedItemColor:
                            LayoutCubit.get(context).getThemeColor(),
                        items: [
                          BottomNavigationBarItem(
                              icon: Icon(Icons.music_note_sharp),
                              label: 'Radio',
                              backgroundColor:
                                  LayoutCubit.get(context).getThemeColor()),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.favorite),
                              label: 'Likes',
                              backgroundColor:
                                  LayoutCubit.get(context).getThemeColor()),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.message),
                              label: 'Chat',
                              backgroundColor:
                                  LayoutCubit.get(context).getThemeColor()),
                        ],
                        currentIndex: currentIndex,
                        onTap: (int index) {
                          setState(() {
                            currentIndex = index;
                            _pageController.animateToPage(
                              index,
                              duration: Duration(milliseconds: 600),
                              curve: Curves.ease,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
