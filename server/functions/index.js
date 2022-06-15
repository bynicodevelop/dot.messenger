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