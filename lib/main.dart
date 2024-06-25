import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lo_fi_radio_app/shared/components/AudioPlayerHandler.dart';
import 'package:lo_fi_radio_app/shared/components/constants.dart';
import 'package:lo_fi_radio_app/shared/network/local/Cache_Helper.dart';
import 'package:lo_fi_radio_app/shared/styles/themes.dart';
import 'Bloc_Observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Main_Screen.dart';
import 'modules/Home_Screen_Cubit/cubit.dart';
import 'modules/ListOfChannels.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  await CacheHelper.init();
  Constants.audioPlayer = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
        androidStopForegroundOnPause: true,
        androidResumeOnClick: true,
        androidNotificationChannelId: 'wownotifications',
        androidNotificationChannelName: 'Notification Channel',
        preloadArtwork: true,
        androidNotificationIcon: 'drawable/playbutton',
        androidShowNotificationBadge: true,
        androidNotificationChannelDescription: 'Notifications'),
  );
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()
        ..isInternet()
        ..fetchUserData()
        ..createFavouritesDatabase()
        ..getMyLink(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CacheHelper.GetData(key: 'fav') == 1 ||
                CacheHelper.GetData(key: 'fav') == 2 ||
                CacheHelper.GetData(key: 'fav') == 3 ||
                CacheHelper.GetData(key: 'fav') == 4
            ? Main_Screen(Constants.audioPlayer)
            : List_Of_Channels(),
        theme: DarkTheme,
      ),
    );
  }
}
