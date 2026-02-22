part of 'generated.dart';

class GetRoutineVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetRoutineVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetRoutineData> dataDeserializer = (dynamic json)  => GetRoutineData.fromJson(jsonDecode(json));
  Serializer<GetRoutineVariables> varsSerializer = (GetRoutineVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetRoutineData, GetRoutineVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetRoutineData, GetRoutineVariables> ref() {
    GetRoutineVariables vars= GetRoutineVariables(id: id,);
    return _dataConnect.query("GetRoutine", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetRoutineRoutine {
  final String id;
  final String? title;
  final GetRoutineRoutineCreator creator;
  GetRoutineRoutine.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = json['title'] == null ? null : nativeFromJson<String>(json['title']),
  creator = GetRoutineRoutineCreator.fromJson(json['creator']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRoutineRoutine otherTyped = other as GetRoutineRoutine;
    return id == otherTyped.id && 
    title == otherTyped.title && 
    creator == otherTyped.creator;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode, creator.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (title != null) {
      json['title'] = nativeToJson<String?>(title);
    }
    json['creator'] = creator.toJson();
    return json;
  }

  GetRoutineRoutine({
    required this.id,
    this.title,
    required this.creator,
  });
}

@immutable
class GetRoutineRoutineCreator {
  final String email;
  final String? name;
  GetRoutineRoutineCreator.fromJson(dynamic json):
  
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

    final GetRoutineRoutineCreator otherTyped = other as GetRoutineRoutineCreator;
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

  GetRoutineRoutineCreator({
    required this.email,
    this.name,
  });
}

@immutable
class GetRoutineData {
  final GetRoutineRoutine? routine;
  GetRoutineData.fromJson(dynamic json):
  
  routine = json['routine'] == null ? null : GetRoutineRoutine.fromJson(json['routine']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRoutineData otherTyped = other as GetRoutineData;
    return routine == otherTyped.routine;
    
  }
  @override
  int get hashCode => routine.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (routine != null) {
      json['routine'] = routine!.toJson();
    }
    return json;
  }

  GetRoutineData({
    this.routine,
  });
}

@immutable
class GetRoutineVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetRoutineVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRoutineVariables otherTyped = other as GetRoutineVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetRoutineVariables({
    required this.id,
  });
}

