const admin = require("firebase-admin/app");
admin.initializeApp();
    
const getNearbyPlaces = require('./get_nearby_places.js');
exports.getNearbyPlaces = getNearbyPlaces.getNearbyPlaces;
const credone = require('./credone.js');
exports.credone = credone.credone;