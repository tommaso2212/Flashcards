import 'package:Flashcards/data/model/TestCard.dart';
import 'package:Flashcards/pages/IViewModel.dart';
import 'package:Flashcards/pages/homepage/HomePageViewModel.dart';
import 'package:Flashcards/pages/stats/Stats.dart';
import 'package:Flashcards/pages/test/TestPage.dart';
import 'package:Flashcards/utils/style/ColorPalette.dart';
import 'package:Flashcards/utils/style/CustomTextStyle.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:Flashcards/widget/CustomModal.dart';
import 'package:Flashcards/widget/SetTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageViewModel>(
      create: (context) => HomePageViewModel(),
      builder: (context, _) {
        //context.select<HomePageViewModel, void>((value) => value.init());
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomPadding: false,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                actions: [
                  Container(
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.03,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        var response = await CustomModal.showAddJSONModal(context);
                        if (response != null && !response) {
                          scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text('Error'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
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
                          .select<HomePageViewModel, Map<Set, bool>>((value) => value.sets)
                          .entries
                          .map(
                            (e) => SetTile(
                              title: e.key.title,
                              color: ColorPalette.fromHex(e.key.color),
                              length: e.key.cards.length,
                              isActive: context.watch<HomePageViewModel>().sets[e.key],
                              onTap: () => context.read<HomePageViewModel>().changeActiveSet(e.key),
                              onLongPress: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Stats(selectedSet: e.key),
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
              onPressed: () {
                List<TestCard> cards = context.read<HomePageViewModel>().todaysCards;
                if (cards.length > 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TestPage(
                        cards: cards..shuffle(),
                        mode: TestMode.DailyTest,
                      ),
                    ),
                  );
                }
              },
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
                title: Text(
                  context.select<HomePageViewModel, bool>((value) => value.currentState == States.LOADING)
                      ? '-'
                      : context.watch<HomePageViewModel>().todaysDone().toString(),
                  style: CustomTextStyle.caption,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.today),
                title: Text(
                  context.select<HomePageViewModel, bool>((value) => value.currentState == States.LOADING)
                      ? '-'
                      : context.watch<HomePageViewModel>().todaysCards.length.toString(),
                  style: CustomTextStyle.caption,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
