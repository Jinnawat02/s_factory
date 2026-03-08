# Basic Usage

```dart
ConnectorConnector.instance.GetUser(getUserVariables).execute();
ConnectorConnector.instance.ListUsers().execute();
ConnectorConnector.instance.GetMechanics().execute();
ConnectorConnector.instance.GetMachine(getMachineVariables).execute();
ConnectorConnector.instance.ListMachines().execute();
ConnectorConnector.instance.GetItem(getItemVariables).execute();
ConnectorConnector.instance.ListItems().execute();
ConnectorConnector.instance.GetRequest(getRequestVariables).execute();
ConnectorConnector.instance.ListRequests().execute();
ConnectorConnector.instance.GetRequestsByMechanicEmail(getRequestsByMechanicEmailVariables).execute();

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

