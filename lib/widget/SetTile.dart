import 'package:Flashcards/utils/style/CustomTextStyle.dart';
import 'package:Flashcards/widget/CustomIcons.dart';
import 'package:flutter/material.dart';

class SetTile extends StatelessWidget {
  final String title;
  final Color color;
  final int length;
  final Function onTap;
  final Function onLongPress;
  final bool isActive;

  SetTile({this.title, this.color, this.length, this.onTap, this.onLongPress, this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      child: RaisedButton(
        onPressed: onTap,
        onLongPress: onLongPress,
        elevation: 10,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06,
          vertical: MediaQuery.of(context).size.height * 0.03,
        ),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            width: 2,
            color: color,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: CustomTextStyle.headline5.copyWith(
                color: color,
              ),
            ),
            isActive ? 
            Row(
              children: [
                Text(
                  length.toString() + ' ',
                  style: CustomTextStyle.headline6.copyWith(
                    color: color,
                  ),
                ),
                Icon(
                  CustomIcons.box,
                ),
              ],
            ) : Icon(Icons.clear),
          ],
        ),
      ),
    );
  }
}
