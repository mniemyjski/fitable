import 'package:bloc/bloc.dart';

class ChangeDateCubit extends Cubit<DateTime> {
  ChangeDateCubit() : super(DateTime.now());

  increment() {
    emit(
      state.add(Duration(days: 1)),
    );
  }

  decrement() {
    emit(
      state.add(Duration(days: -1)),
    );
  }

  change(DateTime dateTime) {
    emit(dateTime);
  }
}
