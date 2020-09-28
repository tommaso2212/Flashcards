import 'package:Flashcards/data/dataaccess/InsertQuery.dart';
import 'package:Flashcards/pages/homepage/HomePage.dart';
import 'package:Flashcards/utils/style/ColorPalette.dart';
import 'package:flutter/material.dart';

class PathInput extends StatefulWidget {
  @override
  _PathInputState createState() => _PathInputState();
}

class _PathInputState extends State<PathInput> {
  TextEditingController textEditingController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<bool> selected;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    selected = [true, false];
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Insert JSON path/url',
                labelText: 'Path/URL',
              ),
              controller: textEditingController,
              cursorColor: ColorPalette.primaryColor,
              style: Theme.of(context).textTheme.bodyText1,
              validator: (value) {
                if (value == '') return 'Must not be empty.';
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03,
            ),
            child: ToggleButtons(
              borderColor: ColorPalette.secondaryColor,
              selectedBorderColor: ColorPalette.primaryColor,
              borderRadius: BorderRadius.circular(10),
              borderWidth: 1,
              fillColor: ColorPalette.primaryColor,
              children: [
                Text(
                  'PATH',
                  style: Theme.of(context).textTheme.caption.copyWith(color: selected[0] ? Colors.white : Colors.black),
                ),
                Text(
                  'URL',
                  style: Theme.of(context).textTheme.caption.copyWith(color: selected[1] ? Colors.white : Colors.black),
                ),
              ],
              isSelected: selected,
              onPressed: (index) {
                int old = selected.indexWhere((element) => element == true);
                setState(() {
                  selected[old] = false;
                  selected[index] = true;
                });
              },
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.06,
            child: RaisedButton(
              onPressed: () {
                
                if (formKey.currentState.validate()) {
                  if (selected[0]) {
                    InsertQuery().insertFromJson(null, textEditingController.text).then((value) {
                      print(value);
                      if (value) {
                        
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false,
                        );
                      } else {
                        Navigator.of(context).pop(false);
                      }
                    });
                  } else if (selected[1]) {
                    InsertQuery().insertFromJson(textEditingController.text, null);
                  }
                }
              },
              elevation: 0,
              color: ColorPalette.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'ADD',
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
