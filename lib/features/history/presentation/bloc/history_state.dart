part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();  

  @override
  List<Object> get props => [];
}
class HistoryInitial extends HistoryState {}
