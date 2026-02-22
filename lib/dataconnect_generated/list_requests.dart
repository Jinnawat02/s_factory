part of 'generated.dart';

class ListRequestsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListRequestsVariablesBuilder(this._dataConnect, );
  Deserializer<ListRequestsData> dataDeserializer = (dynamic json)  => ListRequestsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListRequestsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListRequestsData, void> ref() {
    
    return _dataConnect.query("ListRequests", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListRequestsRequests {
  final String id;
  final ListRequestsRequestsUser user;
  final ListRequestsRequestsMachine machine;
  final Timestamp requestDate;
  final String? description;
  final String? status;
  ListRequestsRequests.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  user = ListRequestsRequestsUser.fromJson(json['user']),
  machine = ListRequestsRequestsMachine.fromJson(json['machine']),
  requestDate = Timestamp.fromJson(json['requestDate']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  status = json['status'] == null ? null : nativeFromJson<String>(json['status']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListRequestsRequests otherTyped = other as ListRequestsRequests;
    return id == otherTyped.id && 
    user == otherTyped.user && 
    machine == otherTyped.machine && 
    requestDate == otherTyped.requestDate && 
    description == otherTyped.description && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, user.hashCode, machine.hashCode, requestDate.hashCode, description.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['user'] = user.toJson();
    json['machine'] = machine.toJson();
    json['requestDate'] = requestDate.toJson();
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    if (status != null) {
      json['status'] = nativeToJson<String?>(status);
    }
    return json;
  }

  ListRequestsRequests({
    required this.id,
    required this.user,
    required this.machine,
    required this.requestDate,
    this.description,
    this.status,
  });
}

@immutable
class ListRequestsRequestsUser {
  final String email;
  final String? name;
  ListRequestsRequestsUser.fromJson(dynamic json):
  
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

    final ListRequestsRequestsUser otherTyped = other as ListRequestsRequestsUser;
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

  ListRequestsRequestsUser({
    required this.email,
    this.name,
  });
}

@immutable
class ListRequestsRequestsMachine {
  final String id;
  final String? name;
  ListRequestsRequestsMachine.fromJson(dynamic json):
  
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

    final ListRequestsRequestsMachine otherTyped = other as ListRequestsRequestsMachine;
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

  ListRequestsRequestsMachine({
    required this.id,
    this.name,
  });
}

@immutable
class ListRequestsData {
  final List<ListRequestsRequests> requests;
  ListRequestsData.fromJson(dynamic json):
  
  requests = (json['requests'] as List<dynamic>)
        .map((e) => ListRequestsRequests.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListRequestsData otherTyped = other as ListRequestsData;
    return requests == otherTyped.requests;
    
  }
  @override
  int get hashCode => requests.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['requests'] = requests.map((e) => e.toJson()).toList();
    return json;
  }

  ListRequestsData({
    required this.requests,
  });
}

