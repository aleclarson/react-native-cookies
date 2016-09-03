
#import "RNCookieManager.h"

@implementation RNCookieManager
{
  NSMutableDictionary *_cookies;
}

- (instancetype)init
{
  if ((self = [super init])) {
    _cookies = [NSMutableDictionary new];

    [self loadCookies];
  }
  return self;
}

- (void)loadCookies
{
  NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
  for (NSHTTPCookie *cookie in storage.cookies) {
    _cookies[cookie.name] = cookie;
  }
}

RCT_EXPORT_MODULE(RNCookieManager);

RCT_EXPORT_METHOD(get:(NSString *)cookieName
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(__unused RCTPromiseRejectBlock)reject)
{
#if RCT_DEV
  NSLog(@"Getting cookie: %@", cookieName);
#endif
  NSHTTPCookie *cookie = _cookies[cookieName];
  if (cookie) {
    resolve(cookie.value);
  } else {
    resolve(nil);
  }
}

RCT_EXPORT_METHOD(set:(NSDictionary *)props
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(__unused RCTPromiseRejectBlock)reject)
{
  NSString *cookieName = props[@"name"];
  NSMutableDictionary *cookieProps = [NSMutableDictionary dictionaryWithDictionary:@{
    NSHTTPCookieName: cookieName,
    NSHTTPCookieValue: props[@"value"],
    NSHTTPCookieDomain: @".react-native.ios",
    NSHTTPCookiePath: @"/",
    NSHTTPCookieVersion: @"1",
  }];

  if (props[@"maxAge"]) {
    cookieProps[NSHTTPCookieMaximumAge] = props[@"maxAge"];
  }

  NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
  NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProps];
  [storage setCookie:_cookies[cookieName] = cookie];

#if RCT_DEV
  NSLog(@"Setting cookie: %@", cookieName);
#endif
  resolve(nil);
}

RCT_EXPORT_METHOD(delete:(NSString *)cookieName
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(__unused RCTPromiseRejectBlock)reject)
{
  NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
  NSHTTPCookie *cookie = _cookies[cookieName];
  if (cookie) {
    [_cookies removeObjectForKey:cookieName];
    [storage deleteCookie:cookie];
  }

  resolve(nil);
}

@end

@implementation RCTBridge (RNCookieManager)

- (RNCookieManager *)cookieManager
{
  return [self moduleForClass:[RNCookieManager class]];
}

@end
