import 'package:Flashcards/data/dataaccess/DeleteQuery.dart';
import 'package:Flashcards/pages/homepage/HomePage.dart';
import 'package:Flashcards/utils/style/ColorPalette.dart';
import 'package:Flashcards/utils/style/CustomTextStyle.dart';
import 'package:Flashcards/widget/PathInput.dart';
import 'package:flutter/material.dart';

class CustomModal {
  static Future<bool> showFinishedModal(BuildContext context, int totalCard, int correctAnswer) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
          horizontal: MediaQuery.of(context).size.width * 0.1,
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Text(
                'Results:',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.check,
                    size: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Text(
                    correctAnswer.toString(),
                    style: CustomTextStyle.subTitle2,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.clear,
                    size: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Text(
                    (totalCard - correctAnswer).toString(),
                    style: CustomTextStyle.subTitle2,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.06,
              child: RaisedButton(
                onPressed: () => Navigator.of(context).pop(true),
                elevation: 0,
                color: ColorPalette.primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'HOMEPAGE',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool> showAddJSONModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
          horizontal: MediaQuery.of(context).size.width * 0.1,
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Text(
                'Add set:',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.left,
              ),
            ),
            PathInput(),
          ],
        ),
      ),
    );
  }

  static Future<bool> showConfirmDeleteModal(BuildContext context, String setTitle) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
          horizontal: MediaQuery.of(context).size.width * 0.1,
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Text(
                'Delete set?',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Text(
                setTitle,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.06,
              child: RaisedButton(
                onPressed: () async => await DeleteQuery().deleteSet(setTitle).then(
                      (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                        (route) => false,
                      ),
                    ),
                elevation: 0,
                color: ColorPalette.primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'CONFIRM',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
