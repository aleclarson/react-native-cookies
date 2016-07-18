
{ RNCookieManager } = require "NativeModules"

assertType = require "assertType"
Void = require "Void"

exports.get = (name) ->
  assertType name, String
  RNCookieManager.get name

exports.set = (name, value, expires) ->
  assertType name, String
  assertType value, String
  assertType expires, [ Number, Void ]
  expires = String expires
  RNCookieManager.set { name, value, expires }

exports.delete = (name) ->
  assertType name, String
  RNCookieManager.delete name
