var RNCookieManager, Void, assertType;

RNCookieManager = require("NativeModules").RNCookieManager;

assertType = require("assertType");

Void = require("Void");

exports.get = function(name) {
  assertType(name, String);
  return RNCookieManager.get(name);
};

exports.set = function(name, value, expires) {
  assertType(name, String);
  assertType(value, String);
  assertType(expires, [Number, Void]);
  expires = String(expires);
  return RNCookieManager.set({
    name: name,
    value: value,
    expires: expires
  });
};

exports["delete"] = function(name) {
  assertType(name, String);
  return RNCookieManager["delete"](name);
};

//# sourceMappingURL=map/index.map
