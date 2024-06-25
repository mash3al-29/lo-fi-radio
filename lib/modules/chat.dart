import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lo_fi_radio_app/shared/components/components.dart';
import 'package:lo_fi_radio_app/shared/components/constants.dart';
import 'package:lo_fi_radio_app/shared/network/local/Cache_Helper.dart';
import 'package:lo_fi_radio_app/shared/styles/colors.dart';
import 'Home_Screen_Cubit/cubit.dart';
import 'Home_Screen_Cubit/states.dart';
import 'ListOfChannels.dart';

class Chat_Screen extends StatefulWidget {
  @override
  _Chat_ScreenState createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  TextEditingController controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    if (Constants.internetStatus == 'present') {
      return Form(
        key: formKey,
        child: Builder(
          builder: (BuildContext context) {
            LayoutCubit.get(context).getMessages();
            LayoutCubit.get(context).getDeveloperMessage();
            return WillPopScope(
              onWillPop: () async {
                LayoutCubit.get(context).resetLikeStatus();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => List_Of_Channels()),
                  (route) => false,
                );
                return true;
              },
              child: Scaffold(
                body: BlocConsumer<LayoutCubit, HomeStates>(
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
                    return StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Scaffold(
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
                                            builder: (context) =>
                                                List_Of_Channels()),
                                        (route) => false);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_rounded,
                                    size: 25,
                                  ),
                                ),
                              ),
                              title: Text(
                                'Chat',
                                style: TextStyle(fontFamily: 'Vcr'),
                              ),
                              centerTitle: true,
                              elevation: 20,
                              actions: [
                                TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          ThemeColors.button),
                                    ),
                                    onPressed: () {
                                      LayoutCubit.get(context).signOut();
                                      LayoutCubit.get(context).fetchUserData();
                                      DefaultToast(
                                          message: 'Logged Out',
                                          fontsize: 14,
                                          Backgroundcolor:
                                              LayoutCubit.get(context)
                                                  .getThemeColor());
                                    },
                                    child: Text("Log Out",
                                        style: TextStyle(
                                          fontFamily: 'Vcr',
                                          color: LayoutCubit.get(context)
                                              .getThemeColor(),
                                        ))),
                              ],
                            ),
                            body: Column(
                              children: [
                                CacheHelper.GetData(key: 'hided') == false ||
                                        CacheHelper.GetData(key: 'hided') ==
                                            null
                                    ? buildDeveloperMessage(
                                        LayoutCubit.get(context)
                                            .developerMessage,
                                        context)
                                    : Container(),
                                Expanded(
                                  child: ListView.separated(
                                    controller: scrollController,
                                    physics: BouncingScrollPhysics(),
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(
                                      height: 15,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return buildChatItem(
                                          LayoutCubit.get(context)
                                              .messages[index],
                                          context);
                                    },
                                    itemCount: LayoutCubit.get(context)
                                        .messages
                                        .length,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: defaultTextFormField(
                                          maxlines: null,
                                          keyboardtype: TextInputType.multiline,
                                          onTap: () {
                                            Timer(
                                              Duration(milliseconds: 200),
                                              () => scrollController.animateTo(
                                                scrollController
                                                    .position.maxScrollExtent,
                                                duration:
                                                    Duration(milliseconds: 200),
                                                curve: Curves.fastOutSlowIn,
                                              ),
                                            );
                                          },
                                          cursor: LayoutCubit.get(context)
                                              .getThemeColor(),
                                          hover: LayoutCubit.get(context)
                                              .getThemeColor(),
                                          controller: controller,
                                          hinttext: 'Write A Message ...',
                                          validate: (String value) {
                                            if (value.isEmpty ||
                                                controller.text.trim() == '' ||
                                                Constants.filter
                                                        .hasProfanity(value) ==
                                                    true) {
                                              return 'Please Enter A Respectful Valid Message!';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      color: ThemeColors.transparent,
                                      clipBehavior: Clip.hardEdge,
                                      shape: CircleBorder(),
                                      splashColor: ThemeColors.button,
                                      height: 50,
                                      elevation: 0,
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                          LayoutCubit.get(context).sendMessage(
                                            name: LayoutCubit.get(context)
                                                .userModel
                                                .name,
                                            text: controller.text,
                                            time: DateTime.now().toString(),
                                            uID:
                                                CacheHelper.GetData(key: 'uID'),
                                          );
                                          controller.clear();
                                        }
                                      },
                                      minWidth: 1,
                                      child: Icon(
                                        Icons.send,
                                        size: 25,
                                        color: LayoutCubit.get(context)
                                            .getThemeColor(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Something Went Wrong!',
                              style: TextStyle(fontFamily: 'Vcr'),
                            ),
                          );
                        } else {
                          return Scaffold(
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
                                            builder: (context) =>
                                                List_Of_Channels()),
                                        (route) => false);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_rounded,
                                    size: 25,
                                  ),
                                ),
                              ),
                              title: Text(
                                'Chat',
                                style: TextStyle(
                                  fontFamily: 'Vcr',
                                ),
                              ),
                              centerTitle: true,
                              elevation: 20,
                            ),
                            body: BlocConsumer<LayoutCubit, HomeStates>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        LayoutCubit.get(context)
                                            .signUpUsingGoogle(
                                                context: context);
                                      },
                                      label: Text(
                                        'Sign In With Google',
                                        style: TextStyle(
                                            fontFamily: 'Arial',
                                            fontWeight: FontWeight.w800),
                                      ),
                                      icon: Icon(
                                        FontAwesomeIcons.google,
                                        color: LayoutCubit.get(context)
                                            .getThemeColor(),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        onPrimary: Colors.black,
                                        minimumSize: Size(double.infinity, 50),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Scaffold(
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
                    MaterialPageRoute(builder: (context) => List_Of_Channels()),
                    (route) => false);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 25,
              ),
            ),
          ),
          title: Text(
            'Chat',
            style: TextStyle(fontFamily: 'Vcr'),
          ),
          centerTitle: true,
          elevation: 20,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'No Internet Connection',
                style: TextStyle(
                  fontFamily: 'Vcr',
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    LayoutCubit.get(context).getMessages();
                  });
                },
                color: LayoutCubit.get(context).getThemeColor(),
                child: Text(
                  'Retry',
                  style: TextStyle(
                      color: Colors.white, fontSize: 12, fontFamily: 'Vcr'),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
