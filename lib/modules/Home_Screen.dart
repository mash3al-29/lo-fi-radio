import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_service/audio_service.dart';
import 'package:lo_fi_radio_app/modules/Home_Screen_Cubit/states.dart';
import 'package:lo_fi_radio_app/modules/settings.dart';
import 'package:lo_fi_radio_app/shared/components/constants.dart';
import 'package:lo_fi_radio_app/shared/network/local/Cache_Helper.dart';
import 'package:lo_fi_radio_app/shared/styles/colors.dart';
import 'package:lo_fi_radio_app/shared/styles/styles.dart';
import 'Home_Screen_Cubit/cubit.dart';
import 'package:just_audio/just_audio.dart';
import 'ListOfChannels.dart';

class Home_Screen extends StatefulWidget {
  Home_Screen({this.audioHandlerHomeScreen});
  AudioHandler audioHandlerHomeScreen;
  @override
  _Home_ScreenState createState() => _Home_ScreenState(audioHandlerHomeScreen);
}

class _Home_ScreenState extends State<Home_Screen>
    with SingleTickerProviderStateMixin {
  _Home_ScreenState(this.audiohandlpor);
  AudioHandler audiohandlpor;

  @override
  void initState() {
    super.initState();
    LayoutCubit.get(context).getProcessingState();
    Constants.animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );
  }

  @override
  Widget build(BuildContext context) {
    changeIcon();
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
        return Builder(
          builder: (BuildContext context) {
            checkForLikedSongStatus();
            return WillPopScope(
              onWillPop: () async {
                LayoutCubit.get(context).resetLikeStatus();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => List_Of_Channels()),
                    (route) => false);
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: Material(
                    color: ThemeColors.transparent,
                    shape: CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(
                      onPressed: () async {
                        LayoutCubit.get(context).resetLikeStatus();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => List_Of_Channels()),
                            (route) => false);
                      },
                      icon: Icon(Icons.arrow_back_rounded, size: 25),
                    ),
                  ),
                  title: Text(
                    'Radio',
                    style: TextStyle(
                      fontFamily: 'Vcr',
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    Material(
                      color: ThemeColors.transparent,
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settings_Screen()));
                          },
                          icon: Icon(
                            Icons.settings,
                            size: 25,
                            color: LayoutCubit.get(context).getThemeColor(),
                          )),
                    ),
                  ],
                  elevation: 20,
                ),
                body: Constants.internetStatus == 'present'
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 180,
                              width: 180,
                              child: ClipRRect(
                                child: Constants.audioDetails ==
                                        ProcessingState.ready
                                    ? Image.asset(
                                        LayoutCubit.get(context)
                                            .getAlbumCover(),
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                        color: LayoutCubit.get(context)
                                            .getThemeColor(),
                                      )),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            SizedBox(height: 20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Constants.audioDetails ==
                                      ProcessingState.ready
                                  ? Text(
                                      Constants.currentAudioMetadata != null
                                          ? CacheHelper.GetData(
                                                      key: 'channel') ==
                                                  2
                                              ? Constants.titleParts[2]
                                              : Constants.currentAudioMetadata
                                                  .info.title
                                                  .split('-')[1]
                                                  .split('[')[0]
                                          : 'Play',
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          fontFamily: 'Vcr'),
                                    )
                                  : Container(),
                            ),
                            Constants.audioDetails == ProcessingState.ready &&
                                    Constants.currentAudioMetadata != null
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: Text(
                                      Constants.currentAudioMetadata != null
                                          ? CacheHelper.GetData(
                                                      key: 'channel') ==
                                                  2
                                              ? Constants.titleParts[1]
                                              : Constants.currentAudioMetadata
                                                          .info.title
                                                          .toString()
                                                          .split('-')[0] ==
                                                      'Unknown '
                                                  ? 'Lo-Fi Radio Exclusive'
                                                  : Constants
                                                      .currentAudioMetadata
                                                      .info
                                                      .title
                                                      .split('-')[0]
                                          : '',
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          fontFamily: 'Arial'),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: LinearProgressIndicator(
                                      color: LayoutCubit.get(context)
                                          .getThemeColor(),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                            SizedBox(height: 20),
                            Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Material(
                                      color: ThemeColors.transparent,
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.hardEdge,
                                      child: IconButton(
                                        icon: Icon(
                                          MyFlutterApp.thumbs_up_alt,
                                          color: Constants.isLiked == true
                                              ? LayoutCubit.get(context)
                                                  .getThemeColor()
                                              : Colors.grey[500],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            Constants.currentAudioMetadata !=
                                                    null
                                                ? Constants.isLiked = true
                                                : null;
                                          });
                                          LayoutCubit.get(context)
                                              .insertFavouritesDatabase(
                                                  Constants.currentAudioMetadata
                                                      .info.title
                                                      .split('-')[1]
                                                      .split('[')[0],
                                                  Constants.currentAudioMetadata
                                                      .info.title
                                                      .split('-')[0],
                                                  Constants.currentAudioMetadata
                                                      .info.url,
                                                  CacheHelper.GetData(
                                                      key: 'channel'));
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    StreamBuilder<bool>(
                                        stream: Constants
                                            .mainAudioPlayer.playingStream,
                                        builder: (context, snapshot) {
                                          dynamic playing = snapshot.data;
                                          Constants.deleteLikeFlag =
                                              snapshot.data;
                                          return FloatingActionButton(
                                            backgroundColor:
                                                LayoutCubit.get(context)
                                                    .getThemeColor(),
                                            onPressed: () {
                                              if (Constants.audioDetails ==
                                                  ProcessingState.ready) {
                                                if (playing) {
                                                  forwardAnimation();
                                                  Constants.mainAudioPlayer
                                                      .pause();
                                                  Constants.audioPlayer.pause();
                                                  LayoutCubit.get(context)
                                                      .changeRapState();
                                                } else {
                                                  reverseAnimation();
                                                  LayoutCubit.get(context)
                                                      .playSong();
                                                  LayoutCubit.get(context)
                                                      .changeRapState();
                                                }
                                              } else {
                                                return null;
                                              }
                                            },
                                            child: AnimatedIcon(
                                              color: Colors.white,
                                              icon: AnimatedIcons.play_pause,
                                              progress:
                                                  Constants.animationController,
                                            ),
                                          );
                                        }),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Material(
                                      color: ThemeColors.transparent,
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.hardEdge,
                                      child: IconButton(
                                        icon: Icon(
                                          MyFlutterApp.thumbs_down_alt,
                                          color: Constants.isLiked == false
                                              ? LayoutCubit.get(context)
                                                  .getThemeColor()
                                              : Colors.grey[500],
                                        ),
                                        onPressed: () {
                                          LayoutCubit.get(context)
                                              .deleteLikeFromHomeScreen();
                                        },
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                              'No Internet Connection',
                              style: TextStyle(
                                fontFamily: 'Vcr',
                                fontSize: 17,
                              ),
                            )),
                            SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  'Once There is Internet, The Stream Will Resume Automatically',
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 13,
                                  ),
                                )),
                          ],
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }

  Future<dynamic> checkForLikedSongStatus() async {
    await Constants.favouritesDatabase
        .rawQuery('SELECT * FROM LikedSongs')
        .then((value) {
      for (var fav in value) {
        if (CacheHelper.GetData(key: 'channel') == 0) {
          if (fav['name'] ==
              Constants.currentAudioMetadata.info.title
                  .split('-')[1]
                  .split('[')[0]) {
            setState(() {
              Constants.isLiked = true;
            });
            break;
          }
        } else if (CacheHelper.GetData(key: 'channel') == 1) {
          if (fav['name'] ==
              Constants.currentAudioMetadata.info.title.split('-')[1]) {
            setState(() {
              Constants.isLiked = true;
            });
            break;
          }
        } else if (CacheHelper.GetData(key: 'channel') == 2) {
          if (fav['name'] ==
              Constants.currentAudioMetadata.info.title.split('-')[1]) {
            setState(() {
              Constants.isLiked = true;
            });
            break;
          }
        } else {
          if (fav['name'] ==
              Constants.currentAudioMetadata.info.title.split('-')[1]) {
            setState(() {
              Constants.isLiked = true;
            });
            break;
          }
        }
      }
    });
  }

  void changeIcon() {
    Constants.deleteLikeFlag == true
        ? Constants.animationController.forward()
        : Constants.animationController.reverse();
  }

  void forwardAnimation() {
    Constants.animationController.forward(from: 1);
  }

  void reverseAnimation() {
    setState(() {
      Constants.animationController.reverse(from: 0);
    });
  }
}
