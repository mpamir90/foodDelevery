part of 'tokoview_bloc.dart';

@immutable
abstract class TokoviewState {}

class TokoviewInitial extends TokoviewState {}

//Save Toko
class OnSaveTokoLoading extends TokoviewState{}

class OnSaveTokoSucceded extends TokoviewState{}

class OnSaveTokoError extends TokoviewState{
  final String errorMessage;
  OnSaveTokoError(this.errorMessage);

}