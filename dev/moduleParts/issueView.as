﻿package  moduleParts{	import flash.display.MovieClip;	import flash.events.EventDispatcher;	import flash.events.Event;	import videoPlay.videoMain	import caurina.transitions.Tweener;	import caurina.transitions.properties.DisplayShortcuts;		public class issueView extends MovieClip{		private var v:videoMain		private var bgwidth:int		private var bgheight:int		private var initVideo:String				public function issueView(i:int,v:int,s:String) {			// constructor code			bgwidth=i			bgheight=v			initVideo=s			addEventListener(Event.ADDED_TO_STAGE,addedtostage)		}		private function addedtostage(event:Event):void{			removeEventListener(Event.ADDED_TO_STAGE,addedtostage)			addEventListener(Event.REMOVED_FROM_STAGE,removedFromStage)			v=new videoMain(initVideo)			v.addEventListener(videoMain.SETUP,vidPlacement)			addChild(v)			v.alpha=0			v.name="v"					}				private function vidPlacement(event:Event):void{			trace(v.vpWidth(), v.vpHeight())			v.removeEventListener(videoMain.SETUP,vidPlacement)			v.x=(.5*bgwidth)-(.5*v.vpWidth()) 			v.y=(.5*bgheight)-(.5*v.vpHeight())			Tweener.addTween(v,{alpha:1,time:1,transition:"easeOutQuad"});		}		private function removedFromStage(event:Event):void{			v.closeDown()			v=null			removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStage)		}	}	}