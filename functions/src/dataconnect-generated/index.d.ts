import { ConnectorConfig, DataConnect, QueryRef, QueryPromise, MutationRef, MutationPromise } from 'firebase/data-connect';

export const connectorConfig: ConnectorConfig;

export type TimestampString = string;
export type UUIDString = string;
export type Int64String = string;
export type DateString = string;




export interface CreateItemData {
  item_insert: Item_Key;
}

export interface CreateItemVariables {
  name: string;
  quantity: number;
  description: string;
  imageUrl?: string | null;
}

export interface CreateMachineData {
  machine_insert: Machine_Key;
}

export interface CreateMachineVariables {
  name: string;
  serialNumber: number;
  description: string;
  imageUrl?: string | null;
}

export interface CreateMaintainLogData {
  maintainLog_insert: MaintainLog_Key;
}

export interface CreateMaintainLogVariables {
  title: string;
  isDone: boolean;
  machineId: UUIDString;
}

export interface CreateNotificationData {
  notification_insert: Notification_Key;
}

export interface CreateNotificationVariables {
  mechanicEmail: string;
  requestId: UUIDString;
  title: string;
  body: string;
}

export interface CreateRequestData {
  request_insert: Request_Key;
}

export interface CreateRequestVariables {
  userEmail: string;
  machineId: UUIDString;
  mechanicEmail: string;
  requestDate: TimestampString;
  description: string;
}

export interface CreateRoutineData {
  routine_insert: Routine_Key;
}

export interface CreateRoutineLogData {
  routineLog_insert: RoutineLog_Key;
}

export interface CreateRoutineLogVariables {
  title: string;
  isDone: boolean;
  routineId: UUIDString;
}

export interface CreateRoutineVariables {
  machineId: UUIDString;
  title: string;
  description: string;
}

export interface CreateUserData {
  user_insert: User_Key;
}

export interface CreateUserVariables {
  email: string;
  password: string;
  name: string;
  role: string;
  tel: string;
  imageUrl?: string | null;
}

export interface DeleteItemData {
  item_delete?: Item_Key | null;
}

export interface DeleteItemVariables {
  id: UUIDString;
}

export interface DeleteMachineData {
  machine_delete?: Machine_Key | null;
}

export interface DeleteMachineVariables {
  id: UUIDString;
}

export interface DeleteUserData {
  user_delete?: User_Key | null;
}

export interface DeleteUserVariables {
  email: string;
}

export interface GetItemData {
  item?: {
    id: UUIDString;
    name?: string | null;
    quantity?: number | null;
    description?: string | null;
  } & Item_Key;
}

export interface GetItemVariables {
  id: UUIDString;
}

export interface GetMachineData {
  machine?: {
    id: UUIDString;
    name?: string | null;
    serialNumber?: number | null;
    description?: string | null;
  } & Machine_Key;
}

export interface GetMachineVariables {
  id: UUIDString;
}

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

export interface GetMaintainLogVariables {
  id: UUIDString;
}

export interface GetMechanicsData {
  users: ({
    email: string;
    name?: string | null;
    role?: string | null;
    tel?: string | null;
    imageUrl?: string | null;
  } & User_Key)[];
}

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

export interface GetNotificationVariables {
  id: UUIDString;
}

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

export interface GetRequestVariables {
  id: UUIDString;
}

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

export interface GetRequestsByMechanicEmailVariables {
  email: string;
}

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

export interface GetRoutineLogVariables {
  id: UUIDString;
}

export interface GetRoutineVariables {
  id: UUIDString;
}

export interface GetRoutinesByMachineIdData {
  routines: ({
    id: UUIDString;
    title?: string | null;
    description?: string | null;
    isCheck?: boolean | null;
  } & Routine_Key)[];
}

export interface GetRoutinesByMachineIdVariables {
  machineId: UUIDString;
}

export interface GetUserData {
  user?: {
    email: string;
    name?: string | null;
    role?: string | null;
    tel?: string | null;
    imageUrl?: string | null;
  } & User_Key;
}

