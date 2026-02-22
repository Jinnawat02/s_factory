part of 'generated.dart';

class InsertMachineVariablesBuilder {
  String id;
  String name;
  int serialNumber;
  String description;

  final FirebaseDataConnect _dataConnect;
  InsertMachineVariablesBuilder(this._dataConnect, {required  this.id,required  this.name,required  this.serialNumber,required  this.description,});
  Deserializer<InsertMachineData> dataDeserializer = (dynamic json)  => InsertMachineData.fromJson(jsonDecode(json));
  Serializer<InsertMachineVariables> varsSerializer = (InsertMachineVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMachineData, InsertMachineVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMachineData, InsertMachineVariables> ref() {
    InsertMachineVariables vars= InsertMachineVariables(id: id,name: name,serialNumber: serialNumber,description: description,);
    return _dataConnect.mutation("InsertMachine", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMachineMachineInsert {
  final String id;
  InsertMachineMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMachineMachineInsert otherTyped = other as InsertMachineMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMachineMachineInsert({
    required this.id,
  });
}

@immutable
class InsertMachineData {
  final InsertMachineMachineInsert machine_insert;
  InsertMachineData.fromJson(dynamic json):
  
  machine_insert = InsertMachineMachineInsert.fromJson(json['machine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMachineData otherTyped = other as InsertMachineData;
    return machine_insert == otherTyped.machine_insert;
    
  }
  @override
  int get hashCode => machine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['machine_insert'] = machine_insert.toJson();
    return json;
  }

  InsertMachineData({
    required this.machine_insert,
  });
}

@immutable
class InsertMachineVariables {
  final String id;
  final String name;
  final int serialNumber;
  final String description;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMachineVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  serialNumber = nativeFromJson<int>(json['serialNumber']),
  description = nativeFromJson<String>(json['description']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMachineVariables otherTyped = other as InsertMachineVariables;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    serialNumber == otherTyped.serialNumber && 
    description == otherTyped.description;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, serialNumber.hashCode, description.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['serialNumber'] = nativeToJson<int>(serialNumber);
    json['description'] = nativeToJson<String>(description);
    return json;
  }

  InsertMachineVariables({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.description,
  });
}

