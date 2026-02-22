part of 'generated.dart';

class ListUsersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListUsersVariablesBuilder(this._dataConnect, );
  Deserializer<ListUsersData> dataDeserializer = (dynamic json)  => ListUsersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListUsersData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListUsersData, void> ref() {
    
    return _dataConnect.query("ListUsers", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListUsersUsers {
  final String email;
  final String? name;
  final String? role;
  final String? tel;
  ListUsersUsers.fromJson(dynamic json):
  
  email = nativeFromJson<String>(json['email']),
  name = json['name'] == null ? null : nativeFromJson<String>(json['name']),
  role = json['role'] == null ? null : nativeFromJson<String>(json['role']),
  tel = json['tel'] == null ? null : nativeFromJson<String>(json['tel']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListUsersUsers otherTyped = other as ListUsersUsers;
    return email == otherTyped.email && 
    name == otherTyped.name && 
    role == otherTyped.role && 
    tel == otherTyped.tel;
    
  }
  @override
  int get hashCode => Object.hashAll([email.hashCode, name.hashCode, role.hashCode, tel.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    if (name != null) {
      json['name'] = nativeToJson<String?>(name);
    }
    if (role != null) {
      json['role'] = nativeToJson<String?>(role);
    }
    if (tel != null) {
      json['tel'] = nativeToJson<String?>(tel);
    }
    return json;
  }

  ListUsersUsers({
    required this.email,
    this.name,
    this.role,
    this.tel,
  });
}

@immutable
class ListUsersData {
  final List<ListUsersUsers> users;
  ListUsersData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => ListUsersUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListUsersData otherTyped = other as ListUsersData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  ListUsersData({
    required this.users,
  });
}