export interface GetUserFcmTokenData {
  user?: {
    fcmToken?: string | null;
  };
}

export interface GetUserFcmTokenVariables {
  email: string;
}

export interface GetUserVariables {
  email: string;
}

export interface Item_Key {
  id: UUIDString;
  __typename?: 'Item_Key';
}

export interface ListItemsData {
  items: ({
    id: UUIDString;
    name?: string | null;
    quantity?: number | null;
    description?: string | null;
    imageUrl?: string | null;
  } & Item_Key)[];
}

export interface ListMachinesData {
  machines: ({
    id: UUIDString;
    name?: string | null;
    serialNumber?: number | null;
    description?: string | null;
    imageUrl?: string | null;
  } & Machine_Key)[];
}

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

export interface ListNotificationsByMechanicVariables {
  mechanicEmail: string;
}

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

export interface ListUsersData {
  users: ({
    email: string;
    name?: string | null;
    role?: string | null;
    tel?: string | null;
    imageUrl?: string | null;
  } & User_Key)[];
}

export interface Machine_Key {
  id: UUIDString;
  __typename?: 'Machine_Key';
}

export interface MaintainLog_Key {
  id: UUIDString;
  __typename?: 'MaintainLog_Key';
}

export interface MarkNotificationReadData {
  notification_update?: Notification_Key | null;
}

export interface MarkNotificationReadVariables {
  id: UUIDString;
}

export interface Notification_Key {
  id: UUIDString;
  __typename?: 'Notification_Key';
}

export interface Request_Key {
  id: UUIDString;
  __typename?: 'Request_Key';
}

export interface RoutineLog_Key {
  id: UUIDString;
  __typename?: 'RoutineLog_Key';
}

export interface Routine_Key {
  id: UUIDString;
  __typename?: 'Routine_Key';
}

export interface UpdateFcmTokenData {
  user_update?: User_Key | null;
}

export interface UpdateFcmTokenVariables {
  email: string;
  fcmToken: string;
}

export interface UpdateItemData {
  item_update?: Item_Key | null;
}

export interface UpdateItemVariables {
  id: UUIDString;
  name?: string | null;
  quantity?: number | null;
  description?: string | null;
  imageUrl?: string | null;
  updatedAt?: TimestampString | null;
}

export interface UpdateMachineData {
  machine_update?: Machine_Key | null;
}

export interface UpdateMachineVariables {
  id: UUIDString;
  name?: string | null;
  serialNumber?: number | null;
  description?: string | null;
  imageUrl?: string | null;
  updatedAt?: TimestampString | null;
}

export interface UpdateRequestStatusData {
  request_update?: Request_Key | null;
}

export interface UpdateRequestStatusVariables {
  id: UUIDString;
  status: string;
  updatedAt?: TimestampString | null;
}

export interface UpdateRoutineData {
  routine_update?: Routine_Key | null;
}

export interface UpdateRoutineVariables {
  id: UUIDString;
  isCheck: boolean;
  updatedAt?: TimestampString | null;
}

export interface UpdateUserData {
  user_update?: User_Key | null;
}

export interface UpdateUserVariables {
  email: string;
  name?: string | null;
  role?: string | null;
  tel?: string | null;
  imageUrl?: string | null;
  updatedAt?: TimestampString | null;
}

export interface User_Key {
  email: string;
  __typename?: 'User_Key';
}

interface UpdateFcmTokenRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateFcmTokenVariables): MutationRef<UpdateFcmTokenData, UpdateFcmTokenVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: UpdateFcmTokenVariables): MutationRef<UpdateFcmTokenData, UpdateFcmTokenVariables>;
  operationName: string;
}
export const updateFcmTokenRef: UpdateFcmTokenRef;

