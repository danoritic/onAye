const functions = require('firebase-functions');
const admin = require('firebase-admin');
// To avoid deployment errors, do not call admin.initializeApp() in your code


exports.credone = () => {
  // Access the JSON data from the request body (assuming a POST request with JSON body)
  // Validate and handle errors (similar to previous example)
  
  const cred={
      type: "service_account",
      project_id: "onlife-3l26ul",
      private_key_id: "8bf3624e9e5cbd8d03c4289218e3c6a6a8911943",
      private_key:
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8BqerQ5xUyOiA\nuR760LrBf4k0N5rHhLr84a9a8930DEndkOl+mO5ytts7DzlSewrff/+pg5eKVFN/\nW+H1/UxyVYIJrseM5HaJ1rV5+yOmOOhIxejHyaNxDz2NnEzhZMuRmsi3wYKZqIHc\nVzkiuOZhLdleMOM56srrzgjtfwKO6ov6JSD13iQdgoHHPKm9to8nl6zNzOI6z9pY\nx7Bl2QSN7kKF3RAARh4hbifERef9T0tWpSiwTgcaf0y2U916DBY5StnmVGCoemFI\nL5/zOBzbkriI5d3B++oykQt1Yc4aGEwWbUu2eMcVgOXC6Ikl0va0cmjdUdcBmnbK\n52USIAEtAgMBAAECggEAHVk2k6t2e99uNyVuGf05oVlcW6uwO6NSooVBn0NAakb+\nwphLcejCE2LKXnIWYvL0tAUhLV7uaPeXnuIDJ6fVZmVFamh/GlVQ0VwTsIoMOvZX\n/3/wwTqOiee0lmWGtInMopoT6WbJkV11g6STtQFCaHnFG4gq94/YA62BxDxWdGMQ\nMgjGaK9nm0EwfqrNgtdEz4b1/mYfw06/PxrB85LM/+15gTmRIAA/PaQxIWbIp+Gi\nAX35liOl+uC+p1fhFhUqr5o1M6/9xxxDQIbXDGRCYbqhfEUf2tNv6PA9d/jxwisQ\nDsD/N9D/65ODhN9edLuctqRhum3TlzcpCVjw5ueRSwKBgQDryqLBjcHTBoJMARjh\naZuPLI6LMN2GVh/ni4MKSV5vReQxt4mpLrHsZ/dUgwaMCqOZehTCZAi7GfqRtVYs\nQJLqDFfuiSItMZKi1maFOHc6iZtcC2m6MazRO/oBPj5CPkrDKlQmvf7QOMB4359D\nzeO/MUgIaUQwsKbMmMJzn29E1wKBgQDMJAXyTu1MeyvPn3FR8OjFBncxkgVXBwwa\npXotZ3l0hGB361Dz78m+O9yvdA0+bRBgNlTi+REnJq1PDbDQsfpixlvekOgjcgyc\nM76hGVe+kkHB2LnJWPHlY3KnqLUdZHwog/cPZzWjaY9pAv8ckvsUkfdAqbgvwY+e\nUi1+5ZvlmwKBgQCWeAOQ/MN5xSeVFQYpotkwbsCwNojHV2KYwkDnaZan77QFvhhN\nLI1CTb5Z4htldsyb/noM6wVfUN7D6TKKntKiJSpgAIcczAvFeoiF71i2tGW+QVJB\nDb4478tEy9GzOElBbluxNYHMosrA2AOso1D5C5vqMjLf13s6CSnd2xqIlQKBgQDA\nfbNRwZTHClnMZDcxoe2LY0ZfaqY4Yr/KHIExcSG4ed6RFUX3TwM3qzC0DMU0ORk4\n7+JpR5wiA7lmEq3IjBpiq1ITcyZBzhgP7kbxl3kCjN0OkXLWZlVqDLUfXNizR34/\nofgEATk1xqLgzV+LLRkuU1kHE0JHXcgz7J9TyeSPwwKBgH/Eq4gKYVkGOKWQ2gMB\n7E3bf6ZmjNuKdwCH9bepYa6Xjq+W8Uu1DQ9hfeZkDw37KLpdHwpQco329x3j4DJT\nx7ECWyt1qB7d5/7Np/gzRjV8c6EF9/WetWj6Rjmw+SRztpCf/xn+ZSDaxGvzEZil\nrZvzB0S0bPkOrntiVQ77QhBw\n-----END PRIVATE KEY-----\n",
      client_email: "onlife-3l26ul@appspot.gserviceaccount.com",
      client_id: "104296519916561161118",
      auth_uri: "https://accounts.google.com/o/oauth2/auth",
      token_uri: "https://oauth2.googleapis.com/token",
      auth_provider_x509_cert_url:
          "https://www.googleapis.com/oauth2/v1/certs",
      client_x509_cert_url:
          "https://www.googleapis.com/robot/v1/metadata/x509/onlife-3l26ul%40appspot.gserviceaccount.com",
      universe_domain: "googleapis.com"
    }



  // Stringify the JSON data
  const jsonDataString = JSON.stringify(cred);

  // Set the response content type and status code
  // res.setHeader('Content-Type', 'application/json; charset=utf-8');
  // res.status(200);

  // Send the JSON response
  // res.send(jsonDataString);
  return{jsonDataString}
};