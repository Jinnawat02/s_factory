# Generated TypeScript README
This README will guide you through the process of using the generated JavaScript SDK package for the connector `connector`. It will also provide examples on how to use your generated SDK to call your Data Connect queries and mutations.

***NOTE:** This README is generated alongside the generated SDK. If you make changes to this file, they will be overwritten when the SDK is regenerated.*

# Table of Contents
- [**Overview**](#generated-javascript-readme)
- [**Accessing the connector**](#accessing-the-connector)
  - [*Connecting to the local Emulator*](#connecting-to-the-local-emulator)
- [**Queries**](#queries)
  - [*GetUserFCMToken*](#getuserfcmtoken)
  - [*GetUser*](#getuser)
  - [*ListUsers*](#listusers)
  - [*GetMechanics*](#getmechanics)
  - [*GetMachine*](#getmachine)
  - [*ListMachines*](#listmachines)
  - [*GetItem*](#getitem)
  - [*ListItems*](#listitems)
  - [*GetRequest*](#getrequest)
  - [*ListRequests*](#listrequests)
  - [*GetRequestsByMechanicEmail*](#getrequestsbymechanicemail)
  - [*GetRoutine*](#getroutine)
  - [*ListRoutines*](#listroutines)
  - [*GetRoutinesByMachineId*](#getroutinesbymachineid)
  - [*GetRoutineLog*](#getroutinelog)
  - [*ListRoutineLogs*](#listroutinelogs)
  - [*GetMaintainLog*](#getmaintainlog)
  - [*ListMaintainLogs*](#listmaintainlogs)
  - [*GetNotification*](#getnotification)
  - [*ListNotificationsByMechanic*](#listnotificationsbymechanic)
- [**Mutations**](#mutations)
  - [*UpdateFCMToken*](#updatefcmtoken)
  - [*CreateUser*](#createuser)
  - [*UpdateUser*](#updateuser)
  - [*DeleteUser*](#deleteuser)
  - [*CreateMachine*](#createmachine)
  - [*UpdateMachine*](#updatemachine)
  - [*DeleteMachine*](#deletemachine)
  - [*CreateItem*](#createitem)
  - [*UpdateItem*](#updateitem)
  - [*DeleteItem*](#deleteitem)
  - [*CreateRequest*](#createrequest)
  - [*UpdateRequestStatus*](#updaterequeststatus)
  - [*CreateRoutine*](#createroutine)
  - [*UpdateRoutine*](#updateroutine)
  - [*CreateMaintainLog*](#createmaintainlog)
  - [*CreateRoutineLog*](#createroutinelog)
  - [*CreateNotification*](#createnotification)
  - [*MarkNotificationRead*](#marknotificationread)

# Accessing the connector
A connector is a collection of Queries and Mutations. One SDK is generated for each connector - this SDK is generated for the connector `connector`. You can find more information about connectors in the [Data Connect documentation](https://firebase.google.com/docs/data-connect#how-does).

You can use this generated SDK by importing from the package `@firebasegen/default-connector` as shown below. Both CommonJS and ESM imports are supported.

You can also follow the instructions from the [Data Connect documentation](https://firebase.google.com/docs/data-connect/web-sdk#set-client).

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig } from '@firebasegen/default-connector';

const dataConnect = getDataConnect(connectorConfig);
```

## Connecting to the local Emulator
By default, the connector will connect to the production service.

To connect to the emulator, you can use the following code.
You can also follow the emulator instructions from the [Data Connect documentation](https://firebase.google.com/docs/data-connect/web-sdk#instrument-clients).

```typescript
import { connectDataConnectEmulator, getDataConnect } from 'firebase/data-connect';
import { connectorConfig } from '@firebasegen/default-connector';

const dataConnect = getDataConnect(connectorConfig);
connectDataConnectEmulator(dataConnect, 'localhost', 9399);
```

After it's initialized, you can call your Data Connect [queries](#queries) and [mutations](#mutations) from your generated SDK.

# Queries

There are two ways to execute a Data Connect Query using the generated Web SDK:
- Using a Query Reference function, which returns a `QueryRef`
  - The `QueryRef` can be used as an argument to `executeQuery()`, which will execute the Query and return a `QueryPromise`
- Using an action shortcut function, which returns a `QueryPromise`
  - Calling the action shortcut function will execute the Query and return a `QueryPromise`

The following is true for both the action shortcut function and the `QueryRef` function:
- The `QueryPromise` returned will resolve to the result of the Query once it has finished executing
- If the Query accepts arguments, both the action shortcut function and the `QueryRef` function accept a single argument: an object that contains all the required variables (and the optional variables) for the Query
- Both functions can be called with or without passing in a `DataConnect` instance as an argument. If no `DataConnect` argument is passed in, then the generated SDK will call `getDataConnect(connectorConfig)` behind the scenes for you.

Below are examples of how to use the `connector` connector's generated functions to execute each query. You can also follow the examples from the [Data Connect documentation](https://firebase.google.com/docs/data-connect/web-sdk#using-queries).

## GetUserFCMToken
You can execute the `GetUserFCMToken` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getUserFcmToken(vars: GetUserFcmTokenVariables): QueryPromise<GetUserFcmTokenData, GetUserFcmTokenVariables>;

interface GetUserFcmTokenRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetUserFcmTokenVariables): QueryRef<GetUserFcmTokenData, GetUserFcmTokenVariables>;
}
export const getUserFcmTokenRef: GetUserFcmTokenRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getUserFcmToken(dc: DataConnect, vars: GetUserFcmTokenVariables): QueryPromise<GetUserFcmTokenData, GetUserFcmTokenVariables>;

interface GetUserFcmTokenRef {
  ...
  (dc: DataConnect, vars: GetUserFcmTokenVariables): QueryRef<GetUserFcmTokenData, GetUserFcmTokenVariables>;
}
export const getUserFcmTokenRef: GetUserFcmTokenRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getUserFcmTokenRef:
```typescript
const name = getUserFcmTokenRef.operationName;
console.log(name);
```

### Variables
The `GetUserFCMToken` query requires an argument of type `GetUserFcmTokenVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetUserFcmTokenVariables {
  email: string;
}
```
### Return Type
Recall that executing the `GetUserFCMToken` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetUserFcmTokenData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetUserFcmTokenData {
  user?: {
    fcmToken?: string | null;
  };
}
```
### Using `GetUserFCMToken`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getUserFcmToken, GetUserFcmTokenVariables } from '@firebasegen/default-connector';

// The `GetUserFCMToken` query requires an argument of type `GetUserFcmTokenVariables`:
const getUserFcmTokenVars: GetUserFcmTokenVariables = {
  email: ..., 
};

// Call the `getUserFcmToken()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getUserFcmToken(getUserFcmTokenVars);
// Variables can be defined inline as well.
const { data } = await getUserFcmToken({ email: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getUserFcmToken(dataConnect, getUserFcmTokenVars);

console.log(data.user);

// Or, you can use the `Promise` API.
getUserFcmToken(getUserFcmTokenVars).then((response) => {
  const data = response.data;
  console.log(data.user);
});
```

### Using `GetUserFCMToken`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getUserFcmTokenRef, GetUserFcmTokenVariables } from '@firebasegen/default-connector';

// The `GetUserFCMToken` query requires an argument of type `GetUserFcmTokenVariables`:
const getUserFcmTokenVars: GetUserFcmTokenVariables = {
  email: ..., 
};

// Call the `getUserFcmTokenRef()` function to get a reference to the query.
const ref = getUserFcmTokenRef(getUserFcmTokenVars);
// Variables can be defined inline as well.
const ref = getUserFcmTokenRef({ email: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getUserFcmTokenRef(dataConnect, getUserFcmTokenVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.user);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.user);
});
```

## GetUser
You can execute the `GetUser` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getUser(vars: GetUserVariables): QueryPromise<GetUserData, GetUserVariables>;

interface GetUserRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetUserVariables): QueryRef<GetUserData, GetUserVariables>;
}
export const getUserRef: GetUserRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getUser(dc: DataConnect, vars: GetUserVariables): QueryPromise<GetUserData, GetUserVariables>;

interface GetUserRef {
  ...
  (dc: DataConnect, vars: GetUserVariables): QueryRef<GetUserData, GetUserVariables>;
}
export const getUserRef: GetUserRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getUserRef:
```typescript
const name = getUserRef.operationName;
console.log(name);
```

### Variables
The `GetUser` query requires an argument of type `GetUserVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetUserVariables {
  email: string;
}
```
### Return Type
Recall that executing the `GetUser` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetUserData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetUserData {
  user?: {
    email: string;
    name?: string | null;
    role?: string | null;
    tel?: string | null;
    imageUrl?: string | null;
  } & User_Key;
}
```
### Using `GetUser`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getUser, GetUserVariables } from '@firebasegen/default-connector';

// The `GetUser` query requires an argument of type `GetUserVariables`:
const getUserVars: GetUserVariables = {
  email: ..., 
};

// Call the `getUser()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getUser(getUserVars);
// Variables can be defined inline as well.
const { data } = await getUser({ email: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getUser(dataConnect, getUserVars);

console.log(data.user);

// Or, you can use the `Promise` API.
getUser(getUserVars).then((response) => {
  const data = response.data;
  console.log(data.user);
});
```

### Using `GetUser`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getUserRef, GetUserVariables } from '@firebasegen/default-connector';

// The `GetUser` query requires an argument of type `GetUserVariables`:
const getUserVars: GetUserVariables = {
  email: ..., 
};

// Call the `getUserRef()` function to get a reference to the query.
const ref = getUserRef(getUserVars);
// Variables can be defined inline as well.
const ref = getUserRef({ email: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getUserRef(dataConnect, getUserVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.user);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.user);
});
```

## ListUsers
You can execute the `ListUsers` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listUsers(): QueryPromise<ListUsersData, undefined>;

interface ListUsersRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListUsersData, undefined>;
}
export const listUsersRef: ListUsersRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listUsers(dc: DataConnect): QueryPromise<ListUsersData, undefined>;

interface ListUsersRef {
  ...
  (dc: DataConnect): QueryRef<ListUsersData, undefined>;
}
export const listUsersRef: ListUsersRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listUsersRef:
```typescript
const name = listUsersRef.operationName;
console.log(name);
```

### Variables
The `ListUsers` query has no variables.
### Return Type
Recall that executing the `ListUsers` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListUsersData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListUsersData {
  users: ({
    email: string;
    name?: string | null;
    role?: string | null;
    tel?: string | null;
    imageUrl?: string | null;
  } & User_Key)[];
}
```
### Using `ListUsers`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listUsers } from '@firebasegen/default-connector';


// Call the `listUsers()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listUsers();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listUsers(dataConnect);

console.log(data.users);

// Or, you can use the `Promise` API.
listUsers().then((response) => {
  const data = response.data;
  console.log(data.users);
});
```

### Using `ListUsers`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listUsersRef } from '@firebasegen/default-connector';


// Call the `listUsersRef()` function to get a reference to the query.
const ref = listUsersRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listUsersRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.users);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.users);
});
```

## GetMechanics
You can execute the `GetMechanics` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getMechanics(): QueryPromise<GetMechanicsData, undefined>;

interface GetMechanicsRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<GetMechanicsData, undefined>;
}
export const getMechanicsRef: GetMechanicsRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getMechanics(dc: DataConnect): QueryPromise<GetMechanicsData, undefined>;

interface GetMechanicsRef {
  ...
  (dc: DataConnect): QueryRef<GetMechanicsData, undefined>;
}
export const getMechanicsRef: GetMechanicsRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getMechanicsRef:
```typescript
const name = getMechanicsRef.operationName;
console.log(name);
```

### Variables
The `GetMechanics` query has no variables.
### Return Type
Recall that executing the `GetMechanics` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetMechanicsData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetMechanicsData {
  users: ({
    email: string;
    name?: string | null;
    role?: string | null;
    tel?: string | null;
    imageUrl?: string | null;
  } & User_Key)[];
}
```
### Using `GetMechanics`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getMechanics } from '@firebasegen/default-connector';


// Call the `getMechanics()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getMechanics();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getMechanics(dataConnect);

console.log(data.users);

// Or, you can use the `Promise` API.
getMechanics().then((response) => {
  const data = response.data;
  console.log(data.users);
});
```

### Using `GetMechanics`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getMechanicsRef } from '@firebasegen/default-connector';


// Call the `getMechanicsRef()` function to get a reference to the query.
const ref = getMechanicsRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getMechanicsRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.users);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.users);
});
```

## GetMachine
You can execute the `GetMachine` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getMachine(vars: GetMachineVariables): QueryPromise<GetMachineData, GetMachineVariables>;

interface GetMachineRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetMachineVariables): QueryRef<GetMachineData, GetMachineVariables>;
}
export const getMachineRef: GetMachineRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getMachine(dc: DataConnect, vars: GetMachineVariables): QueryPromise<GetMachineData, GetMachineVariables>;

interface GetMachineRef {
  ...
  (dc: DataConnect, vars: GetMachineVariables): QueryRef<GetMachineData, GetMachineVariables>;
}
export const getMachineRef: GetMachineRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getMachineRef:
```typescript
const name = getMachineRef.operationName;
console.log(name);
```

### Variables
The `GetMachine` query requires an argument of type `GetMachineVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetMachineVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `GetMachine` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetMachineData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetMachineData {
  machine?: {
    id: UUIDString;
    name?: string | null;
    serialNumber?: number | null;
    description?: string | null;
  } & Machine_Key;
}
```
### Using `GetMachine`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getMachine, GetMachineVariables } from '@firebasegen/default-connector';

// The `GetMachine` query requires an argument of type `GetMachineVariables`:
const getMachineVars: GetMachineVariables = {
  id: ..., 
};

// Call the `getMachine()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getMachine(getMachineVars);
// Variables can be defined inline as well.
const { data } = await getMachine({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getMachine(dataConnect, getMachineVars);

console.log(data.machine);

// Or, you can use the `Promise` API.
getMachine(getMachineVars).then((response) => {
  const data = response.data;
  console.log(data.machine);
});
```

### Using `GetMachine`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getMachineRef, GetMachineVariables } from '@firebasegen/default-connector';

// The `GetMachine` query requires an argument of type `GetMachineVariables`:
const getMachineVars: GetMachineVariables = {
  id: ..., 
};

// Call the `getMachineRef()` function to get a reference to the query.
const ref = getMachineRef(getMachineVars);
// Variables can be defined inline as well.
const ref = getMachineRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getMachineRef(dataConnect, getMachineVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.machine);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.machine);
});
```

## ListMachines
You can execute the `ListMachines` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listMachines(): QueryPromise<ListMachinesData, undefined>;

interface ListMachinesRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListMachinesData, undefined>;
}
export const listMachinesRef: ListMachinesRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listMachines(dc: DataConnect): QueryPromise<ListMachinesData, undefined>;

interface ListMachinesRef {
  ...
  (dc: DataConnect): QueryRef<ListMachinesData, undefined>;
}
export const listMachinesRef: ListMachinesRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listMachinesRef:
```typescript
const name = listMachinesRef.operationName;
console.log(name);
```

### Variables
The `ListMachines` query has no variables.
### Return Type
Recall that executing the `ListMachines` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListMachinesData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListMachinesData {
  machines: ({
    id: UUIDString;
    name?: string | null;
    serialNumber?: number | null;
    description?: string | null;
    imageUrl?: string | null;
  } & Machine_Key)[];
}
```
### Using `ListMachines`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listMachines } from '@firebasegen/default-connector';


// Call the `listMachines()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listMachines();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listMachines(dataConnect);

console.log(data.machines);

// Or, you can use the `Promise` API.
listMachines().then((response) => {
  const data = response.data;
  console.log(data.machines);
});
```

### Using `ListMachines`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listMachinesRef } from '@firebasegen/default-connector';


// Call the `listMachinesRef()` function to get a reference to the query.
const ref = listMachinesRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listMachinesRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.machines);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.machines);
});
```

## GetItem
You can execute the `GetItem` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getItem(vars: GetItemVariables): QueryPromise<GetItemData, GetItemVariables>;

interface GetItemRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetItemVariables): QueryRef<GetItemData, GetItemVariables>;
}
export const getItemRef: GetItemRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getItem(dc: DataConnect, vars: GetItemVariables): QueryPromise<GetItemData, GetItemVariables>;

interface GetItemRef {
  ...
  (dc: DataConnect, vars: GetItemVariables): QueryRef<GetItemData, GetItemVariables>;
}
export const getItemRef: GetItemRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getItemRef:
```typescript
const name = getItemRef.operationName;
console.log(name);
```

### Variables
The `GetItem` query requires an argument of type `GetItemVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetItemVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `GetItem` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetItemData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetItemData {
  item?: {
    id: UUIDString;
    name?: string | null;
    quantity?: number | null;
    description?: string | null;
  } & Item_Key;
}
```
### Using `GetItem`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getItem, GetItemVariables } from '@firebasegen/default-connector';

// The `GetItem` query requires an argument of type `GetItemVariables`:
const getItemVars: GetItemVariables = {
  id: ..., 
};

// Call the `getItem()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getItem(getItemVars);
// Variables can be defined inline as well.
const { data } = await getItem({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getItem(dataConnect, getItemVars);

console.log(data.item);

// Or, you can use the `Promise` API.
getItem(getItemVars).then((response) => {
  const data = response.data;
  console.log(data.item);
});
```

### Using `GetItem`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getItemRef, GetItemVariables } from '@firebasegen/default-connector';

// The `GetItem` query requires an argument of type `GetItemVariables`:
const getItemVars: GetItemVariables = {
  id: ..., 
};

// Call the `getItemRef()` function to get a reference to the query.
const ref = getItemRef(getItemVars);
// Variables can be defined inline as well.
const ref = getItemRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getItemRef(dataConnect, getItemVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.item);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.item);
});
```

## ListItems
You can execute the `ListItems` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listItems(): QueryPromise<ListItemsData, undefined>;

interface ListItemsRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListItemsData, undefined>;
}
export const listItemsRef: ListItemsRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listItems(dc: DataConnect): QueryPromise<ListItemsData, undefined>;

interface ListItemsRef {
  ...
  (dc: DataConnect): QueryRef<ListItemsData, undefined>;
}
export const listItemsRef: ListItemsRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listItemsRef:
```typescript
const name = listItemsRef.operationName;
console.log(name);
```

### Variables
The `ListItems` query has no variables.
### Return Type
Recall that executing the `ListItems` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListItemsData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListItemsData {
  items: ({
    id: UUIDString;
    name?: string | null;
    quantity?: number | null;
    description?: string | null;
    imageUrl?: string | null;
  } & Item_Key)[];
}
```
### Using `ListItems`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listItems } from '@firebasegen/default-connector';


// Call the `listItems()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listItems();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listItems(dataConnect);

console.log(data.items);

// Or, you can use the `Promise` API.
listItems().then((response) => {
  const data = response.data;
  console.log(data.items);
});
```

### Using `ListItems`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listItemsRef } from '@firebasegen/default-connector';


// Call the `listItemsRef()` function to get a reference to the query.
const ref = listItemsRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listItemsRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.items);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.items);
});
```

## GetRequest
You can execute the `GetRequest` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getRequest(vars: GetRequestVariables): QueryPromise<GetRequestData, GetRequestVariables>;

interface GetRequestRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetRequestVariables): QueryRef<GetRequestData, GetRequestVariables>;
}
export const getRequestRef: GetRequestRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getRequest(dc: DataConnect, vars: GetRequestVariables): QueryPromise<GetRequestData, GetRequestVariables>;

interface GetRequestRef {
  ...
  (dc: DataConnect, vars: GetRequestVariables): QueryRef<GetRequestData, GetRequestVariables>;
}
export const getRequestRef: GetRequestRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getRequestRef:
```typescript
const name = getRequestRef.operationName;
console.log(name);
```

### Variables
The `GetRequest` query requires an argument of type `GetRequestVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetRequestVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `GetRequest` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetRequestData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetRequestData {
  request?: {
    id: UUIDString;
    user: {
      email: string;
      name?: string | null;
    } & User_Key;
      machine: {
        id: UUIDString;
        name?: string | null;
      } & Machine_Key;
        requestDate: TimestampString;
        description?: string | null;
        status?: string | null;
  } & Request_Key;
}
```
### Using `GetRequest`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getRequest, GetRequestVariables } from '@firebasegen/default-connector';

// The `GetRequest` query requires an argument of type `GetRequestVariables`:
const getRequestVars: GetRequestVariables = {
  id: ..., 
};

// Call the `getRequest()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getRequest(getRequestVars);
// Variables can be defined inline as well.
const { data } = await getRequest({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getRequest(dataConnect, getRequestVars);

console.log(data.request);

// Or, you can use the `Promise` API.
getRequest(getRequestVars).then((response) => {
  const data = response.data;
  console.log(data.request);
});
```

### Using `GetRequest`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getRequestRef, GetRequestVariables } from '@firebasegen/default-connector';

// The `GetRequest` query requires an argument of type `GetRequestVariables`:
const getRequestVars: GetRequestVariables = {
  id: ..., 
};

// Call the `getRequestRef()` function to get a reference to the query.
const ref = getRequestRef(getRequestVars);
// Variables can be defined inline as well.
const ref = getRequestRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getRequestRef(dataConnect, getRequestVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.request);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.request);
});
```

## ListRequests
You can execute the `ListRequests` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listRequests(): QueryPromise<ListRequestsData, undefined>;

interface ListRequestsRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListRequestsData, undefined>;
}
export const listRequestsRef: ListRequestsRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listRequests(dc: DataConnect): QueryPromise<ListRequestsData, undefined>;

interface ListRequestsRef {
  ...
  (dc: DataConnect): QueryRef<ListRequestsData, undefined>;
}
export const listRequestsRef: ListRequestsRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listRequestsRef:
```typescript
const name = listRequestsRef.operationName;
console.log(name);
```

### Variables
The `ListRequests` query has no variables.
### Return Type
Recall that executing the `ListRequests` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListRequestsData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListRequestsData {
  requests: ({
    id: UUIDString;
    user: {
      email: string;
      name?: string | null;
    } & User_Key;
      machine: {
        id: UUIDString;
        name?: string | null;
      } & Machine_Key;
        mechanic: {
          email: string;
          name?: string | null;
        } & User_Key;
          requestDate: TimestampString;
          description?: string | null;
          status?: string | null;
  } & Request_Key)[];
}
```
### Using `ListRequests`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listRequests } from '@firebasegen/default-connector';


// Call the `listRequests()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listRequests();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listRequests(dataConnect);

console.log(data.requests);

// Or, you can use the `Promise` API.
listRequests().then((response) => {
  const data = response.data;
  console.log(data.requests);
});
```

### Using `ListRequests`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listRequestsRef } from '@firebasegen/default-connector';


// Call the `listRequestsRef()` function to get a reference to the query.
const ref = listRequestsRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listRequestsRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.requests);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.requests);
});
```

## GetRequestsByMechanicEmail
You can execute the `GetRequestsByMechanicEmail` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getRequestsByMechanicEmail(vars: GetRequestsByMechanicEmailVariables): QueryPromise<GetRequestsByMechanicEmailData, GetRequestsByMechanicEmailVariables>;

interface GetRequestsByMechanicEmailRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetRequestsByMechanicEmailVariables): QueryRef<GetRequestsByMechanicEmailData, GetRequestsByMechanicEmailVariables>;
}
export const getRequestsByMechanicEmailRef: GetRequestsByMechanicEmailRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getRequestsByMechanicEmail(dc: DataConnect, vars: GetRequestsByMechanicEmailVariables): QueryPromise<GetRequestsByMechanicEmailData, GetRequestsByMechanicEmailVariables>;

interface GetRequestsByMechanicEmailRef {
  ...
  (dc: DataConnect, vars: GetRequestsByMechanicEmailVariables): QueryRef<GetRequestsByMechanicEmailData, GetRequestsByMechanicEmailVariables>;
}
export const getRequestsByMechanicEmailRef: GetRequestsByMechanicEmailRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getRequestsByMechanicEmailRef:
```typescript
const name = getRequestsByMechanicEmailRef.operationName;
console.log(name);
```

### Variables
The `GetRequestsByMechanicEmail` query requires an argument of type `GetRequestsByMechanicEmailVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetRequestsByMechanicEmailVariables {
  email: string;
}
```
### Return Type
Recall that executing the `GetRequestsByMechanicEmail` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetRequestsByMechanicEmailData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetRequestsByMechanicEmailData {
  requests: ({
    id: UUIDString;
    user: {
      email: string;
      name?: string | null;
    } & User_Key;
      machine: {
        id: UUIDString;
        name?: string | null;
      } & Machine_Key;
        requestDate: TimestampString;
        description?: string | null;
        status?: string | null;
  } & Request_Key)[];
}
```
### Using `GetRequestsByMechanicEmail`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getRequestsByMechanicEmail, GetRequestsByMechanicEmailVariables } from '@firebasegen/default-connector';

// The `GetRequestsByMechanicEmail` query requires an argument of type `GetRequestsByMechanicEmailVariables`:
const getRequestsByMechanicEmailVars: GetRequestsByMechanicEmailVariables = {
  email: ..., 
};

// Call the `getRequestsByMechanicEmail()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getRequestsByMechanicEmail(getRequestsByMechanicEmailVars);
// Variables can be defined inline as well.
const { data } = await getRequestsByMechanicEmail({ email: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getRequestsByMechanicEmail(dataConnect, getRequestsByMechanicEmailVars);

console.log(data.requests);

// Or, you can use the `Promise` API.
getRequestsByMechanicEmail(getRequestsByMechanicEmailVars).then((response) => {
  const data = response.data;
  console.log(data.requests);
});
```

### Using `GetRequestsByMechanicEmail`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getRequestsByMechanicEmailRef, GetRequestsByMechanicEmailVariables } from '@firebasegen/default-connector';

// The `GetRequestsByMechanicEmail` query requires an argument of type `GetRequestsByMechanicEmailVariables`:
const getRequestsByMechanicEmailVars: GetRequestsByMechanicEmailVariables = {
  email: ..., 
};

// Call the `getRequestsByMechanicEmailRef()` function to get a reference to the query.
const ref = getRequestsByMechanicEmailRef(getRequestsByMechanicEmailVars);
// Variables can be defined inline as well.
const ref = getRequestsByMechanicEmailRef({ email: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getRequestsByMechanicEmailRef(dataConnect, getRequestsByMechanicEmailVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.requests);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.requests);
});
```

## GetRoutine
You can execute the `GetRoutine` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getRoutine(vars: GetRoutineVariables): QueryPromise<GetRoutineData, GetRoutineVariables>;

interface GetRoutineRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetRoutineVariables): QueryRef<GetRoutineData, GetRoutineVariables>;
}
export const getRoutineRef: GetRoutineRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getRoutine(dc: DataConnect, vars: GetRoutineVariables): QueryPromise<GetRoutineData, GetRoutineVariables>;

interface GetRoutineRef {
  ...
  (dc: DataConnect, vars: GetRoutineVariables): QueryRef<GetRoutineData, GetRoutineVariables>;
}
export const getRoutineRef: GetRoutineRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getRoutineRef:
```typescript
const name = getRoutineRef.operationName;
console.log(name);
```

### Variables
The `GetRoutine` query requires an argument of type `GetRoutineVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetRoutineVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `GetRoutine` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetRoutineData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetRoutineData {
  routine?: {
    id: UUIDString;
    machine: {
      id: UUIDString;
      name?: string | null;
    } & Machine_Key;
      title?: string | null;
      description?: string | null;
      isCheck?: boolean | null;
  } & Routine_Key;
}
```
### Using `GetRoutine`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getRoutine, GetRoutineVariables } from '@firebasegen/default-connector';

// The `GetRoutine` query requires an argument of type `GetRoutineVariables`:
const getRoutineVars: GetRoutineVariables = {
  id: ..., 
};

// Call the `getRoutine()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getRoutine(getRoutineVars);
// Variables can be defined inline as well.
const { data } = await getRoutine({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getRoutine(dataConnect, getRoutineVars);

console.log(data.routine);

// Or, you can use the `Promise` API.
getRoutine(getRoutineVars).then((response) => {
  const data = response.data;
  console.log(data.routine);
});
```

### Using `GetRoutine`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getRoutineRef, GetRoutineVariables } from '@firebasegen/default-connector';

// The `GetRoutine` query requires an argument of type `GetRoutineVariables`:
const getRoutineVars: GetRoutineVariables = {
  id: ..., 
};

// Call the `getRoutineRef()` function to get a reference to the query.
const ref = getRoutineRef(getRoutineVars);
// Variables can be defined inline as well.
const ref = getRoutineRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getRoutineRef(dataConnect, getRoutineVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.routine);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.routine);
});
```

## ListRoutines
You can execute the `ListRoutines` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listRoutines(): QueryPromise<ListRoutinesData, undefined>;

interface ListRoutinesRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListRoutinesData, undefined>;
}
export const listRoutinesRef: ListRoutinesRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listRoutines(dc: DataConnect): QueryPromise<ListRoutinesData, undefined>;

interface ListRoutinesRef {
  ...
  (dc: DataConnect): QueryRef<ListRoutinesData, undefined>;
}
export const listRoutinesRef: ListRoutinesRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listRoutinesRef:
```typescript
const name = listRoutinesRef.operationName;
console.log(name);
```

### Variables
The `ListRoutines` query has no variables.
### Return Type
Recall that executing the `ListRoutines` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListRoutinesData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListRoutinesData {
  routines: ({
    id: UUIDString;
    machine: {
      id: UUIDString;
      name?: string | null;
    } & Machine_Key;
      title?: string | null;
      description?: string | null;
      isCheck?: boolean | null;
  } & Routine_Key)[];
}
```
### Using `ListRoutines`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listRoutines } from '@firebasegen/default-connector';


// Call the `listRoutines()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listRoutines();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listRoutines(dataConnect);

console.log(data.routines);

// Or, you can use the `Promise` API.
listRoutines().then((response) => {
  const data = response.data;
  console.log(data.routines);
});
```

### Using `ListRoutines`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listRoutinesRef } from '@firebasegen/default-connector';


// Call the `listRoutinesRef()` function to get a reference to the query.
const ref = listRoutinesRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listRoutinesRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.routines);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.routines);
});
```

## GetRoutinesByMachineId
You can execute the `GetRoutinesByMachineId` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getRoutinesByMachineId(vars: GetRoutinesByMachineIdVariables): QueryPromise<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>;

interface GetRoutinesByMachineIdRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetRoutinesByMachineIdVariables): QueryRef<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>;
}
export const getRoutinesByMachineIdRef: GetRoutinesByMachineIdRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getRoutinesByMachineId(dc: DataConnect, vars: GetRoutinesByMachineIdVariables): QueryPromise<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>;

interface GetRoutinesByMachineIdRef {
  ...
  (dc: DataConnect, vars: GetRoutinesByMachineIdVariables): QueryRef<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>;
}
export const getRoutinesByMachineIdRef: GetRoutinesByMachineIdRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getRoutinesByMachineIdRef:
```typescript
const name = getRoutinesByMachineIdRef.operationName;
console.log(name);
```

### Variables
The `GetRoutinesByMachineId` query requires an argument of type `GetRoutinesByMachineIdVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetRoutinesByMachineIdVariables {
  machineId: UUIDString;
}
```
### Return Type
Recall that executing the `GetRoutinesByMachineId` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetRoutinesByMachineIdData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetRoutinesByMachineIdData {
  routines: ({
    id: UUIDString;
    title?: string | null;
    description?: string | null;
    isCheck?: boolean | null;
  } & Routine_Key)[];
}
```
### Using `GetRoutinesByMachineId`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getRoutinesByMachineId, GetRoutinesByMachineIdVariables } from '@firebasegen/default-connector';

// The `GetRoutinesByMachineId` query requires an argument of type `GetRoutinesByMachineIdVariables`:
const getRoutinesByMachineIdVars: GetRoutinesByMachineIdVariables = {
  machineId: ..., 
};

// Call the `getRoutinesByMachineId()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getRoutinesByMachineId(getRoutinesByMachineIdVars);
// Variables can be defined inline as well.
const { data } = await getRoutinesByMachineId({ machineId: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getRoutinesByMachineId(dataConnect, getRoutinesByMachineIdVars);

console.log(data.routines);

// Or, you can use the `Promise` API.
getRoutinesByMachineId(getRoutinesByMachineIdVars).then((response) => {
  const data = response.data;
  console.log(data.routines);
});
```

### Using `GetRoutinesByMachineId`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getRoutinesByMachineIdRef, GetRoutinesByMachineIdVariables } from '@firebasegen/default-connector';

// The `GetRoutinesByMachineId` query requires an argument of type `GetRoutinesByMachineIdVariables`:
const getRoutinesByMachineIdVars: GetRoutinesByMachineIdVariables = {
  machineId: ..., 
};

// Call the `getRoutinesByMachineIdRef()` function to get a reference to the query.
const ref = getRoutinesByMachineIdRef(getRoutinesByMachineIdVars);
// Variables can be defined inline as well.
const ref = getRoutinesByMachineIdRef({ machineId: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getRoutinesByMachineIdRef(dataConnect, getRoutinesByMachineIdVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.routines);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.routines);
});
```

## GetRoutineLog
You can execute the `GetRoutineLog` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getRoutineLog(vars: GetRoutineLogVariables): QueryPromise<GetRoutineLogData, GetRoutineLogVariables>;

interface GetRoutineLogRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetRoutineLogVariables): QueryRef<GetRoutineLogData, GetRoutineLogVariables>;
}
export const getRoutineLogRef: GetRoutineLogRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getRoutineLog(dc: DataConnect, vars: GetRoutineLogVariables): QueryPromise<GetRoutineLogData, GetRoutineLogVariables>;

interface GetRoutineLogRef {
  ...
  (dc: DataConnect, vars: GetRoutineLogVariables): QueryRef<GetRoutineLogData, GetRoutineLogVariables>;
}
export const getRoutineLogRef: GetRoutineLogRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getRoutineLogRef:
```typescript
const name = getRoutineLogRef.operationName;
console.log(name);
```

### Variables
The `GetRoutineLog` query requires an argument of type `GetRoutineLogVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetRoutineLogVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `GetRoutineLog` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetRoutineLogData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetRoutineLogData {
  routineLog?: {
    id: UUIDString;
    title?: string | null;
    isDone?: boolean | null;
    routine: {
      id: UUIDString;
      title?: string | null;
    } & Routine_Key;
  } & RoutineLog_Key;
}
```
### Using `GetRoutineLog`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getRoutineLog, GetRoutineLogVariables } from '@firebasegen/default-connector';

// The `GetRoutineLog` query requires an argument of type `GetRoutineLogVariables`:
const getRoutineLogVars: GetRoutineLogVariables = {
  id: ..., 
};

// Call the `getRoutineLog()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getRoutineLog(getRoutineLogVars);
// Variables can be defined inline as well.
const { data } = await getRoutineLog({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getRoutineLog(dataConnect, getRoutineLogVars);

console.log(data.routineLog);

// Or, you can use the `Promise` API.
getRoutineLog(getRoutineLogVars).then((response) => {
  const data = response.data;
  console.log(data.routineLog);
});
```

### Using `GetRoutineLog`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getRoutineLogRef, GetRoutineLogVariables } from '@firebasegen/default-connector';

// The `GetRoutineLog` query requires an argument of type `GetRoutineLogVariables`:
const getRoutineLogVars: GetRoutineLogVariables = {
  id: ..., 
};

// Call the `getRoutineLogRef()` function to get a reference to the query.
const ref = getRoutineLogRef(getRoutineLogVars);
// Variables can be defined inline as well.
const ref = getRoutineLogRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getRoutineLogRef(dataConnect, getRoutineLogVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.routineLog);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.routineLog);
});
```

## ListRoutineLogs
You can execute the `ListRoutineLogs` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listRoutineLogs(): QueryPromise<ListRoutineLogsData, undefined>;

interface ListRoutineLogsRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListRoutineLogsData, undefined>;
}
export const listRoutineLogsRef: ListRoutineLogsRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listRoutineLogs(dc: DataConnect): QueryPromise<ListRoutineLogsData, undefined>;

interface ListRoutineLogsRef {
  ...
  (dc: DataConnect): QueryRef<ListRoutineLogsData, undefined>;
}
export const listRoutineLogsRef: ListRoutineLogsRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listRoutineLogsRef:
```typescript
const name = listRoutineLogsRef.operationName;
console.log(name);
```

### Variables
The `ListRoutineLogs` query has no variables.
### Return Type
Recall that executing the `ListRoutineLogs` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListRoutineLogsData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListRoutineLogsData {
  routineLogs: ({
    id: UUIDString;
    title?: string | null;
    isDone?: boolean | null;
    routine: {
      id: UUIDString;
      title?: string | null;
    } & Routine_Key;
  } & RoutineLog_Key)[];
}
```
### Using `ListRoutineLogs`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listRoutineLogs } from '@firebasegen/default-connector';


// Call the `listRoutineLogs()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listRoutineLogs();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listRoutineLogs(dataConnect);

console.log(data.routineLogs);

// Or, you can use the `Promise` API.
listRoutineLogs().then((response) => {
  const data = response.data;
  console.log(data.routineLogs);
});
```

### Using `ListRoutineLogs`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listRoutineLogsRef } from '@firebasegen/default-connector';


// Call the `listRoutineLogsRef()` function to get a reference to the query.
const ref = listRoutineLogsRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listRoutineLogsRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.routineLogs);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.routineLogs);
});
```

## GetMaintainLog
You can execute the `GetMaintainLog` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getMaintainLog(vars: GetMaintainLogVariables): QueryPromise<GetMaintainLogData, GetMaintainLogVariables>;

interface GetMaintainLogRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetMaintainLogVariables): QueryRef<GetMaintainLogData, GetMaintainLogVariables>;
}
export const getMaintainLogRef: GetMaintainLogRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getMaintainLog(dc: DataConnect, vars: GetMaintainLogVariables): QueryPromise<GetMaintainLogData, GetMaintainLogVariables>;

interface GetMaintainLogRef {
  ...
  (dc: DataConnect, vars: GetMaintainLogVariables): QueryRef<GetMaintainLogData, GetMaintainLogVariables>;
}
export const getMaintainLogRef: GetMaintainLogRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getMaintainLogRef:
```typescript
const name = getMaintainLogRef.operationName;
console.log(name);
```

### Variables
The `GetMaintainLog` query requires an argument of type `GetMaintainLogVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetMaintainLogVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `GetMaintainLog` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetMaintainLogData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetMaintainLogData {
  maintainLog?: {
    id: UUIDString;
    title?: string | null;
    isDone?: boolean | null;
    machine: {
      id: UUIDString;
      name?: string | null;
    } & Machine_Key;
  } & MaintainLog_Key;
}
```
### Using `GetMaintainLog`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getMaintainLog, GetMaintainLogVariables } from '@firebasegen/default-connector';

// The `GetMaintainLog` query requires an argument of type `GetMaintainLogVariables`:
const getMaintainLogVars: GetMaintainLogVariables = {
  id: ..., 
};

// Call the `getMaintainLog()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getMaintainLog(getMaintainLogVars);
// Variables can be defined inline as well.
const { data } = await getMaintainLog({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getMaintainLog(dataConnect, getMaintainLogVars);

console.log(data.maintainLog);

// Or, you can use the `Promise` API.
getMaintainLog(getMaintainLogVars).then((response) => {
  const data = response.data;
  console.log(data.maintainLog);
});
```

### Using `GetMaintainLog`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getMaintainLogRef, GetMaintainLogVariables } from '@firebasegen/default-connector';

// The `GetMaintainLog` query requires an argument of type `GetMaintainLogVariables`:
const getMaintainLogVars: GetMaintainLogVariables = {
  id: ..., 
};

// Call the `getMaintainLogRef()` function to get a reference to the query.
const ref = getMaintainLogRef(getMaintainLogVars);
// Variables can be defined inline as well.
const ref = getMaintainLogRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getMaintainLogRef(dataConnect, getMaintainLogVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.maintainLog);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.maintainLog);
});
```

## ListMaintainLogs
You can execute the `ListMaintainLogs` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listMaintainLogs(): QueryPromise<ListMaintainLogsData, undefined>;

interface ListMaintainLogsRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListMaintainLogsData, undefined>;
}
export const listMaintainLogsRef: ListMaintainLogsRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listMaintainLogs(dc: DataConnect): QueryPromise<ListMaintainLogsData, undefined>;

interface ListMaintainLogsRef {
  ...
  (dc: DataConnect): QueryRef<ListMaintainLogsData, undefined>;
}
export const listMaintainLogsRef: ListMaintainLogsRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listMaintainLogsRef:
```typescript
const name = listMaintainLogsRef.operationName;
console.log(name);
```

### Variables
The `ListMaintainLogs` query has no variables.
### Return Type
Recall that executing the `ListMaintainLogs` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListMaintainLogsData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListMaintainLogsData {
  maintainLogs: ({
    id: UUIDString;
    title?: string | null;
    isDone?: boolean | null;
    machine: {
      id: UUIDString;
      name?: string | null;
    } & Machine_Key;
  } & MaintainLog_Key)[];
}
```
### Using `ListMaintainLogs`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listMaintainLogs } from '@firebasegen/default-connector';


// Call the `listMaintainLogs()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listMaintainLogs();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listMaintainLogs(dataConnect);

console.log(data.maintainLogs);

// Or, you can use the `Promise` API.
listMaintainLogs().then((response) => {
  const data = response.data;
  console.log(data.maintainLogs);
});
```

### Using `ListMaintainLogs`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listMaintainLogsRef } from '@firebasegen/default-connector';


// Call the `listMaintainLogsRef()` function to get a reference to the query.
const ref = listMaintainLogsRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listMaintainLogsRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.maintainLogs);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.maintainLogs);
});
```

## GetNotification
You can execute the `GetNotification` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getNotification(vars: GetNotificationVariables): QueryPromise<GetNotificationData, GetNotificationVariables>;

interface GetNotificationRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetNotificationVariables): QueryRef<GetNotificationData, GetNotificationVariables>;
}
export const getNotificationRef: GetNotificationRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getNotification(dc: DataConnect, vars: GetNotificationVariables): QueryPromise<GetNotificationData, GetNotificationVariables>;

interface GetNotificationRef {
  ...
  (dc: DataConnect, vars: GetNotificationVariables): QueryRef<GetNotificationData, GetNotificationVariables>;
}
export const getNotificationRef: GetNotificationRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getNotificationRef:
```typescript
const name = getNotificationRef.operationName;
console.log(name);
```

### Variables
The `GetNotification` query requires an argument of type `GetNotificationVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetNotificationVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `GetNotification` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetNotificationData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetNotificationData {
  notification?: {
    id: UUIDString;
    title: string;
    body: string;
    isRead?: boolean | null;
    createdAt: TimestampString;
    mechanic: {
      email: string;
      name?: string | null;
    } & User_Key;
      request: {
        id: UUIDString;
        status?: string | null;
      } & Request_Key;
  } & Notification_Key;
}
```
### Using `GetNotification`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getNotification, GetNotificationVariables } from '@firebasegen/default-connector';

// The `GetNotification` query requires an argument of type `GetNotificationVariables`:
const getNotificationVars: GetNotificationVariables = {
  id: ..., 
};

// Call the `getNotification()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getNotification(getNotificationVars);
// Variables can be defined inline as well.
const { data } = await getNotification({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getNotification(dataConnect, getNotificationVars);

console.log(data.notification);

// Or, you can use the `Promise` API.
getNotification(getNotificationVars).then((response) => {
  const data = response.data;
  console.log(data.notification);
});
```

### Using `GetNotification`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getNotificationRef, GetNotificationVariables } from '@firebasegen/default-connector';

// The `GetNotification` query requires an argument of type `GetNotificationVariables`:
const getNotificationVars: GetNotificationVariables = {
  id: ..., 
};

// Call the `getNotificationRef()` function to get a reference to the query.
const ref = getNotificationRef(getNotificationVars);
// Variables can be defined inline as well.
const ref = getNotificationRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getNotificationRef(dataConnect, getNotificationVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.notification);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.notification);
});
```

## ListNotificationsByMechanic
You can execute the `ListNotificationsByMechanic` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listNotificationsByMechanic(vars: ListNotificationsByMechanicVariables): QueryPromise<ListNotificationsByMechanicData, ListNotificationsByMechanicVariables>;

interface ListNotificationsByMechanicRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: ListNotificationsByMechanicVariables): QueryRef<ListNotificationsByMechanicData, ListNotificationsByMechanicVariables>;
}
export const listNotificationsByMechanicRef: ListNotificationsByMechanicRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listNotificationsByMechanic(dc: DataConnect, vars: ListNotificationsByMechanicVariables): QueryPromise<ListNotificationsByMechanicData, ListNotificationsByMechanicVariables>;

interface ListNotificationsByMechanicRef {
  ...
  (dc: DataConnect, vars: ListNotificationsByMechanicVariables): QueryRef<ListNotificationsByMechanicData, ListNotificationsByMechanicVariables>;
}
export const listNotificationsByMechanicRef: ListNotificationsByMechanicRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listNotificationsByMechanicRef:
```typescript
const name = listNotificationsByMechanicRef.operationName;
console.log(name);
```

### Variables
The `ListNotificationsByMechanic` query requires an argument of type `ListNotificationsByMechanicVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface ListNotificationsByMechanicVariables {
  mechanicEmail: string;
}
```
### Return Type
Recall that executing the `ListNotificationsByMechanic` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListNotificationsByMechanicData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListNotificationsByMechanicData {
  notifications: ({
    id: UUIDString;
    title: string;
    body: string;
    isRead?: boolean | null;
    createdAt: TimestampString;
    request: {
      id: UUIDString;
      status?: string | null;
      machine: {
        id: UUIDString;
        name?: string | null;
      } & Machine_Key;
    } & Request_Key;
  } & Notification_Key)[];
}
```
### Using `ListNotificationsByMechanic`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listNotificationsByMechanic, ListNotificationsByMechanicVariables } from '@firebasegen/default-connector';

// The `ListNotificationsByMechanic` query requires an argument of type `ListNotificationsByMechanicVariables`:
const listNotificationsByMechanicVars: ListNotificationsByMechanicVariables = {
  mechanicEmail: ..., 
};

// Call the `listNotificationsByMechanic()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listNotificationsByMechanic(listNotificationsByMechanicVars);
// Variables can be defined inline as well.
const { data } = await listNotificationsByMechanic({ mechanicEmail: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listNotificationsByMechanic(dataConnect, listNotificationsByMechanicVars);

console.log(data.notifications);

// Or, you can use the `Promise` API.
listNotificationsByMechanic(listNotificationsByMechanicVars).then((response) => {
  const data = response.data;
  console.log(data.notifications);
});
```

### Using `ListNotificationsByMechanic`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listNotificationsByMechanicRef, ListNotificationsByMechanicVariables } from '@firebasegen/default-connector';

// The `ListNotificationsByMechanic` query requires an argument of type `ListNotificationsByMechanicVariables`:
const listNotificationsByMechanicVars: ListNotificationsByMechanicVariables = {
  mechanicEmail: ..., 
};

// Call the `listNotificationsByMechanicRef()` function to get a reference to the query.
const ref = listNotificationsByMechanicRef(listNotificationsByMechanicVars);
// Variables can be defined inline as well.
const ref = listNotificationsByMechanicRef({ mechanicEmail: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listNotificationsByMechanicRef(dataConnect, listNotificationsByMechanicVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.notifications);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.notifications);
});
```

# Mutations

There are two ways to execute a Data Connect Mutation using the generated Web SDK:
- Using a Mutation Reference function, which returns a `MutationRef`
  - The `MutationRef` can be used as an argument to `executeMutation()`, which will execute the Mutation and return a `MutationPromise`
- Using an action shortcut function, which returns a `MutationPromise`
  - Calling the action shortcut function will execute the Mutation and return a `MutationPromise`

The following is true for both the action shortcut function and the `MutationRef` function:
- The `MutationPromise` returned will resolve to the result of the Mutation once it has finished executing
- If the Mutation accepts arguments, both the action shortcut function and the `MutationRef` function accept a single argument: an object that contains all the required variables (and the optional variables) for the Mutation
- Both functions can be called with or without passing in a `DataConnect` instance as an argument. If no `DataConnect` argument is passed in, then the generated SDK will call `getDataConnect(connectorConfig)` behind the scenes for you.

Below are examples of how to use the `connector` connector's generated functions to execute each mutation. You can also follow the examples from the [Data Connect documentation](https://firebase.google.com/docs/data-connect/web-sdk#using-mutations).

## UpdateFCMToken
You can execute the `UpdateFCMToken` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
updateFcmToken(vars: UpdateFcmTokenVariables): MutationPromise<UpdateFcmTokenData, UpdateFcmTokenVariables>;

interface UpdateFcmTokenRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateFcmTokenVariables): MutationRef<UpdateFcmTokenData, UpdateFcmTokenVariables>;
}
export const updateFcmTokenRef: UpdateFcmTokenRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
updateFcmToken(dc: DataConnect, vars: UpdateFcmTokenVariables): MutationPromise<UpdateFcmTokenData, UpdateFcmTokenVariables>;

interface UpdateFcmTokenRef {
  ...
  (dc: DataConnect, vars: UpdateFcmTokenVariables): MutationRef<UpdateFcmTokenData, UpdateFcmTokenVariables>;
}
export const updateFcmTokenRef: UpdateFcmTokenRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the updateFcmTokenRef:
```typescript
const name = updateFcmTokenRef.operationName;
console.log(name);
```

### Variables
The `UpdateFCMToken` mutation requires an argument of type `UpdateFcmTokenVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface UpdateFcmTokenVariables {
  email: string;
  fcmToken: string;
}
```
### Return Type
Recall that executing the `UpdateFCMToken` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `UpdateFcmTokenData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface UpdateFcmTokenData {
  user_update?: User_Key | null;
}
```
### Using `UpdateFCMToken`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, updateFcmToken, UpdateFcmTokenVariables } from '@firebasegen/default-connector';

// The `UpdateFCMToken` mutation requires an argument of type `UpdateFcmTokenVariables`:
const updateFcmTokenVars: UpdateFcmTokenVariables = {
  email: ..., 
  fcmToken: ..., 
};

// Call the `updateFcmToken()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await updateFcmToken(updateFcmTokenVars);
// Variables can be defined inline as well.
const { data } = await updateFcmToken({ email: ..., fcmToken: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await updateFcmToken(dataConnect, updateFcmTokenVars);

console.log(data.user_update);

// Or, you can use the `Promise` API.
updateFcmToken(updateFcmTokenVars).then((response) => {
  const data = response.data;
  console.log(data.user_update);
});
```

### Using `UpdateFCMToken`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, updateFcmTokenRef, UpdateFcmTokenVariables } from '@firebasegen/default-connector';

// The `UpdateFCMToken` mutation requires an argument of type `UpdateFcmTokenVariables`:
const updateFcmTokenVars: UpdateFcmTokenVariables = {
  email: ..., 
  fcmToken: ..., 
};

// Call the `updateFcmTokenRef()` function to get a reference to the mutation.
const ref = updateFcmTokenRef(updateFcmTokenVars);
// Variables can be defined inline as well.
const ref = updateFcmTokenRef({ email: ..., fcmToken: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = updateFcmTokenRef(dataConnect, updateFcmTokenVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.user_update);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.user_update);
});
```

## CreateUser
You can execute the `CreateUser` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createUser(vars: CreateUserVariables): MutationPromise<CreateUserData, CreateUserVariables>;

interface CreateUserRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateUserVariables): MutationRef<CreateUserData, CreateUserVariables>;
}
export const createUserRef: CreateUserRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createUser(dc: DataConnect, vars: CreateUserVariables): MutationPromise<CreateUserData, CreateUserVariables>;

interface CreateUserRef {
  ...
  (dc: DataConnect, vars: CreateUserVariables): MutationRef<CreateUserData, CreateUserVariables>;
}
export const createUserRef: CreateUserRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createUserRef:
```typescript
const name = createUserRef.operationName;
console.log(name);
```

### Variables
The `CreateUser` mutation requires an argument of type `CreateUserVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateUserVariables {
  email: string;
  password: string;
  name: string;
  role: string;
  tel: string;
  imageUrl?: string | null;
}
```
### Return Type
Recall that executing the `CreateUser` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateUserData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateUserData {
  user_insert: User_Key;
}
```
### Using `CreateUser`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createUser, CreateUserVariables } from '@firebasegen/default-connector';

// The `CreateUser` mutation requires an argument of type `CreateUserVariables`:
const createUserVars: CreateUserVariables = {
  email: ..., 
  password: ..., 
  name: ..., 
  role: ..., 
  tel: ..., 
  imageUrl: ..., // optional
};

// Call the `createUser()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createUser(createUserVars);
// Variables can be defined inline as well.
const { data } = await createUser({ email: ..., password: ..., name: ..., role: ..., tel: ..., imageUrl: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createUser(dataConnect, createUserVars);

console.log(data.user_insert);

// Or, you can use the `Promise` API.
createUser(createUserVars).then((response) => {
  const data = response.data;
  console.log(data.user_insert);
});
```

### Using `CreateUser`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createUserRef, CreateUserVariables } from '@firebasegen/default-connector';

// The `CreateUser` mutation requires an argument of type `CreateUserVariables`:
const createUserVars: CreateUserVariables = {
  email: ..., 
  password: ..., 
  name: ..., 
  role: ..., 
  tel: ..., 
  imageUrl: ..., // optional
};

// Call the `createUserRef()` function to get a reference to the mutation.
const ref = createUserRef(createUserVars);
// Variables can be defined inline as well.
const ref = createUserRef({ email: ..., password: ..., name: ..., role: ..., tel: ..., imageUrl: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createUserRef(dataConnect, createUserVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.user_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.user_insert);
});
```

## UpdateUser
You can execute the `UpdateUser` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
updateUser(vars: UpdateUserVariables): MutationPromise<UpdateUserData, UpdateUserVariables>;

interface UpdateUserRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateUserVariables): MutationRef<UpdateUserData, UpdateUserVariables>;
}
export const updateUserRef: UpdateUserRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
updateUser(dc: DataConnect, vars: UpdateUserVariables): MutationPromise<UpdateUserData, UpdateUserVariables>;

interface UpdateUserRef {
  ...
  (dc: DataConnect, vars: UpdateUserVariables): MutationRef<UpdateUserData, UpdateUserVariables>;
}
export const updateUserRef: UpdateUserRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the updateUserRef:
```typescript
const name = updateUserRef.operationName;
console.log(name);
```

### Variables
The `UpdateUser` mutation requires an argument of type `UpdateUserVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface UpdateUserVariables {
  email: string;
  name?: string | null;
  role?: string | null;
  tel?: string | null;
  imageUrl?: string | null;
  updatedAt?: TimestampString | null;
}
```
### Return Type
Recall that executing the `UpdateUser` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `UpdateUserData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface UpdateUserData {
  user_update?: User_Key | null;
}
```
### Using `UpdateUser`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, updateUser, UpdateUserVariables } from '@firebasegen/default-connector';

// The `UpdateUser` mutation requires an argument of type `UpdateUserVariables`:
const updateUserVars: UpdateUserVariables = {
  email: ..., 
  name: ..., // optional
  role: ..., // optional
  tel: ..., // optional
  imageUrl: ..., // optional
  updatedAt: ..., // optional
};

// Call the `updateUser()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await updateUser(updateUserVars);
// Variables can be defined inline as well.
const { data } = await updateUser({ email: ..., name: ..., role: ..., tel: ..., imageUrl: ..., updatedAt: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await updateUser(dataConnect, updateUserVars);

console.log(data.user_update);

// Or, you can use the `Promise` API.
updateUser(updateUserVars).then((response) => {
  const data = response.data;
  console.log(data.user_update);
});
```

### Using `UpdateUser`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, updateUserRef, UpdateUserVariables } from '@firebasegen/default-connector';

// The `UpdateUser` mutation requires an argument of type `UpdateUserVariables`:
const updateUserVars: UpdateUserVariables = {
  email: ..., 
  name: ..., // optional
  role: ..., // optional
  tel: ..., // optional
  imageUrl: ..., // optional
  updatedAt: ..., // optional
};

// Call the `updateUserRef()` function to get a reference to the mutation.
const ref = updateUserRef(updateUserVars);
// Variables can be defined inline as well.
const ref = updateUserRef({ email: ..., name: ..., role: ..., tel: ..., imageUrl: ..., updatedAt: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = updateUserRef(dataConnect, updateUserVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.user_update);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.user_update);
});
```

## DeleteUser
You can execute the `DeleteUser` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
deleteUser(vars: DeleteUserVariables): MutationPromise<DeleteUserData, DeleteUserVariables>;

interface DeleteUserRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: DeleteUserVariables): MutationRef<DeleteUserData, DeleteUserVariables>;
}
export const deleteUserRef: DeleteUserRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
deleteUser(dc: DataConnect, vars: DeleteUserVariables): MutationPromise<DeleteUserData, DeleteUserVariables>;

interface DeleteUserRef {
  ...
  (dc: DataConnect, vars: DeleteUserVariables): MutationRef<DeleteUserData, DeleteUserVariables>;
}
export const deleteUserRef: DeleteUserRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the deleteUserRef:
```typescript
const name = deleteUserRef.operationName;
console.log(name);
```

### Variables
The `DeleteUser` mutation requires an argument of type `DeleteUserVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface DeleteUserVariables {
  email: string;
}
```
### Return Type
Recall that executing the `DeleteUser` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `DeleteUserData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface DeleteUserData {
  user_delete?: User_Key | null;
}
```
### Using `DeleteUser`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, deleteUser, DeleteUserVariables } from '@firebasegen/default-connector';

// The `DeleteUser` mutation requires an argument of type `DeleteUserVariables`:
const deleteUserVars: DeleteUserVariables = {
  email: ..., 
};

// Call the `deleteUser()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await deleteUser(deleteUserVars);
// Variables can be defined inline as well.
const { data } = await deleteUser({ email: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await deleteUser(dataConnect, deleteUserVars);

console.log(data.user_delete);

// Or, you can use the `Promise` API.
deleteUser(deleteUserVars).then((response) => {
  const data = response.data;
  console.log(data.user_delete);
});
```

### Using `DeleteUser`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, deleteUserRef, DeleteUserVariables } from '@firebasegen/default-connector';

// The `DeleteUser` mutation requires an argument of type `DeleteUserVariables`:
const deleteUserVars: DeleteUserVariables = {
  email: ..., 
};

// Call the `deleteUserRef()` function to get a reference to the mutation.
const ref = deleteUserRef(deleteUserVars);
// Variables can be defined inline as well.
const ref = deleteUserRef({ email: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = deleteUserRef(dataConnect, deleteUserVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.user_delete);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.user_delete);
});
```

## CreateMachine
You can execute the `CreateMachine` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createMachine(vars: CreateMachineVariables): MutationPromise<CreateMachineData, CreateMachineVariables>;

interface CreateMachineRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateMachineVariables): MutationRef<CreateMachineData, CreateMachineVariables>;
}
export const createMachineRef: CreateMachineRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createMachine(dc: DataConnect, vars: CreateMachineVariables): MutationPromise<CreateMachineData, CreateMachineVariables>;

interface CreateMachineRef {
  ...
  (dc: DataConnect, vars: CreateMachineVariables): MutationRef<CreateMachineData, CreateMachineVariables>;
}
export const createMachineRef: CreateMachineRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createMachineRef:
```typescript
const name = createMachineRef.operationName;
console.log(name);
```

### Variables
The `CreateMachine` mutation requires an argument of type `CreateMachineVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateMachineVariables {
  name: string;
  serialNumber: number;
  description: string;
  imageUrl?: string | null;
}
```
### Return Type
Recall that executing the `CreateMachine` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateMachineData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateMachineData {
  machine_insert: Machine_Key;
}
```
### Using `CreateMachine`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createMachine, CreateMachineVariables } from '@firebasegen/default-connector';

// The `CreateMachine` mutation requires an argument of type `CreateMachineVariables`:
const createMachineVars: CreateMachineVariables = {
  name: ..., 
  serialNumber: ..., 
  description: ..., 
  imageUrl: ..., // optional
};

// Call the `createMachine()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createMachine(createMachineVars);
// Variables can be defined inline as well.
const { data } = await createMachine({ name: ..., serialNumber: ..., description: ..., imageUrl: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createMachine(dataConnect, createMachineVars);

console.log(data.machine_insert);

// Or, you can use the `Promise` API.
createMachine(createMachineVars).then((response) => {
  const data = response.data;
  console.log(data.machine_insert);
});
```

### Using `CreateMachine`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createMachineRef, CreateMachineVariables } from '@firebasegen/default-connector';

// The `CreateMachine` mutation requires an argument of type `CreateMachineVariables`:
const createMachineVars: CreateMachineVariables = {
  name: ..., 
  serialNumber: ..., 
  description: ..., 
  imageUrl: ..., // optional
};

// Call the `createMachineRef()` function to get a reference to the mutation.
const ref = createMachineRef(createMachineVars);
// Variables can be defined inline as well.
const ref = createMachineRef({ name: ..., serialNumber: ..., description: ..., imageUrl: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createMachineRef(dataConnect, createMachineVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.machine_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.machine_insert);
});
```

## UpdateMachine
You can execute the `UpdateMachine` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
updateMachine(vars: UpdateMachineVariables): MutationPromise<UpdateMachineData, UpdateMachineVariables>;

interface UpdateMachineRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateMachineVariables): MutationRef<UpdateMachineData, UpdateMachineVariables>;
}
export const updateMachineRef: UpdateMachineRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
updateMachine(dc: DataConnect, vars: UpdateMachineVariables): MutationPromise<UpdateMachineData, UpdateMachineVariables>;

interface UpdateMachineRef {
  ...
  (dc: DataConnect, vars: UpdateMachineVariables): MutationRef<UpdateMachineData, UpdateMachineVariables>;
}
export const updateMachineRef: UpdateMachineRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the updateMachineRef:
```typescript
const name = updateMachineRef.operationName;
console.log(name);
```

### Variables
The `UpdateMachine` mutation requires an argument of type `UpdateMachineVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface UpdateMachineVariables {
  id: UUIDString;
  name?: string | null;
  serialNumber?: number | null;
  description?: string | null;
  imageUrl?: string | null;
  updatedAt?: TimestampString | null;
}
```
### Return Type
Recall that executing the `UpdateMachine` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `UpdateMachineData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface UpdateMachineData {
  machine_update?: Machine_Key | null;
}
```
### Using `UpdateMachine`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, updateMachine, UpdateMachineVariables } from '@firebasegen/default-connector';

// The `UpdateMachine` mutation requires an argument of type `UpdateMachineVariables`:
const updateMachineVars: UpdateMachineVariables = {
  id: ..., 
  name: ..., // optional
  serialNumber: ..., // optional
  description: ..., // optional
  imageUrl: ..., // optional
  updatedAt: ..., // optional
};

// Call the `updateMachine()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await updateMachine(updateMachineVars);
// Variables can be defined inline as well.
const { data } = await updateMachine({ id: ..., name: ..., serialNumber: ..., description: ..., imageUrl: ..., updatedAt: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await updateMachine(dataConnect, updateMachineVars);

console.log(data.machine_update);

// Or, you can use the `Promise` API.
updateMachine(updateMachineVars).then((response) => {
  const data = response.data;
  console.log(data.machine_update);
});
```

### Using `UpdateMachine`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, updateMachineRef, UpdateMachineVariables } from '@firebasegen/default-connector';

// The `UpdateMachine` mutation requires an argument of type `UpdateMachineVariables`:
const updateMachineVars: UpdateMachineVariables = {
  id: ..., 
  name: ..., // optional
  serialNumber: ..., // optional
  description: ..., // optional
  imageUrl: ..., // optional
  updatedAt: ..., // optional
};

// Call the `updateMachineRef()` function to get a reference to the mutation.
const ref = updateMachineRef(updateMachineVars);
// Variables can be defined inline as well.
const ref = updateMachineRef({ id: ..., name: ..., serialNumber: ..., description: ..., imageUrl: ..., updatedAt: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = updateMachineRef(dataConnect, updateMachineVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.machine_update);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.machine_update);
});
```

## DeleteMachine
You can execute the `DeleteMachine` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
deleteMachine(vars: DeleteMachineVariables): MutationPromise<DeleteMachineData, DeleteMachineVariables>;

interface DeleteMachineRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: DeleteMachineVariables): MutationRef<DeleteMachineData, DeleteMachineVariables>;
}
export const deleteMachineRef: DeleteMachineRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
deleteMachine(dc: DataConnect, vars: DeleteMachineVariables): MutationPromise<DeleteMachineData, DeleteMachineVariables>;

interface DeleteMachineRef {
  ...
  (dc: DataConnect, vars: DeleteMachineVariables): MutationRef<DeleteMachineData, DeleteMachineVariables>;
}
export const deleteMachineRef: DeleteMachineRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the deleteMachineRef:
```typescript
const name = deleteMachineRef.operationName;
console.log(name);
```

### Variables
The `DeleteMachine` mutation requires an argument of type `DeleteMachineVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface DeleteMachineVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `DeleteMachine` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `DeleteMachineData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface DeleteMachineData {
  machine_delete?: Machine_Key | null;
}
```
### Using `DeleteMachine`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, deleteMachine, DeleteMachineVariables } from '@firebasegen/default-connector';

// The `DeleteMachine` mutation requires an argument of type `DeleteMachineVariables`:
const deleteMachineVars: DeleteMachineVariables = {
  id: ..., 
};

// Call the `deleteMachine()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await deleteMachine(deleteMachineVars);
// Variables can be defined inline as well.
const { data } = await deleteMachine({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await deleteMachine(dataConnect, deleteMachineVars);

console.log(data.machine_delete);

// Or, you can use the `Promise` API.
deleteMachine(deleteMachineVars).then((response) => {
  const data = response.data;
  console.log(data.machine_delete);
});
```

### Using `DeleteMachine`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, deleteMachineRef, DeleteMachineVariables } from '@firebasegen/default-connector';

// The `DeleteMachine` mutation requires an argument of type `DeleteMachineVariables`:
const deleteMachineVars: DeleteMachineVariables = {
  id: ..., 
};

// Call the `deleteMachineRef()` function to get a reference to the mutation.
const ref = deleteMachineRef(deleteMachineVars);
// Variables can be defined inline as well.
const ref = deleteMachineRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = deleteMachineRef(dataConnect, deleteMachineVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.machine_delete);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.machine_delete);
});
```

## CreateItem
You can execute the `CreateItem` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createItem(vars: CreateItemVariables): MutationPromise<CreateItemData, CreateItemVariables>;

interface CreateItemRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateItemVariables): MutationRef<CreateItemData, CreateItemVariables>;
}
export const createItemRef: CreateItemRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createItem(dc: DataConnect, vars: CreateItemVariables): MutationPromise<CreateItemData, CreateItemVariables>;

interface CreateItemRef {
  ...
  (dc: DataConnect, vars: CreateItemVariables): MutationRef<CreateItemData, CreateItemVariables>;
}
export const createItemRef: CreateItemRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createItemRef:
```typescript
const name = createItemRef.operationName;
console.log(name);
```

### Variables
The `CreateItem` mutation requires an argument of type `CreateItemVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateItemVariables {
  name: string;
  quantity: number;
  description: string;
  imageUrl?: string | null;
}
```
### Return Type
Recall that executing the `CreateItem` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateItemData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateItemData {
  item_insert: Item_Key;
}
```
### Using `CreateItem`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createItem, CreateItemVariables } from '@firebasegen/default-connector';

// The `CreateItem` mutation requires an argument of type `CreateItemVariables`:
const createItemVars: CreateItemVariables = {
  name: ..., 
  quantity: ..., 
  description: ..., 
  imageUrl: ..., // optional
};

// Call the `createItem()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createItem(createItemVars);
// Variables can be defined inline as well.
const { data } = await createItem({ name: ..., quantity: ..., description: ..., imageUrl: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createItem(dataConnect, createItemVars);

console.log(data.item_insert);

// Or, you can use the `Promise` API.
createItem(createItemVars).then((response) => {
  const data = response.data;
  console.log(data.item_insert);
});
```

### Using `CreateItem`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createItemRef, CreateItemVariables } from '@firebasegen/default-connector';

// The `CreateItem` mutation requires an argument of type `CreateItemVariables`:
const createItemVars: CreateItemVariables = {
  name: ..., 
  quantity: ..., 
  description: ..., 
  imageUrl: ..., // optional
};

// Call the `createItemRef()` function to get a reference to the mutation.
const ref = createItemRef(createItemVars);
// Variables can be defined inline as well.
const ref = createItemRef({ name: ..., quantity: ..., description: ..., imageUrl: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createItemRef(dataConnect, createItemVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.item_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.item_insert);
});
```

## UpdateItem
You can execute the `UpdateItem` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
updateItem(vars: UpdateItemVariables): MutationPromise<UpdateItemData, UpdateItemVariables>;

interface UpdateItemRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateItemVariables): MutationRef<UpdateItemData, UpdateItemVariables>;
}
export const updateItemRef: UpdateItemRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
updateItem(dc: DataConnect, vars: UpdateItemVariables): MutationPromise<UpdateItemData, UpdateItemVariables>;

interface UpdateItemRef {
  ...
  (dc: DataConnect, vars: UpdateItemVariables): MutationRef<UpdateItemData, UpdateItemVariables>;
}
export const updateItemRef: UpdateItemRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the updateItemRef:
```typescript
const name = updateItemRef.operationName;
console.log(name);
```

### Variables
The `UpdateItem` mutation requires an argument of type `UpdateItemVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface UpdateItemVariables {
  id: UUIDString;
  name?: string | null;
  quantity?: number | null;
  description?: string | null;
  imageUrl?: string | null;
  updatedAt?: TimestampString | null;
}
```
### Return Type
Recall that executing the `UpdateItem` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `UpdateItemData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface UpdateItemData {
  item_update?: Item_Key | null;
}
```
### Using `UpdateItem`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, updateItem, UpdateItemVariables } from '@firebasegen/default-connector';

// The `UpdateItem` mutation requires an argument of type `UpdateItemVariables`:
const updateItemVars: UpdateItemVariables = {
  id: ..., 
  name: ..., // optional
  quantity: ..., // optional
  description: ..., // optional
  imageUrl: ..., // optional
  updatedAt: ..., // optional
};

// Call the `updateItem()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await updateItem(updateItemVars);
// Variables can be defined inline as well.
const { data } = await updateItem({ id: ..., name: ..., quantity: ..., description: ..., imageUrl: ..., updatedAt: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await updateItem(dataConnect, updateItemVars);

console.log(data.item_update);

// Or, you can use the `Promise` API.
updateItem(updateItemVars).then((response) => {
  const data = response.data;
  console.log(data.item_update);
});
```

### Using `UpdateItem`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, updateItemRef, UpdateItemVariables } from '@firebasegen/default-connector';

// The `UpdateItem` mutation requires an argument of type `UpdateItemVariables`:
const updateItemVars: UpdateItemVariables = {
  id: ..., 
  name: ..., // optional
  quantity: ..., // optional
  description: ..., // optional
  imageUrl: ..., // optional
  updatedAt: ..., // optional
};

// Call the `updateItemRef()` function to get a reference to the mutation.
const ref = updateItemRef(updateItemVars);
// Variables can be defined inline as well.
const ref = updateItemRef({ id: ..., name: ..., quantity: ..., description: ..., imageUrl: ..., updatedAt: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = updateItemRef(dataConnect, updateItemVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.item_update);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.item_update);
});
```

## DeleteItem
You can execute the `DeleteItem` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
deleteItem(vars: DeleteItemVariables): MutationPromise<DeleteItemData, DeleteItemVariables>;

interface DeleteItemRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: DeleteItemVariables): MutationRef<DeleteItemData, DeleteItemVariables>;
}
export const deleteItemRef: DeleteItemRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
deleteItem(dc: DataConnect, vars: DeleteItemVariables): MutationPromise<DeleteItemData, DeleteItemVariables>;

interface DeleteItemRef {
  ...
  (dc: DataConnect, vars: DeleteItemVariables): MutationRef<DeleteItemData, DeleteItemVariables>;
}
export const deleteItemRef: DeleteItemRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the deleteItemRef:
```typescript
const name = deleteItemRef.operationName;
console.log(name);
```

### Variables
The `DeleteItem` mutation requires an argument of type `DeleteItemVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface DeleteItemVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `DeleteItem` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `DeleteItemData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface DeleteItemData {
  item_delete?: Item_Key | null;
}
```
### Using `DeleteItem`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, deleteItem, DeleteItemVariables } from '@firebasegen/default-connector';

// The `DeleteItem` mutation requires an argument of type `DeleteItemVariables`:
const deleteItemVars: DeleteItemVariables = {
  id: ..., 
};

// Call the `deleteItem()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await deleteItem(deleteItemVars);
// Variables can be defined inline as well.
const { data } = await deleteItem({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await deleteItem(dataConnect, deleteItemVars);

console.log(data.item_delete);

// Or, you can use the `Promise` API.
deleteItem(deleteItemVars).then((response) => {
  const data = response.data;
  console.log(data.item_delete);
});
```

### Using `DeleteItem`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, deleteItemRef, DeleteItemVariables } from '@firebasegen/default-connector';

// The `DeleteItem` mutation requires an argument of type `DeleteItemVariables`:
const deleteItemVars: DeleteItemVariables = {
  id: ..., 
};

// Call the `deleteItemRef()` function to get a reference to the mutation.
const ref = deleteItemRef(deleteItemVars);
// Variables can be defined inline as well.
const ref = deleteItemRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = deleteItemRef(dataConnect, deleteItemVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.item_delete);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.item_delete);
});
```

## CreateRequest
You can execute the `CreateRequest` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createRequest(vars: CreateRequestVariables): MutationPromise<CreateRequestData, CreateRequestVariables>;

interface CreateRequestRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateRequestVariables): MutationRef<CreateRequestData, CreateRequestVariables>;
}
export const createRequestRef: CreateRequestRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createRequest(dc: DataConnect, vars: CreateRequestVariables): MutationPromise<CreateRequestData, CreateRequestVariables>;

interface CreateRequestRef {
  ...
  (dc: DataConnect, vars: CreateRequestVariables): MutationRef<CreateRequestData, CreateRequestVariables>;
}
export const createRequestRef: CreateRequestRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createRequestRef:
```typescript
const name = createRequestRef.operationName;
console.log(name);
```

### Variables
The `CreateRequest` mutation requires an argument of type `CreateRequestVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateRequestVariables {
  userEmail: string;
  machineId: UUIDString;
  mechanicEmail: string;
  requestDate: TimestampString;
  description: string;
}
```
### Return Type
Recall that executing the `CreateRequest` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateRequestData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateRequestData {
  request_insert: Request_Key;
}
```
### Using `CreateRequest`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createRequest, CreateRequestVariables } from '@firebasegen/default-connector';

// The `CreateRequest` mutation requires an argument of type `CreateRequestVariables`:
const createRequestVars: CreateRequestVariables = {
  userEmail: ..., 
  machineId: ..., 
  mechanicEmail: ..., 
  requestDate: ..., 
  description: ..., 
};

// Call the `createRequest()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createRequest(createRequestVars);
// Variables can be defined inline as well.
const { data } = await createRequest({ userEmail: ..., machineId: ..., mechanicEmail: ..., requestDate: ..., description: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createRequest(dataConnect, createRequestVars);

console.log(data.request_insert);

// Or, you can use the `Promise` API.
createRequest(createRequestVars).then((response) => {
  const data = response.data;
  console.log(data.request_insert);
});
```

### Using `CreateRequest`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createRequestRef, CreateRequestVariables } from '@firebasegen/default-connector';

// The `CreateRequest` mutation requires an argument of type `CreateRequestVariables`:
const createRequestVars: CreateRequestVariables = {
  userEmail: ..., 
  machineId: ..., 
  mechanicEmail: ..., 
  requestDate: ..., 
  description: ..., 
};

// Call the `createRequestRef()` function to get a reference to the mutation.
const ref = createRequestRef(createRequestVars);
// Variables can be defined inline as well.
const ref = createRequestRef({ userEmail: ..., machineId: ..., mechanicEmail: ..., requestDate: ..., description: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createRequestRef(dataConnect, createRequestVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.request_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.request_insert);
});
```

## UpdateRequestStatus
You can execute the `UpdateRequestStatus` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
updateRequestStatus(vars: UpdateRequestStatusVariables): MutationPromise<UpdateRequestStatusData, UpdateRequestStatusVariables>;

interface UpdateRequestStatusRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateRequestStatusVariables): MutationRef<UpdateRequestStatusData, UpdateRequestStatusVariables>;
}
export const updateRequestStatusRef: UpdateRequestStatusRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
updateRequestStatus(dc: DataConnect, vars: UpdateRequestStatusVariables): MutationPromise<UpdateRequestStatusData, UpdateRequestStatusVariables>;

interface UpdateRequestStatusRef {
  ...
  (dc: DataConnect, vars: UpdateRequestStatusVariables): MutationRef<UpdateRequestStatusData, UpdateRequestStatusVariables>;
}
export const updateRequestStatusRef: UpdateRequestStatusRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the updateRequestStatusRef:
```typescript
const name = updateRequestStatusRef.operationName;
console.log(name);
```

### Variables
The `UpdateRequestStatus` mutation requires an argument of type `UpdateRequestStatusVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface UpdateRequestStatusVariables {
  id: UUIDString;
  status: string;
  updatedAt?: TimestampString | null;
}
```
### Return Type
Recall that executing the `UpdateRequestStatus` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `UpdateRequestStatusData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface UpdateRequestStatusData {
  request_update?: Request_Key | null;
}
```
### Using `UpdateRequestStatus`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, updateRequestStatus, UpdateRequestStatusVariables } from '@firebasegen/default-connector';

// The `UpdateRequestStatus` mutation requires an argument of type `UpdateRequestStatusVariables`:
const updateRequestStatusVars: UpdateRequestStatusVariables = {
  id: ..., 
  status: ..., 
  updatedAt: ..., // optional
};

// Call the `updateRequestStatus()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await updateRequestStatus(updateRequestStatusVars);
// Variables can be defined inline as well.
const { data } = await updateRequestStatus({ id: ..., status: ..., updatedAt: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await updateRequestStatus(dataConnect, updateRequestStatusVars);

console.log(data.request_update);

// Or, you can use the `Promise` API.
updateRequestStatus(updateRequestStatusVars).then((response) => {
  const data = response.data;
  console.log(data.request_update);
});
```

### Using `UpdateRequestStatus`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, updateRequestStatusRef, UpdateRequestStatusVariables } from '@firebasegen/default-connector';

// The `UpdateRequestStatus` mutation requires an argument of type `UpdateRequestStatusVariables`:
const updateRequestStatusVars: UpdateRequestStatusVariables = {
  id: ..., 
  status: ..., 
  updatedAt: ..., // optional
};

// Call the `updateRequestStatusRef()` function to get a reference to the mutation.
const ref = updateRequestStatusRef(updateRequestStatusVars);
// Variables can be defined inline as well.
const ref = updateRequestStatusRef({ id: ..., status: ..., updatedAt: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = updateRequestStatusRef(dataConnect, updateRequestStatusVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.request_update);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.request_update);
});
```

## CreateRoutine
You can execute the `CreateRoutine` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createRoutine(vars: CreateRoutineVariables): MutationPromise<CreateRoutineData, CreateRoutineVariables>;

interface CreateRoutineRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateRoutineVariables): MutationRef<CreateRoutineData, CreateRoutineVariables>;
}
export const createRoutineRef: CreateRoutineRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createRoutine(dc: DataConnect, vars: CreateRoutineVariables): MutationPromise<CreateRoutineData, CreateRoutineVariables>;

interface CreateRoutineRef {
  ...
  (dc: DataConnect, vars: CreateRoutineVariables): MutationRef<CreateRoutineData, CreateRoutineVariables>;
}
export const createRoutineRef: CreateRoutineRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createRoutineRef:
```typescript
const name = createRoutineRef.operationName;
console.log(name);
```

### Variables
The `CreateRoutine` mutation requires an argument of type `CreateRoutineVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateRoutineVariables {
  machineId: UUIDString;
  title: string;
  description: string;
}
```
### Return Type
Recall that executing the `CreateRoutine` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateRoutineData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateRoutineData {
  routine_insert: Routine_Key;
}
```
### Using `CreateRoutine`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createRoutine, CreateRoutineVariables } from '@firebasegen/default-connector';

// The `CreateRoutine` mutation requires an argument of type `CreateRoutineVariables`:
const createRoutineVars: CreateRoutineVariables = {
  machineId: ..., 
  title: ..., 
  description: ..., 
};

// Call the `createRoutine()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createRoutine(createRoutineVars);
// Variables can be defined inline as well.
const { data } = await createRoutine({ machineId: ..., title: ..., description: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createRoutine(dataConnect, createRoutineVars);

console.log(data.routine_insert);

// Or, you can use the `Promise` API.
createRoutine(createRoutineVars).then((response) => {
  const data = response.data;
  console.log(data.routine_insert);
});
```

### Using `CreateRoutine`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createRoutineRef, CreateRoutineVariables } from '@firebasegen/default-connector';

// The `CreateRoutine` mutation requires an argument of type `CreateRoutineVariables`:
const createRoutineVars: CreateRoutineVariables = {
  machineId: ..., 
  title: ..., 
  description: ..., 
};

// Call the `createRoutineRef()` function to get a reference to the mutation.
const ref = createRoutineRef(createRoutineVars);
// Variables can be defined inline as well.
const ref = createRoutineRef({ machineId: ..., title: ..., description: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createRoutineRef(dataConnect, createRoutineVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.routine_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.routine_insert);
});
```

## UpdateRoutine
You can execute the `UpdateRoutine` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
updateRoutine(vars: UpdateRoutineVariables): MutationPromise<UpdateRoutineData, UpdateRoutineVariables>;

interface UpdateRoutineRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateRoutineVariables): MutationRef<UpdateRoutineData, UpdateRoutineVariables>;
}
export const updateRoutineRef: UpdateRoutineRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
updateRoutine(dc: DataConnect, vars: UpdateRoutineVariables): MutationPromise<UpdateRoutineData, UpdateRoutineVariables>;

interface UpdateRoutineRef {
  ...
  (dc: DataConnect, vars: UpdateRoutineVariables): MutationRef<UpdateRoutineData, UpdateRoutineVariables>;
}
export const updateRoutineRef: UpdateRoutineRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the updateRoutineRef:
```typescript
const name = updateRoutineRef.operationName;
console.log(name);
```

### Variables
The `UpdateRoutine` mutation requires an argument of type `UpdateRoutineVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface UpdateRoutineVariables {
  id: UUIDString;
  isCheck: boolean;
  updatedAt?: TimestampString | null;
}
```
### Return Type
Recall that executing the `UpdateRoutine` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `UpdateRoutineData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface UpdateRoutineData {
  routine_update?: Routine_Key | null;
}
```
### Using `UpdateRoutine`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, updateRoutine, UpdateRoutineVariables } from '@firebasegen/default-connector';

// The `UpdateRoutine` mutation requires an argument of type `UpdateRoutineVariables`:
const updateRoutineVars: UpdateRoutineVariables = {
  id: ..., 
  isCheck: ..., 
  updatedAt: ..., // optional
};

// Call the `updateRoutine()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await updateRoutine(updateRoutineVars);
// Variables can be defined inline as well.
const { data } = await updateRoutine({ id: ..., isCheck: ..., updatedAt: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await updateRoutine(dataConnect, updateRoutineVars);

console.log(data.routine_update);

// Or, you can use the `Promise` API.
updateRoutine(updateRoutineVars).then((response) => {
  const data = response.data;
  console.log(data.routine_update);
});
```

### Using `UpdateRoutine`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, updateRoutineRef, UpdateRoutineVariables } from '@firebasegen/default-connector';

// The `UpdateRoutine` mutation requires an argument of type `UpdateRoutineVariables`:
const updateRoutineVars: UpdateRoutineVariables = {
  id: ..., 
  isCheck: ..., 
  updatedAt: ..., // optional
};

// Call the `updateRoutineRef()` function to get a reference to the mutation.
const ref = updateRoutineRef(updateRoutineVars);
// Variables can be defined inline as well.
const ref = updateRoutineRef({ id: ..., isCheck: ..., updatedAt: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = updateRoutineRef(dataConnect, updateRoutineVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.routine_update);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.routine_update);
});
```

## CreateMaintainLog
You can execute the `CreateMaintainLog` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createMaintainLog(vars: CreateMaintainLogVariables): MutationPromise<CreateMaintainLogData, CreateMaintainLogVariables>;

interface CreateMaintainLogRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateMaintainLogVariables): MutationRef<CreateMaintainLogData, CreateMaintainLogVariables>;
}
export const createMaintainLogRef: CreateMaintainLogRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createMaintainLog(dc: DataConnect, vars: CreateMaintainLogVariables): MutationPromise<CreateMaintainLogData, CreateMaintainLogVariables>;

interface CreateMaintainLogRef {
  ...
  (dc: DataConnect, vars: CreateMaintainLogVariables): MutationRef<CreateMaintainLogData, CreateMaintainLogVariables>;
}
export const createMaintainLogRef: CreateMaintainLogRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createMaintainLogRef:
```typescript
const name = createMaintainLogRef.operationName;
console.log(name);
```

### Variables
The `CreateMaintainLog` mutation requires an argument of type `CreateMaintainLogVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateMaintainLogVariables {
  title: string;
  isDone: boolean;
  machineId: UUIDString;
}
```
### Return Type
Recall that executing the `CreateMaintainLog` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateMaintainLogData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateMaintainLogData {
  maintainLog_insert: MaintainLog_Key;
}
```
### Using `CreateMaintainLog`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createMaintainLog, CreateMaintainLogVariables } from '@firebasegen/default-connector';

// The `CreateMaintainLog` mutation requires an argument of type `CreateMaintainLogVariables`:
const createMaintainLogVars: CreateMaintainLogVariables = {
  title: ..., 
  isDone: ..., 
  machineId: ..., 
};

// Call the `createMaintainLog()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createMaintainLog(createMaintainLogVars);
// Variables can be defined inline as well.
const { data } = await createMaintainLog({ title: ..., isDone: ..., machineId: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createMaintainLog(dataConnect, createMaintainLogVars);

console.log(data.maintainLog_insert);

// Or, you can use the `Promise` API.
createMaintainLog(createMaintainLogVars).then((response) => {
  const data = response.data;
  console.log(data.maintainLog_insert);
});
```

### Using `CreateMaintainLog`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createMaintainLogRef, CreateMaintainLogVariables } from '@firebasegen/default-connector';

// The `CreateMaintainLog` mutation requires an argument of type `CreateMaintainLogVariables`:
const createMaintainLogVars: CreateMaintainLogVariables = {
  title: ..., 
  isDone: ..., 
  machineId: ..., 
};

// Call the `createMaintainLogRef()` function to get a reference to the mutation.
const ref = createMaintainLogRef(createMaintainLogVars);
// Variables can be defined inline as well.
const ref = createMaintainLogRef({ title: ..., isDone: ..., machineId: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createMaintainLogRef(dataConnect, createMaintainLogVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.maintainLog_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.maintainLog_insert);
});
```

## CreateRoutineLog
You can execute the `CreateRoutineLog` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createRoutineLog(vars: CreateRoutineLogVariables): MutationPromise<CreateRoutineLogData, CreateRoutineLogVariables>;

interface CreateRoutineLogRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateRoutineLogVariables): MutationRef<CreateRoutineLogData, CreateRoutineLogVariables>;
}
export const createRoutineLogRef: CreateRoutineLogRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createRoutineLog(dc: DataConnect, vars: CreateRoutineLogVariables): MutationPromise<CreateRoutineLogData, CreateRoutineLogVariables>;

interface CreateRoutineLogRef {
  ...
  (dc: DataConnect, vars: CreateRoutineLogVariables): MutationRef<CreateRoutineLogData, CreateRoutineLogVariables>;
}
export const createRoutineLogRef: CreateRoutineLogRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createRoutineLogRef:
```typescript
const name = createRoutineLogRef.operationName;
console.log(name);
```

### Variables
The `CreateRoutineLog` mutation requires an argument of type `CreateRoutineLogVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateRoutineLogVariables {
  title: string;
  isDone: boolean;
  routineId: UUIDString;
}
```
### Return Type
Recall that executing the `CreateRoutineLog` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateRoutineLogData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateRoutineLogData {
  routineLog_insert: RoutineLog_Key;
}
```
### Using `CreateRoutineLog`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createRoutineLog, CreateRoutineLogVariables } from '@firebasegen/default-connector';

// The `CreateRoutineLog` mutation requires an argument of type `CreateRoutineLogVariables`:
const createRoutineLogVars: CreateRoutineLogVariables = {
  title: ..., 
  isDone: ..., 
  routineId: ..., 
};

// Call the `createRoutineLog()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createRoutineLog(createRoutineLogVars);
// Variables can be defined inline as well.
const { data } = await createRoutineLog({ title: ..., isDone: ..., routineId: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createRoutineLog(dataConnect, createRoutineLogVars);

console.log(data.routineLog_insert);

// Or, you can use the `Promise` API.
createRoutineLog(createRoutineLogVars).then((response) => {
  const data = response.data;
  console.log(data.routineLog_insert);
});
```

### Using `CreateRoutineLog`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createRoutineLogRef, CreateRoutineLogVariables } from '@firebasegen/default-connector';

// The `CreateRoutineLog` mutation requires an argument of type `CreateRoutineLogVariables`:
const createRoutineLogVars: CreateRoutineLogVariables = {
  title: ..., 
  isDone: ..., 
  routineId: ..., 
};

// Call the `createRoutineLogRef()` function to get a reference to the mutation.
const ref = createRoutineLogRef(createRoutineLogVars);
// Variables can be defined inline as well.
const ref = createRoutineLogRef({ title: ..., isDone: ..., routineId: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createRoutineLogRef(dataConnect, createRoutineLogVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.routineLog_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.routineLog_insert);
});
```

## CreateNotification
You can execute the `CreateNotification` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createNotification(vars: CreateNotificationVariables): MutationPromise<CreateNotificationData, CreateNotificationVariables>;

interface CreateNotificationRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateNotificationVariables): MutationRef<CreateNotificationData, CreateNotificationVariables>;
}
export const createNotificationRef: CreateNotificationRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createNotification(dc: DataConnect, vars: CreateNotificationVariables): MutationPromise<CreateNotificationData, CreateNotificationVariables>;

interface CreateNotificationRef {
  ...
  (dc: DataConnect, vars: CreateNotificationVariables): MutationRef<CreateNotificationData, CreateNotificationVariables>;
}
export const createNotificationRef: CreateNotificationRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createNotificationRef:
```typescript
const name = createNotificationRef.operationName;
console.log(name);
```

### Variables
The `CreateNotification` mutation requires an argument of type `CreateNotificationVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateNotificationVariables {
  mechanicEmail: string;
  requestId: UUIDString;
  title: string;
  body: string;
}
```
### Return Type
Recall that executing the `CreateNotification` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateNotificationData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateNotificationData {
  notification_insert: Notification_Key;
}
```
### Using `CreateNotification`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createNotification, CreateNotificationVariables } from '@firebasegen/default-connector';

// The `CreateNotification` mutation requires an argument of type `CreateNotificationVariables`:
const createNotificationVars: CreateNotificationVariables = {
  mechanicEmail: ..., 
  requestId: ..., 
  title: ..., 
  body: ..., 
};

// Call the `createNotification()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createNotification(createNotificationVars);
// Variables can be defined inline as well.
const { data } = await createNotification({ mechanicEmail: ..., requestId: ..., title: ..., body: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createNotification(dataConnect, createNotificationVars);

console.log(data.notification_insert);

// Or, you can use the `Promise` API.
createNotification(createNotificationVars).then((response) => {
  const data = response.data;
  console.log(data.notification_insert);
});
```

### Using `CreateNotification`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createNotificationRef, CreateNotificationVariables } from '@firebasegen/default-connector';

// The `CreateNotification` mutation requires an argument of type `CreateNotificationVariables`:
const createNotificationVars: CreateNotificationVariables = {
  mechanicEmail: ..., 
  requestId: ..., 
  title: ..., 
  body: ..., 
};

// Call the `createNotificationRef()` function to get a reference to the mutation.
const ref = createNotificationRef(createNotificationVars);
// Variables can be defined inline as well.
const ref = createNotificationRef({ mechanicEmail: ..., requestId: ..., title: ..., body: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createNotificationRef(dataConnect, createNotificationVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.notification_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.notification_insert);
});
```

## MarkNotificationRead
You can execute the `MarkNotificationRead` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
markNotificationRead(vars: MarkNotificationReadVariables): MutationPromise<MarkNotificationReadData, MarkNotificationReadVariables>;

interface MarkNotificationReadRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: MarkNotificationReadVariables): MutationRef<MarkNotificationReadData, MarkNotificationReadVariables>;
}
export const markNotificationReadRef: MarkNotificationReadRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
markNotificationRead(dc: DataConnect, vars: MarkNotificationReadVariables): MutationPromise<MarkNotificationReadData, MarkNotificationReadVariables>;

interface MarkNotificationReadRef {
  ...
  (dc: DataConnect, vars: MarkNotificationReadVariables): MutationRef<MarkNotificationReadData, MarkNotificationReadVariables>;
}
export const markNotificationReadRef: MarkNotificationReadRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the markNotificationReadRef:
```typescript
const name = markNotificationReadRef.operationName;
console.log(name);
```

### Variables
The `MarkNotificationRead` mutation requires an argument of type `MarkNotificationReadVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface MarkNotificationReadVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `MarkNotificationRead` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `MarkNotificationReadData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface MarkNotificationReadData {
  notification_update?: Notification_Key | null;
}
```
### Using `MarkNotificationRead`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, markNotificationRead, MarkNotificationReadVariables } from '@firebasegen/default-connector';

// The `MarkNotificationRead` mutation requires an argument of type `MarkNotificationReadVariables`:
const markNotificationReadVars: MarkNotificationReadVariables = {
  id: ..., 
};

// Call the `markNotificationRead()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await markNotificationRead(markNotificationReadVars);
// Variables can be defined inline as well.
const { data } = await markNotificationRead({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await markNotificationRead(dataConnect, markNotificationReadVars);

console.log(data.notification_update);

// Or, you can use the `Promise` API.
markNotificationRead(markNotificationReadVars).then((response) => {
  const data = response.data;
  console.log(data.notification_update);
});
```

### Using `MarkNotificationRead`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, markNotificationReadRef, MarkNotificationReadVariables } from '@firebasegen/default-connector';

// The `MarkNotificationRead` mutation requires an argument of type `MarkNotificationReadVariables`:
const markNotificationReadVars: MarkNotificationReadVariables = {
  id: ..., 
};

// Call the `markNotificationReadRef()` function to get a reference to the mutation.
const ref = markNotificationReadRef(markNotificationReadVars);
// Variables can be defined inline as well.
const ref = markNotificationReadRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = markNotificationReadRef(dataConnect, markNotificationReadVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.notification_update);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.notification_update);
});
```

