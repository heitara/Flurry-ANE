/*
 Air Native Extension for  Flurry analytics on iOS
 .................................................

 Author: Emil Atanasov
 Note: Updated version of orginal file, to prove
 a default implementation of this native android extension.
 http://www.lancelotmobile.com

 Copyright (c) 2012, Lancelotmobile Ltd.
 All rights reserved.
*/

package com.sticksports.nativeExtensions
{
	import flash.external.ExtensionContext;

	public class Flurry
	{
		public static const GENDER_MALE : String = "m";
		public static const GENDER_FEMALE : String = "f";
		
		private static var extensionContext : ExtensionContext = null;
		
		private static function initExtension():void
		{
			
		}
		
		/**
		 * Is the extension supported
		 */
		public static function get isSupported() : Boolean
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " isSupported: true");
			return true;
		}
		
		private static var _sessionStarted : Boolean;
		private static var _showErrorInLog : Boolean = false;
		private static var _debugLogEnabled : Boolean = false;
		private static var _sessionContinueSeconds : int = 10;
		private static var _secureTransportEnabled : Boolean = false;
		private static var _sessionReportsOnClose : Boolean = true;
		private static var _sessionReportsOnPause : Boolean = true;
		private static var _eventLoggingEnabled : Boolean = true;

		/**
		 * Override the app version. Should be called before start session.
		 */
		public static function setAppVersion( version : String ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setAppVersion: ", version);
		}
		
		/**
		 * The Flurry Agent version number. Should be called before start session.
		 */
		public static function get flurryAgentVersion() : String
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " get flurryAgentVersion: ");
			var version : String = "undefined";
			return version;
		}
		
		/**
		 * Should be called before start session. Default is false.
		 */
		public static function get showErrorInLog() : Boolean
		{
			return _showErrorInLog;
		}
		public static function set showErrorInLog( value : Boolean ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setShowErrorInLog");
			_showErrorInLog = false;
		}
		
		/**
		 * Generate debug logs for Flurry support. Should be called before start session. Default is false.
		 */
		public static function get debugLogEnabled() : Boolean
		{
			return _debugLogEnabled;
		}
		public static function set debugLogEnabled( value : Boolean ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setDebugLogEnabled: ", value);
			_debugLogEnabled = value;
		}
		
		/**
		 * Should be called before start session. Default is 10.
		 */
		public static function get sessionContinueSeconds() : int
		{
			return _sessionContinueSeconds;
		}
		public static function set sessionContinueSeconds( seconds : int ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setSessionContinueSeconds: ", seconds);
			_sessionContinueSeconds = seconds;

		}
		
		/**
		 * Set data to be sent over SSL. Should be called before start session. Default is false.
		 */
		public static function get secureTransportEnabled() : Boolean
		{
			return _secureTransportEnabled;
		}
		public static function set secureTransportEnabled( value : Boolean ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setSecureTransportEnabled: ", value);
			_secureTransportEnabled = value;

		}
		
		/**
		 * Start session, attempt to send saved sessions to the server.
		 */
		public static function startSession( id : String ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " startSession: ", id);
			_sessionStarted = true;
		}
		
		/**
		 * Log events.
		 */
		public static function logEvent( eventName : String, parameters : Object = null ) : void
		{
			if( parameters )
			{
				var array : Array = new Array();
				for( var key : String in parameters )
				{
					array.push( key );
					array.push( String( parameters[key] ) );
				}
				trace("[com.sticksports.nativeExtensions.Flurry]", " logEvent: ", eventName, array);
			}
			else
			{
				trace("[com.sticksports.nativeExtensions.Flurry]", " logEvent: ", eventName);
			}
		}
		
		/**
		 * Log errors.
		 */
		public static function logError( errorId : String, message : String ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " logError: ", errorId, message);
		}
		
		/**
		 * Log timed events.
		 */
		public static function startTimedEvent( eventName : String, parameters : Object = null ) : void
		{
			if( parameters )
			{
				var array : Array = new Array();
				for( var key : String in parameters )
				{
					array.push( key );
					array.push( parameters[key] as String );
				}
				trace("[com.sticksports.nativeExtensions.Flurry]", " startTimedEvent: ", eventName, array);
			}
			else
			{
				trace("[com.sticksports.nativeExtensions.Flurry]", " startTimedEvent: ", eventName);
			}
		}
		
		/**
		 * Log timed events. Non-null parameters will updater the event parameters.
		 */
		public static function endTimedEvent( eventName : String, parameters : Object = null ) : void
		{
			if( parameters )
			{
				var array : Array = new Array();
				for( var key : String in parameters )
				{
					array.push( key );
					array.push( parameters[key] as String );
				}
				trace("[com.sticksports.nativeExtensions.Flurry]", " endTimedEvent: ", eventName, array);
			}
			else
			{
				trace("[com.sticksports.nativeExtensions.Flurry]", " endTimedEvent: ", eventName);
			}
		}
		
		/**
		 * Set user's id in your system.
		 */
		public static function setUserId( id : String ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setUserId: ", id);
		}
		
		/**
		 * Set user's age in years
		 */
		public static function setUserAge( age : int ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setUserAge: ", age);
		}
		
		/**
		 * Set user's gender ("m" or "f")
		 */
		public static function setUserGender( gender : String ) : void
		{
			if( gender == GENDER_MALE || gender == GENDER_FEMALE )
			{
				trace("[com.sticksports.nativeExtensions.Flurry]", " setUserGender: ", gender);
			}
		}
		
		/**
		 * Set location information
		 */
		public static function setLocation( latitude : Number, longitude : Number, horizontalAccuracy : Number, verticalAccuracy : Number ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setLocation: ", latitude, longitude);
		}
		
		/**
		 * Disable location reporting infromaltion.
		 * Call it before startSession.
		 * Applicable only for android.
		 */
		public static function setReportLocation( disable:Boolean ) : void
		{
			if(!_sessionStarted)
			{
				trace("[com.sticksports.nativeExtensions.Flurry]", " setReportLocation: ", disable);
			}
		}
		
		
		/**
		 * Default is true.
		 */
		public static function get sessionReportsOnClose() : Boolean
		{
			return _sessionReportsOnClose;
		}
		public static function set sessionReportsOnClose( value : Boolean ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setSessionReportsOnClose: ", value);
			_sessionReportsOnClose = value;
		}
		
		/**
		 * Default is true.
		 */
		public static function get sessionReportsOnPause() : Boolean
		{
			return _sessionReportsOnPause;
		}
		public static function set sessionReportsOnPause( value : Boolean ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setSessionReportsOnPause: ", value);
			_sessionReportsOnPause = value;
		}
		
		/**
		 * Availbale only on android.
		 * Ends the session. If it's re-initiated in some time interval(less than 10s) then
		 * Flurry agetn thinks that this is the same session. 
		 */
		public static function endSession() : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " endSession: ");
		}
		
		/**
		 * Enable logging. Default is true.
		 */
		public static function get eventLoggingEnabled() : Boolean
		{
			return _eventLoggingEnabled;
		}
		public static function set eventLoggingEnabled( value : Boolean ) : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " setEventLoggingEnabled: ", value);
			_eventLoggingEnabled = value;
		}
		
		public static function logPageView() : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " logPageView ");
		}
		
		/**
		 * Clean up the extension - only if you no longer need it or want to free memory.
		 */
		public static function dispose() : void
		{
			trace("[com.sticksports.nativeExtensions.Flurry]", " dispose: ");
		}
	}
}

