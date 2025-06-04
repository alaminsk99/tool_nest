
abstract class AuthEvent{}

/// Only login button tapped
///





class LoginBtnTapped extends AuthEvent{
  final String email;
  final String password;
  LoginBtnTapped(this.email,this.password);
}


class ToggleEvent extends AuthEvent{}