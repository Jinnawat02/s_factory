library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_request.dart';

part 'update_routine.dart';

part 'get_user.dart';

part 'list_users.dart';

part 'get_mechanics.dart';

part 'get_machine.dart';

part 'list_machines.dart';

part 'get_item.dart';

part 'list_items.dart';

part 'get_request.dart';

part 'list_requests.dart';

part 'get_requests_by_mechanic_email.dart';

part 'get_routine.dart';

part 'get_routines_by_machine_id.dart';

part 'get_routine_log.dart';

part 'list_routine_logs.dart';

part 'get_maintain_log.dart';

part 'list_maintain_logs.dart';







class ConnectorConnector {
  
  
  CreateRequestVariablesBuilder createRequest ({required String userEmail, required String machineId, required String description, required Timestamp requestDate, required String mechanicEmail, }) {
    return CreateRequestVariablesBuilder(dataConnect, userEmail: userEmail,machineId: machineId,description: description,requestDate: requestDate,mechanicEmail: mechanicEmail,);
  }
  
  
  UpdateRoutineVariablesBuilder updateRoutine ({required String id, required bool isCheck, }) {
    return UpdateRoutineVariablesBuilder(dataConnect, id: id,isCheck: isCheck,);
  }
  
  
  GetUserVariablesBuilder getUser ({required String email, }) {
    return GetUserVariablesBuilder(dataConnect, email: email,);
  }
  
  
  ListUsersVariablesBuilder listUsers () {
    return ListUsersVariablesBuilder(dataConnect, );
  }
  
  
  GetMechanicsVariablesBuilder getMechanics () {
    return GetMechanicsVariablesBuilder(dataConnect, );
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
  
  
  GetRequestsByMechanicEmailVariablesBuilder getRequestsByMechanicEmail ({required String email, }) {
    return GetRequestsByMechanicEmailVariablesBuilder(dataConnect, email: email,);
  }
  
  
  GetRoutineVariablesBuilder getRoutine ({required String id, }) {
    return GetRoutineVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetRoutinesByMachineIdVariablesBuilder getRoutinesByMachineId ({required String machineId, }) {
    return GetRoutinesByMachineIdVariablesBuilder(dataConnect, machineId: machineId,);
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
