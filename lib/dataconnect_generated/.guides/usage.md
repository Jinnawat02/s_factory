# Basic Usage

```dart
ConnectorConnector.instance.CreateUser(createUserVariables).execute();
ConnectorConnector.instance.UpdateUser(updateUserVariables).execute();
ConnectorConnector.instance.DeleteUser(deleteUserVariables).execute();
ConnectorConnector.instance.CreateMachine(createMachineVariables).execute();
ConnectorConnector.instance.UpdateMachine(updateMachineVariables).execute();
ConnectorConnector.instance.DeleteMachine(deleteMachineVariables).execute();
ConnectorConnector.instance.CreateItem(createItemVariables).execute();
ConnectorConnector.instance.UpdateItem(updateItemVariables).execute();
ConnectorConnector.instance.DeleteItem(deleteItemVariables).execute();
ConnectorConnector.instance.CreateRequest(createRequestVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await ConnectorConnector.instance.UpdateRoutine({ ... })
.updatedAt(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

