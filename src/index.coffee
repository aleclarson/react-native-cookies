
{ RNCookieManager } = require "NativeModules"

assertType = require "assertType"
Typle = require "Typle"
Void = require "Void"

exports.get = (name) ->
  assertType name, String
  RNCookieManager.get name

exports.set = (name, value, maxAge) ->
  assertType name, String
  assertType value, String
  assertType maxAge, Typle [ Number, Void ]
  maxAge = String maxAge if maxAge isnt undefined
  RNCookieManager.set { name, value, maxAge }

exports.delete = (name) ->
  assertType name, String
  RNCookieManager.delete name
