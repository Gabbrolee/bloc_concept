import 'package:bloc/bloc.dart';

// enum CounterEvent { increment, decrement }
//
// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0);
//
//   @override
//   Stream<int> mapEventToState(CounterEvent event) async* {
//     switch (event) {
//       case CounterEvent.increment:
//         yield state + 1;
//         break;
//       case CounterEvent.decrement:
//         yield state - 1;
//         break;
//     }
//   }
// }
//
// Future<void> main(List<String> args) async {
//   final bloc = CounterBloc();
//
//   final streamSubscription = bloc.listen(print);
//
//   bloc.add(CounterEvent.increment);
//   bloc.add(CounterEvent.increment);
//   bloc.add(CounterEvent.increment);
//
//   bloc.add(CounterEvent.decrement);
//   bloc.add(CounterEvent.decrement);
//   bloc.add(CounterEvent.decrement);
//
//   await Future.delayed(Duration
//       .zero); //! we use this to not cancel the subscription immediately down here
//
//   await streamSubscription.cancel();
//   await bloc.close();
// }

enum CounterEvent{increment, decrement}

class CounterBloc extends Bloc<CounterEvent, int>{
  CounterBloc(): super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async*{
    switch(event){
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.decrement:
        yield state - 1;
        break;
    }
  }
}

Future <void> main(List<String> args) async {
   final bloc = CounterBloc();
   final streamSubscription = bloc.listen(print);

   print(bloc.state);    // print initial state of the counter
   bloc.add(CounterEvent.increment); // +1 is added
   bloc.add(CounterEvent.increment); // +1 is added again making it 2
   bloc.add(CounterEvent.increment);  // +1 is added again making it 3

   bloc.add(CounterEvent.decrement);  // 1 is removed making it 2 now
   bloc.add(CounterEvent.decrement);  // 1 is removed making it 1 now

  await Future.delayed(Duration.zero);   // use inorder not to cancel subscription immediately
  await streamSubscription.cancel();
  await bloc.close();
}