export function updateFcmToken(vars: UpdateFcmTokenVariables): MutationPromise<UpdateFcmTokenData, UpdateFcmTokenVariables>;
export function updateFcmToken(dc: DataConnect, vars: UpdateFcmTokenVariables): MutationPromise<UpdateFcmTokenData, UpdateFcmTokenVariables>;

interface GetUserFcmTokenRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetUserFcmTokenVariables): QueryRef<GetUserFcmTokenData, GetUserFcmTokenVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetUserFcmTokenVariables): QueryRef<GetUserFcmTokenData, GetUserFcmTokenVariables>;
  operationName: string;
}
export const getUserFcmTokenRef: GetUserFcmTokenRef;

export function getUserFcmToken(vars: GetUserFcmTokenVariables): QueryPromise<GetUserFcmTokenData, GetUserFcmTokenVariables>;
export function getUserFcmToken(dc: DataConnect, vars: GetUserFcmTokenVariables): QueryPromise<GetUserFcmTokenData, GetUserFcmTokenVariables>;

interface CreateUserRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateUserVariables): MutationRef<CreateUserData, CreateUserVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateUserVariables): MutationRef<CreateUserData, CreateUserVariables>;
  operationName: string;
}
export const createUserRef: CreateUserRef;

export function createUser(vars: CreateUserVariables): MutationPromise<CreateUserData, CreateUserVariables>;
export function createUser(dc: DataConnect, vars: CreateUserVariables): MutationPromise<CreateUserData, CreateUserVariables>;

interface UpdateUserRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateUserVariables): MutationRef<UpdateUserData, UpdateUserVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: UpdateUserVariables): MutationRef<UpdateUserData, UpdateUserVariables>;
  operationName: string;
}
export const updateUserRef: UpdateUserRef;

export function updateUser(vars: UpdateUserVariables): MutationPromise<UpdateUserData, UpdateUserVariables>;
export function updateUser(dc: DataConnect, vars: UpdateUserVariables): MutationPromise<UpdateUserData, UpdateUserVariables>;

interface DeleteUserRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: DeleteUserVariables): MutationRef<DeleteUserData, DeleteUserVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: DeleteUserVariables): MutationRef<DeleteUserData, DeleteUserVariables>;
  operationName: string;
}
export const deleteUserRef: DeleteUserRef;

export function deleteUser(vars: DeleteUserVariables): MutationPromise<DeleteUserData, DeleteUserVariables>;
export function deleteUser(dc: DataConnect, vars: DeleteUserVariables): MutationPromise<DeleteUserData, DeleteUserVariables>;

interface CreateMachineRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateMachineVariables): MutationRef<CreateMachineData, CreateMachineVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateMachineVariables): MutationRef<CreateMachineData, CreateMachineVariables>;
  operationName: string;
}
export const createMachineRef: CreateMachineRef;

export function createMachine(vars: CreateMachineVariables): MutationPromise<CreateMachineData, CreateMachineVariables>;
export function createMachine(dc: DataConnect, vars: CreateMachineVariables): MutationPromise<CreateMachineData, CreateMachineVariables>;

interface UpdateMachineRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateMachineVariables): MutationRef<UpdateMachineData, UpdateMachineVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: UpdateMachineVariables): MutationRef<UpdateMachineData, UpdateMachineVariables>;
  operationName: string;
}
export const updateMachineRef: UpdateMachineRef;

export function updateMachine(vars: UpdateMachineVariables): MutationPromise<UpdateMachineData, UpdateMachineVariables>;
export function updateMachine(dc: DataConnect, vars: UpdateMachineVariables): MutationPromise<UpdateMachineData, UpdateMachineVariables>;

interface DeleteMachineRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: DeleteMachineVariables): MutationRef<DeleteMachineData, DeleteMachineVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: DeleteMachineVariables): MutationRef<DeleteMachineData, DeleteMachineVariables>;
  operationName: string;
}
export const deleteMachineRef: DeleteMachineRef;

