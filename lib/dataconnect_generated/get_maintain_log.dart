part of 'generated.dart';

class GetMaintainLogVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetMaintainLogVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetMaintainLogData> dataDeserializer = (dynamic json)  => GetMaintainLogData.fromJson(jsonDecode(json));
  Serializer<GetMaintainLogVariables> varsSerializer = (GetMaintainLogVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetMaintainLogData, GetMaintainLogVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetMaintainLogData, GetMaintainLogVariables> ref() {
    GetMaintainLogVariables vars= GetMaintainLogVariables(id: id,);
    return _dataConnect.query("GetMaintainLog", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetMaintainLogMaintainLog {
  final String id;
  final String? title;
  final bool? isDone;
  final GetMaintainLogMaintainLogMachine machine;
  GetMaintainLogMaintainLog.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = json['title'] == null ? null : nativeFromJson<String>(json['title']),
  isDone = json['isDone'] == null ? null : nativeFromJson<bool>(json['isDone']),
  machine = GetMaintainLogMaintainLogMachine.fromJson(json['machine']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMaintainLogMaintainLog otherTyped = other as GetMaintainLogMaintainLog;
    return id == otherTyped.id && 
    title == otherTyped.title && 
    isDone == otherTyped.isDone && 
    machine == otherTyped.machine;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode, isDone.hashCode, machine.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (title != null) {
      json['title'] = nativeToJson<String?>(title);
    }
    if (isDone != null) {
      json['isDone'] = nativeToJson<bool?>(isDone);
    }
    json['machine'] = machine.toJson();
    return json;
  }

  GetMaintainLogMaintainLog({
    required this.id,
    this.title,
    this.isDone,
    required this.machine,
  });
}

@immutable
class GetMaintainLogMaintainLogMachine {
  final String id;
  final String? name;
  GetMaintainLogMaintainLogMachine.fromJson(dynamic json):
  
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

    final GetMaintainLogMaintainLogMachine otherTyped = other as GetMaintainLogMaintainLogMachine;
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

  GetMaintainLogMaintainLogMachine({
    required this.id,
    this.name,
  });
}

@immutable
class GetMaintainLogData {
  final GetMaintainLogMaintainLog? maintainLog;
  GetMaintainLogData.fromJson(dynamic json):
  
  maintainLog = json['maintainLog'] == null ? null : GetMaintainLogMaintainLog.fromJson(json['maintainLog']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMaintainLogData otherTyped = other as GetMaintainLogData;
    return maintainLog == otherTyped.maintainLog;
    
  }
  @override
  int get hashCode => maintainLog.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (maintainLog != null) {
      json['maintainLog'] = maintainLog!.toJson();
    }
    return json;
  }

  GetMaintainLogData({
    this.maintainLog,
  });
}

@immutable
class GetMaintainLogVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetMaintainLogVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMaintainLogVariables otherTyped = other as GetMaintainLogVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetMaintainLogVariables({
    required this.id,
  });
}

