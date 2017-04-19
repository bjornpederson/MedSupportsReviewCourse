﻿package testViewer{	import flash.events.Event;	import flash.events.EventDispatcher;	public class testModel extends EventDispatcher {		public static var XMLUPDATE:String = 'XMLUpdated';		public static var QUESTIONADD:String = 'questionadd';		public static var BARUPDATE:String = 'progressbarupdate';		public static var ANSWERS:String = 'answersdone';		public var _testXml:XML;		private var _testSection:int = 0;		private var keyArr:Array = [];		private var ansArr:Array = [];		public var answerSet:Array = [];		private var answerInfo:Array = [];		private var totalQuest:int = 0;		private var totalAnswers:int = 0;		private var questionNum:int = 0;		private var numSections:int = 0;		private var barpercentage:Number=0		private var percentageRight:Number=0		public function testModel() {			// constructor code		}		public function setXml(xml:XML):void {			_testXml = new XML(xml);			totalQuest = _testXml.question.length();			setAnswerArr();			//questionBuild();			dispatchEvent(new Event(testModel.XMLUPDATE));		}		private function setAnswerArr():void {			for (var j:int=0; j<totalQuest; j++)			{				keyArr[j] = _testXml.question[j]. @ answer;				ansArr[j] = 0;			}		}		public function questionBuild():void {			answerInfo = [];			answerSet = [];			totalAnswers = _testXml.question[questionNum].answer.length();			for (var i:int=0; i<totalAnswers; i++)			{				answerInfo = [i,_testXml.question[questionNum].answer[i]. @ text,_testXml.question[questionNum].answer[i]. @ choiceValue];				answerSet[i] = answerInfo;			}			dispatchEvent(new Event(testModel.QUESTIONADD));		}		public function answerCheck(i:int):void {			ansArr[questionNum] = i;			counting()			if (ansArr[questionNum] != keyArr[questionNum])			{				//correction function here			} else			{				//right answer function here			}			questionNum++			if (questionNum==ansArr.length){				calcCorrect()			}else{			questionBuild()			}		}		private function counting():void {			//trace("counting fired");			var countNumber:int = 0;			var quickStore:int = 0;			for (quickStore; quickStore<=ansArr.length-1; quickStore++)			{				//trace(quickStore)				if (ansArr[quickStore] > 0)				{					countNumber++;					//trace ("Count Number: "+countNumber)				}			}			barpercentage=(countNumber)/(quickStore+1)			//trace(barpercentage, countNumber, quickStore)			dispatchEvent(new Event(testModel.BARUPDATE));		}				public function traceout():Number{			return barpercentage		}				private function calcCorrect():void {			var countNumber:int = 0;			var quickStore:int = 0;			for (quickStore; quickStore<=ansArr.length-1; quickStore++)			{				//trace(quickStore)				if (ansArr[quickStore] == keyArr[quickStore])				{					countNumber++;					//trace ("Count Number: "+countNumber)				}			}			barpercentage=1			dispatchEvent(new Event(testModel.BARUPDATE));			percentageRight = (countNumber)/(quickStore+1)			dispatchEvent(new Event(testModel.ANSWERS));		}				public function testOut():String{			var s:String = "You scored: "+Math.round(percentageRight*100)+"%"			return s		}		public function numberQuestion():int {			return questionNum;		}	}}