export function deleteMachine(vars: DeleteMachineVariables): MutationPromise<DeleteMachineData, DeleteMachineVariables>;
export function deleteMachine(dc: DataConnect, vars: DeleteMachineVariables): MutationPromise<DeleteMachineData, DeleteMachineVariables>;

interface CreateItemRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateItemVariables): MutationRef<CreateItemData, CreateItemVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateItemVariables): MutationRef<CreateItemData, CreateItemVariables>;
  operationName: string;
}
export const createItemRef: CreateItemRef;

export function createItem(vars: CreateItemVariables): MutationPromise<CreateItemData, CreateItemVariables>;
export function createItem(dc: DataConnect, vars: CreateItemVariables): MutationPromise<CreateItemData, CreateItemVariables>;

interface UpdateItemRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateItemVariables): MutationRef<UpdateItemData, UpdateItemVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: UpdateItemVariables): MutationRef<UpdateItemData, UpdateItemVariables>;
  operationName: string;
}
export const updateItemRef: UpdateItemRef;

export function updateItem(vars: UpdateItemVariables): MutationPromise<UpdateItemData, UpdateItemVariables>;
export function updateItem(dc: DataConnect, vars: UpdateItemVariables): MutationPromise<UpdateItemData, UpdateItemVariables>;

interface DeleteItemRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: DeleteItemVariables): MutationRef<DeleteItemData, DeleteItemVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: DeleteItemVariables): MutationRef<DeleteItemData, DeleteItemVariables>;
  operationName: string;
}
export const deleteItemRef: DeleteItemRef;

export function deleteItem(vars: DeleteItemVariables): MutationPromise<DeleteItemData, DeleteItemVariables>;
export function deleteItem(dc: DataConnect, vars: DeleteItemVariables): MutationPromise<DeleteItemData, DeleteItemVariables>;

interface CreateRequestRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateRequestVariables): MutationRef<CreateRequestData, CreateRequestVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateRequestVariables): MutationRef<CreateRequestData, CreateRequestVariables>;
  operationName: string;
}
export const createRequestRef: CreateRequestRef;

export function createRequest(vars: CreateRequestVariables): MutationPromise<CreateRequestData, CreateRequestVariables>;
export function createRequest(dc: DataConnect, vars: CreateRequestVariables): MutationPromise<CreateRequestData, CreateRequestVariables>;

interface UpdateRequestStatusRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateRequestStatusVariables): MutationRef<UpdateRequestStatusData, UpdateRequestStatusVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: UpdateRequestStatusVariables): MutationRef<UpdateRequestStatusData, UpdateRequestStatusVariables>;
  operationName: string;
}
export const updateRequestStatusRef: UpdateRequestStatusRef;

export function updateRequestStatus(vars: UpdateRequestStatusVariables): MutationPromise<UpdateRequestStatusData, UpdateRequestStatusVariables>;
export function updateRequestStatus(dc: DataConnect, vars: UpdateRequestStatusVariables): MutationPromise<UpdateRequestStatusData, UpdateRequestStatusVariables>;

interface CreateRoutineRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateRoutineVariables): MutationRef<CreateRoutineData, CreateRoutineVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateRoutineVariables): MutationRef<CreateRoutineData, CreateRoutineVariables>;
  operationName: string;
}
export const createRoutineRef: CreateRoutineRef;

export function createRoutine(vars: CreateRoutineVariables): MutationPromise<CreateRoutineData, CreateRoutineVariables>;
export function createRoutine(dc: DataConnect, vars: CreateRoutineVariables): MutationPromise<CreateRoutineData, CreateRoutineVariables>;

interface UpdateRoutineRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: UpdateRoutineVariables): MutationRef<UpdateRoutineData, UpdateRoutineVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: UpdateRoutineVariables): MutationRef<UpdateRoutineData, UpdateRoutineVariables>;
  operationName: string;
}
export const updateRoutineRef: UpdateRoutineRef;

