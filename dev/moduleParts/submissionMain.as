﻿package moduleParts{	import flash.display.MovieClip;	import flash.events.EventDispatcher;	import flash.events.Event;	import submissionViewer.*;	import caurina.transitions.Tweener;	public class submissionMain extends MovieClip {				private var model:submissionModel		private var view:submissionView		private var control:submissionController				private var submissionXml:XML		private var bgwidth:int;		private var bgheight:int;		public function submissionMain(i:int,v:int,xml:XML) {			// constructor code			bgwidth = i;			trace (1)			bgheight = v;			trace(2)			submissionXml = new XML(xml)			//trace(submissionXml.point.length())			addEventListener(Event.ADDED_TO_STAGE,addedtostage);		}		private function addedtostage(event:Event):void {			removeEventListener(Event.ADDED_TO_STAGE,addedtostage);			addEventListener(Event.REMOVED_FROM_STAGE,removedFromStage);			model= new submissionModel();			control = new submissionController(model);			view = new submissionView(model,control,submissionXml, bgwidth, bgheight);			addChild(view);					}		private function removedFromStage(event:Event):void {			removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStage);			removeChild(view) 			view=null		}	}}