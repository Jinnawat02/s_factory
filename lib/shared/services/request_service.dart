import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../dataconnect_generated/generated.dart';

/// Central service for all Request lifecycle operations.
/// Each method bundles the primary action + any side-effects
/// (MaintainLog creation, status updates, notifications) so
/// callers never have to remember to chain them manually.
class RequestService {
  final _db = ConnectorConnector.instance;

  // ---------------------------------------------------------------------------
  // CREATE a new request → also creates an "open" MaintainLog entry
  // ---------------------------------------------------------------------------
  Future<void> submitRequest({
    required String userEmail,
    required String machineId,
    required String machineName,
    required String mechanicEmail,
    required Timestamp requestDate,
    required String description,
  }) async {
    // 1. Create the request
    await _db
        .createRequest(
          userEmail: userEmail,
          machineId: machineId,
          mechanicEmail: mechanicEmail,
          requestDate: requestDate,
          description: description,
        )
        .execute();

    // 2. Automatically log it as an open maintenance entry
    await _db
        .createMaintainLog(
          title: 'Maintenance Opened: $machineName',
          isDone: false,
          machineId: machineId,
        )
        .execute();
  }

  // ---------------------------------------------------------------------------
  // COMPLETE a request → mark status "Fixed" + close the MaintainLog
  // ---------------------------------------------------------------------------
  Future<void> completeRequest({
    required String requestId,
    required String machineId,
    required String machineName,
  }) async {
    // 1. Update request status
    await _db.updateRequestStatus(id: requestId, status: 'Fixed').execute();

    // 2. Automatically log that the maintenance is done
    await _db
        .createMaintainLog(
          title: 'Fixed Request: $machineName',
          isDone: true,
          machineId: machineId,
        )
        .execute();
  }

  // ---------------------------------------------------------------------------
  // REJECT / CANCEL a request → mark status "Cancelled" + log it
  // ---------------------------------------------------------------------------
  Future<void> cancelRequest({
    required String requestId,
    required String machineId,
    required String machineName,
  }) async {
    await _db.updateRequestStatus(id: requestId, status: 'Cancelled').execute();

    await _db
        .createMaintainLog(
          title: 'Request Cancelled: $machineName',
          isDone: false,
          machineId: machineId,
        )
        .execute();
  }

  // ---------------------------------------------------------------------------
  // ACCEPT a request → mark status "In Progress" + log it
  // ---------------------------------------------------------------------------
  Future<void> acceptRequest({
    required String requestId,
    required String machineId,
    required String machineName,
  }) async {
    await _db
        .updateRequestStatus(id: requestId, status: 'In Progress')
        .execute();

    await _db
        .createMaintainLog(
          title: 'Maintenance In Progress: $machineName',
          isDone: false,
          machineId: machineId,
        )
        .execute();
  }
}
