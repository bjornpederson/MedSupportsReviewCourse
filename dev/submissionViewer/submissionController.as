﻿package submissionViewer{	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.MouseEvent;	import com.reflektii.db.dbxml;		public class submissionController extends EventDispatcher {		private var _model:Object;		public function submissionController(m:Object) {			// constructor code			_model = m;		}				public function setXml(xml:XML):void{			_model.setXml(xml)		}					}}