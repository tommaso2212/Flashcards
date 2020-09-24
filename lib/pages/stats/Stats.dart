import 'package:Flashcards/pages/IViewModel.dart';
import 'package:Flashcards/pages/stats/StatsViewModel.dart';
import 'package:Flashcards/utils/BoxUtils.dart';
import 'package:Flashcards/utils/style/ColorPalette.dart';
import 'package:Flashcards/utils/style/CustomTextStyle.dart';
import 'package:Flashcards/widget/SetTile.dart';
import 'package:flutter/material.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:provider/provider.dart';

class Stats extends StatelessWidget {
  final Set selectedSet;

  const Stats({this.selectedSet});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StatsViewModel>(
      create: (context) => StatsViewModel(selectedSet),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            selectedSet.title,
            style: CustomTextStyle.headline5.copyWith(
              color: Colors.white,
            ),
          ),
          backgroundColor: ColorPalette.fromHex(selectedSet.color),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                context.select<StatsViewModel, bool>((value) => value.currentState == States.LOADING)
                    ? [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1,
                          ),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation(
                              ColorPalette.primaryColor,
                            ),
                          ),
                        )
                      ]
                    : context
                        .select<StatsViewModel, Map<Boxes, int>>((value) => value.boxes)
                        .entries
                        .map(
                          (e) => SetTile(
                              title: BoxUtils.boxTitle[e.key],
                              color: ColorPalette.fromHex(selectedSet.color),
                              length: e.value,
                              onTap: () {}),
                        )
                        .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
