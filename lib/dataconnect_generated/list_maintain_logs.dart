part of 'generated.dart';

class ListMaintainLogsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMaintainLogsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMaintainLogsData> dataDeserializer = (dynamic json)  => ListMaintainLogsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMaintainLogsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMaintainLogsData, void> ref() {
    
    return _dataConnect.query("ListMaintainLogs", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMaintainLogsMaintainLogs {
  final String id;
  final String? title;
  final bool? isDone;
  final ListMaintainLogsMaintainLogsMachine machine;
  ListMaintainLogsMaintainLogs.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = json['title'] == null ? null : nativeFromJson<String>(json['title']),
  isDone = json['isDone'] == null ? null : nativeFromJson<bool>(json['isDone']),
  machine = ListMaintainLogsMaintainLogsMachine.fromJson(json['machine']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMaintainLogsMaintainLogs otherTyped = other as ListMaintainLogsMaintainLogs;
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

  ListMaintainLogsMaintainLogs({
    required this.id,
    this.title,
    this.isDone,
    required this.machine,
  });
}

@immutable
class ListMaintainLogsMaintainLogsMachine {
  final String id;
  final String? name;
  ListMaintainLogsMaintainLogsMachine.fromJson(dynamic json):
  
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

    final ListMaintainLogsMaintainLogsMachine otherTyped = other as ListMaintainLogsMaintainLogsMachine;
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

  ListMaintainLogsMaintainLogsMachine({
    required this.id,
    this.name,
  });
}

@immutable
class ListMaintainLogsData {
  final List<ListMaintainLogsMaintainLogs> maintainLogs;
  ListMaintainLogsData.fromJson(dynamic json):
  
  maintainLogs = (json['maintainLogs'] as List<dynamic>)
        .map((e) => ListMaintainLogsMaintainLogs.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMaintainLogsData otherTyped = other as ListMaintainLogsData;
    return maintainLogs == otherTyped.maintainLogs;
    
  }
  @override
  int get hashCode => maintainLogs.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['maintainLogs'] = maintainLogs.map((e) => e.toJson()).toList();
    return json;
  }

  ListMaintainLogsData({
    required this.maintainLogs,
  });
}

