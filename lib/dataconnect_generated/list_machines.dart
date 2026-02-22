part of 'generated.dart';

class ListMachinesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMachinesVariablesBuilder(this._dataConnect, );
  Deserializer<ListMachinesData> dataDeserializer = (dynamic json)  => ListMachinesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMachinesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMachinesData, void> ref() {
    
    return _dataConnect.query("ListMachines", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMachinesMachines {
  final String id;
  final String? name;
  final int? serialNumber;
  final String? description;
  ListMachinesMachines.fromJson(dynamic json):
  
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

    final ListMachinesMachines otherTyped = other as ListMachinesMachines;
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

  ListMachinesMachines({
    required this.id,
    this.name,
    this.serialNumber,
    this.description,
  });
}

@immutable
class ListMachinesData {
  final List<ListMachinesMachines> machines;
  ListMachinesData.fromJson(dynamic json):
  
  machines = (json['machines'] as List<dynamic>)
        .map((e) => ListMachinesMachines.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMachinesData otherTyped = other as ListMachinesData;
    return machines == otherTyped.machines;
    
  }
  @override
  int get hashCode => machines.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['machines'] = machines.map((e) => e.toJson()).toList();
    return json;
  }

  ListMachinesData({
    required this.machines,
  });
}

