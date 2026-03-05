# Basic Usage

```dart
ConnectorConnector.instance.CreateRequest(createRequestVariables).execute();
ConnectorConnector.instance.UpdateRoutine(updateRoutineVariables).execute();
ConnectorConnector.instance.UpdateRequestStatus(updateRequestStatusVariables).execute();
ConnectorConnector.instance.CreateItem(createItemVariables).execute();
ConnectorConnector.instance.CreateMachine(createMachineVariables).execute();
ConnectorConnector.instance.CreateUser(createUserVariables).execute();
ConnectorConnector.instance.GetUser(getUserVariables).execute();
ConnectorConnector.instance.ListUsers().execute();
ConnectorConnector.instance.GetMechanics().execute();
ConnectorConnector.instance.GetMachine(getMachineVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await ConnectorConnector.instance.CreateUser({ ... })
.name(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

