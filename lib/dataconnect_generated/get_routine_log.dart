part of 'generated.dart';

class GetRoutineLogVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetRoutineLogVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetRoutineLogData> dataDeserializer = (dynamic json)  => GetRoutineLogData.fromJson(jsonDecode(json));
  Serializer<GetRoutineLogVariables> varsSerializer = (GetRoutineLogVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetRoutineLogData, GetRoutineLogVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetRoutineLogData, GetRoutineLogVariables> ref() {
    GetRoutineLogVariables vars= GetRoutineLogVariables(id: id,);
    return _dataConnect.query("GetRoutineLog", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetRoutineLogRoutineLog {
  final String id;
  final String? title;
  final bool? isDone;
  final GetRoutineLogRoutineLogRoutine routine;
  GetRoutineLogRoutineLog.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = json['title'] == null ? null : nativeFromJson<String>(json['title']),
  isDone = json['isDone'] == null ? null : nativeFromJson<bool>(json['isDone']),
  routine = GetRoutineLogRoutineLogRoutine.fromJson(json['routine']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRoutineLogRoutineLog otherTyped = other as GetRoutineLogRoutineLog;
    return id == otherTyped.id && 
    title == otherTyped.title && 
    isDone == otherTyped.isDone && 
    routine == otherTyped.routine;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode, isDone.hashCode, routine.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (title != null) {
      json['title'] = nativeToJson<String?>(title);
    }
    if (isDone != null) {
      json['isDone'] = nativeToJson<bool?>(isDone);
    }
    json['routine'] = routine.toJson();
    return json;
  }

  GetRoutineLogRoutineLog({
    required this.id,
    this.title,
    this.isDone,
    required this.routine,
  });
}

@immutable
class GetRoutineLogRoutineLogRoutine {
  final String id;
  final String? title;
  GetRoutineLogRoutineLogRoutine.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = json['title'] == null ? null : nativeFromJson<String>(json['title']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRoutineLogRoutineLogRoutine otherTyped = other as GetRoutineLogRoutineLogRoutine;
    return id == otherTyped.id && 
    title == otherTyped.title;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (title != null) {
      json['title'] = nativeToJson<String?>(title);
    }
    return json;
  }

  GetRoutineLogRoutineLogRoutine({
    required this.id,
    this.title,
  });
}

@immutable
class GetRoutineLogData {
  final GetRoutineLogRoutineLog? routineLog;
  GetRoutineLogData.fromJson(dynamic json):
  
  routineLog = json['routineLog'] == null ? null : GetRoutineLogRoutineLog.fromJson(json['routineLog']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRoutineLogData otherTyped = other as GetRoutineLogData;
    return routineLog == otherTyped.routineLog;
    
  }
  @override
  int get hashCode => routineLog.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (routineLog != null) {
      json['routineLog'] = routineLog!.toJson();
    }
    return json;
  }

  GetRoutineLogData({
    this.routineLog,
  });
}

@immutable
class GetRoutineLogVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetRoutineLogVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRoutineLogVariables otherTyped = other as GetRoutineLogVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetRoutineLogVariables({
    required this.id,
  });
}

