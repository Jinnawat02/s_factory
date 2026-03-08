const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");
const { createRequest, createNotification, getMechanicFcmToken } = require("./dataconnect_generated");

admin.initializeApp();

exports.submitRepairRequest = functions.https.onCall(async (data, context) => {
    // 0. Extract variables
    const { machineId, description, mechanicEmail, requestDate } = data;
    const userEmail = context.auth?.token?.email;

    if (!userEmail) {
        throw new functions.https.HttpsError("unauthenticated", "User must be logged in.");
    }
    if (!machineId || !description || !mechanicEmail || !requestDate) {
        throw new functions.https.HttpsError("invalid-argument", "Missing required fields.");
    }

    try {
        // 1. Create Request
        const requestRes = await createRequest({
            userEmail,
            machineId,
            description,
            requestDate,
            mechanicEmail
        });
        const requestId = requestRes.data.request_insert.id;

        // 2. Create Notification in Database
        const title = `มีการแจ้งซ่อมใหม่: จากคุณ ${userEmail}`;
        const body = `ปัญหา: ${description}`;
        await createNotification({
            mechanicEmail,
            requestId,
            title,
            body,
            createdAt: new Date().toISOString()
        });

        // 3. Get FCM Token of Mechanic
        const tokenRes = await getMechanicFcmToken({ email: mechanicEmail });
        const fcmToken = tokenRes.data.user?.fcmToken;

        // 4. Send Push Notification if token exists
        if (fcmToken) {
            const message = {
                notification: {
                    title: title,
                    body: body,
                },
                token: fcmToken,
            };
            await admin.messaging().send(message);
            console.log("Successfully sent push notification to:", mechanicEmail);
        } else {
            console.log("No FCM token found for:", mechanicEmail);
        }

        return { success: true, requestId };
    } catch (error) {
        console.error("Error submitting repair request:", error);
        throw new functions.https.HttpsError("internal", error.message);
    }
});
