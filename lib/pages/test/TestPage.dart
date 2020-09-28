import 'package:Flashcards/data/model/TestCard.dart';
import 'package:Flashcards/pages/homepage/HomePage.dart';
import 'package:Flashcards/pages/test/TestPageViewModel.dart';
import 'package:Flashcards/utils/style/ColorPalette.dart';
import 'package:Flashcards/widget/CustomModal.dart';
import 'package:Flashcards/widget/cards/CardSideA.dart';
import 'package:Flashcards/widget/cards/CardSideB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';

class TestPage extends StatefulWidget {
  final List<TestCard> cards;
  final TestMode mode;

  TestPage({this.cards, this.mode});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  Color backgroundColor;
  bool isCorrectTarget;
  bool isWrongTarget;

  @override
  void initState() {
    super.initState();
    backgroundColor = ColorPalette.secondaryColor;
    isCorrectTarget = false;
    isWrongTarget = false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TestPageViewModel>(
      create: (context) => TestPageViewModel(),
      builder: (context, _) => Scaffold(
        backgroundColor: backgroundColor,
        body: context.select<TestPageViewModel, bool>((value) => value.currentIndex == widget.cards.length)
            ? GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (route) => false,
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'NO CARDS LEFT',
                    style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                  ),
                ),
              )
            : Draggable<TestCard>(
                childWhenDragging: widget.mode == TestMode.DailyTest
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DragTarget<TestCard>(
                            builder: (context, listCards, _) => Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              color: Colors.transparent,
                              alignment: Alignment.topCenter,
                              child: Text(
                                isCorrectTarget ? 'CORRECT' : '',
                                style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                              ),
                            ),
                            onWillAccept: (data) {
                              setState(() {
                                backgroundColor = Colors.red;
                                isWrongTarget = true;
                              });
                              return true;
                            },
                            onAccept: (data) {
                              context.read<TestPageViewModel>().wrongAnswer(data);
                              if (context.read<TestPageViewModel>().currentIndex == widget.cards.length - 1) {
                                CustomModal.showFinishedModal(
                                  context,
                                  widget.cards.length,
                                  context.read<TestPageViewModel>().correctCount,
                                ).then(
                                  (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                    (route) => false,
                                  ),
                                );
                              }
                            },
                            onLeave: (data) => setState(
                              () {
                                backgroundColor = ColorPalette.secondaryColor;
                                isWrongTarget = false;
                              },
                            ),
                          ),
                          DragTarget<TestCard>(
                            builder: (context, listCards, _) => Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              color: Colors.transparent,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                isWrongTarget ? 'WRONG' : '',
                                style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                              ),
                            ),
                            onWillAccept: (data) {
                              setState(() {
                                backgroundColor = Colors.green;
                                isCorrectTarget = true;
                              });
                              return true;
                            },
                            onAccept: (data) {
                              context.read<TestPageViewModel>().correctAnswer(data);
                              if (context.read<TestPageViewModel>().currentIndex == widget.cards.length - 1) {
                                CustomModal.showFinishedModal(
                                  context,
                                  widget.cards.length,
                                  context.read<TestPageViewModel>().correctCount,
                                );
                              }
                            },
                            onLeave: (data) => setState(
                              () {
                                backgroundColor = ColorPalette.secondaryColor;
                                isCorrectTarget = false;
                              },
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DragTarget<TestCard>(
                            builder: (context, listCards, _) => Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.transparent,
                            ),
                            onAccept: (data) {
                              if (context.read<TestPageViewModel>().currentIndex == widget.cards.length - 1) {
                                Navigator.of(context).pop();
                              } else {
                                context.read<TestPageViewModel>().nextCard();
                              }
                            },
                          ),
                          DragTarget<TestCard>(
                            builder: (context, listCards, _) => Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.transparent,
                            ),
                            onAccept: (data) {
                              if (context.read<TestPageViewModel>().currentIndex == 0) {
                                Navigator.of(context).pop();
                              } else {
                                context.read<TestPageViewModel>().previousCard();
                              }
                            },
                          ),
                        ],
                      ),
                onDragEnd: (details) => setState(
                  () {
                    backgroundColor = ColorPalette.secondaryColor;
                    isWrongTarget = false;
                    isCorrectTarget = false;
                  },
                ),
                data: context.select<TestPageViewModel, TestCard>((value) => widget.cards[value.currentIndex]),
                feedback: CardSideA(
                  definition: context
                      .select<TestPageViewModel, String>((value) => widget.cards[value.currentIndex].definition),
                  color: context.select<TestPageViewModel, Color>((value) => widget.cards[value.currentIndex].color),
                ),
                child: FlipCard(
                  front: CardSideA(
                    definition: context
                        .select<TestPageViewModel, String>((value) => widget.cards[value.currentIndex].definition),
                    color:
                        context.select<TestPageViewModel, Color>((value) => widget.cards[value.currentIndex].color),
                  ),
                  back: CardSideB(
                    definition: context
                        .select<TestPageViewModel, String>((value) => widget.cards[value.currentIndex].definition),
                    description: context
                        .select<TestPageViewModel, String>((value) => widget.cards[value.currentIndex].description),
                    color:
                        context.select<TestPageViewModel, Color>((value) => widget.cards[value.currentIndex].color),
                  ),
                ),
              ),
      ),
    );
  }
}

enum TestMode {
  DailyTest,
  Overview,
}
