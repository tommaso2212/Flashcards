import 'package:Flashcards/pages/IViewModel.dart';
import 'package:Flashcards/pages/homepage/HomePageViewModel.dart';
import 'package:Flashcards/pages/stats/Stats.dart';
import 'package:Flashcards/utils/style/ColorPalette.dart';
import 'package:Flashcards/utils/style/CustomTextStyle.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:Flashcards/widget/SetTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageViewModel>(
      create: (context) => HomePageViewModel(),
      builder: (context, _) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Flashcards',
                  style: CustomTextStyle.headline5.copyWith(color: Colors.white),
                ),
                background: Image.asset(
                  'res/images/appBar_background.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                context.select<HomePageViewModel, bool>((value) => value.currentState == States.LOADING)
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
                        .select<HomePageViewModel, List<Set>>((value) => value.sets)
                        .map(
                          (e) => SetTile(
                            title: e.title,
                            color: ColorPalette.fromHex(e.color),
                            length: e.cards.length,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Stats(selectedSet: e),
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            )
          ],
        ),
        floatingActionButton: Container(
          height: MediaQuery.of(context).size.width * 0.23,
          width: MediaQuery.of(context).size.width * 0.23,
          child: FloatingActionButton(
            onPressed: () {},
            elevation: 20,
            backgroundColor: ColorPalette.primaryColor,
            child: Icon(
              Icons.play_arrow,
              size: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment_turned_in,
              ),
              title: Text('10'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              title: Text('20'),
            ),
          ],
        ),
      ),
    );
  }
}
