﻿package module{	import flash.display.Sprite;	import buttonBuild.menuBuilder;	import mainAreaBuild.modulebg;	import moduleParts.*;	import flash.events.EventDispatcher;	import flash.events.Event;	import caurina.transitions.Tweener;	import caurina.transitions.properties.DisplayShortcuts;	import buttonBuild.subMenuBuilder2;	import textBuilder.textArea;	public class moduleView extends Sprite {		private var _model:Object;		private var _controller:Object;		private var moduleNumber:int;		private var menu:menuBuilder;		private var submenu:subMenuBuilder2;		private var viewXML:XML;		private var modbg:modulebg;		private var modHead:moduletitle;		private var modArea:Sprite;		private var issue:issueView;		private var buttonNum:int;		private var im:imageMain;		private var doc:docMain;		private var info:infoMain;		private var test:testMain;		private var reflection:reflectionMain;		private var submission:submissionMain;		private var imageXml:XML;		private var docsXml:XML;		private var infoXml:XML;		private var testXml:XML;		private var reflectionXml:XML;		private var submissionXml:XML;		private var descBox:descriptionBox;		private var probBox:textArea;		private var directionBox:textArea		public function moduleView(m:Object,c:Object,i:int) {			// constructor code			_model = m;			_controller = c;			moduleNumber = i;			DisplayShortcuts.init();			_model.addEventListener(moduleModel.XMLUPDATE,xmlupdate);			_model.addEventListener(moduleModel.MENUADD,menuadd);			_model.addEventListener(moduleModel.SUBMENUADD,submenuadd);			_model.addEventListener(moduleModel.STATECHANGE,closeDown);			_model.addEventListener(moduleModel.MAINMENUUPDATE,closeDownSubmenu);			_model.addEventListener(moduleModel.MAINMENUUPDATE,addModuleComp);			_model.addEventListener(moduleModel.SUBMENUUPDATE,addModuleComp);			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);			trace("added to Stage");		}		private function onAddedToStage(event:Event):void {			_controller.loadXml();			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);		}		private function xmlupdate(event:Event):void {			viewXML = new XML(_model.xml);			setmodArea();			setmodTitle();			addDirections();			_controller.buildMenu(stage.stageWidth,stage.stageHeight,1);			_controller.buildSubMenu(stage.stageWidth,stage.stageHeight,6);		}		private function menuadd(event:Event):void {			for (var i:int = 0; i < _model.fullMenu.length; i++)			{				menu = new menuBuilder(_model.fullMenu[i][0],i,_model.fullMenu.length,_model);				addChild(menu);				menu.name = "menu";				menu.x = _model.fullMenu[i][1];				menu.y = _model.fullMenu[i][2];				menu.addEventListener(menuBuilder.UPDATE,update);				menu.colorChange(_model.mainMenuArea);			}		}		private function submenuadd(event:Event):void {			for (var i:int = 0; i < _model.fullSubMenu.length; i++)			{				submenu = new subMenuBuilder2(_model.fullSubMenu[i][0],i,_model.fullSubMenu.length,_model);				addChild(submenu);				submenu.name = "submenu";				submenu.x = _model.fullSubMenu[i][1];				submenu.y = _model.fullSubMenu[i][2];				submenu.addEventListener(subMenuBuilder2.UPDATE,update);				trace("submenu active: " + _model.subMenuArea,i);				submenu.colorChange(_model.subMenuArea);			}			displayList();		}		private function setmodArea():void {			modArea = new Sprite  ;			addChild(modArea);			modArea.name = "modArea";			modArea.x = 10;			modArea.y = 125;			modbg = new modulebg(490,930);			modArea.addChild(modbg);			modbg.name = "modbg";		}		private function setmodTitle():void {			modHead = new moduletitle  ;			addChild(modHead);			modHead.name = "modHead";			modHead.x = 130;			modHead.y = 30;			modHead.modTitleText.text = viewXML.title;			modHead.modDescText.text = viewXML.statementofproblem;			//modHead.modDescText.wordWrap=true		}				private function addDirections():void{			trace (viewXML.submenu[1].intro)			directionBox = new textArea(viewXML.submenu[1].intro[0]);			modArea.addChild(directionBox);			directionBox.alpha = 0;			directionBox.name = "directionBox";			directionBox.y = .5 * modArea.height - .5 * directionBox.height;;			directionBox.x = .5 * modArea.width - .5 * directionBox.width;			Tweener.addTween(directionBox,{alpha:1,time:.3,transition:"easeOutQuad"});		}		private function addIssue():void {			trace(viewXML.submenu[1].area[0]);			issue = new issueView(modArea.width,modArea.height,viewXML.submenu[1].area[0]);			issue.name = "issue";			issue.alpha = 0;			modArea.addChild(issue);			Tweener.addTween(issue,{alpha:1,time:.3,transition:"easeOutQuad"});		}		private function displayList():void {			for (var u:int = numChildren-1; u >=0; u--)			{				trace("DisplayList: "+u,getChildAt(u).name);			}		}				private function moddisplayList():void {			for (var u:int = modArea.numChildren-1; u >=0; u--)			{				trace("Mod Area DisplayList: "+u, modArea.getChildAt(u).name);			}		}				public function blurStage():void {			var n:uint = this.numChildren - 1;			//Blurs out everything on the stage			for (var i:Number=0; i<=n; i++)			{				Tweener.addTween(				this.getChildAt(i),{				time:.2,				 _Blur_blurX:15,				 _Blur_blurY:15,				 transition:"easeOutQuad"				 });			}		}		public function clearViewStage():void {			var n:uint = this.numChildren - 1;			//Blurs out everything on the stage			for (var i:Number=0; i<=n; i++)			{				Tweener.addTween(				this.getChildAt(i),{				 time:.2,				 _Blur_blurX:0,				 _Blur_blurY:0,				 transition:"easeOutQuad"				 });			}		}		private function update(event:Event):void {			trace(event.target.name,event.target.buttonNum);			for (var u:int = modArea.numChildren - 1; u >= 1; u--)			{				trace(u,modArea.getChildAt(u).name,modArea.getChildAt(u).visible);				if (u > 1 && modbg.getChildAt(u).visible == true)				{					Tweener.addTween(modArea.getChildAt(u),{_autoAlpha:0,time:.3,transition:"easeOutQuad"});				} else if (u == 1 && modArea.getChildAt(1).visible == true)				{					Tweener.addTween(modArea.getChildAt(1),{_autoAlpha:0,time:.3,transition:"easeOutQuad",onComplete:controlClick,onCompleteParams:[event]});				} else if (u == 1 && modArea.getChildAt(1).visible == false)				{					controlClick(event);				}			}			//only until all pieces are developed			if (modArea.numChildren == 1)			{				controlClick(event);			}			trace("From module: " + event.target.name);		}		private function controlClick(event:Event):void {			for (var u:int = modArea.numChildren - 1; u >= 1; u--)			{				trace("Mod Area Change: "+modArea.getChildAt(u).name);				modArea.removeChildAt(u);				if (u == 1)				{					trace("Mod Area Last: "+modArea.numChildren, u);					_controller.menuEvent(event);				}			}			//only until all pieces are developed			if (modArea.numChildren == 1)			{				_controller.menuEvent(event);			}		}		private function closeDownSubmenu(event:Event):void {			var n:int = 1;			var t:int = numChildren;			for (var u:int = numChildren - 1; u >= 0; u--)			{				trace(u,getChildAt(u).name);				if (getChildAt(u).name == "submenu")				{					trace(n,_model.fullSubMenu.length);					getChildAt(u).removeEventListener(subMenuBuilder2.UPDATE,update);					n++;					if (n == _model.fullSubMenu.length)					{						Tweener.addTween(getChildAt(u),{_autoAlpha:0,time:.3,transition:"easeOutQuad", onComplete:removeSubMenu});					} else					{						Tweener.addTween(getChildAt(u),{_autoAlpha:0,time:.3,transition:"easeOutQuad"});					}				}/*else if (_model.fullSubMenu.length==0)				{				removeSubMenu();				}*/			}		}		private function removeSubMenu():void {			var n:int = numChildren - 1;			var t:int = numChildren;			do			{				if (getChildAt(n).name == "submenu")				{					removeChildAt(n);				}				n--;			} while (numChildren>(t-_model.fullSubMenu.length));			_controller.buildSubMenu(stage.stageWidth,stage.stageHeight,0);		}		private function addModuleComp(event:Event):void {			trace("New Sub Menu Area to be loaded: "+_model.subMenuArea+"\nMain Menu Area to be loaded: "+_model.mainMenuArea);			if (_model.mainMenuArea == 1)			{				if (viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]. @ name == "video")				{					addIssue();				}				if (viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]. @ name == "images")				{					imageXml = new XML(viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea].(@name=="images"));					setupIm();				}				if (viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]. @ name == "documents")				{					docsXml = new XML(viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea].(@name=="documents"));					setupDocs();				}				if (viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]. @ name == "problem")				{					setupProb();				}			}			if (_model.mainMenuArea == 2)			{				infoXml = new XML(viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]);				setupInfo();			}			if (_model.mainMenuArea == 3)			{				if (viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]. @ name == "test")				{					testXml = new XML(viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]);					setupTest();				}				if (viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]. @ name == "reflection")				{					reflectionXml = new XML(viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]);					setupReflection();				}				if (viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]. @ name == "your solution")				{					submissionXml = new XML(viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]);					setupSubmission();				}			}		}		private function closeDown(event:Event):void {			trace(event);			for (var u:int = numChildren - 1; u >= 0; u--)			{				Tweener.addTween(getChildAt(u),{_autoAlpha:0,time:.3,transition:"easeOutQuad"});				if (u == 0)				{					Tweener.addTween(getChildAt(u),{_autoAlpha:0,time:.3,transition:"easeOutQuad",onComplete:removePieces});				}			}		}		private function setupIm():void {			im = new imageMain(modbg.width,modbg.height,imageXml);			modArea.addChild(im);			im.name = "im";			im.alpha = 0;			Tweener.addTween(im,{alpha:1,time:.3,transition:"easeOutQuad"});		}		private function setupDocs():void {			doc = new docMain(modbg.width,modbg.height,docsXml);			modArea.addChild(doc);			doc.name = "doc";			doc.alpha = 0;			Tweener.addTween(doc,{alpha:1,time:.3,transition:"easeOutQuad"});		}		private function setupInfo():void {			info = new infoMain(modbg.width,modbg.height,infoXml);			modArea.addChild(info);			info.name = "info";			info.alpha = 0;			Tweener.addTween(info,{alpha:1,time:.3,transition:"easeOutQuad"});		}		private function setupProb() {			//trace(viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]);			probBox = new textArea(viewXML.submenu[_model.mainMenuArea].area[_model.subMenuArea]);			modArea.addChild(probBox);			probBox.alpha = 0;			probBox.name = "probBox";			probBox.y = .5 * modArea.height - .5 * probBox.height;;			probBox.x = .5 * modArea.width - .5 * probBox.width;			Tweener.addTween(probBox,{alpha:1,time:.3,transition:"easeOutQuad"});		}				private function setupTest():void {			test = new testMain(modbg.width, modbg.height, testXml)			modArea.addChild(test) 			test.name="test"			test.alpha=0			Tweener.addTween(test,{alpha:1,time:.3,transition:"easeOutQuad"});		}				private function setupReflection():void {			reflection = new reflectionMain(modbg.width, modbg.height, reflectionXml)			modArea.addChild(reflection) 			reflection.name="reflection"			reflection.alpha=0			Tweener.addTween(reflection,{alpha:1,time:.3,transition:"easeOutQuad"});		}		private function setupSubmission():void {			submission = new submissionMain(modbg.width, modbg.height, submissionXml)			modArea.addChild(submission) 			submission.name="submission"			submission.alpha=0			Tweener.addTween(submission,{alpha:1,time:.3,transition:"easeOutQuad"});		}		private function removePieces():void {			trace("firing removePieces");			_model.removeEventListener(moduleModel.XMLUPDATE,xmlupdate);			_model.removeEventListener(moduleModel.MENUADD,menuadd);			_model.removeEventListener(moduleModel.SUBMENUADD,submenuadd);			_model.removeEventListener(moduleModel.STATECHANGE,closeDown);			_model.removeEventListener(moduleModel.MAINMENUUPDATE,closeDownSubmenu);			var c:int = numChildren - 1;			trace(c);			displayList();			for (c; c >= 0; c--)			{				if (getChildAt(c).name == "menu")				{					getChildAt(c).removeEventListener(menuBuilder.UPDATE,update);				} else if (getChildAt(c).name == "submenu")				{					getChildAt(c).removeEventListener(subMenuBuilder2.UPDATE,update);					trace(getChildAt(c).name+" removes submenu listener");				} else if (c == 0)				{					removeChildAt(c);					trace("events removed");					_controller.removalComplete();				} else				{					removeChildAt(c);				}			}		}	}}