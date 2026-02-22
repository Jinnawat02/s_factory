part of 'generated.dart';

class GetRequestVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetRequestVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetRequestData> dataDeserializer = (dynamic json)  => GetRequestData.fromJson(jsonDecode(json));
  Serializer<GetRequestVariables> varsSerializer = (GetRequestVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetRequestData, GetRequestVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetRequestData, GetRequestVariables> ref() {
    GetRequestVariables vars= GetRequestVariables(id: id,);
    return _dataConnect.query("GetRequest", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetRequestRequest {
  final String id;
  final GetRequestRequestUser user;
  final GetRequestRequestMachine machine;
  final Timestamp requestDate;
  final String? description;
  final String? status;
  GetRequestRequest.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  user = GetRequestRequestUser.fromJson(json['user']),
  machine = GetRequestRequestMachine.fromJson(json['machine']),
  requestDate = Timestamp.fromJson(json['requestDate']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  status = json['status'] == null ? null : nativeFromJson<String>(json['status']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRequestRequest otherTyped = other as GetRequestRequest;
    return id == otherTyped.id && 
    user == otherTyped.user && 
    machine == otherTyped.machine && 
    requestDate == otherTyped.requestDate && 
    description == otherTyped.description && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, user.hashCode, machine.hashCode, requestDate.hashCode, description.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['user'] = user.toJson();
    json['machine'] = machine.toJson();
    json['requestDate'] = requestDate.toJson();
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    if (status != null) {
      json['status'] = nativeToJson<String?>(status);
    }
    return json;
  }

  GetRequestRequest({
    required this.id,
    required this.user,
    required this.machine,
    required this.requestDate,
    this.description,
    this.status,
  });
}

@immutable
class GetRequestRequestUser {
  final String email;
  final String? name;
  GetRequestRequestUser.fromJson(dynamic json):
  
  email = nativeFromJson<String>(json['email']),
  name = json['name'] == null ? null : nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRequestRequestUser otherTyped = other as GetRequestRequestUser;
    return email == otherTyped.email && 
    name == otherTyped.name;
    
  }
  @override
  int get hashCode => Object.hashAll([email.hashCode, name.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    if (name != null) {
      json['name'] = nativeToJson<String?>(name);
    }
    return json;
  }

  GetRequestRequestUser({
    required this.email,
    this.name,
  });
}

@immutable
class GetRequestRequestMachine {
  final String id;
  final String? name;
  GetRequestRequestMachine.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = json['name'] == null ? null : nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRequestRequestMachine otherTyped = other as GetRequestRequestMachine;
    return id == otherTyped.id && 
    name == otherTyped.name;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (name != null) {
      json['name'] = nativeToJson<String?>(name);
    }
    return json;
  }

  GetRequestRequestMachine({
    required this.id,
    this.name,
  });
}

@immutable
class GetRequestData {
  final GetRequestRequest? request;
  GetRequestData.fromJson(dynamic json):
  
  request = json['request'] == null ? null : GetRequestRequest.fromJson(json['request']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRequestData otherTyped = other as GetRequestData;
    return request == otherTyped.request;
    
  }
  @override
  int get hashCode => request.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (request != null) {
      json['request'] = request!.toJson();
    }
    return json;
  }

  GetRequestData({
    this.request,
  });
}

@immutable
class GetRequestVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetRequestVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRequestVariables otherTyped = other as GetRequestVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetRequestVariables({
    required this.id,
  });
}

