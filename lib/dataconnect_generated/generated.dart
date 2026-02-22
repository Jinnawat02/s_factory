library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_request.dart';

part 'insert_user.dart';

part 'insert_machine.dart';

part 'get_user.dart';

part 'list_users.dart';

part 'get_machine.dart';

part 'list_machines.dart';

part 'get_item.dart';

part 'list_items.dart';

part 'get_request.dart';

part 'list_requests.dart';

part 'get_routine.dart';

part 'list_routines.dart';

part 'get_routine_log.dart';

part 'list_routine_logs.dart';

part 'get_maintain_log.dart';

part 'list_maintain_logs.dart';







class ConnectorConnector {
  
  
  CreateRequestVariablesBuilder createRequest ({required String userEmail, required String machineId, required String description, required Timestamp requestDate, }) {
    return CreateRequestVariablesBuilder(dataConnect, userEmail: userEmail,machineId: machineId,description: description,requestDate: requestDate,);
  }
  
  
  InsertUserVariablesBuilder insertUser ({required String email, required String password, required String name, required String role, required String tel, }) {
    return InsertUserVariablesBuilder(dataConnect, email: email,password: password,name: name,role: role,tel: tel,);
  }
  
  
  InsertMachineVariablesBuilder insertMachine ({required String id, required String name, required int serialNumber, required String description, }) {
    return InsertMachineVariablesBuilder(dataConnect, id: id,name: name,serialNumber: serialNumber,description: description,);
  }
  
  
  GetUserVariablesBuilder getUser ({required String email, }) {
    return GetUserVariablesBuilder(dataConnect, email: email,);
  }
  
  
  ListUsersVariablesBuilder listUsers () {
    return ListUsersVariablesBuilder(dataConnect, );
  }
  
  
  GetMachineVariablesBuilder getMachine ({required String id, }) {
    return GetMachineVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMachinesVariablesBuilder listMachines () {
    return ListMachinesVariablesBuilder(dataConnect, );
  }
  
  
  GetItemVariablesBuilder getItem ({required String id, }) {
    return GetItemVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListItemsVariablesBuilder listItems () {
    return ListItemsVariablesBuilder(dataConnect, );
  }
  
  
  GetRequestVariablesBuilder getRequest ({required String id, }) {
    return GetRequestVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListRequestsVariablesBuilder listRequests () {
    return ListRequestsVariablesBuilder(dataConnect, );
  }
  
  
  GetRoutineVariablesBuilder getRoutine ({required String id, }) {
    return GetRoutineVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListRoutinesVariablesBuilder listRoutines () {
    return ListRoutinesVariablesBuilder(dataConnect, );
  }
  
  
  GetRoutineLogVariablesBuilder getRoutineLog ({required String id, }) {
    return GetRoutineLogVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListRoutineLogsVariablesBuilder listRoutineLogs () {
    return ListRoutineLogsVariablesBuilder(dataConnect, );
  }
  
  
  GetMaintainLogVariablesBuilder getMaintainLog ({required String id, }) {
    return GetMaintainLogVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMaintainLogsVariablesBuilder listMaintainLogs () {
    return ListMaintainLogsVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-southeast1',
    'connector',
    'fir-factory-45cec-service',
  );

  ConnectorConnector({required this.dataConnect});
  static ConnectorConnector get instance {
    return ConnectorConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
