part of 'tokoview_bloc.dart';

@immutable
abstract class TokoviewEvent {}

class SaveToko extends TokoviewEvent{
  final String uid;
  final String namaToko;
  final String provinsi;
  final String kota;
  final String alamat;
  final Uint8List? uint8list;
  SaveToko(this.namaToko, this.provinsi, this.kota, this.alamat, this.uid, [this.uint8list]);
}