part of 'homeview_bloc.dart';

@immutable
abstract class HomeviewEvent {}

class GetToko extends HomeviewEvent{
  final String uid;
  GetToko(this.uid);
}