part of 'generated.dart';

class ListItemsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListItemsVariablesBuilder(this._dataConnect, );
  Deserializer<ListItemsData> dataDeserializer = (dynamic json)  => ListItemsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListItemsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListItemsData, void> ref() {
    
    return _dataConnect.query("ListItems", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListItemsItems {
  final String id;
  final String? name;
  final int? quantity;
  final String? description;
  ListItemsItems.fromJson(dynamic json):
  
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

    final ListItemsItems otherTyped = other as ListItemsItems;
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

  ListItemsItems({
    required this.id,
    this.name,
    this.quantity,
    this.description,
  });
}

@immutable
class ListItemsData {
  final List<ListItemsItems> items;
  ListItemsData.fromJson(dynamic json):
  
  items = (json['items'] as List<dynamic>)
        .map((e) => ListItemsItems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListItemsData otherTyped = other as ListItemsData;
    return items == otherTyped.items;
    
  }
  @override
  int get hashCode => items.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['items'] = items.map((e) => e.toJson()).toList();
    return json;
  }

  ListItemsData({
    required this.items,
  });
}

