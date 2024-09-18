import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lo_fi_radio_app/models/User_Model.dart';
import 'package:flutter/material.dart';
import 'package:lo_fi_radio_app/models/messages.dart';
import 'package:lo_fi_radio_app/models/shareLinkModel.dart';
import 'package:lo_fi_radio_app/shared/styles/colors.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lo_fi_radio_app/modules/Home_Screen_Cubit/states.dart';
import 'package:lo_fi_radio_app/shared/components/components.dart';
import 'package:lo_fi_radio_app/shared/components/constants.dart';
import 'package:lo_fi_radio_app/shared/network/local/Cache_Helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:file_picker/file_picker.dart';

class LayoutCubit extends Cubit<HomeStates> {
  LayoutCubit() : super(InitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  List<MessageModel> messages = [];
  MessageModel developerMessage = MessageModel();
  dynamic favourites = [];
  bool rapAudioChecker = true;
  shareLinkModel myGlobalLink = shareLinkModel();
  UserModel userModel = UserModel();
  GoogleSignInAccount userLoggedIn;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<dynamic> playAudio() {
    return Constants.mainAudioPlayer
        .setAudioSource(_setAudioSource())
        .then((value) {
      Constants.mainAudioPlayer.setVolume(_setVolume());
      Constants.mainAudioPlayer.icyMetadataStream.listen((value) {
        Constants.currentAudioMetadata = value;
        RegExp dashRegex = RegExp(r'\s*[-–—]\s*');
        Constants.titleParts = value.info.title.split(dashRegex);
        _rapAudioCheck();
        emit(RapAudioChecked());
      });
    }).catchError((error) {
      emit(RapAudioCheckedError());
    });
  }

  dynamic _setVolume() {
    return CacheHelper.GetData(key: 'volume') != null
        ? CacheHelper.GetData(key: 'volume')
        : 1.0;
  }

  dynamic _setAudioSource() {
    return AudioSource.uri(Uri.parse(CacheHelper.GetData(key: 'channel') == 0
        ? 'https://usa9.fastcast4u.com/proxy/jamz?mp=/1'
        : CacheHelper.GetData(key: 'channel') == 1
            ? 'https://play.streamafrica.net/lofiradio'
            : CacheHelper.GetData(key: 'channel') == 2
                ? 'https://stream-161.zeno.fm/3u1qndyk8rhvv?zs=S-PmFX-8RAOsp7kjMnpRtg'
                : 'https://lfhh.radioca.st/stream'));
  }

  void _rapAudioCheck() {
    if (CacheHelper.GetData(key: 'channel') == 3 ||
        CacheHelper.GetData(key: 'fav') == 3) {
      if (rapAudioChecker == true && Constants.currentAudioMetadata != null) {
        BottomNavigationBar navigationBar = Constants.globalKey.currentWidget;
        navigationBar.onTap(1);
        navigationBar.onTap(0);
        rapAudioChecker = false;
        emit(AudioPlayedSuccess());
      }
    }
  }

  Future<dynamic> updateUser({
    @required String name,
    @required String uID,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) async {
      for (var z in value.docs) {
        if (z.get('name') == name &&
            z.get('uID') != CacheHelper.GetData(key: 'uID')) {
          Constants.updateUserFlag = 'Not Available';
          break;
        } else {
          Constants.updateUserFlag = 'Available';
        }
      }
    });
    compareUsername(
      name: name,
      uID: uID,
    );
  }

