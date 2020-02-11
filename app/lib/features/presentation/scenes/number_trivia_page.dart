import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/presentation/widgets/loading_widget.dart';
import 'package:number_trivia/features/presentation/widgets/message_display.dart';
import 'package:number_trivia/features/presentation/widgets/trivia_controls.dart';
import 'package:number_trivia/features/presentation/widgets/trivia_display.dart';
import 'package:number_trivia/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<NumberTriviaBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                //Top half
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(message: "Start searching!");
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  }
                }),
                SizedBox(
                  height: 20.0,
                ),
                TriviaControls()
              ],
            ),
          ),
        ));
  }
}