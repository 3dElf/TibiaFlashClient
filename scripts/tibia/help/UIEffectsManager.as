package tibia.help
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.effects.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.chat.chatWidgetClasses.*;
    import tibia.worldmap.*;
    import tibia.worldmap.widgetClasses.*;

    public class UIEffectsManager extends EventDispatcher
    {
        private var m_SequenceGlow:Sequence = null;
        private static const KEYWORD_MARGIN:uint = 8;
        private static var m_CreatedTextHints:Vector.<TextHint> = new Vector.<TextHint>;
        private static var m_CreatedMouseButtonHints:Vector.<MouseButtonHint> = new Vector.<MouseButtonHint>;
        private static var m_CreatedEffects:Vector.<EffectInstance> = new Vector.<EffectInstance>;
        private static const MOUSE_BUTTON_HINT_FULL_ALPHA:Number = 1;
        private static var m_CreatedArrowHints:Vector.<ArrowHint> = new Vector.<ArrowHint>;
        private static var m_CreatedGlowElements:Vector.<UIComponent> = new Vector.<UIComponent>;
        private static var m_CreatedEventListeners:Vector.<EventListenersInfo> = null;

        public function UIEffectsManager(param1:IEventDispatcher = null)
        {
            super(param1);
            this.initializeGlowSequence();
            m_CreatedEventListeners = new Vector.<EventListenersInfo>;
            return;
        }// end function

        public function highlightUIElementByCoordinate(param1:Vector3D, param2:Boolean = true) : void
        {
            var _loc_3:* = GUIRectangle.s_GetCoordinateInfo(param1);
            if ("coordinate" in _loc_3)
            {
                this.showMapEffect(param1);
            }
            else if ("identifier" in _loc_3)
            {
                this.higlightUIElementByIdentifier(_loc_3["identifier"] as Class, _loc_3["subIdentifier"], param2);
            }
            return;
        }// end function

        public function showKeywordEffect(param1:String) : void
        {
            var _GUIRectangle:GUIRectangle;
            var _Rectangle:Rectangle;
            var NewRectangle:Rectangle;
            var GlowElement:UIComponent;
            var ArrowPosition:Point;
            var _ArrowHint:ArrowHint;
            var _UIComponent:UIComponent;
            var _EventListenerInfo:EventListenersInfo;
            var a_Keyword:* = param1;
            _GUIRectangle = GUIRectangle.s_FromKeyword(a_Keyword);
            if (_GUIRectangle.rectangle != null)
            {
                _Rectangle = _GUIRectangle.rectangle;
                NewRectangle = new Rectangle(_Rectangle.x - KEYWORD_MARGIN, _Rectangle.y - KEYWORD_MARGIN, _Rectangle.width + 2 * KEYWORD_MARGIN, _Rectangle.height + 2 * KEYWORD_MARGIN);
                GlowElement = this.createGlowingRectangle(NewRectangle, NewRectangle.height - KEYWORD_MARGIN);
                ArrowPosition;
                ArrowPosition = _GUIRectangle.rectangle.bottomRight.clone();
                ArrowPosition.y = ArrowPosition.y - _GUIRectangle.rectangle.height / 2;
                ArrowPosition.x = ArrowPosition.x + KEYWORD_MARGIN;
                _ArrowHint = this.showArrowEffect(ArrowPosition);
                _UIComponent = this.findUIElementByIdentifier(ChannelMessageRenderer, a_Keyword).parent as UIComponent;
                _EventListenerInfo = new EventListenersInfo();
                _EventListenerInfo.m_EventDispatcher = Tibia.s_GetSecondaryTimer();
                _EventListenerInfo.m_EventName = TimerEvent.TIMER;
                _EventListenerInfo.m_EventFunction = function () : void
            {
                _GUIRectangle.refresh();
                if (_GUIRectangle.rectangle != null)
                {
                    ArrowPosition = _GUIRectangle.rectangle.bottomRight.clone();
                    ArrowPosition.y = ArrowPosition.y - _GUIRectangle.rectangle.height / 2;
                    ArrowPosition.x = ArrowPosition.x + KEYWORD_MARGIN;
                    _ArrowHint.updateArrowPosition(ArrowPosition);
                    GlowElement.x = _GUIRectangle.rectangle.x - KEYWORD_MARGIN;
                    GlowElement.y = _GUIRectangle.rectangle.y - KEYWORD_MARGIN;
                }
                return;
            }// end function
            ;
                _EventListenerInfo.attach();
                m_CreatedEventListeners.push(_EventListenerInfo);
            }
            return;
        }// end function

        public function addUIComponentGlowEffect(param1:UIComponent, param2:Boolean = true, param3:Boolean = false) : void
        {
            (this.m_SequenceGlow.children[0] as Glow).inner = param2;
            (this.m_SequenceGlow.children[1] as Glow).inner = param2;
            (this.m_SequenceGlow.children[0] as Glow).knockout = param3;
            (this.m_SequenceGlow.children[1] as Glow).knockout = param3;
            this.m_SequenceGlow.targets.push(param1);
            if (this.m_SequenceGlow.isPlaying)
            {
                this.m_SequenceGlow.end();
            }
            this.m_SequenceGlow.play();
            return;
        }// end function

        public function removeUIComponentGlowEffect(param1:UIComponent) : void
        {
            var _loc_2:* = 0;
            if (this.m_SequenceGlow != null)
            {
                _loc_2 = this.m_SequenceGlow.targets.indexOf(param1);
                if (_loc_2 > -1)
                {
                    this.m_SequenceGlow.targets.splice(_loc_2, 1);
                    if (this.m_SequenceGlow.isPlaying)
                    {
                        this.m_SequenceGlow.end();
                        if (this.m_SequenceGlow.targets.length > 0)
                        {
                            this.m_SequenceGlow.play();
                        }
                    }
                }
            }
            return;
        }// end function

        public function findUIElementByIdentifier(param1:Class, param2) : UIComponent
        {
            var _loc_3:* = new UIEffectsRetrieveComponentCommandEvent(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT);
            _loc_3.identifier = param1;
            _loc_3.subIdentifier = param2;
            dispatchEvent(_loc_3);
            return _loc_3.resultUIComponent;
        }// end function

        public function showMapEffect(param1:Vector3D) : void
        {
            var MapCoordinate:Vector3D;
            var a_AbsolutePosition:* = param1;
            var _WorldMapStorage:* = Tibia.s_GetWorldMapStorage();
            var _EffectInstance:EffectInstance;
            try
            {
                _EffectInstance = Tibia.s_GetAppearanceStorage().createEffectInstance(56);
                _EffectInstance.setEndless();
                m_CreatedEffects.push(_EffectInstance);
                MapCoordinate = _WorldMapStorage.toMap(a_AbsolutePosition);
                _WorldMapStorage.appendEffect(a_AbsolutePosition.x, a_AbsolutePosition.y, a_AbsolutePosition.z, _EffectInstance);
                _EffectInstance = Tibia.s_GetAppearanceStorage().createEffectInstance(57);
                _EffectInstance.setEndless();
                m_CreatedEffects.push(_EffectInstance);
                _WorldMapStorage.appendEffect(a_AbsolutePosition.x, a_AbsolutePosition.y, a_AbsolutePosition.z, _EffectInstance);
            }
            catch (e:Error)
            {
                throw new Error("UIEffectsManager.showMapEffect: Failed to add map effect at " + a_AbsolutePosition.toString());
            }
            return;
        }// end function

        public function showDragDropEffect(param1:Vector3D, param2:Vector3D) : void
        {
            var SourceGUIRectangle:GUIRectangle;
            var DestinationGUIRectangle:GUIRectangle;
            var _MouseButtonHint:MouseButtonHint;
            var _Sequence:Sequence;
            var _EventListenerInfo:EventListenersInfo;
            var a_SourcePosition:* = param1;
            var a_DestinationPosition:* = param2;
            var _Renderer:* = this.findUIElementByIdentifier(WorldMapWidget, RendererImpl) as RendererImpl;
            SourceGUIRectangle = GUIRectangle.s_FromCoordinate(a_SourcePosition);
            DestinationGUIRectangle = GUIRectangle.s_FromCoordinate(a_DestinationPosition);
            if (SourceGUIRectangle.rectangle != null && DestinationGUIRectangle.rectangle != null)
            {
                this.highlightUIElementByCoordinate(a_SourcePosition);
                this.highlightUIElementByCoordinate(a_DestinationPosition);
                _MouseButtonHint = new MouseButtonHint();
                _MouseButtonHint.alpha = 1;
                _MouseButtonHint.visible = true;
                _MouseButtonHint.phase = 0;
                _Sequence = new Sequence();
                _MouseButtonHint.x = 200;
                _MouseButtonHint.y = 200;
                _MouseButtonHint.visible = true;
                _MouseButtonHint.addMousePhaseChange(MouseButtonHint.DEFAULT_NO_MOUSE_BUTTON);
                _MouseButtonHint.addMove(SourceGUIRectangle.centerPoint, SourceGUIRectangle.centerPoint, 0);
                _MouseButtonHint.addFadeIn(MOUSE_BUTTON_HINT_FULL_ALPHA);
                _MouseButtonHint.addPause();
                _MouseButtonHint.addMousePhaseChange(MouseButtonHint.CROSSHAIR_LEFT_MOUSE_BUTTON);
                _MouseButtonHint.addHintTextChange("Drag", 500);
                _MouseButtonHint.addPause();
                _MouseButtonHint.addMove(SourceGUIRectangle.centerPoint, DestinationGUIRectangle.centerPoint, 1000);
                _MouseButtonHint.addPause(200);
                _MouseButtonHint.addHintTextChange("Drop", 500, true);
                _MouseButtonHint.addPause();
                _MouseButtonHint.addMousePhaseChange(MouseButtonHint.DEFAULT_NO_MOUSE_BUTTON);
                _MouseButtonHint.addPause();
                _MouseButtonHint.addHintTextChange(null, 200);
                _MouseButtonHint.addFadeOut(MOUSE_BUTTON_HINT_FULL_ALPHA);
                _MouseButtonHint.repeatCount = int.MAX_VALUE;
                _EventListenerInfo = new EventListenersInfo();
                _EventListenerInfo.m_EventDispatcher = Tibia.s_GetSecondaryTimer();
                _EventListenerInfo.m_EventName = TimerEvent.TIMER;
                _EventListenerInfo.m_EventFunction = function () : void
            {
                SourceGUIRectangle.refresh();
                DestinationGUIRectangle.refresh();
                _MouseButtonHint.updateMoveEffect(SourceGUIRectangle.centerPoint, SourceGUIRectangle.centerPoint, 0);
                _MouseButtonHint.updateMoveEffect(SourceGUIRectangle.centerPoint, DestinationGUIRectangle.centerPoint, 1);
                return;
            }// end function
            ;
                _EventListenerInfo.attach();
                _MouseButtonHint.show();
                _MouseButtonHint.play();
                m_CreatedMouseButtonHints.push(_MouseButtonHint);
                m_CreatedEventListeners.push(_EventListenerInfo);
            }
            return;
        }// end function

        private function calculateTextHintBasePosition(param1:Rectangle, param2:Vector3D) : Point
        {
            var _loc_3:* = param1.topLeft.clone();
            switch(param2.z)
            {
                case 1:
                {
                    _loc_3.offset(param1.width, 0);
                    break;
                }
                case 2:
                {
                    _loc_3.offset(param1.width, param1.height);
                    break;
                }
                case 3:
                {
                    _loc_3.offset(0, param1.height);
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_3.offset(param2.x, param2.y);
            return _loc_3;
        }// end function

        public function clearEffects() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            while (m_CreatedEventListeners.length > 0)
            {
                
                _loc_1 = m_CreatedEventListeners.pop();
                _loc_1.detach();
            }
            if (this.m_SequenceGlow != null)
            {
                this.m_SequenceGlow.end();
                this.m_SequenceGlow.targets.length = 0;
            }
            while (m_CreatedEffects.length > 0)
            {
                
                _loc_2 = m_CreatedEffects.pop();
                _loc_2.end();
            }
            while (m_CreatedMouseButtonHints.length > 0)
            {
                
                _loc_3 = m_CreatedMouseButtonHints.pop();
                _loc_3.end();
                _loc_3.hide();
            }
            while (m_CreatedArrowHints.length > 0)
            {
                
                _loc_4 = m_CreatedArrowHints.pop();
                _loc_4.hide();
            }
            while (m_CreatedGlowElements.length > 0)
            {
                
                _loc_5 = m_CreatedGlowElements.pop();
                TransparentHintLayer.getInstance().removeChild(_loc_5);
            }
            while (m_CreatedTextHints.length > 0)
            {
                
                _loc_6 = m_CreatedTextHints.pop();
                _loc_6.hide();
            }
            return;
        }// end function

        public function createGlowingRectangle(param1:Rectangle, param2:uint = 0) : UIComponent
        {
            var _loc_3:* = new UIComponent();
            TransparentHintLayer.getInstance().addChild(_loc_3);
            _loc_3.x = param1.x;
            _loc_3.y = param1.y;
            _loc_3.width = param1.width;
            _loc_3.height = param1.height;
            _loc_3.graphics.lineStyle(3, 16711680, 0.6);
            if (param2 > 0)
            {
                _loc_3.graphics.drawRoundRect(0, 0, _loc_3.width, _loc_3.height, param2, param2);
            }
            else
            {
                _loc_3.graphics.drawRect(0, 0, _loc_3.width, _loc_3.height);
            }
            this.addUIComponentGlowEffect(_loc_3, false, false);
            TransparentHintLayer.getInstance().addChild(_loc_3);
            m_CreatedGlowElements.push(_loc_3);
            return _loc_3;
        }// end function

        public function showTextHint(param1:String, param2:GUIRectangle, param3:Vector3D) : TextHint
        {
            var _TextHint:TextHint;
            var TextHintPosition:Point;
            var a_Text:* = param1;
            var a_GUIRectangle:* = param2;
            var a_Offset:* = param3;
            _TextHint;
            if (a_GUIRectangle.rectangle != null)
            {
                TextHintPosition = this.calculateTextHintBasePosition(a_GUIRectangle.rectangle, a_Offset);
                _TextHint = new TextHint(TextHintPosition);
                _TextHint.hintText = a_Text;
                _TextHint.show();
                m_CreatedTextHints.push(_TextHint);
            }
            var _EventListenerInfo:* = new EventListenersInfo();
            _EventListenerInfo.m_EventDispatcher = Tibia.s_GetSecondaryTimer();
            _EventListenerInfo.m_EventName = TimerEvent.TIMER;
            _EventListenerInfo.m_EventFunction = function () : void
            {
                var _loc_1:* = null;
                a_GUIRectangle.refresh();
                if (a_GUIRectangle.rectangle != null)
                {
                    _loc_1 = calculateTextHintBasePosition(a_GUIRectangle.rectangle, a_Offset);
                    _TextHint.updateTextPosition(_loc_1);
                }
                return;
            }// end function
            ;
            _EventListenerInfo.attach();
            m_CreatedEventListeners.push(_EventListenerInfo);
            return _TextHint;
        }// end function

        public function showUseEffect(param1:Vector3D, param2:Vector3D) : void
        {
            var SourceGUIRectangle:GUIRectangle;
            var DestinationGUIRectangle:GUIRectangle;
            var _MouseButtonHint:MouseButtonHint;
            var ArrowPosition:Point;
            var _ArrowHint:ArrowHint;
            var a_Coordinate:* = param1;
            var a_MultiUseTarget:* = param2;
            var _Renderer:* = this.findUIElementByIdentifier(WorldMapWidget, RendererImpl) as RendererImpl;
            SourceGUIRectangle = GUIRectangle.s_FromCoordinate(a_Coordinate);
            DestinationGUIRectangle = GUIRectangle.s_FromCoordinate(a_MultiUseTarget);
            this.highlightUIElementByCoordinate(a_Coordinate);
            var _EventListenerInfo:EventListenersInfo;
            if (SourceGUIRectangle.rectangle != null && DestinationGUIRectangle.rectangle != null)
            {
                this.highlightUIElementByCoordinate(a_MultiUseTarget);
                _MouseButtonHint = new MouseButtonHint();
                _MouseButtonHint.alpha = 1;
                _MouseButtonHint.visible = true;
                _MouseButtonHint.phase = 0;
                _MouseButtonHint.addMousePhaseChange(MouseButtonHint.DEFAULT_NO_MOUSE_BUTTON);
                _MouseButtonHint.addMove(SourceGUIRectangle.centerPoint, SourceGUIRectangle.centerPoint, 0);
                _MouseButtonHint.addFadeIn(MOUSE_BUTTON_HINT_FULL_ALPHA);
                _MouseButtonHint.addHintTextChange("1st Click", 500);
                _MouseButtonHint.addMousePhaseChange(MouseButtonHint.DEFAULT_LEFT_MOUSE_BUTTON);
                _MouseButtonHint.addPause();
                _MouseButtonHint.addMousePhaseChange(MouseButtonHint.CROSSHAIR_NO_MOUSE_BUTTON);
                _MouseButtonHint.addPause();
                _MouseButtonHint.addFadeOut(MOUSE_BUTTON_HINT_FULL_ALPHA);
                _MouseButtonHint.addHintTextChange(null);
                _MouseButtonHint.addMove(DestinationGUIRectangle.centerPoint, DestinationGUIRectangle.centerPoint, 0);
                _MouseButtonHint.addFadeIn(MOUSE_BUTTON_HINT_FULL_ALPHA);
                _MouseButtonHint.addMousePhaseChange(MouseButtonHint.CROSSHAIR_NO_MOUSE_BUTTON);
                _MouseButtonHint.addHintTextChange("2nd Click", 500);
                _MouseButtonHint.addMousePhaseChange(MouseButtonHint.CROSSHAIR_LEFT_MOUSE_BUTTON);
                _MouseButtonHint.addPause();
                _MouseButtonHint.addMousePhaseChange(MouseButtonHint.DEFAULT_NO_MOUSE_BUTTON);
                _MouseButtonHint.addPause();
                _MouseButtonHint.addFadeOut(MOUSE_BUTTON_HINT_FULL_ALPHA);
                _MouseButtonHint.addHintTextChange(null);
                _MouseButtonHint.repeatCount = int.MAX_VALUE;
                _EventListenerInfo = new EventListenersInfo();
                _EventListenerInfo.m_EventDispatcher = Tibia.s_GetSecondaryTimer();
                _EventListenerInfo.m_EventName = TimerEvent.TIMER;
                _EventListenerInfo.m_EventFunction = function () : void
            {
                SourceGUIRectangle.refresh();
                DestinationGUIRectangle.refresh();
                _MouseButtonHint.updateMoveEffect(SourceGUIRectangle.centerPoint, SourceGUIRectangle.centerPoint, 0);
                _MouseButtonHint.updateMoveEffect(DestinationGUIRectangle.centerPoint, DestinationGUIRectangle.centerPoint, 1);
                return;
            }// end function
            ;
                _EventListenerInfo.attach();
                _MouseButtonHint.show();
                _MouseButtonHint.play();
                m_CreatedMouseButtonHints.push(_MouseButtonHint);
                m_CreatedEventListeners.push(_EventListenerInfo);
            }
            else if (SourceGUIRectangle.rectangle != null && GUIRectangle.s_IsMapCoordinate(a_Coordinate) == false)
            {
                ArrowPosition = SourceGUIRectangle.rectangle.bottomRight.clone();
                ArrowPosition.y = ArrowPosition.y - SourceGUIRectangle.rectangle.height / 2;
                _ArrowHint = this.showArrowEffect(ArrowPosition);
                _EventListenerInfo = new EventListenersInfo();
                _EventListenerInfo.m_EventDispatcher = Tibia.s_GetSecondaryTimer();
                _EventListenerInfo.m_EventName = TimerEvent.TIMER;
                _EventListenerInfo.m_EventFunction = function () : void
            {
                SourceGUIRectangle.refresh();
                var _loc_1:* = SourceGUIRectangle.rectangle.bottomRight.clone();
                _loc_1.y = _loc_1.y - SourceGUIRectangle.rectangle.height / 2;
                _ArrowHint.updateArrowPosition(_loc_1);
                return;
            }// end function
            ;
                _EventListenerInfo.attach();
                m_CreatedEventListeners.push(_EventListenerInfo);
            }
            return;
        }// end function

        public function showArrowEffect(param1:Point) : ArrowHint
        {
            var _loc_2:* = null;
            if (param1 != null)
            {
                _loc_2 = new ArrowHint(param1);
                _loc_2.show();
                m_CreatedArrowHints.push(_loc_2);
                return _loc_2;
            }
            return null;
        }// end function

        private function initializeGlowSequence() : void
        {
            var _loc_1:* = new Glow();
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 0.7;
            _loc_1.color = 16711680;
            _loc_1.blurXFrom = 8;
            _loc_1.blurXTo = 16;
            _loc_1.blurYFrom = 8;
            _loc_1.blurYTo = 16;
            _loc_1.strength = 4;
            _loc_1.duration = 1000;
            _loc_1.inner = true;
            var _loc_2:* = new Glow();
            _loc_2.alphaFrom = 0.7;
            _loc_2.alphaTo = 0;
            _loc_2.color = 16711680;
            _loc_2.blurXFrom = 16;
            _loc_2.blurXTo = 8;
            _loc_2.blurYFrom = 16;
            _loc_2.blurYTo = 8;
            _loc_2.strength = 4;
            _loc_2.duration = 1000;
            _loc_2.inner = true;
            this.m_SequenceGlow = new Sequence();
            this.m_SequenceGlow.addChild(_loc_1);
            this.m_SequenceGlow.addChild(_loc_2);
            this.m_SequenceGlow.repeatCount = int.MAX_VALUE;
            return;
        }// end function

        public function higlightUIElementByIdentifier(param1:Class, param2, param3:Boolean = true) : void
        {
            var _loc_4:* = null;
            if (param1 == null)
            {
                this.clearEffects();
            }
            else
            {
                _loc_4 = this.findUIElementByIdentifier(param1, param2);
                if (_loc_4 != null)
                {
                    this.addUIComponentGlowEffect(_loc_4, param3);
                }
            }
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.events.*;

import flash.geom.*;

import mx.core.*;

import mx.effects.*;

import shared.utility.*;

import tibia.appearances.*;

import tibia.chat.chatWidgetClasses.*;

import tibia.worldmap.*;

import tibia.worldmap.widgetClasses.*;

class EventListenersInfo extends Object
{
    public var m_EventFunction:Function = null;
    public var m_EventName:String = null;
    public var m_EventDispatcher:EventDispatcher = null;

    function EventListenersInfo()
    {
        return;
    }// end function

    public function attach() : void
    {
        this.m_EventDispatcher.addEventListener(this.m_EventName, this.m_EventFunction);
        return;
    }// end function

    public function detach() : void
    {
        this.m_EventDispatcher.removeEventListener(this.m_EventName, this.m_EventFunction);
        return;
    }// end function

}

