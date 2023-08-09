import 'dart:convert';

import 'package:http/http.dart' as http;

class MessageNetwrokApiClient {
  Future<http.Response> getUsersFromTheDhis2Server(String username,
      String password, String endpoint, String organizationId) async {
    String userRoleIdFamily = "vZzRjtId5as";
    String userRoleSuperUser = "yrB6vc5Ip3r";
    final authHeader =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    String url =
        '$endpoint/api/users.json?fields=[id,name]&filter=userCredentials.userRoles.id:eq:$userRoleSuperUser&organisationUnits.id:eq:$organizationId&paging=false';
    return await http.get(
      Uri.parse(url),
      headers: {'Authorization': authHeader},
    );
  }

  Future<http.Response> getAllConversationsOfTheUser(
      String username, String password, String endpoint) async {
    final authHeader =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    return await http.get(
      Uri.parse("$endpoint/api/messageConversations.json?&paging=false"),
      headers: {'Authorization': authHeader},
    );
  }

  Future<http.Response> lookUpToAUser(String username, String password,
      String endpoint, String reciepentId) async {
    final authHeader =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    return await http.get(
      Uri.parse("$endpoint/api/userLookup/$reciepentId"),
      headers: {'Authorization': authHeader},
    );
  }

  Future<http.Response> getConverationsOfUserForTheChatRoom(String username,
      String password, String serverURL, String chatRoomId) async {
    String endpoint =
        "$serverURL/api/messageConversations/$chatRoomId/messages.json?paging=false";
    final authHeader =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    return await http.get(
      Uri.parse(endpoint),
      headers: {'Authorization': authHeader},
    );
  }

  Future<http.Response> createChatRoom(String username, String password,
      String serverURL, List<String> recipients, String userId) async {
    final authHeader =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    String endpoint = "$serverURL/api/messageConversations";
    return await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'subject': '$userId\$\$${recipients[0]}',
        'text': '$userId\$\$${recipients[0]}',
        'userGroups': [],
        'users': recipients.map((recipient) => {'id': recipient}).toList(),
      }),
    );
  }

  Future<http.Response> sendMessage(
      String username,
      String password,
      String serverURL,
      String message,
      List<String> recipients,
      String chatRoomId,
      String userId) async {
    final authHeader =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    String endpoint = "$serverURL/api/messageConversations/$chatRoomId";
    return await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'subject': '$userId\$\$${recipients[0]}',
        'text': message,
        'userGroups': [],
        'users': recipients.map((recipient) => {'id': recipient}).toList(),
      }),
    );
  }
}
