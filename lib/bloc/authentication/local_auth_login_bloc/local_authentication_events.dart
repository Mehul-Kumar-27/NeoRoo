class LocalAuthEvents {}

class LocalAuthRequestEvent extends LocalAuthEvents {
  final String serverURL;
  final String username;
  final String password;
  LocalAuthRequestEvent(this.serverURL, this.password, this.username);
}
