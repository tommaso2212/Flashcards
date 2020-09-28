import 'package:Flashcards/utils/style/ColorPalette.dart';
import 'package:Flashcards/widget/CustomIcons.dart';
import 'package:flutter/material.dart';
import 'package:katex_flutter/katex_flutter.dart';

class CardSideB extends StatelessWidget {
  final String definition;
  final String description;
  final Color color;

  CardSideB({@required this.definition, @required this.description, @required this.color});

  List<Widget> parseDescription(BuildContext context) {
    List<Widget> widgets = [];
    List<String> str = description.split(r'#\');
    str.forEach((element) {
      if (element != '') {
        List<String> latexValue = element.split(r'#{');
        String value = latexValue[1].replaceFirst(RegExp(r'#}'), '');
        switch (latexValue[0]) {
          case 'text': // #\text{testo}
            widgets.add(
              Text(
                value,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
            break;
          case 'image': // #\image{url}
            widgets.add(
              Image.network(
                value,
              ),
            );
            break;
          case 'math': // #\math{formula}
            widgets.add(
              Container(
                child: KaTeX(
                    laTeXCode: Text(
                  r'$$' + value + r'$$',
                  style: Theme.of(context).textTheme.bodyText1,
                )),
              ),
            );
            break;
        }
      }
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: color,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.2,
              bottom: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Icon(
              CustomIcons.vacuumTube,
              color: ColorPalette.secondaryColor,
              size: MediaQuery.of(context).size.width * 0.25,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2,
            ),
            child: Text(
              definition.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.copyWith(color: color),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: parseDescription(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
