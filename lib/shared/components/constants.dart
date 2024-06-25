import 'package:profanity_filter/profanity_filter.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';

class Constants {
  static AudioHandler audioPlayer;

  static dynamic selectedGifFile;

  static bool switchValue = false;

  static String channelFlagPresent;

  static GlobalKey globalKey = new GlobalKey();

  static String updateUserFlag;

  static dynamic deleteLikeFlag;

  static String internetStatus;

  static final filter = ProfanityFilter();

  static IcyMetadata currentAudioMetadata;

  static AnimationController animationController;

  static bool isLiked;

  static ProcessingState audioDetails;

  static AudioPlayer mainAudioPlayer = AudioPlayer();

  static List<String> titleParts;

  static Database favouritesDatabase;
}
