part of 'generated.dart';

class GetItemVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetItemVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetItemData> dataDeserializer = (dynamic json)  => GetItemData.fromJson(jsonDecode(json));
  Serializer<GetItemVariables> varsSerializer = (GetItemVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetItemData, GetItemVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetItemData, GetItemVariables> ref() {
    GetItemVariables vars= GetItemVariables(id: id,);
    return _dataConnect.query("GetItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetItemItem {
  final String id;
  final String? name;
  final int? quantity;
  final String? description;
  GetItemItem.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = json['name'] == null ? null : nativeFromJson<String>(json['name']),
  quantity = json['quantity'] == null ? null : nativeFromJson<int>(json['quantity']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetItemItem otherTyped = other as GetItemItem;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    quantity == otherTyped.quantity && 
    description == otherTyped.description;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, quantity.hashCode, description.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (name != null) {
      json['name'] = nativeToJson<String?>(name);
    }
    if (quantity != null) {
      json['quantity'] = nativeToJson<int?>(quantity);
    }
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    return json;
  }

  GetItemItem({
    required this.id,
    this.name,
    this.quantity,
    this.description,
  });
}

@immutable
class GetItemData {
  final GetItemItem? item;
  GetItemData.fromJson(dynamic json):
  
  item = json['item'] == null ? null : GetItemItem.fromJson(json['item']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetItemData otherTyped = other as GetItemData;
    return item == otherTyped.item;
    
  }
  @override
  int get hashCode => item.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (item != null) {
      json['item'] = item!.toJson();
    }
    return json;
  }

  GetItemData({
    this.item,
  });
}

@immutable
class GetItemVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetItemVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetItemVariables otherTyped = other as GetItemVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetItemVariables({
    required this.id,
  });
}

