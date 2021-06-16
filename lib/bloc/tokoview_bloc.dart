import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:fooddelevery/services/api_service.dart';
import 'package:fooddelevery/services/firestore_service.dart';
import 'package:meta/meta.dart';

part 'tokoview_event.dart';
part 'tokoview_state.dart';

class TokoviewBloc extends Bloc<TokoviewEvent, TokoviewState> {
  TokoviewBloc() : super(TokoviewInitial());

  @override
  Stream<TokoviewState> mapEventToState(
    TokoviewEvent event,
  ) async* {
    if (event is SaveToko) {
      yield OnSaveTokoLoading();
      try {
        Map<String, dynamic>? image;
        if (event.uint8list != null) {
          image = await ApiService().uploadImage(event.uint8list);
        }

        await FirestoreService().setToko(event.uid, event.namaToko,
            event.provinsi, event.kota, event.alamat, image);
        yield (OnSaveTokoSucceded());
      } catch (e) {
        print(e.toString());
        yield OnSaveTokoError(e.toString());
      }
    }
  }
}
