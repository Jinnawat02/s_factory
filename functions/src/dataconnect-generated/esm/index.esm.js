import { queryRef, executeQuery, mutationRef, executeMutation, validateArgs } from 'firebase/data-connect';

export const connectorConfig = {
  connector: 'connector',
  service: 'fir-factory-45cec-service',
  location: 'asia-southeast1'
};

export const updateFcmTokenRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateFCMToken', inputVars);
}
updateFcmTokenRef.operationName = 'UpdateFCMToken';

export function updateFcmToken(dcOrVars, vars) {
  return executeMutation(updateFcmTokenRef(dcOrVars, vars));
}

export const getUserFcmTokenRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetUserFCMToken', inputVars);
}
getUserFcmTokenRef.operationName = 'GetUserFCMToken';

export function getUserFcmToken(dcOrVars, vars) {
  return executeQuery(getUserFcmTokenRef(dcOrVars, vars));
}

export const createUserRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateUser', inputVars);
}
createUserRef.operationName = 'CreateUser';

export function createUser(dcOrVars, vars) {
  return executeMutation(createUserRef(dcOrVars, vars));
}

export const updateUserRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateUser', inputVars);
}
updateUserRef.operationName = 'UpdateUser';

export function updateUser(dcOrVars, vars) {
  return executeMutation(updateUserRef(dcOrVars, vars));
}

export const deleteUserRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'DeleteUser', inputVars);
}
deleteUserRef.operationName = 'DeleteUser';

export function deleteUser(dcOrVars, vars) {
  return executeMutation(deleteUserRef(dcOrVars, vars));
}

export const createMachineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateMachine', inputVars);
}
createMachineRef.operationName = 'CreateMachine';

export function createMachine(dcOrVars, vars) {
  return executeMutation(createMachineRef(dcOrVars, vars));
}

export const updateMachineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateMachine', inputVars);
}
updateMachineRef.operationName = 'UpdateMachine';

export function updateMachine(dcOrVars, vars) {
  return executeMutation(updateMachineRef(dcOrVars, vars));
}

export const deleteMachineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'DeleteMachine', inputVars);
}
deleteMachineRef.operationName = 'DeleteMachine';

export function deleteMachine(dcOrVars, vars) {
  return executeMutation(deleteMachineRef(dcOrVars, vars));
}

export const createItemRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateItem', inputVars);
}
createItemRef.operationName = 'CreateItem';

export function createItem(dcOrVars, vars) {
  return executeMutation(createItemRef(dcOrVars, vars));
}

export const updateItemRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateItem', inputVars);
}
updateItemRef.operationName = 'UpdateItem';

export function updateItem(dcOrVars, vars) {
  return executeMutation(updateItemRef(dcOrVars, vars));
}

export const deleteItemRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'DeleteItem', inputVars);
}
deleteItemRef.operationName = 'DeleteItem';

export function deleteItem(dcOrVars, vars) {
  return executeMutation(deleteItemRef(dcOrVars, vars));
}

export const createRequestRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateRequest', inputVars);
}
createRequestRef.operationName = 'CreateRequest';

export function createRequest(dcOrVars, vars) {
  return executeMutation(createRequestRef(dcOrVars, vars));
}

export const updateRequestStatusRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateRequestStatus', inputVars);
}
updateRequestStatusRef.operationName = 'UpdateRequestStatus';

export function updateRequestStatus(dcOrVars, vars) {
  return executeMutation(updateRequestStatusRef(dcOrVars, vars));
}

export const createRoutineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateRoutine', inputVars);
}
createRoutineRef.operationName = 'CreateRoutine';

export function createRoutine(dcOrVars, vars) {
  return executeMutation(createRoutineRef(dcOrVars, vars));
}

export const updateRoutineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateRoutine', inputVars);
}
updateRoutineRef.operationName = 'UpdateRoutine';

export function updateRoutine(dcOrVars, vars) {
  return executeMutation(updateRoutineRef(dcOrVars, vars));
}

export const createMaintainLogRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateMaintainLog', inputVars);
}
createMaintainLogRef.operationName = 'CreateMaintainLog';

export function createMaintainLog(dcOrVars, vars) {
  return executeMutation(createMaintainLogRef(dcOrVars, vars));
}

export const createRoutineLogRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateRoutineLog', inputVars);
}
createRoutineLogRef.operationName = 'CreateRoutineLog';

export function createRoutineLog(dcOrVars, vars) {
  return executeMutation(createRoutineLogRef(dcOrVars, vars));
}

export const createNotificationRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateNotification', inputVars);
}
createNotificationRef.operationName = 'CreateNotification';

export function createNotification(dcOrVars, vars) {
  return executeMutation(createNotificationRef(dcOrVars, vars));
}

