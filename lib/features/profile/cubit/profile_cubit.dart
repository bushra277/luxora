import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flutter/features/auth/pages/login_page.dart';
import 'package:task_flutter/features/profile/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileCubit() : super(ProfileInitial());

  void fetchProfile() {
    emit(ProfileLoading());
    try {
      final user = _auth.currentUser;
      if (user != null) {
        emit(ProfileLoaded(
          uid: user.uid,
          name: user.displayName ?? "No Name",
          email: user.email ?? "No Email",
          photoUrl: user.photoURL,
        ));
      } else {
        emit(ProfileError("No user found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateName(String name) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        fetchProfile();
      } else {
        emit(ProfileError("No user found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future <void> logout(BuildContext context) async {
    
    FocusScope.of(context).unfocus();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }
}
