const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.onUserCreated = functions.auth.user().onCreate(async (user) => { 
    const userRef = admin.firestore().collection("users").doc(user.uid);
    
    const userData = {
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
    };

    await userRef.set(userData);
})

exports.onUserAddedContact = functions.firestore.document("users/{userId}/contacts/{contactId}").onCreate(async (snapshot, context) => { 
    const {userId, contactId} = context.params;

    const contactDocumentSnapshot = await admin
        .firestore()
        .collection("users")
        .doc(userId)
        .collection("contacts")
        .doc(contactId)
        .get();

    const { userRef } = contactDocumentSnapshot.data();

    const contactRefDocuments = await userRef
        .collection("contacts")
        .where("userRef", "==", admin.firestore().collection("users").doc(userId))
        .get();

    if(contactRefDocuments.docs.length > 0) {
        return;
    }

    await userRef.collection("contacts").add({
        userRef: admin.firestore().collection("users").doc(userId)
    })
});

exports.onMessageCreated = functions.firestore.document("/chats/{chatId}/messages/{messageId}").onCreate(async (snapshot, context) => {
    const { chatId } = context.params;
    const { text, createdAt } = snapshot.data();
    
    await admin.firestore().collection("chats").doc(chatId).update({
        lastMessage: text,
        updatedAt: createdAt
    })
});