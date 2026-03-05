# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ConnectorConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetUser
#### Required Arguments
```dart
String email = ...;
ConnectorConnector.instance.getUser(
  email: email,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserData, GetUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getUser(
  email: email,
);
GetUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;

final ref = ConnectorConnector.instance.getUser(
  email: email,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListUsers
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.listUsers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListUsersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.listUsers();
ListUsersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.listUsers().ref();
ref.execute();

ref.subscribe(...);
```


### GetMechanics
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.getMechanics().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMechanicsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getMechanics();
GetMechanicsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.getMechanics().ref();
ref.execute();

ref.subscribe(...);
```


### GetMachine
#### Required Arguments
```dart
String id = ...;
ConnectorConnector.instance.getMachine(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMachineData, GetMachineVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getMachine(
  id: id,
);
GetMachineData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ConnectorConnector.instance.getMachine(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListMachines
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.listMachines().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMachinesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.listMachines();
ListMachinesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.listMachines().ref();
ref.execute();

ref.subscribe(...);
```


### GetItem
#### Required Arguments
```dart
String id = ...;
ConnectorConnector.instance.getItem(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetItemData, GetItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getItem(
  id: id,
);
GetItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ConnectorConnector.instance.getItem(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListItems
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.listItems().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListItemsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.listItems();
ListItemsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.listItems().ref();
ref.execute();

ref.subscribe(...);
```


### GetRequest
#### Required Arguments
```dart
String id = ...;
ConnectorConnector.instance.getRequest(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetRequestData, GetRequestVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getRequest(
  id: id,
);
GetRequestData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ConnectorConnector.instance.getRequest(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListRequests
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.listRequests().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListRequestsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.listRequests();
ListRequestsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.listRequests().ref();
ref.execute();

ref.subscribe(...);
```


### GetRequestsByMechanicEmail
#### Required Arguments
```dart
String email = ...;
ConnectorConnector.instance.getRequestsByMechanicEmail(
  email: email,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetRequestsByMechanicEmailData, GetRequestsByMechanicEmailVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getRequestsByMechanicEmail(
  email: email,
);
GetRequestsByMechanicEmailData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;

final ref = ConnectorConnector.instance.getRequestsByMechanicEmail(
  email: email,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetRoutine
#### Required Arguments
```dart
String id = ...;
ConnectorConnector.instance.getRoutine(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetRoutineData, GetRoutineVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getRoutine(
  id: id,
);
GetRoutineData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ConnectorConnector.instance.getRoutine(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetRoutinesByMachineId
#### Required Arguments
```dart
String machineId = ...;
ConnectorConnector.instance.getRoutinesByMachineId(
  machineId: machineId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getRoutinesByMachineId(
  machineId: machineId,
);
GetRoutinesByMachineIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String machineId = ...;

final ref = ConnectorConnector.instance.getRoutinesByMachineId(
  machineId: machineId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetRoutineLog
#### Required Arguments
```dart
String id = ...;
ConnectorConnector.instance.getRoutineLog(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetRoutineLogData, GetRoutineLogVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getRoutineLog(
  id: id,
);
GetRoutineLogData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ConnectorConnector.instance.getRoutineLog(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListRoutineLogs
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.listRoutineLogs().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListRoutineLogsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.listRoutineLogs();
ListRoutineLogsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.listRoutineLogs().ref();
ref.execute();

ref.subscribe(...);
```


### GetMaintainLog
#### Required Arguments
```dart
String id = ...;
ConnectorConnector.instance.getMaintainLog(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMaintainLogData, GetMaintainLogVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getMaintainLog(
  id: id,
);
GetMaintainLogData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ConnectorConnector.instance.getMaintainLog(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListMaintainLogs
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.listMaintainLogs().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMaintainLogsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.listMaintainLogs();
ListMaintainLogsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.listMaintainLogs().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateRequest
#### Required Arguments
```dart
String userEmail = ...;
String machineId = ...;
String description = ...;
Timestamp requestDate = ...;
String mechanicEmail = ...;
ConnectorConnector.instance.createRequest(
  userEmail: userEmail,
  machineId: machineId,
  description: description,
  requestDate: requestDate,
  mechanicEmail: mechanicEmail,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateRequestData, CreateRequestVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.createRequest(
  userEmail: userEmail,
  machineId: machineId,
  description: description,
  requestDate: requestDate,
  mechanicEmail: mechanicEmail,
);
CreateRequestData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userEmail = ...;
String machineId = ...;
String description = ...;
Timestamp requestDate = ...;
String mechanicEmail = ...;

final ref = ConnectorConnector.instance.createRequest(
  userEmail: userEmail,
  machineId: machineId,
  description: description,
  requestDate: requestDate,
  mechanicEmail: mechanicEmail,
).ref();
ref.execute();
```


### UpdateRoutine
#### Required Arguments
```dart
String id = ...;
bool isCheck = ...;
ConnectorConnector.instance.updateRoutine(
  id: id,
  isCheck: isCheck,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateRoutineData, UpdateRoutineVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.updateRoutine(
  id: id,
  isCheck: isCheck,
);
UpdateRoutineData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
bool isCheck = ...;

final ref = ConnectorConnector.instance.updateRoutine(
  id: id,
  isCheck: isCheck,
).ref();
ref.execute();
```


### UpdateRequestStatus
#### Required Arguments
```dart
String id = ...;
String status = ...;
ConnectorConnector.instance.updateRequestStatus(
  id: id,
  status: status,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateRequestStatusData, UpdateRequestStatusVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.updateRequestStatus(
  id: id,
  status: status,
);
UpdateRequestStatusData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String status = ...;

final ref = ConnectorConnector.instance.updateRequestStatus(
  id: id,
  status: status,
).ref();
ref.execute();
```


### CreateItem
#### Required Arguments
```dart
String name = ...;
int quantity = ...;
ConnectorConnector.instance.createItem(
  name: name,
  quantity: quantity,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateItem, we created `CreateItemBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateItemVariablesBuilder {
  ...
   CreateItemVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }

  ...
}
ConnectorConnector.instance.createItem(
  name: name,
  quantity: quantity,
)
.description(description)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateItemData, CreateItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.createItem(
  name: name,
  quantity: quantity,
);
CreateItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
int quantity = ...;

final ref = ConnectorConnector.instance.createItem(
  name: name,
  quantity: quantity,
).ref();
ref.execute();
```


### CreateMachine
#### Required Arguments
```dart
String name = ...;
ConnectorConnector.instance.createMachine(
  name: name,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateMachine, we created `CreateMachineBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateMachineVariablesBuilder {
  ...
   CreateMachineVariablesBuilder serialNumber(int? t) {
   _serialNumber.value = t;
   return this;
  }
  CreateMachineVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }

  ...
}
ConnectorConnector.instance.createMachine(
  name: name,
)
.serialNumber(serialNumber)
.description(description)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateMachineData, CreateMachineVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.createMachine(
  name: name,
);
CreateMachineData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;

final ref = ConnectorConnector.instance.createMachine(
  name: name,
).ref();
ref.execute();
```


### CreateUser
#### Required Arguments
```dart
String email = ...;
String password = ...;
ConnectorConnector.instance.createUser(
  email: email,
  password: password,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateUser, we created `CreateUserBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateUserVariablesBuilder {
  ...
   CreateUserVariablesBuilder name(String? t) {
   _name.value = t;
   return this;
  }
  CreateUserVariablesBuilder role(String? t) {
   _role.value = t;
   return this;
  }
  CreateUserVariablesBuilder tel(String? t) {
   _tel.value = t;
   return this;
  }

  ...
}
ConnectorConnector.instance.createUser(
  email: email,
  password: password,
)
.name(name)
.role(role)
.tel(tel)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateUserData, CreateUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.createUser(
  email: email,
  password: password,
);
CreateUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;
String password = ...;

final ref = ConnectorConnector.instance.createUser(
  email: email,
  password: password,
).ref();
ref.execute();
```

