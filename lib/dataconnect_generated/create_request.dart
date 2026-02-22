part of 'generated.dart';

class CreateRequestVariablesBuilder {
  String userEmail;
  String machineId;
  String description;
  Timestamp requestDate;

  final FirebaseDataConnect _dataConnect;
  CreateRequestVariablesBuilder(this._dataConnect, {required  this.userEmail,required  this.machineId,required  this.description,required  this.requestDate,});
  Deserializer<CreateRequestData> dataDeserializer = (dynamic json)  => CreateRequestData.fromJson(jsonDecode(json));
  Serializer<CreateRequestVariables> varsSerializer = (CreateRequestVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateRequestData, CreateRequestVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateRequestData, CreateRequestVariables> ref() {
    CreateRequestVariables vars= CreateRequestVariables(userEmail: userEmail,machineId: machineId,description: description,requestDate: requestDate,);
    return _dataConnect.mutation("CreateRequest", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateRequestRequestInsert {
  final String id;
  CreateRequestRequestInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateRequestRequestInsert otherTyped = other as CreateRequestRequestInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateRequestRequestInsert({
    required this.id,
  });
}

@immutable
class CreateRequestData {
  final CreateRequestRequestInsert request_insert;
  CreateRequestData.fromJson(dynamic json):
  
  request_insert = CreateRequestRequestInsert.fromJson(json['request_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateRequestData otherTyped = other as CreateRequestData;
    return request_insert == otherTyped.request_insert;
    
  }
  @override
  int get hashCode => request_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['request_insert'] = request_insert.toJson();
    return json;
  }

  CreateRequestData({
    required this.request_insert,
  });
}

@immutable
class CreateRequestVariables {
  final String userEmail;
  final String machineId;
  final String description;
  final Timestamp requestDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateRequestVariables.fromJson(Map<String, dynamic> json):
  
  userEmail = nativeFromJson<String>(json['userEmail']),
  machineId = nativeFromJson<String>(json['machineId']),
  description = nativeFromJson<String>(json['description']),
  requestDate = Timestamp.fromJson(json['requestDate']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateRequestVariables otherTyped = other as CreateRequestVariables;
    return userEmail == otherTyped.userEmail && 
    machineId == otherTyped.machineId && 
    description == otherTyped.description && 
    requestDate == otherTyped.requestDate;
    
  }
  @override
  int get hashCode => Object.hashAll([userEmail.hashCode, machineId.hashCode, description.hashCode, requestDate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userEmail'] = nativeToJson<String>(userEmail);
    json['machineId'] = nativeToJson<String>(machineId);
    json['description'] = nativeToJson<String>(description);
    json['requestDate'] = requestDate.toJson();
    return json;
  }

  CreateRequestVariables({
    required this.userEmail,
    required this.machineId,
    required this.description,
    required this.requestDate,
  });
}

