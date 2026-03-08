import { ConnectorConfig, DataConnect, OperationOptions, ExecuteOperationResponse } from 'firebase-admin/data-connect';

export const connectorConfig: ConnectorConfig;

export type TimestampString = string;
export type UUIDString = string;
export type Int64String = string;
export type DateString = string;


export interface CreateItemData {
  item_insert: {
    id: UUIDString;
  };
}

export interface CreateItemVariables {
  name: string;
  quantity: number;
  description: string;
}

export interface CreateMachineData {
  machine_insert: {
    id: UUIDString;
  };
}

export interface CreateMachineVariables {
  name: string;
  serialNumber: number;
  description: string;
}

export interface CreateNotificationData {
  notification_insert: {
    id: UUIDString;
  };
}

export interface CreateNotificationVariables {
  mechanicEmail: string;
  requestId: UUIDString;
  title: string;
  body: string;
  createdAt: TimestampString;
}

export interface CreateRequestData {
  request_insert: {
    id: UUIDString;
  };
}

export interface CreateRequestVariables {
  userEmail: string;
  machineId: UUIDString;
  description: string;
  requestDate: TimestampString;
  mechanicEmail: string;
}

export interface CreateUserData {
  user_insert: {
    email: string;
  };
}

export interface CreateUserVariables {
  email: string;
  password: string;
  name: string;
  role: string;
  tel: string;
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

export interface GetMechanicFcmTokenData {
  user?: {
    fcmToken?: string | null;
  };
}

export interface GetMechanicFcmTokenVariables {
  email: string;
}

export interface GetMechanicsData {
  users: ({
    email: string;
    name?: string | null;
    role?: string | null;
    tel?: string | null;
  } & User_Key)[];
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
  } & User_Key;
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
  } & Item_Key)[];
}

