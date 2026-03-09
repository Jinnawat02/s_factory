const { queryRef, executeQuery, mutationRef, executeMutation, validateArgs } = require('firebase/data-connect');

const connectorConfig = {
  connector: 'connector',
  service: 'fir-factory-45cec-service',
  location: 'asia-southeast1'
};
exports.connectorConfig = connectorConfig;

const updateFcmTokenRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateFCMToken', inputVars);
}
updateFcmTokenRef.operationName = 'UpdateFCMToken';
exports.updateFcmTokenRef = updateFcmTokenRef;

exports.updateFcmToken = function updateFcmToken(dcOrVars, vars) {
  return executeMutation(updateFcmTokenRef(dcOrVars, vars));
};

const getUserFcmTokenRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetUserFCMToken', inputVars);
}
getUserFcmTokenRef.operationName = 'GetUserFCMToken';
exports.getUserFcmTokenRef = getUserFcmTokenRef;

exports.getUserFcmToken = function getUserFcmToken(dcOrVars, vars) {
  return executeQuery(getUserFcmTokenRef(dcOrVars, vars));
};

const createUserRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateUser', inputVars);
}
createUserRef.operationName = 'CreateUser';
exports.createUserRef = createUserRef;

exports.createUser = function createUser(dcOrVars, vars) {
  return executeMutation(createUserRef(dcOrVars, vars));
};

const updateUserRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateUser', inputVars);
}
updateUserRef.operationName = 'UpdateUser';
exports.updateUserRef = updateUserRef;

exports.updateUser = function updateUser(dcOrVars, vars) {
  return executeMutation(updateUserRef(dcOrVars, vars));
};

const deleteUserRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'DeleteUser', inputVars);
}
deleteUserRef.operationName = 'DeleteUser';
exports.deleteUserRef = deleteUserRef;

exports.deleteUser = function deleteUser(dcOrVars, vars) {
  return executeMutation(deleteUserRef(dcOrVars, vars));
};

const createMachineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateMachine', inputVars);
}
createMachineRef.operationName = 'CreateMachine';
exports.createMachineRef = createMachineRef;

exports.createMachine = function createMachine(dcOrVars, vars) {
  return executeMutation(createMachineRef(dcOrVars, vars));
};

const updateMachineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateMachine', inputVars);
}
updateMachineRef.operationName = 'UpdateMachine';
exports.updateMachineRef = updateMachineRef;

exports.updateMachine = function updateMachine(dcOrVars, vars) {
  return executeMutation(updateMachineRef(dcOrVars, vars));
};

const deleteMachineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'DeleteMachine', inputVars);
}
deleteMachineRef.operationName = 'DeleteMachine';
exports.deleteMachineRef = deleteMachineRef;

exports.deleteMachine = function deleteMachine(dcOrVars, vars) {
  return executeMutation(deleteMachineRef(dcOrVars, vars));
};

const createItemRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateItem', inputVars);
}
createItemRef.operationName = 'CreateItem';
exports.createItemRef = createItemRef;

exports.createItem = function createItem(dcOrVars, vars) {
  return executeMutation(createItemRef(dcOrVars, vars));
};

const updateItemRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateItem', inputVars);
}
updateItemRef.operationName = 'UpdateItem';
exports.updateItemRef = updateItemRef;

exports.updateItem = function updateItem(dcOrVars, vars) {
  return executeMutation(updateItemRef(dcOrVars, vars));
};

const deleteItemRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'DeleteItem', inputVars);
}
deleteItemRef.operationName = 'DeleteItem';
exports.deleteItemRef = deleteItemRef;

exports.deleteItem = function deleteItem(dcOrVars, vars) {
  return executeMutation(deleteItemRef(dcOrVars, vars));
};

const createRequestRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateRequest', inputVars);
}
createRequestRef.operationName = 'CreateRequest';
exports.createRequestRef = createRequestRef;

exports.createRequest = function createRequest(dcOrVars, vars) {
  return executeMutation(createRequestRef(dcOrVars, vars));
};

const updateRequestStatusRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateRequestStatus', inputVars);
}
updateRequestStatusRef.operationName = 'UpdateRequestStatus';
exports.updateRequestStatusRef = updateRequestStatusRef;

exports.updateRequestStatus = function updateRequestStatus(dcOrVars, vars) {
  return executeMutation(updateRequestStatusRef(dcOrVars, vars));
};

const createRoutineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateRoutine', inputVars);
}
createRoutineRef.operationName = 'CreateRoutine';
exports.createRoutineRef = createRoutineRef;

exports.createRoutine = function createRoutine(dcOrVars, vars) {
  return executeMutation(createRoutineRef(dcOrVars, vars));
};

const updateRoutineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'UpdateRoutine', inputVars);
}
updateRoutineRef.operationName = 'UpdateRoutine';
exports.updateRoutineRef = updateRoutineRef;

exports.updateRoutine = function updateRoutine(dcOrVars, vars) {
  return executeMutation(updateRoutineRef(dcOrVars, vars));
};

const createMaintainLogRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateMaintainLog', inputVars);
}
createMaintainLogRef.operationName = 'CreateMaintainLog';
exports.createMaintainLogRef = createMaintainLogRef;

exports.createMaintainLog = function createMaintainLog(dcOrVars, vars) {
  return executeMutation(createMaintainLogRef(dcOrVars, vars));
};

const createRoutineLogRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateRoutineLog', inputVars);
}
createRoutineLogRef.operationName = 'CreateRoutineLog';
exports.createRoutineLogRef = createRoutineLogRef;

exports.createRoutineLog = function createRoutineLog(dcOrVars, vars) {
  return executeMutation(createRoutineLogRef(dcOrVars, vars));
};

const createNotificationRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateNotification', inputVars);
}
createNotificationRef.operationName = 'CreateNotification';
exports.createNotificationRef = createNotificationRef;

exports.createNotification = function createNotification(dcOrVars, vars) {
  return executeMutation(createNotificationRef(dcOrVars, vars));
};

const markNotificationReadRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'MarkNotificationRead', inputVars);
}
markNotificationReadRef.operationName = 'MarkNotificationRead';
exports.markNotificationReadRef = markNotificationReadRef;

exports.markNotificationRead = function markNotificationRead(dcOrVars, vars) {
  return executeMutation(markNotificationReadRef(dcOrVars, vars));
};

const getUserRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetUser', inputVars);
}
getUserRef.operationName = 'GetUser';
exports.getUserRef = getUserRef;

exports.getUser = function getUser(dcOrVars, vars) {
  return executeQuery(getUserRef(dcOrVars, vars));
};

const listUsersRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListUsers');
}
listUsersRef.operationName = 'ListUsers';
exports.listUsersRef = listUsersRef;

exports.listUsers = function listUsers(dc) {
  return executeQuery(listUsersRef(dc));
};

const getMechanicsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetMechanics');
}
getMechanicsRef.operationName = 'GetMechanics';
exports.getMechanicsRef = getMechanicsRef;

exports.getMechanics = function getMechanics(dc) {
  return executeQuery(getMechanicsRef(dc));
};

const getMachineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetMachine', inputVars);
}
getMachineRef.operationName = 'GetMachine';
exports.getMachineRef = getMachineRef;

exports.getMachine = function getMachine(dcOrVars, vars) {
  return executeQuery(getMachineRef(dcOrVars, vars));
};

const listMachinesRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListMachines');
}
listMachinesRef.operationName = 'ListMachines';
exports.listMachinesRef = listMachinesRef;

exports.listMachines = function listMachines(dc) {
  return executeQuery(listMachinesRef(dc));
};

const getItemRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetItem', inputVars);
}
getItemRef.operationName = 'GetItem';
exports.getItemRef = getItemRef;

exports.getItem = function getItem(dcOrVars, vars) {
  return executeQuery(getItemRef(dcOrVars, vars));
};

const listItemsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListItems');
}
listItemsRef.operationName = 'ListItems';
exports.listItemsRef = listItemsRef;

exports.listItems = function listItems(dc) {
  return executeQuery(listItemsRef(dc));
};

const getRequestRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetRequest', inputVars);
}
getRequestRef.operationName = 'GetRequest';
exports.getRequestRef = getRequestRef;

exports.getRequest = function getRequest(dcOrVars, vars) {
  return executeQuery(getRequestRef(dcOrVars, vars));
};

const listRequestsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListRequests');
}
listRequestsRef.operationName = 'ListRequests';
exports.listRequestsRef = listRequestsRef;

exports.listRequests = function listRequests(dc) {
  return executeQuery(listRequestsRef(dc));
};

const getRequestsByMechanicEmailRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetRequestsByMechanicEmail', inputVars);
}
getRequestsByMechanicEmailRef.operationName = 'GetRequestsByMechanicEmail';
exports.getRequestsByMechanicEmailRef = getRequestsByMechanicEmailRef;

exports.getRequestsByMechanicEmail = function getRequestsByMechanicEmail(dcOrVars, vars) {
  return executeQuery(getRequestsByMechanicEmailRef(dcOrVars, vars));
};

const getRoutineRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetRoutine', inputVars);
}
getRoutineRef.operationName = 'GetRoutine';
exports.getRoutineRef = getRoutineRef;

exports.getRoutine = function getRoutine(dcOrVars, vars) {
  return executeQuery(getRoutineRef(dcOrVars, vars));
};

const listRoutinesRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListRoutines');
}
listRoutinesRef.operationName = 'ListRoutines';
exports.listRoutinesRef = listRoutinesRef;

exports.listRoutines = function listRoutines(dc) {
  return executeQuery(listRoutinesRef(dc));
};

const getRoutinesByMachineIdRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetRoutinesByMachineId', inputVars);
}
getRoutinesByMachineIdRef.operationName = 'GetRoutinesByMachineId';
exports.getRoutinesByMachineIdRef = getRoutinesByMachineIdRef;

exports.getRoutinesByMachineId = function getRoutinesByMachineId(dcOrVars, vars) {
  return executeQuery(getRoutinesByMachineIdRef(dcOrVars, vars));
};

const getRoutineLogRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetRoutineLog', inputVars);
}
getRoutineLogRef.operationName = 'GetRoutineLog';
exports.getRoutineLogRef = getRoutineLogRef;

exports.getRoutineLog = function getRoutineLog(dcOrVars, vars) {
  return executeQuery(getRoutineLogRef(dcOrVars, vars));
};

const listRoutineLogsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListRoutineLogs');
}
listRoutineLogsRef.operationName = 'ListRoutineLogs';
exports.listRoutineLogsRef = listRoutineLogsRef;

exports.listRoutineLogs = function listRoutineLogs(dc) {
  return executeQuery(listRoutineLogsRef(dc));
};

const getMaintainLogRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetMaintainLog', inputVars);
}
getMaintainLogRef.operationName = 'GetMaintainLog';
exports.getMaintainLogRef = getMaintainLogRef;

exports.getMaintainLog = function getMaintainLog(dcOrVars, vars) {
  return executeQuery(getMaintainLogRef(dcOrVars, vars));
};

const listMaintainLogsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListMaintainLogs');
}
listMaintainLogsRef.operationName = 'ListMaintainLogs';
exports.listMaintainLogsRef = listMaintainLogsRef;

exports.listMaintainLogs = function listMaintainLogs(dc) {
  return executeQuery(listMaintainLogsRef(dc));
};

const getNotificationRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetNotification', inputVars);
}
getNotificationRef.operationName = 'GetNotification';
exports.getNotificationRef = getNotificationRef;

exports.getNotification = function getNotification(dcOrVars, vars) {
  return executeQuery(getNotificationRef(dcOrVars, vars));
};

const listNotificationsByMechanicRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListNotificationsByMechanic', inputVars);
}
listNotificationsByMechanicRef.operationName = 'ListNotificationsByMechanic';
exports.listNotificationsByMechanicRef = listNotificationsByMechanicRef;

exports.listNotificationsByMechanic = function listNotificationsByMechanic(dcOrVars, vars) {
  return executeQuery(listNotificationsByMechanicRef(dcOrVars, vars));
};
