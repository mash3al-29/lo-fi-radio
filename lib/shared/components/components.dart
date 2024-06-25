import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lo_fi_radio_app/models/messages.dart';
import 'package:lo_fi_radio_app/modules/Home_Screen_Cubit/cubit.dart';
import 'package:lo_fi_radio_app/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

Widget defaultButton({
  context,
  bool isUpperCase = false,
  double width = double.infinity,
  Color color,
  double radius = 0.0,
  @required Function function,
  @required String text,
  double elevation = 20,
  Color textColor = Colors.white,
}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(radius),
        color: color != null ? color : ThemeColors.orangeAccent,
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        elevation: elevation,
        height: 30,
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                color: LayoutCubit.get(context).getThemeColor(),
                fontFamily: 'Vcr',
                fontSize: 13)),
      ),
    );

Widget defaultTextFormField({
  @required TextEditingController controller,
  String LabelText,
  Function SubmitFunction,
  Function ChangeFunction,
  IconData prefixicon,
  @required Function validate,
  Widget SufixIcon,
  bool isObscure = false,
  Function isSuffixpressed,
  Function onTap,
  bool enabled,
  Color iconcolor,
  String hinttext,
  Color cursor,
  Color hover,
  var keyboardtype,
  var maxlines,
}) =>
    TextFormField(
      textInputAction: TextInputAction.done,
      style: TextStyle(color: Colors.white, fontFamily: 'Vcr'),
      cursorColor: cursor,
      controller: controller,
      onFieldSubmitted: SubmitFunction,
      onChanged: ChangeFunction,
      enabled: enabled,
      keyboardType: keyboardtype,
      maxLines: maxlines,
      obscureText: isObscure,
      onTap: onTap,
      decoration: InputDecoration(
          filled: true,
          errorStyle: TextStyle(fontFamily: 'Vcr'),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[800], width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[800], width: 2.0),
          ),
          fillColor: Colors.grey[800],
          hoverColor: hover,
          focusColor: Colors.grey[400],
          labelStyle: TextStyle(fontSize: 15, color: Colors.grey[400]),
          labelText: LabelText,
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey[400]),
          suffixIcon: SufixIcon),
      validator: validate,
    );

void DefaultToast({
  @required String message,
  Color Backgroundcolor,
  @required double fontsize,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor:
        Backgroundcolor != null ? Backgroundcolor : ThemeColors.purple,
    textColor: Colors.white,
    fontSize: fontsize,
  );
}

Widget buildAboutMeButton(
    String url, String text, IconData icon, dynamic context) {
  return InkWell(
    customBorder:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
    onTap: () async {
      String googleUrl = url;
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        DefaultToast(
            message: 'Something Wrong Has Happened! Please Try Again Later',
            fontsize: 12,
            Backgroundcolor: LayoutCubit.get(context).getThemeColor());
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: LayoutCubit.get(context).getThemeColor(),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Vcr'),
          ),
        ],
      ),
    ),
  );
}

Widget buildAboutMeText(String text) {
  return Text(
    text,
    style:
        TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Vcr'),
  );
}

Widget buildAboutMeSecondaryText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Vcr',
    ),
    textAlign: TextAlign.start,
  );
}

Widget buildChatItem(
  MessageModel model,
  context,
) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  DateFormat('hh:mm a').format(DateTime.parse(model.time)),
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Arial', fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    model.time.split(" ")[0].split("-")[2] +
                        '-' +
                        model.time.split(" ")[0].split("-")[1] +
                        '-' +
                        model.time.split(" ")[0].split("-")[0],
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Arial',
                        fontSize: 12)),
              ],
            ),
            SizedBox(
              width: 13,
            ),
            Text(
              '${model.name} :',
              style: TextStyle(
                  color: LayoutCubit.get(context).getThemeColor(),
                  fontFamily: 'Arial',
                  fontSize: 14),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.text,
                    style: TextStyle(
                        fontFamily: 'Vcr', color: Colors.white, fontSize: 14),
                    maxLines: 20,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildDeveloperMessage(MessageModel developerMessage, dynamic context) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: Colors.black38,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  developerMessage.time,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Arial', fontSize: 14),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  developerMessage.name,
                  style: TextStyle(
                      color: LayoutCubit.get(context).getThemeColor(),
                      fontFamily: 'Arial',
                      fontSize: 14),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        developerMessage.text,
                        style: TextStyle(
                            fontFamily: 'Vcr',
                            color: Colors.white,
                            fontSize: 14),
                        maxLines: 20,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget BuildLike(dynamic audioDetails, context) {
  return InkWell(
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    onTap: () {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: 290,
            height: 290,
            color: ThemeColors.background,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          child: Image.asset(
                            audioDetails['channel'] == 0
                                ? 'assets/images/coverchill.jpg'
                                : audioDetails['channel'] == 1
                                    ? 'assets/images/coverclassic.jpg'
                                    : audioDetails['channel'] == 2
                                        ? 'assets/images/coversad.jpg'
                                        : 'assets/images/coverrap.jpg',
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                audioDetails['name'],
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: LayoutCubit.get(context)
                                        .getThemeColor(),
                                    fontFamily: 'Vcr',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                audioDetails['artist'] == 'Unknown '
                                    ? 'Lo-Fi Radio Exclusive'
                                    : audioDetails['artist'],
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Arial',
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      LayoutCubit.get(context).deleteLikeFromDatabase(
                          audioDetails['id'], audioDetails['name']);
                      DefaultToast(
                          message: 'Removed From Likes',
                          fontsize: 14,
                          Backgroundcolor:
                              LayoutCubit.get(context).getThemeColor());
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Delete From Likes',
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Share.share(
                          "I'm listening to ${audioDetails['name']} made by ${audioDetails['artist']}! - Download Lo-Fi Radio From Here: https://galaxy.store/lofiradio or Here: ${LayoutCubit.get(context).myGlobalLink.sharedLink}",
                          subject: 'Look At This Song!');
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Share This Song',
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      String googleUrl =
                          'https://www.google.com/search?q=${audioDetails['name']}+-+${audioDetails['artist']}&oq=${audioDetails['name']}+-${audioDetails['artist']}&aqs=chrome..69i57j69i59j35i39j0i512l2j0i20i263i512l2j69i60.1446j0j7&sourceid=chrome&ie=UTF-8';
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
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Search On Google',
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text:
                              '${audioDetails['name']} - ${audioDetails['artist']}'));
                      DefaultToast(
                          message: 'Copied To Clipboard',
                          fontsize: 12,
                          Backgroundcolor:
                              LayoutCubit.get(context).getThemeColor());
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.copy,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Copy Title',
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      );
    },
    child: Container(
      width: 60,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            child: ClipRRect(
              child: Image.asset(
                audioDetails['channel'] == 0
                    ? 'assets/images/coverchill.jpg'
                    : audioDetails['channel'] == 1
                        ? 'assets/images/coverclassic.jpg'
                        : audioDetails['channel'] == 2
                            ? 'assets/images/coversad.jpg'
                            : 'assets/images/coverrap.jpg',
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    audioDetails['name'],
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: LayoutCubit.get(context).getThemeColor(),
                        fontFamily: 'Vcr',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Text(
                      audioDetails['artist'] == 'Unknown '
                          ? 'Lo-Fi Radio Exclusive'
                          : audioDetails['artist'],
                      textAlign: TextAlign.left,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Arial',
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
