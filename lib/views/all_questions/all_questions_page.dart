import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbrojak/bloc/all_questions/all_questions_bloc.dart';
import 'package:zbrojak/components/_page/side_page.dart';
import 'package:zbrojak/components/question/question_widget.dart';
import 'package:zbrojak/services/prefs_repo.dart';

class AllQuestionsPage extends StatelessWidget {
  AllQuestionsPage({Key? key}) : super(key: key);

  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllQuestionsBloc(
        prefs: context.read<PrefsRepo>(),
      )..add(LoadQuestions()),
      child: Builder(builder: (context) {
        return SidePage(
          body: _buildBody(context),
          controlButtons: [
            IconButton(
              onPressed: () {
                carouselController.jumpToPage(0);
              },
              icon: const Icon(Icons.restart_alt),
            )
          ],
        );
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocBuilder<AllQuestionsBloc, AllQuestionsState>(
      builder: (context, state) {
        if (state is AllQuestionsLoaded) {
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: state.initIndex,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                BlocProvider.of<AllQuestionsBloc>(context).add(
                  QuestionIndexChanged(index: index),
                );
              },
            ),
            carouselController: carouselController,
            items: state.questions.map((question) {
              return QuestionWidget(
                question: question,
                onAnswer: (_, __) {},
                shuffle: false,
                showCorrect: true,
              );
            }).toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
