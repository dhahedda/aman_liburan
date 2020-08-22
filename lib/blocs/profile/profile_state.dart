part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInit extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileResponse extends ProfileState {
  final dynamic response;

  const ProfileResponse({@required this.response});

  ProfileResponse copyWith({dynamic response, List<Placemark> placemarks, bool acceptCashOnDelivery}) {
    return ProfileResponse(
      response: response ?? this.response,
    );
  }

  @override
  List<Object> get props => [response];
}

class ProfileSignOutResponse extends ProfileState {
  final GlobalResponse response;

  const ProfileSignOutResponse({@required this.response});

  @override
  List<Object> get props => [response];
}

class UpdateProfileResponse extends ProfileState {
  final GlobalResponse response;

  const UpdateProfileResponse({@required this.response});

  @override
  List<Object> get props => [response];
}

class UpdatePaymentResponse extends ProfileState {
  final GlobalResponse response;

  const UpdatePaymentResponse({@required this.response});

  @override
  List<Object> get props => [response];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({@required this.message});

  @override
  List<Object> get props => [message];
}
