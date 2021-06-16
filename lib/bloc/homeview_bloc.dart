import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../services/firestore_service.dart';

part 'homeview_event.dart';
part 'homeview_state.dart';

class HomeviewBloc extends Bloc<HomeviewEvent, HomeviewState> {
  HomeviewBloc() : super(HomeviewInitial());

  @override
  Stream<HomeviewState> mapEventToState(
    HomeviewEvent event,
  ) async* {
    if(event is GetToko){
      yield OnGetTokoLoading();

      try {
        yield OnGetTokoSucceded(await FirestoreService().getToko(event.uid));

      } catch (e) {
        yield OnGetTokoError(e.toString());
      }
    }
  }
}
