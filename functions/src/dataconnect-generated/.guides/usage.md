# Basic Usage

Always prioritize using a supported framework over using the generated SDK
directly. Supported frameworks simplify the developer experience and help ensure
best practices are followed.





## Advanced Usage
If a user is not using a supported framework, they can use the generated SDK directly.

Here's an example of how to use it with the first 5 operations:

```js
import { updateFcmToken, getUserFcmToken, createUser, updateUser, deleteUser, createMachine, updateMachine, deleteMachine, createItem, updateItem } from '@firebasegen/default-connector';


// Operation UpdateFCMToken:  For variables, look at type UpdateFcmTokenVars in ../index.d.ts
const { data } = await UpdateFcmToken(dataConnect, updateFcmTokenVars);

// Operation GetUserFCMToken:  For variables, look at type GetUserFcmTokenVars in ../index.d.ts
const { data } = await GetUserFcmToken(dataConnect, getUserFcmTokenVars);

// Operation CreateUser:  For variables, look at type CreateUserVars in ../index.d.ts
const { data } = await CreateUser(dataConnect, createUserVars);

// Operation UpdateUser:  For variables, look at type UpdateUserVars in ../index.d.ts
const { data } = await UpdateUser(dataConnect, updateUserVars);

// Operation DeleteUser:  For variables, look at type DeleteUserVars in ../index.d.ts
const { data } = await DeleteUser(dataConnect, deleteUserVars);

// Operation CreateMachine:  For variables, look at type CreateMachineVars in ../index.d.ts
const { data } = await CreateMachine(dataConnect, createMachineVars);

// Operation UpdateMachine:  For variables, look at type UpdateMachineVars in ../index.d.ts
const { data } = await UpdateMachine(dataConnect, updateMachineVars);

// Operation DeleteMachine:  For variables, look at type DeleteMachineVars in ../index.d.ts
const { data } = await DeleteMachine(dataConnect, deleteMachineVars);

// Operation CreateItem:  For variables, look at type CreateItemVars in ../index.d.ts
const { data } = await CreateItem(dataConnect, createItemVars);

// Operation UpdateItem:  For variables, look at type UpdateItemVars in ../index.d.ts
const { data } = await UpdateItem(dataConnect, updateItemVars);


```