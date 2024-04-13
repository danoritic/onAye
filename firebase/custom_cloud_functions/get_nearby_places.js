// To avoid deployment errors, do not call admin.initializeApp() in your code
const { getFunctions, onCall } = require('firebase-functions/v2/https');
const axios = require('axios');


exports.getNearbyPlaces = functions.https.onCall(async (data, context) => {
  try {
    const { lat, lng } = data;
    if (!lat || !lng) {
      throw new functions.https.HttpsError('invalid-argument', 'Missing latitude or longitude');
    }

    const apiKey = 'YOUR_GOOGLE_PLACES_API_KEY'; // Replace with your actual API key

    const requestData = {
      maxResultCount: 10,
      rankPreference: "DISTANCE",
      locationRestriction: {
        circle: {
          center: { latitude: lat, longitude: lng },
          radius: 100.0
        }
      },
      // languageCode: "en"
    };

    const options = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': apiKey,
        'X-Goog-FieldMask': 'places.displayName', 'places.id'
      },
      data: requestData,
      url: 'https://places.googleapis.com/v1/places:searchNearby'
    };

    const response = await axios(options);
    const places = response.data; // Modify as needed based on the response structure

    return places;
  } catch (error) {
    console.error(error);
    throw new functions.https.HttpsError('unknown', 'An error occurred while fetching places');
  }
});