part of 'generated.dart';

class GetMachineVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetMachineVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetMachineData> dataDeserializer = (dynamic json)  => GetMachineData.fromJson(jsonDecode(json));
  Serializer<GetMachineVariables> varsSerializer = (GetMachineVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetMachineData, GetMachineVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetMachineData, GetMachineVariables> ref() {
    GetMachineVariables vars= GetMachineVariables(id: id,);
    return _dataConnect.query("GetMachine", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetMachineMachine {
  final String id;
  final String? name;
  final int? serialNumber;
  final String? description;
  GetMachineMachine.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = json['name'] == null ? null : nativeFromJson<String>(json['name']),
  serialNumber = json['serialNumber'] == null ? null : nativeFromJson<int>(json['serialNumber']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMachineMachine otherTyped = other as GetMachineMachine;
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
    if (name != null) {
      json['name'] = nativeToJson<String?>(name);
    }
    if (serialNumber != null) {
      json['serialNumber'] = nativeToJson<int?>(serialNumber);
    }
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    return json;
  }

  GetMachineMachine({
    required this.id,
    this.name,
    this.serialNumber,
    this.description,
  });
}

@immutable
class GetMachineData {
  final GetMachineMachine? machine;
  GetMachineData.fromJson(dynamic json):
  
  machine = json['machine'] == null ? null : GetMachineMachine.fromJson(json['machine']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMachineData otherTyped = other as GetMachineData;
    return machine == otherTyped.machine;
    
  }
  @override
  int get hashCode => machine.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (machine != null) {
      json['machine'] = machine!.toJson();
    }
    return json;
  }

  GetMachineData({
    this.machine,
  });
}

@immutable
class GetMachineVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetMachineVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMachineVariables otherTyped = other as GetMachineVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetMachineVariables({
    required this.id,
  });
}

