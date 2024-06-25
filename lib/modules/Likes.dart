import 'package:flutter/material.dart';
import 'package:lo_fi_radio_app/modules/Home_Screen_Cubit/cubit.dart';
import 'package:lo_fi_radio_app/modules/Home_Screen_Cubit/states.dart';
import 'package:lo_fi_radio_app/modules/ListOfChannels.dart';
import 'package:lo_fi_radio_app/shared/components/components.dart';
import 'package:lo_fi_radio_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo_fi_radio_app/shared/styles/colors.dart';

class Likes_Screen extends StatefulWidget {
  @override
  _Likes_ScreenState createState() => _Likes_ScreenState();
}

class _Likes_ScreenState extends State<Likes_Screen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, HomeStates>(
      listener: (context, state) {
        if (state is RapAudioChecked) {
          setState(() {
            Constants.isLiked = null;
          });
        }
      },
      builder: (context, state) {
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
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 25,
                    ),
                  ),
                ),
                title: Text(
                  'Likes',
                  style: TextStyle(
                    fontFamily: 'Vcr',
                  ),
                ),
                actions: [
                  TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(ThemeColors.button),
                      ),
                      onPressed: () {
                        LayoutCubit.get(context).deleteAllFavouritesDatabase();
                        if (LayoutCubit.get(context).favourites.length > 0) {
                          DefaultToast(
                              message: 'Removed All Likes',
                              fontsize: 14,
                              Backgroundcolor:
                                  LayoutCubit.get(context).getThemeColor());
                        } else {
                          DefaultToast(
                              message: 'No Likes To Remove',
                              fontsize: 14,
                              Backgroundcolor:
                                  LayoutCubit.get(context).getThemeColor());
                        }
                      },
                      child: Text(
                        'Delete All Likes',
                        style: TextStyle(
                          fontFamily: 'Vcr',
                          fontSize: 10,
                          color: LayoutCubit.get(context).getThemeColor(),
                        ),
                      )),
                ],
                centerTitle: true,
                elevation: 20,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: LayoutCubit.get(context).favourites.length > 0 &&
                                LayoutCubit.get(context).favourites != null
                            ? ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return BuildLike(
                                      LayoutCubit.get(context)
                                          .favourites[index],
                                      context);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 25,
                                  );
                                },
                                itemCount:
                                    LayoutCubit.get(context).favourites.length)
                            : Center(
                                child: Text(
                                  'No Likes Added Yet!',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Vcr'),
                                ),
                              )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              )),
        );
      },
    );
  }
}
