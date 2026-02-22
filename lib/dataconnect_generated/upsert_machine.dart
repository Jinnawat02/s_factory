part of 'generated.dart';

class UpsertMachineVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  UpsertMachineVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpsertMachineData> dataDeserializer = (dynamic json)  => UpsertMachineData.fromJson(jsonDecode(json));
  Serializer<UpsertMachineVariables> varsSerializer = (UpsertMachineVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpsertMachineData, UpsertMachineVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpsertMachineData, UpsertMachineVariables> ref() {
    UpsertMachineVariables vars= UpsertMachineVariables(id: id,);
    return _dataConnect.mutation("UpsertMachine", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpsertMachineMachineUpsert {
  final String id;
  UpsertMachineMachineUpsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertMachineMachineUpsert otherTyped = other as UpsertMachineMachineUpsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpsertMachineMachineUpsert({
    required this.id,
  });
}

@immutable
class UpsertMachineData {
  final UpsertMachineMachineUpsert machine_upsert;
  UpsertMachineData.fromJson(dynamic json):
  
  machine_upsert = UpsertMachineMachineUpsert.fromJson(json['machine_upsert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertMachineData otherTyped = other as UpsertMachineData;
    return machine_upsert == otherTyped.machine_upsert;
    
  }
  @override
  int get hashCode => machine_upsert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['machine_upsert'] = machine_upsert.toJson();
    return json;
  }

  UpsertMachineData({
    required this.machine_upsert,
  });
}

@immutable
class UpsertMachineVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpsertMachineVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertMachineVariables otherTyped = other as UpsertMachineVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpsertMachineVariables({
    required this.id,
  });
}