export function updateRoutine(vars: UpdateRoutineVariables): MutationPromise<UpdateRoutineData, UpdateRoutineVariables>;
export function updateRoutine(dc: DataConnect, vars: UpdateRoutineVariables): MutationPromise<UpdateRoutineData, UpdateRoutineVariables>;

interface CreateMaintainLogRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateMaintainLogVariables): MutationRef<CreateMaintainLogData, CreateMaintainLogVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateMaintainLogVariables): MutationRef<CreateMaintainLogData, CreateMaintainLogVariables>;
  operationName: string;
}
export const createMaintainLogRef: CreateMaintainLogRef;

export function createMaintainLog(vars: CreateMaintainLogVariables): MutationPromise<CreateMaintainLogData, CreateMaintainLogVariables>;
export function createMaintainLog(dc: DataConnect, vars: CreateMaintainLogVariables): MutationPromise<CreateMaintainLogData, CreateMaintainLogVariables>;

interface CreateRoutineLogRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateRoutineLogVariables): MutationRef<CreateRoutineLogData, CreateRoutineLogVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateRoutineLogVariables): MutationRef<CreateRoutineLogData, CreateRoutineLogVariables>;
  operationName: string;
}
export const createRoutineLogRef: CreateRoutineLogRef;

export function createRoutineLog(vars: CreateRoutineLogVariables): MutationPromise<CreateRoutineLogData, CreateRoutineLogVariables>;
export function createRoutineLog(dc: DataConnect, vars: CreateRoutineLogVariables): MutationPromise<CreateRoutineLogData, CreateRoutineLogVariables>;

interface CreateNotificationRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateNotificationVariables): MutationRef<CreateNotificationData, CreateNotificationVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateNotificationVariables): MutationRef<CreateNotificationData, CreateNotificationVariables>;
  operationName: string;
}
export const createNotificationRef: CreateNotificationRef;

export function createNotification(vars: CreateNotificationVariables): MutationPromise<CreateNotificationData, CreateNotificationVariables>;
export function createNotification(dc: DataConnect, vars: CreateNotificationVariables): MutationPromise<CreateNotificationData, CreateNotificationVariables>;

interface MarkNotificationReadRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: MarkNotificationReadVariables): MutationRef<MarkNotificationReadData, MarkNotificationReadVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: MarkNotificationReadVariables): MutationRef<MarkNotificationReadData, MarkNotificationReadVariables>;
  operationName: string;
}
export const markNotificationReadRef: MarkNotificationReadRef;

export function markNotificationRead(vars: MarkNotificationReadVariables): MutationPromise<MarkNotificationReadData, MarkNotificationReadVariables>;
export function markNotificationRead(dc: DataConnect, vars: MarkNotificationReadVariables): MutationPromise<MarkNotificationReadData, MarkNotificationReadVariables>;

interface GetUserRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetUserVariables): QueryRef<GetUserData, GetUserVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetUserVariables): QueryRef<GetUserData, GetUserVariables>;
  operationName: string;
}
export const getUserRef: GetUserRef;

export function getUser(vars: GetUserVariables): QueryPromise<GetUserData, GetUserVariables>;
export function getUser(dc: DataConnect, vars: GetUserVariables): QueryPromise<GetUserData, GetUserVariables>;

interface ListUsersRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListUsersData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListUsersData, undefined>;
  operationName: string;
}
export const listUsersRef: ListUsersRef;

export function listUsers(): QueryPromise<ListUsersData, undefined>;
export function listUsers(dc: DataConnect): QueryPromise<ListUsersData, undefined>;

interface GetMechanicsRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<GetMechanicsData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<GetMechanicsData, undefined>;
  operationName: string;
}
export const getMechanicsRef: GetMechanicsRef;

export function getMechanics(): QueryPromise<GetMechanicsData, undefined>;
export function getMechanics(dc: DataConnect): QueryPromise<GetMechanicsData, undefined>;

