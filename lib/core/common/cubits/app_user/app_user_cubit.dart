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
    // try {
    //   var client = sp.Supabase.instance.client.auth.currentUser;

    //   if (client == null) {
    //     log("No current user found.");
    //     return;
    //   }
    //   var userId = client.id;
    //   if (userId == "") {
    //     log("User ID is null.");
    //     return;
    //   }
    //   await sp.Supabase.instance.client.auth.admin.deleteUser(userId);
    //   log("Account Deleted");
    // } catch (e) {
    //   log("Failed to delete account: $e");
    // }

    try {
      var client = sp.Supabase.instance.client.auth.currentUser;

      if (client == null) {
        log("No current user found.");
        return;
      }

      var userId = client.id;

      if (userId == null) {
        log("User ID is null.");
        return;
      }

      // Kullanıcı hesabını devre dışı bırakma (Örnek olarak veritabanında bir alanı güncelleme)
      await sp.Supabase.instance.client
          .from('users')
          .update({'is_active': false}).eq('id', userId);

      log("Account Deactivated");
    } catch (e) {
      log("Failed to deactivate account: $e");
    }
  }

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
