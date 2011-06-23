//------------------------------------------------------------------------------
//  Allen Ding 2011.
//  Public domain.
//------------------------------------------------------------------------------

#import "TCMTrace.h"

@interface TCMTraceLogger()

// Indent level
@property (nonatomic) NSUInteger indentLevel;

@end

//------------------------------------------------------------------------------

@implementation TCMTraceLogger

@synthesize indentLevel = indentLevel_;

#pragma mark -
#pragma mark Shared logger

+ (TCMTraceLogger *)sharedTraceLogger {
    static TCMTraceLogger *sharedTraceLogger = nil;
    
    if (sharedTraceLogger == nil) {
        sharedTraceLogger = [[self alloc] init];
    }
    
    return sharedTraceLogger;
}

#pragma mark -
#pragma mark Logging

- (void)pushContext {
    self.indentLevel = self.indentLevel + 1;
}


- (void)popContext {
    self.indentLevel = self.indentLevel - 1;
}


- (void)log:(NSString *)message {
    if (message == nil) {
        return;
    }
    
    // Build a prefix for the message.
    size_t bufferSize = self.indentLevel * 4 + 1;
    char *indentBuffer = (char *)malloc(bufferSize);
    memset(indentBuffer, ' ', bufferSize);
    indentBuffer[bufferSize - 1] = '\0';
    NSLog(@"%s%@\n", indentBuffer, message);
    free(indentBuffer);
}

@end
