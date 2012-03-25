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
package com.lancelotmobile.ane.flurry;

import java.util.HashMap;

import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.flurry.android.FlurryAgent;

public class StartTimedEvent implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		FREObject eventIdObj = args[0];
		try {
			FREArray params = null;
			if(args.length > 1 && args[1] != null) {
				 params = (FREArray)args[1];
			}
			String eventId = eventIdObj.getAsString();
			if(params != null) {
				int length = (int) params.getLength() / 2; // key value pairs
				HashMap<String, String> map = new HashMap<String, String>();
				for(int i = 0 ; i < length; i++) {
					map.put(params.getObjectAt(i*2).getAsString(), params.getObjectAt(i * 2 + 1).getAsString());
				}
				FlurryAgent.logEvent(eventId, map, true);
			}
			else {
				FlurryAgent.logEvent(eventId, true);
			}
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (FRETypeMismatchException e) {
			e.printStackTrace();
		} catch (FREInvalidObjectException e) {
			e.printStackTrace();
		} catch (FREWrongThreadException e) {
			e.printStackTrace();
		}
		
		return null;
	}

}
