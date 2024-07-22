import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;
import 'package:tuncblog/core/common/entities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void signOut() async {
    await sp.Supabase.instance.client.auth.signOut();
  }

  void deleteAccount() async {
    var client = sp.Supabase.instance.client.auth.currentUser;
    var userId = client!.id;
    await sp.Supabase.instance.client.auth.admin.deleteUser(userId);
    log("Account Deleted");
  }

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
