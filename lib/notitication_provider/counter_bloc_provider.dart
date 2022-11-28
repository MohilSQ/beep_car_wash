import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';

import 'counter_bloc.dart';

class CounterBlocProvider extends BlocProvider<CounterBloc> {
  CounterBlocProvider({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          creator: (context, bag) {
            return CounterBloc();
          },
        );

  static CounterBloc of(BuildContext context) => BlocProvider.of(context);
}