interface GetMachineRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetMachineVariables): QueryRef<GetMachineData, GetMachineVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetMachineVariables): QueryRef<GetMachineData, GetMachineVariables>;
  operationName: string;
}
export const getMachineRef: GetMachineRef;

export function getMachine(vars: GetMachineVariables): QueryPromise<GetMachineData, GetMachineVariables>;
export function getMachine(dc: DataConnect, vars: GetMachineVariables): QueryPromise<GetMachineData, GetMachineVariables>;

interface ListMachinesRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListMachinesData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListMachinesData, undefined>;
  operationName: string;
}
export const listMachinesRef: ListMachinesRef;

export function listMachines(): QueryPromise<ListMachinesData, undefined>;
export function listMachines(dc: DataConnect): QueryPromise<ListMachinesData, undefined>;

interface GetItemRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetItemVariables): QueryRef<GetItemData, GetItemVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetItemVariables): QueryRef<GetItemData, GetItemVariables>;
  operationName: string;
}
export const getItemRef: GetItemRef;

export function getItem(vars: GetItemVariables): QueryPromise<GetItemData, GetItemVariables>;
export function getItem(dc: DataConnect, vars: GetItemVariables): QueryPromise<GetItemData, GetItemVariables>;

interface ListItemsRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListItemsData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListItemsData, undefined>;
  operationName: string;
}
export const listItemsRef: ListItemsRef;

export function listItems(): QueryPromise<ListItemsData, undefined>;
export function listItems(dc: DataConnect): QueryPromise<ListItemsData, undefined>;

interface GetRequestRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetRequestVariables): QueryRef<GetRequestData, GetRequestVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetRequestVariables): QueryRef<GetRequestData, GetRequestVariables>;
  operationName: string;
}
export const getRequestRef: GetRequestRef;

export function getRequest(vars: GetRequestVariables): QueryPromise<GetRequestData, GetRequestVariables>;
export function getRequest(dc: DataConnect, vars: GetRequestVariables): QueryPromise<GetRequestData, GetRequestVariables>;

interface ListRequestsRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListRequestsData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListRequestsData, undefined>;
  operationName: string;
}
export const listRequestsRef: ListRequestsRef;

export function listRequests(): QueryPromise<ListRequestsData, undefined>;
export function listRequests(dc: DataConnect): QueryPromise<ListRequestsData, undefined>;

interface GetRequestsByMechanicEmailRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetRequestsByMechanicEmailVariables): QueryRef<GetRequestsByMechanicEmailData, GetRequestsByMechanicEmailVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetRequestsByMechanicEmailVariables): QueryRef<GetRequestsByMechanicEmailData, GetRequestsByMechanicEmailVariables>;
  operationName: string;
}
export const getRequestsByMechanicEmailRef: GetRequestsByMechanicEmailRef;

export function getRequestsByMechanicEmail(vars: GetRequestsByMechanicEmailVariables): QueryPromise<GetRequestsByMechanicEmailData, GetRequestsByMechanicEmailVariables>;
export function getRequestsByMechanicEmail(dc: DataConnect, vars: GetRequestsByMechanicEmailVariables): QueryPromise<GetRequestsByMechanicEmailData, GetRequestsByMechanicEmailVariables>;

interface GetRoutineRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetRoutineVariables): QueryRef<GetRoutineData, GetRoutineVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetRoutineVariables): QueryRef<GetRoutineData, GetRoutineVariables>;
  operationName: string;
}
export const getRoutineRef: GetRoutineRef;

export function getRoutine(vars: GetRoutineVariables): QueryPromise<GetRoutineData, GetRoutineVariables>;
export function getRoutine(dc: DataConnect, vars: GetRoutineVariables): QueryPromise<GetRoutineData, GetRoutineVariables>;

interface ListRoutinesRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListRoutinesData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListRoutinesData, undefined>;
  operationName: string;
}
export const listRoutinesRef: ListRoutinesRef;

export function listRoutines(): QueryPromise<ListRoutinesData, undefined>;
export function listRoutines(dc: DataConnect): QueryPromise<ListRoutinesData, undefined>;

interface GetRoutinesByMachineIdRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetRoutinesByMachineIdVariables): QueryRef<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetRoutinesByMachineIdVariables): QueryRef<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>;
  operationName: string;
}
export const getRoutinesByMachineIdRef: GetRoutinesByMachineIdRef;

export function getRoutinesByMachineId(vars: GetRoutinesByMachineIdVariables): QueryPromise<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>;
export function getRoutinesByMachineId(dc: DataConnect, vars: GetRoutinesByMachineIdVariables): QueryPromise<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>;

interface GetRoutineLogRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetRoutineLogVariables): QueryRef<GetRoutineLogData, GetRoutineLogVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetRoutineLogVariables): QueryRef<GetRoutineLogData, GetRoutineLogVariables>;
  operationName: string;
}
export const getRoutineLogRef: GetRoutineLogRef;

export function getRoutineLog(vars: GetRoutineLogVariables): QueryPromise<GetRoutineLogData, GetRoutineLogVariables>;
export function getRoutineLog(dc: DataConnect, vars: GetRoutineLogVariables): QueryPromise<GetRoutineLogData, GetRoutineLogVariables>;

interface ListRoutineLogsRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListRoutineLogsData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListRoutineLogsData, undefined>;
  operationName: string;
}
export const listRoutineLogsRef: ListRoutineLogsRef;

export function listRoutineLogs(): QueryPromise<ListRoutineLogsData, undefined>;
export function listRoutineLogs(dc: DataConnect): QueryPromise<ListRoutineLogsData, undefined>;

interface GetMaintainLogRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetMaintainLogVariables): QueryRef<GetMaintainLogData, GetMaintainLogVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetMaintainLogVariables): QueryRef<GetMaintainLogData, GetMaintainLogVariables>;
  operationName: string;
}
export const getMaintainLogRef: GetMaintainLogRef;

export function getMaintainLog(vars: GetMaintainLogVariables): QueryPromise<GetMaintainLogData, GetMaintainLogVariables>;
export function getMaintainLog(dc: DataConnect, vars: GetMaintainLogVariables): QueryPromise<GetMaintainLogData, GetMaintainLogVariables>;

interface ListMaintainLogsRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListMaintainLogsData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListMaintainLogsData, undefined>;
  operationName: string;
}
export const listMaintainLogsRef: ListMaintainLogsRef;

export function listMaintainLogs(): QueryPromise<ListMaintainLogsData, undefined>;
export function listMaintainLogs(dc: DataConnect): QueryPromise<ListMaintainLogsData, undefined>;

interface GetNotificationRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetNotificationVariables): QueryRef<GetNotificationData, GetNotificationVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetNotificationVariables): QueryRef<GetNotificationData, GetNotificationVariables>;
  operationName: string;
}
export const getNotificationRef: GetNotificationRef;

export function getNotification(vars: GetNotificationVariables): QueryPromise<GetNotificationData, GetNotificationVariables>;
export function getNotification(dc: DataConnect, vars: GetNotificationVariables): QueryPromise<GetNotificationData, GetNotificationVariables>;

interface ListNotificationsByMechanicRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: ListNotificationsByMechanicVariables): QueryRef<ListNotificationsByMechanicData, ListNotificationsByMechanicVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: ListNotificationsByMechanicVariables): QueryRef<ListNotificationsByMechanicData, ListNotificationsByMechanicVariables>;
  operationName: string;
}
export const listNotificationsByMechanicRef: ListNotificationsByMechanicRef;

export function listNotificationsByMechanic(vars: ListNotificationsByMechanicVariables): QueryPromise<ListNotificationsByMechanicData, ListNotificationsByMechanicVariables>;
export function listNotificationsByMechanic(dc: DataConnect, vars: ListNotificationsByMechanicVariables): QueryPromise<ListNotificationsByMechanicData, ListNotificationsByMechanicVariables>;

