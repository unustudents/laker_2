part of 'profile_cubit.dart';

/// Abstract base class for all ProfileCubit states
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state when ProfileCubit is first created
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Loading state saat fetch user profile data
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// Successful state dengan user profile data
class ProfileLoaded extends ProfileState {
  /// User data map dengan keys: uid, nama, email, photoUrl
  final ProfilEntity userData;

  const ProfileLoaded(this.userData);

  @override
  List<Object?> get props => [userData];
}

/// Loading state saat sedang signout
class ProfileSigningOut extends ProfileState {
  const ProfileSigningOut();
}

/// Successful signout state - ready untuk navigate ke login
class ProfileSignoutSuccess extends ProfileState {
  const ProfileSignoutSuccess();
}

/// Error state dengan error message
class ProfileError extends ProfileState {
  /// Error message
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
