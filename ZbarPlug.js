// Copy this file to PhoneGap's /www/ folder (created by the PhoneGapLib.xcodeproj

var Barcode = {};

Barcode.read = function (callback) {
	PhoneGap.exec("ZbarPlug.showZbar", GetFunctionName(callback));
};


