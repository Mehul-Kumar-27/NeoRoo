class LoginEvents{}

class LoginEvent extends LoginEvents{
  final String serverURL;
  final String username;
  final String password;
  LoginEvent(this.serverURL,this.password,this.username);  
}
class LocalLoginEvent extends LoginEvents{}