  Future<dynamic> compareUsername({
    @required String name,
    @required String uID,
  }) {
    // != Not Available
    if (Constants.updateUserFlag == 'Available') {
      UserModel model = UserModel(
        uID: uID,
        name: name,
        image: userModel.image,
        email: userModel.email,
      );
      return FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.email)
          .update(model.ToMap())
          .then((value) async {
        fetchUserData();
        changeMessages('messageschill');
        changeMessages('messageshiphop');
        changeMessages('messagessad');
        changeMessages('messagesrap');
        emit(UpdateSuccess());
      }).catchError((error) {
        emit(UpdateError());
      });
    } else {
      return null;
    }
  }

  void getProcessingState() {
    Constants.mainAudioPlayer.processingStateStream.listen((event) {
      Constants.audioDetails = event;
      emit(GotProcessingState());
    });
  }

  void playSong() {
    Constants.mainAudioPlayer.seek(Duration(days: 30));
    Constants.mainAudioPlayer.play();
    Constants.audioPlayer.play();
    Constants.mainAudioPlayer.icyMetadataStream.listen((value) {
      Constants.currentAudioMetadata = value;
      emit(MetaDataUpdated());
    });
  }

  Future<dynamic> deleteUserAccount() async {
    emit(DeletedUserSuccess());
    await fetchUserData();
    await removeMessages('messageschill').then((value) async {
      await removeMessages('messageshiphop');
      await removeMessages('messagessad');
      await removeMessages('messagesrap');
      await fetchUserData().then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userModel.email)
            .delete();
        await FirebaseAuth.instance.currentUser.delete();
      }).then((value) {
        signOut();
      });
    });
  }

  Color getThemeColor() {
    if (CacheHelper.GetData(key: 'color') == 0) {
      return ThemeColors.teal;
    } else if (CacheHelper.GetData(key: 'color') == 1) {
      return ThemeColors.purple;
    } else if (CacheHelper.GetData(key: 'color') == 2) {
      return ThemeColors.yellow;
    } else if (CacheHelper.GetData(key: 'color') == 3) {
      return ThemeColors.blue;
    } else if (CacheHelper.GetData(key: 'color') == 4) {
      return ThemeColors.orange;
    } else if (CacheHelper.GetData(key: 'color') == 5) {
      return ThemeColors.red;
    } else {
      return ThemeColors.teal;
    }
  }

  void changeRapState() {
    emit(RapAudioCheckedError());
  }

  Future<dynamic> fetchUserData() {
    emit(GetUserLoading());
    return FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.GetData(key: 'email'))
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccess());
    }).catchError((dynamic error) {
      userModel = null;
      emit(GetUserError());
    });
  }

  Future<dynamic> signUpUsingGoogle({context}) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    userLoggedIn = googleUser;
    final googleAuthentication = await googleUser.authentication;
    final cred = GoogleAuthProvider.credential(
      accessToken: googleAuthentication.accessToken,
      idToken: googleAuthentication.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(cred).then((value) async {
      CacheHelper.PutData(key: 'uID', value: value.user.uid);
      defaultToastSignedIn(context);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userLoggedIn.email)
          .get()
          .then((firebaseResult) {
        if (firebaseResult.exists == false) {
          userCreate(
            uID: value.user.uid,
            name: userLoggedIn.displayName,
            email: userLoggedIn.email,
            image: userLoggedIn.photoUrl,
          );
        } else {
          return null;
        }
      }).catchError((onError) {
        defaultToastError();
      });
      saveUserData();
      fetchUserData();
    }).catchError((onError) {
      defaultToastError();
      signOut();
    });
    emit(SignedUpChanged());
  }

  void defaultToastError() {
    DefaultToast(
        message: 'Something Wrong Has Happened. Please Try Again Later!',
        fontsize: 14,
        Backgroundcolor: getThemeColor());
  }

  void defaultToastSignedIn(dynamic context) {
    DefaultToast(
        message: 'Signed In',
        fontsize: 12,
        Backgroundcolor: LayoutCubit.get(context).getThemeColor());
  }

  void saveUserData() async {
    await CacheHelper.PutData(key: 'email', value: userLoggedIn.email);
    await CacheHelper.PutData(key: 'name', value: userLoggedIn.displayName);
  }

  void removeUserData() {
    CacheHelper.sharedPreferences.remove('uID');
    CacheHelper.sharedPreferences.remove('email');
  }

  Future<dynamic> signOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    userModel = null;
    removeUserData();
    emit(SignOutSuccessful());
  }

  Future<void> userCreate({
    @required String name,
    @required String email,
    String image,
    @required String uID,
  }) async {
    UserModel model = UserModel(
      uID: uID,
      name: name,
      email: email,
      image: image,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .set(
          model.ToMap(),
        )
        .then((value) {
      emit(CreateUserWithDataInFireBaseSuccess());
      fetchUserData();
    }).catchError((onError) {
      emit(CreateUserWithDataInFireBaseError());
    });
  }

  void createFavouritesDatabase() {
    openDatabase('favourites.db', version: 1,
        onCreate: (favouritesDatabase, version) async {
      await favouritesDatabase
          .execute(
              'CREATE TABLE LikedSongs (id INTEGER PRIMARY KEY,name TEXT, artist TEXT, image TEXT,channel INTEGER)')
          .then((value) => print('Table Created'))
          .catchError((error) {
        print('Error while creating table ${error.toString()}');
      });
    }, onOpen: (favouritesDatabase) {
      getFromDatabase(favouritesDatabase);
    }).then((value) {
      Constants.favouritesDatabase = value;
      emit(CreatedDatabaseSuccess());
    });
  }

  void insertFavouritesDatabase(
    String name,
    String artist,
    String image,
    int channel,
  ) async {
    Constants.favouritesDatabase
        .rawQuery('SELECT * FROM LikedSongs')
        .then((value) {
      bool matched = false;
      value.forEach((value) {
        if (value['name'] == name) {
          Constants.isLiked = true;
          matched = true;
        }
      });
      if (value.length > 0 && value != null) {
        if (matched == true) {
          _notAddedToLikesToast();
          emit(UpdateDatabaseError());
          matched = false;
        } else {
          return Constants.favouritesDatabase.transaction((trans) async {
            trans
                .rawInsert(
                  'INSERT INTO LikedSongs (name,artist,image,channel) VALUES("$name","$artist","$image",$channel)',
                )
                .then((value) => print('$value Inserted'));
            emit(UpdateDatabaseSuccess());
            getFromDatabase(Constants.favouritesDatabase);
            _addedToLikesToast();
          });
        }
      } else {
        return Constants.favouritesDatabase.transaction((trans) async {
          trans
              .rawInsert(
                'INSERT INTO LikedSongs (name,artist,image,channel) VALUES("$name","$artist","$image",$channel)',
              )
              .then((value) => emit(UpdateDatabaseSuccess()));
          getFromDatabase(Constants.favouritesDatabase);
          _addedToLikesToast();
        });
      }
    });
  }

  void _addedToLikesToast() {
    DefaultToast(
        message: 'Added To Likes',
        fontsize: 13,
        Backgroundcolor: getThemeColor());
  }

  void _notAddedToLikesToast() {
    DefaultToast(
        message: 'This Song Is Already In Your Likes',
        fontsize: 12,
        Backgroundcolor: getThemeColor());
  }

  void getFromDatabase(favouritesDatabase) async {
    favourites = [];
    emit(GetFromDatabaseRefresh());
    favouritesDatabase.rawQuery('SELECT * FROM LikedSongs').then((value) {
      value.forEach((element) {
        favourites.add(element);
        emit(GetFromDatabaseSuccess());
      });
    });
  }

  void resetLikeStatus() async {
    Constants.isLiked = null;
    emit(ResetLikeStatusSuccess());
  }

  dynamic deleteLikeFromDatabase(int id, dynamic name) {
    final songName = name;
    Constants.favouritesDatabase
        .rawDelete('DELETE FROM LikedSongs WHERE id = ?', [id]).then((value) {
      getFromDatabase(Constants.favouritesDatabase);
      emit(DeleteLikeSuccess());
      if (songName ==
          Constants.currentAudioMetadata.info.title
              .split('-')[1]
              .split('[')[0]) {
        resetLikeStatus();
      }
      emit(DeleteLikeSuccess());
    }).catchError((error) {
      emit(DeleteLikeError());
    });
  }

  Future<Uint8List> readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File imageFile = new File.fromUri(myUri);
    Uint8List bytes;
    await imageFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
  }

  void createDir() async {
    Directory baseDir = await getApplicationDocumentsDirectory();
    String dirToBeCreated = "GifsToUse";
    String finalDir = join(baseDir.uri.path, dirToBeCreated);
    CacheHelper.PutData(key: 'AppFolder', value: finalDir);
    var dir = Directory(finalDir);
    bool dirExists = await dir.exists();
    if (!dirExists) {
      dir.create();
    }
  }

  Future<dynamic> getGif() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gif'],
    );
    if (result != null) {
      PlatformFile selectedGif = result.files.first;
      Constants.selectedGifFile = File(selectedGif.path).readAsBytesSync();
      chooseGifFile();
      emit(CheckForKeysSuccess());
    }
  }

  dynamic chooseGifFile() {
    return CacheHelper.PutData(
        key: CacheHelper.GetData(key: 'channel') == 0
            ? 'chill'
            : CacheHelper.GetData(key: 'channel') == 1
                ? 'hiphop'
                : CacheHelper.GetData(key: 'channel') == 2
                    ? 'sad'
                    : 'rap',
        value: String.fromCharCodes(Constants.selectedGifFile));
  }

  void removeOneChannelGif() {
    CacheHelper.GetData(key: 'channel') == 0
        ? CacheHelper.sharedPreferences.remove('chill')
        : CacheHelper.GetData(key: 'channel') == 1
            ? CacheHelper.sharedPreferences.remove('hiphop')
            : CacheHelper.GetData(key: 'channel') == 2
                ? CacheHelper.sharedPreferences.remove('sad')
                : CacheHelper.sharedPreferences.remove('rap');
  }

  void clearOneChannelGif() {
    removeOneChannelGif();
    emit(GotGifSuccessful());
  }

  void clearAllChannelsGifs() {
    CacheHelper.sharedPreferences.remove('chill');
    CacheHelper.sharedPreferences.remove('hiphop');
    CacheHelper.sharedPreferences.remove('sad');
    CacheHelper.sharedPreferences.remove('rap');
    emit(ClearedAllGifsSuccessful());
  }

  bool checkForKey() {
    if (CacheHelper.GetData(key: 'chill') != null) {
      return true;
    } else if (CacheHelper.GetData(key: 'hiphop') != null) {
      return true;
    } else if (CacheHelper.GetData(key: 'sad') != null) {
      return true;
    } else if (CacheHelper.GetData(key: 'rap') != null) {
      return true;
    } else {
      return false;
    }
  }

  void checkForKeyWithFlags() {
    if (CacheHelper.GetData(key: 'channel') == 0) {
      if (CacheHelper.GetData(key: 'chill') != null) {
        Constants.channelFlagPresent = 'true';
        emit(CheckForKeysSuccess());
      }
    } else if (CacheHelper.GetData(key: 'channel') == 1) {
      if (CacheHelper.GetData(key: 'hiphop') != null) {
        Constants.channelFlagPresent = 'true';
        emit(CheckForKeysSuccess());
      }
    } else if (CacheHelper.GetData(key: 'channel') == 2) {
      if (CacheHelper.GetData(key: 'sad') != null) {
        Constants.channelFlagPresent = 'true';
        emit(CheckForKeysSuccess());
      }
    } else {
      if (CacheHelper.GetData(key: 'rap') != null) {
        Constants.channelFlagPresent = 'true';
        emit(CheckForKeysSuccess());
      }
    }
  }

  void getDeveloperMessage() {
    FirebaseFirestore.instance
        .collection('devmessage')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        developerMessage = MessageModel.fromJson(element.data());
      });
      emit(GotDeveloperMessageSuccess());
    });
  }

  void getMyLink() {
    FirebaseFirestore.instance
        .collection('shareLink')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        myGlobalLink = shareLinkModel.fromJson(element.data());
      });
      emit(GotLinkSuccessful());
    });
  }

  dynamic deleteLikeFromHomeScreen() {
    dynamic deleteLikeFlag;
    Constants.favouritesDatabase
        .rawQuery('SELECT * FROM LikedSongs')
        .then((value) {
      value.forEach((value) {
        if (value['name'] ==
            Constants.currentAudioMetadata.info.title
                .split('-')[1]
                .split('[')[0]) {
          Constants.favouritesDatabase.rawDelete(
              'DELETE FROM LikedSongs WHERE name = ?',
              [value['name']]).then((value) {
            getFromDatabase(Constants.favouritesDatabase);
            emit(DeletedFromHomeSuccess());
            Constants.isLiked = false;
            deleteLikeFlag = 'deleted';
            DefaultToast(
                message: 'Removed From Likes',
                fontsize: 12,
                Backgroundcolor: getThemeColor());
            emit(DeletedFromHomeSuccess());
          });
        } else {
          deleteLikeFlag = 'not deleted';
          emit(DeletedFromHomeError());
        }
      });
      if (deleteLikeFlag == 'not deleted') {
        Constants.isLiked = false;
        DefaultToast(
            message: 'Removed From Likes',
            fontsize: 12,
            Backgroundcolor: getThemeColor());
        emit(DeletedFromHomeSuccess());
      }
    });
  }

  void audioPlayedSuccessRefresh() {
    emit(AudioPlayedSuccess());
  }

  Future<bool> isInternet() async {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.mobile) {
        if (await DataConnectionChecker().hasConnection == true) {
          Constants.internetStatus = 'present';
          LayoutCubit()..playAudio();
          emit(InternetChecked());
          return true;
        } else {
          Constants.internetStatus = 'not present';
          emit(InternetChecked());
          return false;
        }
      } else if (result == ConnectivityResult.wifi) {
        if (await DataConnectionChecker().hasConnection == true) {
          Constants.internetStatus = 'present';
          LayoutCubit()..playAudio();
          emit(InternetChecked());
          return true;
        } else {
          Constants.internetStatus = 'not present';
          emit(InternetChecked());
          return false;
        }
      } else {
        Constants.internetStatus = 'not present';
        emit(InternetChecked());
        return false;
      }
    });
  }

  void deleteAllFavouritesDatabase() {
    Constants.favouritesDatabase
        .rawDelete(
      'DELETE FROM LikedSongs',
    )
        .then((value) {
      emit(DeleteAllFavouritesSuccess());
      getFromDatabase(Constants.favouritesDatabase);
      Constants.isLiked = null;
      emit(DeleteAllFavouritesSuccess());
    }).catchError((error) {
      emit(DeleteAllFavouritesError());
    });
  }

  String _chooseChannel() {
    return CacheHelper.GetData(key: 'channel') == 0
        ? 'messageschill'
        : CacheHelper.GetData(key: 'channel') == 1
            ? 'messageshiphop'
            : CacheHelper.GetData(key: 'channel') == 2
                ? 'messagessad'
                : 'messagesrap';
  }

  void sendMessage({
    String text,
    String name,
    String time,
    String uID,
  }) {
    MessageModel message = MessageModel(
        uID: uID,
        text: text,
        datetime: FieldValue.serverTimestamp(),
        name: name,
        time: time);
    FirebaseFirestore.instance
        .collection(_chooseChannel())
        .add(message.ToMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError());
    });
  }

  void changeMessages(String channelName) async {
    emit(ChangedMessagesSuccess());
    await fetchUserData();
    return await FirebaseFirestore.instance
        .collection(channelName)
        .get()
        .then((value) async {
      value.docs.forEach((z) {
        if (CacheHelper.GetData(key: 'uID') == z.get('uID')) {
          z.reference.update({
            'name': userModel.name,
          }).then((value) async {
            emit(ChangedMessagesSuccess());
          });
        }
      });
    });
  }

  Future<dynamic> removeMessages(String channelName) async {
    emit(RemovedMessagesSuccess());
    await fetchUserData();
    return await FirebaseFirestore.instance
        .collection(channelName)
        .get()
        .then((value) async {
      value.docs.forEach((z) {
        if (CacheHelper.GetData(key: 'uID') == z.get('uID')) {
          z.reference.delete().then((value) async {
            await fetchUserData();
            emit(RemovedMessagesSuccess());
          });
        }
      });
    });
  }

  void getMessages() {
    FirebaseFirestore.instance
        .collection(CacheHelper.GetData(key: 'channel') == 0
            ? 'messageschill'
            : CacheHelper.GetData(key: 'channel') == 1
                ? 'messageshiphop'
                : CacheHelper.GetData(key: 'channel') == 2
                    ? 'messagessad'
                    : 'messagesrap')
        .orderBy('datetime')
        .limitToLast(12)
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccess());
    });
  }

  String getAlbumCover() {
    return CacheHelper.GetData(key: 'channel') == 0
        ? 'assets/images/coverchill.jpg'
        : CacheHelper.GetData(key: 'channel') == 1
            ? "assets/images/coverclassic.jpg"
            : CacheHelper.GetData(key: 'channel') == 2
                ? "assets/images/coversad.jpg"
                : "assets/images/coverrap.jpg";
  }

//http://hyades.shoutca.st:8043/stream2 => rap lofi
//https://hunter.fm/radio-lo-fi/
//http://198.245.60.88:8080/stream
//http://hyades.shoutca.st:8043/stream
}
