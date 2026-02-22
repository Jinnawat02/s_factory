part of 'generated.dart';

class ListRoutineLogsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListRoutineLogsVariablesBuilder(this._dataConnect, );
  Deserializer<ListRoutineLogsData> dataDeserializer = (dynamic json)  => ListRoutineLogsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListRoutineLogsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListRoutineLogsData, void> ref() {
    
    return _dataConnect.query("ListRoutineLogs", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListRoutineLogsRoutineLogs {
  final String id;
  final String? title;
  final bool? isDone;
  final ListRoutineLogsRoutineLogsRoutine routine;
  ListRoutineLogsRoutineLogs.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = json['title'] == null ? null : nativeFromJson<String>(json['title']),
  isDone = json['isDone'] == null ? null : nativeFromJson<bool>(json['isDone']),
  routine = ListRoutineLogsRoutineLogsRoutine.fromJson(json['routine']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListRoutineLogsRoutineLogs otherTyped = other as ListRoutineLogsRoutineLogs;
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

  ListRoutineLogsRoutineLogs({
    required this.id,
    this.title,
    this.isDone,
    required this.routine,
  });
}

@immutable
class ListRoutineLogsRoutineLogsRoutine {
  final String id;
  final String? title;
  ListRoutineLogsRoutineLogsRoutine.fromJson(dynamic json):
  
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

    final ListRoutineLogsRoutineLogsRoutine otherTyped = other as ListRoutineLogsRoutineLogsRoutine;
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

  ListRoutineLogsRoutineLogsRoutine({
    required this.id,
    this.title,
  });
}

@immutable
class ListRoutineLogsData {
  final List<ListRoutineLogsRoutineLogs> routineLogs;
  ListRoutineLogsData.fromJson(dynamic json):
  
  routineLogs = (json['routineLogs'] as List<dynamic>)
        .map((e) => ListRoutineLogsRoutineLogs.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListRoutineLogsData otherTyped = other as ListRoutineLogsData;
    return routineLogs == otherTyped.routineLogs;
    
  }
  @override
  int get hashCode => routineLogs.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['routineLogs'] = routineLogs.map((e) => e.toJson()).toList();
    return json;
  }

  ListRoutineLogsData({
    required this.routineLogs,
  });
}

