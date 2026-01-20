abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;

  ProfileLoaded({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
  });
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

