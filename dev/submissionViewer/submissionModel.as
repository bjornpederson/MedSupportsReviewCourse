﻿package submissionViewer{	import flash.events.Event;	import flash.events.EventDispatcher;	public class submissionModel extends EventDispatcher {		public static var XMLUPDATE:String = 'XMLUpdated';		public var _submissionXml:XML;				public function submissionModel() {			// constructor code		}		public function setXml(xml:XML):void {			_submissionXml = new XML(xml);			dispatchEvent(new Event(submissionModel.XMLUPDATE));		}					}}