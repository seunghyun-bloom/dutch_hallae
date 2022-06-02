const functions = require("firebase-functions");
const admin = require("firebase-admin");
const auth = require("firebase-auth");
var serviceAccount = require("./service_account.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});


exports.createCustomToken = functions.region("asia-northeast3").https.onRequest(async (request, response) => {
const user = request.body;
const uid = `kakao:${user.uid}`;
const updateParams = {
    email: user.email,
    photoURL: user.photoURL,
    displayName: user.displayName,
};

try {
    await admin.auth().updateUser(uid, updateParams);
} catch (e) {
    updateParams["uid"] = uid;
    await admin.auth().createUser(updateParams);
}

const token = await admin.auth().createCustomToken(uid);

response.send(token);
});
