var RNCookieManager, Typle, Void, assertType;

RNCookieManager = require("NativeModules").RNCookieManager;

assertType = require("assertType");

Typle = require("Typle");

Void = require("Void");

exports.get = function(name) {
  assertType(name, String);
  return RNCookieManager.get(name);
};

exports.set = function(name, value, maxAge) {
  assertType(name, String);
  assertType(value, String);
  assertType(maxAge, Typle([Number, Void]));
  if (maxAge !== void 0) {
    maxAge = String(maxAge);
  }
  return RNCookieManager.set({
    name: name,
    value: value,
    maxAge: maxAge
  });
};

exports["delete"] = function(name) {
  assertType(name, String);
  return RNCookieManager["delete"](name);
};

//# sourceMappingURL=map/index.map