export const markNotificationReadRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'MarkNotificationRead', inputVars);
}
markNotificationReadRef.operationName = 'MarkNotificationRead';

export function markNotificationRead(dcOrVars, vars) {
  return executeMutation(markNotificationReadRef(dcOrVars, vars));
}

export const getUserRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetUser', inputVars);
}
getUserRef.operationName = 'GetUser';

export function getUser(dcOrVars, vars) {
  return executeQuery(getUserRef(dcOrVars, vars));
}

export const listUsersRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListUsers');
}
listUsersRef.operationName = 'ListUsers';

export function listUsers(dc) {
  return executeQuery(listUsersRef(dc));
}

export const getMechanicsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetMechanics');
}
getMechanicsRef.operationName = 'GetMechanics';

export function getMechanics(dc) {
  return executeQuery(getMechanicsRef(dc));
}

export const getMachineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetMachine', inputVars);
}
getMachineRef.operationName = 'GetMachine';

export function getMachine(dcOrVars, vars) {
  return executeQuery(getMachineRef(dcOrVars, vars));
}

export const listMachinesRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListMachines');
}
listMachinesRef.operationName = 'ListMachines';

export function listMachines(dc) {
  return executeQuery(listMachinesRef(dc));
}

export const getItemRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetItem', inputVars);
}
getItemRef.operationName = 'GetItem';

export function getItem(dcOrVars, vars) {
  return executeQuery(getItemRef(dcOrVars, vars));
}

export const listItemsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListItems');
}
listItemsRef.operationName = 'ListItems';

export function listItems(dc) {
  return executeQuery(listItemsRef(dc));
}

export const getRequestRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetRequest', inputVars);
}
getRequestRef.operationName = 'GetRequest';

export function getRequest(dcOrVars, vars) {
  return executeQuery(getRequestRef(dcOrVars, vars));
}

export const listRequestsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListRequests');
}
listRequestsRef.operationName = 'ListRequests';

export function listRequests(dc) {
  return executeQuery(listRequestsRef(dc));
}

export const getRequestsByMechanicEmailRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetRequestsByMechanicEmail', inputVars);
}
getRequestsByMechanicEmailRef.operationName = 'GetRequestsByMechanicEmail';

export function getRequestsByMechanicEmail(dcOrVars, vars) {
  return executeQuery(getRequestsByMechanicEmailRef(dcOrVars, vars));
}

export const getRoutineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetRoutine', inputVars);
}
getRoutineRef.operationName = 'GetRoutine';

export function getRoutine(dcOrVars, vars) {
  return executeQuery(getRoutineRef(dcOrVars, vars));
}

export const listRoutinesRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListRoutines');
}
listRoutinesRef.operationName = 'ListRoutines';

export function listRoutines(dc) {
  return executeQuery(listRoutinesRef(dc));
}

export const getRoutinesByMachineIdRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetRoutinesByMachineId', inputVars);
}
getRoutinesByMachineIdRef.operationName = 'GetRoutinesByMachineId';

export function getRoutinesByMachineId(dcOrVars, vars) {
  return executeQuery(getRoutinesByMachineIdRef(dcOrVars, vars));
}

export const getRoutineLogRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetRoutineLog', inputVars);
}
getRoutineLogRef.operationName = 'GetRoutineLog';

export function getRoutineLog(dcOrVars, vars) {
  return executeQuery(getRoutineLogRef(dcOrVars, vars));
}

export const listRoutineLogsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListRoutineLogs');
}
listRoutineLogsRef.operationName = 'ListRoutineLogs';

export function listRoutineLogs(dc) {
  return executeQuery(listRoutineLogsRef(dc));
}

export const getMaintainLogRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetMaintainLog', inputVars);
}
getMaintainLogRef.operationName = 'GetMaintainLog';

export function getMaintainLog(dcOrVars, vars) {
  return executeQuery(getMaintainLogRef(dcOrVars, vars));
}

export const listMaintainLogsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListMaintainLogs');
}
listMaintainLogsRef.operationName = 'ListMaintainLogs';

export function listMaintainLogs(dc) {
  return executeQuery(listMaintainLogsRef(dc));
}

export const getNotificationRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetNotification', inputVars);
}
getNotificationRef.operationName = 'GetNotification';

export function getNotification(dcOrVars, vars) {
  return executeQuery(getNotificationRef(dcOrVars, vars));
}

export const listNotificationsByMechanicRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListNotificationsByMechanic', inputVars);
}
listNotificationsByMechanicRef.operationName = 'ListNotificationsByMechanic';

export function listNotificationsByMechanic(dcOrVars, vars) {
  return executeQuery(listNotificationsByMechanicRef(dcOrVars, vars));
}