export interface ListMachinesData {
  machines: ({
    id: UUIDString;
    name?: string | null;
    serialNumber?: number | null;
    description?: string | null;
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

export interface ListMechanicNotificationsData {
  notifications: ({
    id: UUIDString;
    title: string;
    body: string;
    isRead?: boolean | null;
    createdAt: TimestampString;
    request: {
      id: UUIDString;
      machine: {
        name?: string | null;
      };
    } & Request_Key;
  } & Notification_Key)[];
}

export interface ListMechanicNotificationsVariables {
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

export interface ListUsersData {
  users: ({
    email: string;
    name?: string | null;
    role?: string | null;
    tel?: string | null;
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
  notification_update?: {
    id: UUIDString;
  };
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

export interface UpdateRequestStatusData {
  request_update?: {
    id: UUIDString;
  };
}

export interface UpdateRequestStatusVariables {
  id: UUIDString;
  status: string;
}

export interface UpdateRoutineData {
  routine_update?: {
    id: UUIDString;
  };
}

export interface UpdateRoutineVariables {
  id: UUIDString;
  isCheck: boolean;
}

export interface UpdateUserFcmTokenData {
  user_update?: {
    email: string;
  };
}

export interface UpdateUserFcmTokenVariables {
  email: string;
  token: string;
}

export interface User_Key {
  email: string;
  __typename?: 'User_Key';
}

/** Generated Node Admin SDK operation action function for the 'CreateRequest' Mutation. Allow users to execute without passing in DataConnect. */
export function createRequest(dc: DataConnect, vars: CreateRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateRequestData>>;
/** Generated Node Admin SDK operation action function for the 'CreateRequest' Mutation. Allow users to pass in custom DataConnect instances. */
export function createRequest(vars: CreateRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateRequestData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateRoutine' Mutation. Allow users to execute without passing in DataConnect. */
export function updateRoutine(dc: DataConnect, vars: UpdateRoutineVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateRoutineData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateRoutine' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateRoutine(vars: UpdateRoutineVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateRoutineData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateRequestStatus' Mutation. Allow users to execute without passing in DataConnect. */
export function updateRequestStatus(dc: DataConnect, vars: UpdateRequestStatusVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateRequestStatusData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateRequestStatus' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateRequestStatus(vars: UpdateRequestStatusVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateRequestStatusData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateUserFcmToken' Mutation. Allow users to execute without passing in DataConnect. */
export function updateUserFcmToken(dc: DataConnect, vars: UpdateUserFcmTokenVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateUserFcmTokenData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateUserFcmToken' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateUserFcmToken(vars: UpdateUserFcmTokenVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateUserFcmTokenData>>;

/** Generated Node Admin SDK operation action function for the 'CreateNotification' Mutation. Allow users to execute without passing in DataConnect. */
export function createNotification(dc: DataConnect, vars: CreateNotificationVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateNotificationData>>;
/** Generated Node Admin SDK operation action function for the 'CreateNotification' Mutation. Allow users to pass in custom DataConnect instances. */
export function createNotification(vars: CreateNotificationVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateNotificationData>>;

/** Generated Node Admin SDK operation action function for the 'MarkNotificationRead' Mutation. Allow users to execute without passing in DataConnect. */
export function markNotificationRead(dc: DataConnect, vars: MarkNotificationReadVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<MarkNotificationReadData>>;
/** Generated Node Admin SDK operation action function for the 'MarkNotificationRead' Mutation. Allow users to pass in custom DataConnect instances. */
export function markNotificationRead(vars: MarkNotificationReadVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<MarkNotificationReadData>>;

/** Generated Node Admin SDK operation action function for the 'CreateItem' Mutation. Allow users to execute without passing in DataConnect. */
export function createItem(dc: DataConnect, vars: CreateItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateItemData>>;
/** Generated Node Admin SDK operation action function for the 'CreateItem' Mutation. Allow users to pass in custom DataConnect instances. */
export function createItem(vars: CreateItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateItemData>>;

/** Generated Node Admin SDK operation action function for the 'CreateMachine' Mutation. Allow users to execute without passing in DataConnect. */
export function createMachine(dc: DataConnect, vars: CreateMachineVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateMachineData>>;
/** Generated Node Admin SDK operation action function for the 'CreateMachine' Mutation. Allow users to pass in custom DataConnect instances. */
export function createMachine(vars: CreateMachineVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateMachineData>>;

/** Generated Node Admin SDK operation action function for the 'CreateUser' Mutation. Allow users to execute without passing in DataConnect. */
export function createUser(dc: DataConnect, vars: CreateUserVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateUserData>>;
/** Generated Node Admin SDK operation action function for the 'CreateUser' Mutation. Allow users to pass in custom DataConnect instances. */
export function createUser(vars: CreateUserVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateUserData>>;

/** Generated Node Admin SDK operation action function for the 'GetUser' Query. Allow users to execute without passing in DataConnect. */
export function getUser(dc: DataConnect, vars: GetUserVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetUserData>>;
/** Generated Node Admin SDK operation action function for the 'GetUser' Query. Allow users to pass in custom DataConnect instances. */
export function getUser(vars: GetUserVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetUserData>>;

/** Generated Node Admin SDK operation action function for the 'ListUsers' Query. Allow users to execute without passing in DataConnect. */
export function listUsers(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListUsersData>>;
/** Generated Node Admin SDK operation action function for the 'ListUsers' Query. Allow users to pass in custom DataConnect instances. */
export function listUsers(options?: OperationOptions): Promise<ExecuteOperationResponse<ListUsersData>>;

/** Generated Node Admin SDK operation action function for the 'GetMechanics' Query. Allow users to execute without passing in DataConnect. */
export function getMechanics(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMechanicsData>>;
/** Generated Node Admin SDK operation action function for the 'GetMechanics' Query. Allow users to pass in custom DataConnect instances. */
export function getMechanics(options?: OperationOptions): Promise<ExecuteOperationResponse<GetMechanicsData>>;

/** Generated Node Admin SDK operation action function for the 'GetMachine' Query. Allow users to execute without passing in DataConnect. */
export function getMachine(dc: DataConnect, vars: GetMachineVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMachineData>>;
/** Generated Node Admin SDK operation action function for the 'GetMachine' Query. Allow users to pass in custom DataConnect instances. */
export function getMachine(vars: GetMachineVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMachineData>>;

/** Generated Node Admin SDK operation action function for the 'ListMachines' Query. Allow users to execute without passing in DataConnect. */
export function listMachines(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListMachinesData>>;
/** Generated Node Admin SDK operation action function for the 'ListMachines' Query. Allow users to pass in custom DataConnect instances. */
export function listMachines(options?: OperationOptions): Promise<ExecuteOperationResponse<ListMachinesData>>;

/** Generated Node Admin SDK operation action function for the 'GetItem' Query. Allow users to execute without passing in DataConnect. */
export function getItem(dc: DataConnect, vars: GetItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetItemData>>;
/** Generated Node Admin SDK operation action function for the 'GetItem' Query. Allow users to pass in custom DataConnect instances. */
export function getItem(vars: GetItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetItemData>>;

/** Generated Node Admin SDK operation action function for the 'ListItems' Query. Allow users to execute without passing in DataConnect. */
export function listItems(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListItemsData>>;
/** Generated Node Admin SDK operation action function for the 'ListItems' Query. Allow users to pass in custom DataConnect instances. */
export function listItems(options?: OperationOptions): Promise<ExecuteOperationResponse<ListItemsData>>;

/** Generated Node Admin SDK operation action function for the 'GetRequest' Query. Allow users to execute without passing in DataConnect. */
export function getRequest(dc: DataConnect, vars: GetRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRequestData>>;
/** Generated Node Admin SDK operation action function for the 'GetRequest' Query. Allow users to pass in custom DataConnect instances. */
export function getRequest(vars: GetRequestVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRequestData>>;

/** Generated Node Admin SDK operation action function for the 'ListRequests' Query. Allow users to execute without passing in DataConnect. */
export function listRequests(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListRequestsData>>;
/** Generated Node Admin SDK operation action function for the 'ListRequests' Query. Allow users to pass in custom DataConnect instances. */
export function listRequests(options?: OperationOptions): Promise<ExecuteOperationResponse<ListRequestsData>>;

/** Generated Node Admin SDK operation action function for the 'GetRequestsByMechanicEmail' Query. Allow users to execute without passing in DataConnect. */
export function getRequestsByMechanicEmail(dc: DataConnect, vars: GetRequestsByMechanicEmailVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRequestsByMechanicEmailData>>;
/** Generated Node Admin SDK operation action function for the 'GetRequestsByMechanicEmail' Query. Allow users to pass in custom DataConnect instances. */
export function getRequestsByMechanicEmail(vars: GetRequestsByMechanicEmailVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRequestsByMechanicEmailData>>;

/** Generated Node Admin SDK operation action function for the 'GetRoutine' Query. Allow users to execute without passing in DataConnect. */
export function getRoutine(dc: DataConnect, vars: GetRoutineVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRoutineData>>;
/** Generated Node Admin SDK operation action function for the 'GetRoutine' Query. Allow users to pass in custom DataConnect instances. */
export function getRoutine(vars: GetRoutineVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRoutineData>>;

/** Generated Node Admin SDK operation action function for the 'GetRoutinesByMachineId' Query. Allow users to execute without passing in DataConnect. */
export function getRoutinesByMachineId(dc: DataConnect, vars: GetRoutinesByMachineIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRoutinesByMachineIdData>>;
/** Generated Node Admin SDK operation action function for the 'GetRoutinesByMachineId' Query. Allow users to pass in custom DataConnect instances. */
export function getRoutinesByMachineId(vars: GetRoutinesByMachineIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRoutinesByMachineIdData>>;

/** Generated Node Admin SDK operation action function for the 'GetRoutineLog' Query. Allow users to execute without passing in DataConnect. */
export function getRoutineLog(dc: DataConnect, vars: GetRoutineLogVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRoutineLogData>>;
/** Generated Node Admin SDK operation action function for the 'GetRoutineLog' Query. Allow users to pass in custom DataConnect instances. */
export function getRoutineLog(vars: GetRoutineLogVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRoutineLogData>>;

/** Generated Node Admin SDK operation action function for the 'ListRoutineLogs' Query. Allow users to execute without passing in DataConnect. */
export function listRoutineLogs(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListRoutineLogsData>>;
/** Generated Node Admin SDK operation action function for the 'ListRoutineLogs' Query. Allow users to pass in custom DataConnect instances. */
export function listRoutineLogs(options?: OperationOptions): Promise<ExecuteOperationResponse<ListRoutineLogsData>>;

/** Generated Node Admin SDK operation action function for the 'GetMaintainLog' Query. Allow users to execute without passing in DataConnect. */
export function getMaintainLog(dc: DataConnect, vars: GetMaintainLogVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMaintainLogData>>;
/** Generated Node Admin SDK operation action function for the 'GetMaintainLog' Query. Allow users to pass in custom DataConnect instances. */
export function getMaintainLog(vars: GetMaintainLogVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMaintainLogData>>;

/** Generated Node Admin SDK operation action function for the 'ListMaintainLogs' Query. Allow users to execute without passing in DataConnect. */
export function listMaintainLogs(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListMaintainLogsData>>;
/** Generated Node Admin SDK operation action function for the 'ListMaintainLogs' Query. Allow users to pass in custom DataConnect instances. */
export function listMaintainLogs(options?: OperationOptions): Promise<ExecuteOperationResponse<ListMaintainLogsData>>;

/** Generated Node Admin SDK operation action function for the 'GetMechanicFcmToken' Query. Allow users to execute without passing in DataConnect. */
export function getMechanicFcmToken(dc: DataConnect, vars: GetMechanicFcmTokenVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMechanicFcmTokenData>>;
/** Generated Node Admin SDK operation action function for the 'GetMechanicFcmToken' Query. Allow users to pass in custom DataConnect instances. */
export function getMechanicFcmToken(vars: GetMechanicFcmTokenVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMechanicFcmTokenData>>;

/** Generated Node Admin SDK operation action function for the 'ListMechanicNotifications' Query. Allow users to execute without passing in DataConnect. */
export function listMechanicNotifications(dc: DataConnect, vars: ListMechanicNotificationsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ListMechanicNotificationsData>>;
/** Generated Node Admin SDK operation action function for the 'ListMechanicNotifications' Query. Allow users to pass in custom DataConnect instances. */
export function listMechanicNotifications(vars: ListMechanicNotificationsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ListMechanicNotificationsData>>;

