import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { getDataConnect } from "firebase-admin/data-connect";

admin.initializeApp();

export const notifyMechanic = onCall(async (request) => {
    const data = request.data;
    const mechanicEmail = data.mechanicEmail;
    const requestId = data.requestId;

    if (!mechanicEmail || !requestId) {
        throw new HttpsError(
            "invalid-argument",
            "The function must be called with mechanicEmail and requestId."
        );
    }

    try {
        // Call Data Connect to get the mechanic's FCM Token using Admin SDK
        const dc = getDataConnect({
            serviceId: 'fir-factory-45cec-service',
            location: 'asia-southeast1'
        });

        const query = `
          query GetUserFCMToken($email: String!) {
            user(key: {email: $email}) {
              fcmToken
            }
          }
        `;

        const result = await dc.executeGraphql(query, { variables: { email: mechanicEmail } });
        const resData = result.data as any;
        const user = resData.user;

        if (!user || typeof user !== 'object' || !('fcmToken' in user) || !user.fcmToken) {
            console.log(`No FCM token found for user: ${mechanicEmail}`);
            return { success: false, message: "User has no FCM token" };
        }

        const token = user.fcmToken;

        // Send the notification using Firebase Admin SDK
        const message = {
            token: token,
            notification: {
                title: "New Repair Request",
                body: "A new repair request has been assigned to you.",
            },
            data: {
                requestId: requestId, // Deep link payload
            },
            android: {
                notification: {
                    clickAction: "FLUTTER_NOTIFICATION_CLICK"
                }
            },
            apns: {
                payload: {
                    aps: {
                        category: "FLUTTER_NOTIFICATION_CLICK"
                    }
                }
            }
        };

        const response = await admin.messaging().send(message);
        console.log("Successfully sent message:", response);
        return { success: true, messageId: response };

    } catch (error: any) {
        console.error("Error sending notification:", error);

        // If it's a known messaging error like 'invalid token', don't throw 500
        if (error.code === 'messaging/registration-token-not-registered' ||
            error.message?.includes('Requested entity was not found')) {
            return {
                success: false,
                message: "FCM token is no longer valid or device was uninstalled."
            };
        }

        throw new HttpsError("internal", "Failed to send notification.");
    }
});
