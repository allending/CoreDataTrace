//------------------------------------------------------------------------------
//  Allen Ding 2011.
//  Public domain.
//------------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface TCMTraceLogger : NSObject

// Shared logger
+ (TCMTraceLogger *)sharedTraceLogger;

// Logging
- (void)pushContext;
- (void)popContext;
- (void)log:(NSString *)message;

@end

//------------------------------------------------------------------------------

// Macros for tracing
#ifndef TCM_TRACE_ENABLED
#define TCM_TRACE_ENABLED (DEBUG && !__clang_analyzer__)
#endif

#if TCM_TRACE_ENABLED
#define TCM_TRACE_BEGIN()   [[TCMTraceLogger sharedTraceLogger] log:[NSString stringWithUTF8String:__PRETTY_FUNCTION__]]; [[TCMTraceLogger sharedTraceLogger] pushContext]; @try {
#define TCM_TRACE(...)      [[TCMTraceLogger sharedTraceLogger] log:[NSString stringWithFormat:__VA_ARGS__]];
#define TCM_TRACE_END()     } @finally { [[TCMTraceLogger sharedTraceLogger] popContext]; }
#else
#define TCM_TRACE_BEGIN()
#define TCM_TRACE(message)
#define TCM_TRACE_END()
#endif
