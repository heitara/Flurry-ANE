/*
 Air Native Extension for  Flurry analytics on iOS
 .................................................

 Author: Richard Lord
 Owner: Stick Sports Ltd.
 http://www.sticksports.com

 Copyright (c) 2011, Stick Sports Ltd.
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 - Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 - Redistributions in binary form must reproduce the above copyright notice, this
   list of conditions and the following disclaimer in the documentation and/or
   other materials provided with the distribution.
 - Neither the name of Stick Sports Ltd. nor the names of its contributors may be
   used to endorse or promote products derived from this software without specific
   prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
*/

#import "FlashRuntimeExtensions.h"
#import "FlurryAnalytics.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

DEFINE_ANE_FUNCTION( initNativeCode )
{
    return NULL;
}

DEFINE_ANE_FUNCTION( setAppVersion )
{
    uint32_t length = 0;
    uint8_t *value = NULL;
    if( FREGetObjectAsUTF8( argv[0], &length, &value ) == FRE_OK )
    {
        NSString* version = [NSString stringWithUTF8String: (char*) value];
        [FlurryAnalytics setAppVersion:version];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( getFlurryAgentVersion )
{
    NSString* version = [FlurryAnalytics getFlurryAgentVersion];
    FREObject result;
    if ( FRENewObjectFromUTF8( version.length, (unsigned char*) version.UTF8String, &result ) == FRE_OK )
    {
        return result;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setShowErrorInLog )
{
    uint32_t value = 0;
    if (FREGetObjectAsBool( argv[0], &value ) == FRE_OK )
    {
        if( value == 0 )
        {
            [FlurryAnalytics setShowErrorInLogEnabled:NO];
        }
        else
        {
            [FlurryAnalytics setShowErrorInLogEnabled:YES];
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setDebugLogEnabled )
{
    uint32_t value = 0;
    if (FREGetObjectAsBool( argv[0], &value ) == FRE_OK )
    {
        if( value == 0 )
        {
            [FlurryAnalytics setDebugLogEnabled:NO];
        }
        else
        {
            [FlurryAnalytics setDebugLogEnabled:YES];
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setSessionContinueSeconds )
{
    int32_t value = 0;
    if (FREGetObjectAsInt32( argv[0], &value ) == FRE_OK )
    {
        [FlurryAnalytics setSessionContinueSeconds:value];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setSecureTransportEnabled )
{
    uint32_t value = 0;
    if (FREGetObjectAsBool( argv[0], &value ) == FRE_OK )
    {
        if( value == 0 )
        {
            [FlurryAnalytics setSecureTransportEnabled:NO];
        }
        else
        {
            [FlurryAnalytics setSecureTransportEnabled:YES];
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( startSession )
{
    uint32_t length = 0;
    uint8_t *value = NULL;
    if( FREGetObjectAsUTF8( argv[0], &length, &value ) == FRE_OK )
    {
        NSString* sessionId = [NSString stringWithUTF8String: (char*) value];
        [FlurryAnalytics startSession:sessionId];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( logEvent )
{
    uint32_t length = 0;
    uint8_t *value = NULL;
    if( FREGetObjectAsUTF8( argv[0], &length, &value ) != FRE_OK ) return NULL;
    NSString* event = [NSString stringWithUTF8String: (char*) value];
    if( argc == 2 )
    {
        FREObject array = argv[1];
        uint32_t length = 0;
        if( FREGetArrayLength( array, &length ) != FRE_OK ) return NULL;
        uint32_t count = length >> 1;
        if( count > 0 )
        {
            NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithCapacity:count];
            uint32_t i;
            NSString* key;
            NSString* value;
            
            FREObject fo;
            uint8_t* foString = NULL;
            uint32_t foLength = 0;
            
            for( i = 0; i < count; ++i )
            {
                if( FREGetArrayElementAt( array, i * 2, &fo ) != FRE_OK ) continue;
                if( FREGetObjectAsUTF8( fo, &foLength, &foString ) != FRE_OK ) continue;
                key = [NSString stringWithUTF8String: (char*) foString];
                
                if( FREGetArrayElementAt( array, i * 2 + 1, &fo ) != FRE_OK ) continue;
                if( FREGetObjectAsUTF8( fo, &foLength, &foString ) != FRE_OK ) continue;
                value = [NSString stringWithUTF8String: (char*) foString];
                
                [parameters setValue:value forKey:key];
            }
            
            [FlurryAnalytics logEvent:event withParameters:parameters];
        }
        else
        {
            [FlurryAnalytics logEvent:event];
        }
    }
    else
    {
        [FlurryAnalytics logEvent:event];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( logError )
{
    uint32_t length = 0;
    uint8_t *value = NULL;
    
    if( FREGetObjectAsUTF8( argv[0], &length, &value ) != FRE_OK ) return NULL;
    NSString* id = [NSString stringWithUTF8String: (char*) value];

    if( FREGetObjectAsUTF8( argv[0], &length, &value ) != FRE_OK ) return NULL;
    NSString* message = [NSString stringWithUTF8String: (char*) value];
    
    [FlurryAnalytics logError:id message:message error:nil];
    return NULL;
}

DEFINE_ANE_FUNCTION( startTimedEvent )
{
    uint32_t length = 0;
    uint8_t *value = NULL;
    if( FREGetObjectAsUTF8( argv[0], &length, &value ) != FRE_OK ) return NULL;
    NSString* event = [NSString stringWithUTF8String: (char*) value];
    if( argc == 2 )
    {
        FREObject array = argv[1];
        uint32_t length = 0;
        if( FREGetArrayLength( array, &length ) != FRE_OK ) return NULL;
        uint32_t count = length >> 1;
        if( count > 0 )
        {
            NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithCapacity:count];
            uint32_t i;
            NSString* key;
            NSString* value;
            
            FREObject fo;
            uint8_t* foString;
            uint32_t foLength;
            
            for( i = 0; i < count; ++i )
            {
                if( FREGetArrayElementAt( array, i * 2, &fo ) != FRE_OK ) continue;
                if( FREGetObjectAsUTF8( fo, &foLength, &foString ) != FRE_OK ) continue;
                key = [NSString stringWithUTF8String: (char*) foString];
                
                if( FREGetArrayElementAt( array, i * 2 + 1, &fo ) != FRE_OK ) continue;
                if( FREGetObjectAsUTF8( fo, &foLength, &foString ) != FRE_OK ) continue;
                value = [NSString stringWithUTF8String: (char*) foString];
                
                [parameters setValue:value forKey:key];
            }
            
            [FlurryAnalytics logEvent:event withParameters:parameters timed:YES];
        }
        else
        {
            [FlurryAnalytics logEvent:event timed:YES];
        }
    }
    else
    {
        [FlurryAnalytics logEvent:event timed:YES];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( endTimedEvent )
{
    uint32_t length = 0;
    uint8_t *value = NULL;
    if( FREGetObjectAsUTF8( argv[0], &length, &value ) != FRE_OK ) return NULL;
    NSString* event = [NSString stringWithUTF8String: (char*) value];
    if( argc == 2 )
    {
        FREObject array = argv[1];
        uint32_t length = 0;
        if( FREGetArrayLength( array, &length ) != FRE_OK ) return NULL;
        uint32_t count = length >> 1;
        if( count > 0 )
        {
            NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithCapacity:count];
            uint32_t i;
            NSString* key;
            NSString* value;
            
            FREObject fo;
            uint8_t* foString;
            uint32_t foLength;
            
            for( i = 0; i < count; ++i )
            {
                if( FREGetArrayElementAt( array, i * 2, &fo ) != FRE_OK ) continue;
                if( FREGetObjectAsUTF8( fo, &foLength, &foString ) != FRE_OK ) continue;
                key = [NSString stringWithUTF8String: (char*) foString];
                
                if( FREGetArrayElementAt( array, i * 2 + 1, &fo ) != FRE_OK ) continue;
                if( FREGetObjectAsUTF8( fo, &foLength, &foString ) != FRE_OK ) continue;
                value = [NSString stringWithUTF8String: (char*) foString];
                
                [parameters setValue:value forKey:key];
            }
            
            [FlurryAnalytics endTimedEvent:event withParameters:parameters];
        }
        else
        {
            [FlurryAnalytics endTimedEvent:event withParameters:Nil];
        }
    }
    else
    {
        [FlurryAnalytics endTimedEvent:event withParameters:Nil];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setUserId )
{
    uint32_t length = 0;
    uint8_t *value = NULL;
    if( FREGetObjectAsUTF8( argv[0], &length, &value ) == FRE_OK )
    {
        NSString* userId = [NSString stringWithUTF8String: (char*) value];
        [FlurryAnalytics setUserID:userId];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setUserAge )
{
    int32_t value = 0;
    if (FREGetObjectAsInt32( argv[0], &value ) == FRE_OK )
    {
        [FlurryAnalytics setAge:value];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setUserGender )
{
    uint32_t length = 0;
    uint8_t *value = NULL;
    if( FREGetObjectAsUTF8( argv[0], &length, &value ) == FRE_OK )
    {
        NSString* userGender = [NSString stringWithUTF8String: (char*) value];
        [FlurryAnalytics setGender:userGender];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setLocation )
{
    // latitude : Number, longitude : Number, horizontalAccuracy : Number, verticalAccuracy : Number
    double latitude;
    double longitude;
    double horizontalAccuracy;
    double verticalAccuracy;
    
    if( FREGetObjectAsDouble( argv[0], &latitude ) != FRE_OK ) return NULL;
    if( FREGetObjectAsDouble( argv[1], &longitude ) != FRE_OK ) return NULL;
    if( FREGetObjectAsDouble( argv[2], &horizontalAccuracy ) != FRE_OK ) return NULL;
    if( FREGetObjectAsDouble( argv[3], &verticalAccuracy ) != FRE_OK ) return NULL;
        
    [FlurryAnalytics setLatitude:latitude longitude:longitude horizontalAccuracy:(float)horizontalAccuracy verticalAccuracy:(float)verticalAccuracy];
    return NULL;
}

DEFINE_ANE_FUNCTION( setSessionReportsOnClose )
{
    uint32_t value = 0;
    if (FREGetObjectAsBool( argv[0], &value ) == FRE_OK )
    {
        if( value == 0 )
        {
            [FlurryAnalytics setSessionReportsOnCloseEnabled:NO];
        }
        else
        {
            [FlurryAnalytics setSessionReportsOnCloseEnabled:YES];
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setSessionReportsOnPause )
{
    uint32_t value = 0;
    if (FREGetObjectAsBool( argv[0], &value ) == FRE_OK )
    {
        if( value == 0 )
        {
            [FlurryAnalytics setSessionReportsOnPauseEnabled:NO];
        }
        else
        {
            [FlurryAnalytics setSessionReportsOnPauseEnabled:YES];
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setEventLoggingEnabled )
{
    uint32_t value = 0;
    if (FREGetObjectAsBool( argv[0], &value ) == FRE_OK )
    {
        if( value == 0 )
        {
            [FlurryAnalytics setEventLoggingEnabled:NO];
        }
        else
        {
            [FlurryAnalytics setEventLoggingEnabled:YES];
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( logPageView )
{
    [FlurryAnalytics logPageView];
    return NULL;
}


void ContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
	*numFunctionsToSet = 20;
    
	FRENamedFunction* func = (FRENamedFunction*) malloc( sizeof(FRENamedFunction) * 20 );
    
	func[0].name = (const uint8_t*) "initNativeCode";
	func[0].functionData = NULL;
    func[0].function = &initNativeCode;
	
	func[1].name = (const uint8_t*) "setAppVersion";
	func[1].functionData = NULL;
	func[1].function = &setAppVersion;
	
	func[2].name = (const uint8_t*) "getFlurryAgentVersion";
	func[2].functionData = NULL;
	func[2].function = &getFlurryAgentVersion;
	
	func[3].name = (const uint8_t*) "setShowErrorInLog";
	func[3].functionData = NULL;
	func[3].function = &setShowErrorInLog;
	
	func[4].name = (const uint8_t*) "setDebugLogEnabled";
	func[4].functionData = NULL;
	func[4].function = &setDebugLogEnabled;
	
	func[5].name = (const uint8_t*) "setSessionContinueSeconds";
	func[5].functionData = NULL;
	func[5].function = &setSessionContinueSeconds;
	
	func[6].name = (const uint8_t*) "setSecureTransportEnabled";
	func[6].functionData = NULL;
	func[6].function = &setSecureTransportEnabled;
	
	func[7].name = (const uint8_t*) "startSession";
	func[7].functionData = NULL;
	func[7].function = &startSession;
	
	func[8].name = (const uint8_t*) "logEvent";
	func[8].functionData = NULL;
	func[8].function = &logEvent;
	
	func[9].name = (const uint8_t*) "logError";
	func[9].functionData = NULL;
	func[9].function = &logError;
	
	func[10].name = (const uint8_t*) "startTimedEvent";
	func[10].functionData = NULL;
	func[10].function = &startTimedEvent;
	
	func[11].name = (const uint8_t*) "endTimedEvent";
	func[11].functionData = NULL;
	func[11].function = &endTimedEvent;
	
	func[12].name = (const uint8_t*) "setUserId";
	func[12].functionData = NULL;
	func[12].function = &setUserId;
	
	func[13].name = (const uint8_t*) "setUserAge";
	func[13].functionData = NULL;
	func[13].function = &setUserAge;
	
	func[14].name = (const uint8_t*) "setUserGender";
	func[14].functionData = NULL;
	func[14].function = &setUserGender;
	
	func[15].name = (const uint8_t*) "setLocation";
	func[15].functionData = NULL;
	func[15].function = &setLocation;
	
	func[16].name = (const uint8_t*) "setSessionReportsOnClose";
	func[16].functionData = NULL;
	func[16].function = &setSessionReportsOnClose;
	
	func[17].name = (const uint8_t*) "setSessionReportsOnPause";
	func[17].functionData = NULL;
	func[17].function = &setSessionReportsOnPause;
	
	func[18].name = (const uint8_t*) "setEventLoggingEnabled";
	func[18].functionData = NULL;
	func[18].function = &setEventLoggingEnabled;
    
    func[19].name = (const uint8_t*) "logPageView";
	func[19].functionData = NULL;
	func[19].function = &logPageView;
	
	*functionsToSet = func;
}

void ContextFinalizer( FREContext ctx )
{
	return;
}

void ExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) 
{ 
    extDataToSet = NULL;  // This example does not use any extension data. 
    *ctxInitializerToSet = &ContextInitializer; 
    *ctxFinalizerToSet = &ContextFinalizer; 
}

void ExtensionFinalizer()
{
    return;
}
