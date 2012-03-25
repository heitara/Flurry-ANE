/**
 * Developed by Lancelotmobile Ltd. (c) 2012
 * http://www.lancelotmobile.com
 *
 * Copyright (c) 2012 Lancelotmobile.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 **/
package com.lancelotmobile.ane;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.lancelotmobile.ane.flurry.EndSession;
import com.lancelotmobile.ane.flurry.EndTimedEvent;
import com.lancelotmobile.ane.flurry.GetFlurryAgentVersion;
import com.lancelotmobile.ane.flurry.GetPhoneId;
import com.lancelotmobile.ane.flurry.LogError;
import com.lancelotmobile.ane.flurry.LogEvent;
import com.lancelotmobile.ane.flurry.LogPageView;
import com.lancelotmobile.ane.flurry.SetAppVersion;
import com.lancelotmobile.ane.flurry.SetEventLoggingEnabled;
import com.lancelotmobile.ane.flurry.SetReportLocation;
import com.lancelotmobile.ane.flurry.SetSecureTransportEnabled;
import com.lancelotmobile.ane.flurry.SetSessionContinueSeconds;
import com.lancelotmobile.ane.flurry.SetShowErrorInLog;
import com.lancelotmobile.ane.flurry.SetUserAge;
import com.lancelotmobile.ane.flurry.SetUserGender;
import com.lancelotmobile.ane.flurry.SetUserId;
import com.lancelotmobile.ane.flurry.StartSession;
import com.lancelotmobile.ane.flurry.StartTimedEvent;

public class FlurryContext extends FREContext {

	@Override
	public void dispose() {
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		functionMap.put("endSession", new EndSession());//ok
		functionMap.put("endTimedEvent", new EndTimedEvent());//ok
		functionMap.put("getFlurryAgentVersion", new GetFlurryAgentVersion());//ok
		functionMap.put("getPhoneId", new GetPhoneId());
		functionMap.put("logError", new LogError());//ok
		functionMap.put("logEvent", new LogEvent());//ok
		functionMap.put("logPageView", new LogPageView());//ok
		functionMap.put("setAppVersion", new SetAppVersion()); //ok
		functionMap.put("setEventLoggingEnabled", new SetEventLoggingEnabled());//ok
		functionMap.put("setReportLocation", new SetReportLocation());//ok
		functionMap.put("setSecureTransportEnabled", new SetSecureTransportEnabled());//ok
		functionMap.put("setSessionContinueSeconds", new SetSessionContinueSeconds());//ok
		functionMap.put("setShowErrorInLog", new SetShowErrorInLog());//ok
		functionMap.put("setUserAge", new SetUserAge());//ok
		functionMap.put("setUserId", new SetUserId());//ok
		functionMap.put("setUserGender", new SetUserGender());//ok
		functionMap.put("startSession", new StartSession());//ok
		functionMap.put("startTimedEvent", new StartTimedEvent());//ok
	    return functionMap;
	}

}
