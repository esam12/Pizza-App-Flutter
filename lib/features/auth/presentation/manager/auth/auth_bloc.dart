import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:pizza_app/core/usecases/use_case.dart';
import 'package:pizza_app/core/common/entities/user_entity.dart';
import 'package:pizza_app/features/auth/domain/usecases/current_user.dart';
import 'package:pizza_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:pizza_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCuibt,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCuibt,
        super(AuthInitial()) {
    on<AuthSignUp>(_authSignUp);
    on<AuthLogin>(_authSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggeInd);
  }

  Future<void> _authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(UserSignUpParams(
      email: event.email,
      password: event.password,
      name: event.name,
    ));
    res.fold((l) => emit(AuthFailure(message: l.meesage.toString())),
        (r) => _emitAuthSuccess(r, emit));
  }

  Future<void> _authSignIn(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password));
    res.fold((l) => emit(AuthFailure(message: l.meesage.toString())),
        (r) => _emitAuthSuccess(r, emit));
  }

  Future<void> _isUserLoggeInd(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold((l) => emit(AuthFailure(message: l.meesage)), (r) {
      print(r.id);

      _emitAuthSuccess(r, emit);
    });
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
