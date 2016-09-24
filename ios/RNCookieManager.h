
#import "RCTBridge.h"
#import "RCTBridgeModule.h"

@interface RNCookieManager : NSObject <RCTBridgeModule>

- (void)loadCookies;

@end

@interface RCTBridge (RNCookieManager)

@property (nonatomic, readonly) RNCookieManager *cookieManager;

@end
