part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();
  
  @override
  List<Object> get props => [];
}

class UserDetailInitial extends UserDetailState {}
