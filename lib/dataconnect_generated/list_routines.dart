part of 'generated.dart';

class ListRoutinesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListRoutinesVariablesBuilder(this._dataConnect, );
  Deserializer<ListRoutinesData> dataDeserializer = (dynamic json)  => ListRoutinesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListRoutinesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListRoutinesData, void> ref() {
    
    return _dataConnect.query("ListRoutines", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListRoutinesRoutines {
  final String id;
  final String? title;
  final ListRoutinesRoutinesCreator creator;
  ListRoutinesRoutines.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = json['title'] == null ? null : nativeFromJson<String>(json['title']),
  creator = ListRoutinesRoutinesCreator.fromJson(json['creator']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListRoutinesRoutines otherTyped = other as ListRoutinesRoutines;
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

  ListRoutinesRoutines({
    required this.id,
    this.title,
    required this.creator,
  });
}

@immutable
class ListRoutinesRoutinesCreator {
  final String email;
  final String? name;
  ListRoutinesRoutinesCreator.fromJson(dynamic json):
  
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

    final ListRoutinesRoutinesCreator otherTyped = other as ListRoutinesRoutinesCreator;
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

  ListRoutinesRoutinesCreator({
    required this.email,
    this.name,
  });
}

@immutable
class ListRoutinesData {
  final List<ListRoutinesRoutines> routines;
  ListRoutinesData.fromJson(dynamic json):
  
  routines = (json['routines'] as List<dynamic>)
        .map((e) => ListRoutinesRoutines.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListRoutinesData otherTyped = other as ListRoutinesData;
    return routines == otherTyped.routines;
    
  }
  @override
  int get hashCode => routines.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['routines'] = routines.map((e) => e.toJson()).toList();
    return json;
  }

  ListRoutinesData({
    required this.routines,
  });
}

