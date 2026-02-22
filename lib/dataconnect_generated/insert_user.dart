part of 'generated.dart';

class InsertUserVariablesBuilder {
  String email;
  String password;
  String name;
  String role;
  String tel;

  final FirebaseDataConnect _dataConnect;
  InsertUserVariablesBuilder(this._dataConnect, {required  this.email,required  this.password,required  this.name,required  this.role,required  this.tel,});
  Deserializer<InsertUserData> dataDeserializer = (dynamic json)  => InsertUserData.fromJson(jsonDecode(json));
  Serializer<InsertUserVariables> varsSerializer = (InsertUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertUserData, InsertUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertUserData, InsertUserVariables> ref() {
    InsertUserVariables vars= InsertUserVariables(email: email,password: password,name: name,role: role,tel: tel,);
    return _dataConnect.mutation("InsertUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertUserUserInsert {
  final String email;
  InsertUserUserInsert.fromJson(dynamic json):
  
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertUserUserInsert otherTyped = other as InsertUserUserInsert;
    return email == otherTyped.email;
    
  }
  @override
  int get hashCode => email.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  InsertUserUserInsert({
    required this.email,
  });
}

@immutable
class InsertUserData {
  final InsertUserUserInsert user_insert;
  InsertUserData.fromJson(dynamic json):
  
  user_insert = InsertUserUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertUserData otherTyped = other as InsertUserData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  InsertUserData({
    required this.user_insert,
  });
}

@immutable
class InsertUserVariables {
  final String email;
  final String password;
  final String name;
  final String role;
  final String tel;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertUserVariables.fromJson(Map<String, dynamic> json):
  
  email = nativeFromJson<String>(json['email']),
  password = nativeFromJson<String>(json['password']),
  name = nativeFromJson<String>(json['name']),
  role = nativeFromJson<String>(json['role']),
  tel = nativeFromJson<String>(json['tel']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertUserVariables otherTyped = other as InsertUserVariables;
    return email == otherTyped.email && 
    password == otherTyped.password && 
    name == otherTyped.name && 
    role == otherTyped.role && 
    tel == otherTyped.tel;
    
  }
  @override
  int get hashCode => Object.hashAll([email.hashCode, password.hashCode, name.hashCode, role.hashCode, tel.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    json['password'] = nativeToJson<String>(password);
    json['name'] = nativeToJson<String>(name);
    json['role'] = nativeToJson<String>(role);
    json['tel'] = nativeToJson<String>(tel);
    return json;
  }

  InsertUserVariables({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.tel,
  });
}

