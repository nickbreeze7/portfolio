    const functions = require("firebase-functions");
    const admin = require("firebase-admin");
    const auth = require("firebase-auth");

    var serviceAccount = require("./fir-barbershop01-firebase-adminsdk-hjjv7-f6e825bf7d.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

exports.createCustomToken01 = functions
    .https.onRequest(async (request, response) => {
        const user = request.body;

        const uid = `kakao:${user.uid}`;

        const updateParams = {
            email: user.email,
            photoURL: user.photoURL,
            displayName: user.displayName,
      };
       //console.log("email :===========>>>"+email);

  try {
  // 기존에 계정이 있는 경우
    await admin.auth().updateUser(uid, updateParams);
  } catch (e) {
    updateParams["uid"] = uid;
    await admin.auth().createUser(updateParams);

  }

  const token = await admin.auth().createCustomToken01(uid);

  response.send(token);
});