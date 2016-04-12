package tibia.sessiondump.controller
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.managers.*;
    import tibia.cursors.*;
    import tibia.game.*;
    import tibia.help.*;

    public class SessiondumpMouseShield extends Container
    {
        private var m_UIEmbeddedMouseShield:UIComponent = null;
        private var m_FadeSequence:Sequence;
        private var m_MouseShieldRegion:Rectangle;
        private var m_IsShown:Boolean = false;
        private var m_CursorHelper:CursorHelper;
        private var m_FadeAnimationRequested:Boolean = false;
        private var m_FullyTransparent:Boolean = false;
        private var m_MouseShieldHoles:Vector.<GUIRectangle>;
        private var m_CaptureMouse:Boolean = true;
        private var m_ShowHintLabel:Boolean = true;
        private static var s_Instance:SessiondumpMouseShield = null;
        private static const BUNDLE:String = "Global";

        public function SessiondumpMouseShield()
        {
            this.m_MouseShieldRegion = new Rectangle();
            this.m_MouseShieldHoles = new Vector.<GUIRectangle>;
            this.m_FadeSequence = new Sequence();
            this.m_CursorHelper = new CursorHelper(CursorManagerPriority.MEDIUM);
            mouseChildren = false;
            return;
        }// end function

        public function hide(param1:Boolean = true) : void
        {
            var _loc_2:* = null;
            if (this.captureMouse && param1)
            {
                setTimeout(this.hide, 50, false);
            }
            else if (this.m_IsShown)
            {
                _loc_2 = Tibia.s_GetInstance().systemManager;
                _loc_2.removeEventListener(Event.RESIZE, this.onResize);
                this.setMouseCapture(false);
                _loc_2.popUpChildren.removeChild(this);
                this.m_CursorHelper.resetCursor();
                Tibia.s_GetInstance().m_UITibiaRootContainer.removeEventListener(Event.RESIZE, this.onResize);
                Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER, this.onTimer);
                Tibia.s_GetInstance().removeEventListener(Event.ACTIVATE, this.onActiveChanged);
                Tibia.s_GetInstance().removeEventListener(Event.DEACTIVATE, this.onActiveChanged);
                this.m_IsShown = false;
                if (Tibia.s_GetInputHandler() != null)
                {
                    Tibia.s_GetInputHandler().captureKeyboard = true;
                }
                if (PopUpBase.getCurrent() != null)
                {
                    PopUpBase.getCurrent().setFocus();
                    PopUpBase.getCurrent().drawFocus(false);
                }
            }
            return;
        }// end function

        public function set captureMouse(param1:Boolean) : void
        {
            this.m_CaptureMouse = param1;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _GUIRectangle:*;
            var a_UnscaledWidth:* = param1;
            var a_UnscaledHeight:* = param2;
            super.updateDisplayList(a_UnscaledWidth, a_UnscaledHeight);
            this.m_UIEmbeddedMouseShield.x = 0;
            this.m_UIEmbeddedMouseShield.y = 0;
            var _loc_4:* = this.m_UIEmbeddedMouseShield.graphics;
            with (this.m_UIEmbeddedMouseShield.graphics)
            {
                clear();
                beginFill(0, 1);
                drawRect(0, 0, a_UnscaledWidth, a_UnscaledHeight);
                var _loc_5:* = 0;
                var _loc_6:* = m_MouseShieldHoles;
                while (_loc_6 in _loc_5)
                {
                    
                    _GUIRectangle = _loc_6[_loc_5];
                    if (_GUIRectangle.rectangle != null)
                    {
                        drawRect(_GUIRectangle.rectangle.x, _GUIRectangle.rectangle.y, _GUIRectangle.rectangle.width, _GUIRectangle.rectangle.height);
                    }
                }
                endFill();
            }
            return;
        }// end function

        public function get isShown() : Boolean
        {
            return this.m_IsShown;
        }// end function

        public function reset() : void
        {
            this.endFadeAnimation();
            this.clearMouseHoles();
            return;
        }// end function

        public function refreshMouseHoles() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.m_MouseShieldHoles)
            {
                
                _loc_1.refresh();
            }
            return;
        }// end function

        private function onMouseEvent(event:MouseEvent) : void
        {
            if (event.type == MouseEvent.ROLL_OVER)
            {
                this.m_CursorHelper.setCursor(DefaultRejectCursor);
            }
            else if (event.type == MouseEvent.ROLL_OUT)
            {
                this.m_CursorHelper.resetCursor();
            }
            return;
        }// end function

        public function endFadeAnimation(param1:Boolean = true) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            if (this.m_FadeSequence != null)
            {
                _loc_2 = this.m_UIEmbeddedMouseShield.alpha;
                _loc_3 = new Fade();
                _loc_3.alphaFrom = _loc_2;
                _loc_3.alphaTo = 0;
                _loc_3.duration = 400;
                _loc_3.target = this.m_UIEmbeddedMouseShield;
                this.m_FadeSequence.end();
                this.m_UIEmbeddedMouseShield.alpha = _loc_2;
                _loc_3.play();
            }
            if (param1)
            {
                this.m_FadeAnimationRequested = false;
            }
            return;
        }// end function

        public function set fullyTransparent(param1:Boolean) : void
        {
            if (this.m_FullyTransparent != param1)
            {
                this.m_FullyTransparent = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            var _loc_1:* = null;
            var _loc_2:* = Tibia.s_GetInstance().systemManager;
            _loc_1 = Tibia.s_GetInstance().systemManager;
            if (_loc_2 != null && _loc_1.stage != null)
            {
                this.m_UIEmbeddedMouseShield = new UIComponent();
                this.m_UIEmbeddedMouseShield.alpha = 0;
                this.addChild(this.m_UIEmbeddedMouseShield);
                this.blendMode = BlendMode.LAYER;
                this.m_UIEmbeddedMouseShield.blendMode = BlendMode.LAYER;
                _loc_1.deployMouseShields(true);
                this.m_UIEmbeddedMouseShield.addEventListener(MouseEvent.ROLL_OVER, this.onMouseEvent);
                this.m_UIEmbeddedMouseShield.addEventListener(MouseEvent.ROLL_OUT, this.onMouseEvent);
                this.addEventListener(MouseEvent.ROLL_OVER, this.onMouseEvent);
                this.addEventListener(MouseEvent.ROLL_OUT, this.onMouseEvent);
            }
            this.m_CursorHelper.setCursor(DefaultRejectCursor);
            return;
        }// end function

        private function setMouseCapture(param1:Boolean) : void
        {
            var _loc_2:* = Tibia.s_GetInstance().systemManager;
            var _loc_3:* = null;
            var _loc_4:* = new Array(MouseEvent.MOUSE_WHEEL, MouseEvent.ROLL_OVER, MouseEvent.ROLL_OUT, MouseEvent.MOUSE_MOVE, MouseEvent.MOUSE_DOWN, MouseEvent.RIGHT_MOUSE_DOWN, MouseEvent.MIDDLE_MOUSE_DOWN, MouseEvent.MOUSE_UP, MouseEvent.RIGHT_MOUSE_UP, MouseEvent.MIDDLE_MOUSE_UP, MouseEvent.CLICK, MouseEvent.RIGHT_CLICK, MouseEvent.MIDDLE_CLICK, MouseEvent.DOUBLE_CLICK);
            if (param1)
            {
                for each (_loc_3 in _loc_4)
                {
                    
                    _loc_2.addEventListener(_loc_3, this.onMouseEvent, true, int.MAX_VALUE);
                }
            }
            else
            {
                for each (_loc_3 in _loc_4)
                {
                    
                    _loc_2.removeEventListener(_loc_3, this.onMouseEvent, true);
                }
            }
            return;
        }// end function

        public function addMouseHole(param1:GUIRectangle) : void
        {
            this.m_MouseShieldHoles.push(param1);
            invalidateDisplayList();
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = null;
            super.measure();
            _loc_1 = Tibia.s_GetInstance().m_UITibiaRootContainer;
            if (_loc_1 != null)
            {
                measuredMinHeight = _loc_1.height;
                measuredHeight = _loc_1.height;
                measuredMinWidth = Math.max(measuredMinWidth, _loc_1.width);
                measuredWidth = Math.max(measuredWidth, _loc_1.width);
                this.m_MouseShieldRegion.setTo(0, 0, measuredWidth, measuredHeight);
                this.refreshMouseHoles();
            }
            return;
        }// end function

        public function set showHintLabel(param1:Boolean) : void
        {
            if (this.m_ShowHintLabel != param1)
            {
                this.m_ShowHintLabel = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        public function get fullyTransparent() : Boolean
        {
            return this.m_FullyTransparent;
        }// end function

        private function onTimer(event:Event) : void
        {
            this.refreshMouseHoles();
            invalidateDisplayList();
            return;
        }// end function

        private function onActiveChanged(event:Event) : void
        {
            if (this.m_FadeAnimationRequested)
            {
                if (event.type == Event.ACTIVATE)
                {
                    this.startFadeAnimation();
                }
                else if (event.type == Event.DEACTIVATE)
                {
                    this.endFadeAnimation(false);
                }
            }
            return;
        }// end function

        public function startFadeAnimation(param1:uint = 10000) : void
        {
            this.m_FadeAnimationRequested = true;
            if (Tibia.s_GetInstance().isActive == false)
            {
                return;
            }
            if (this.m_FadeSequence != null)
            {
                this.m_FadeSequence.end();
            }
            this.m_FadeSequence = new Sequence();
            var _loc_2:* = new Fade();
            _loc_2.alphaFrom = 0;
            _loc_2.alphaTo = 0.7;
            _loc_2.duration = 700;
            this.m_FadeSequence.addChild(_loc_2);
            var _loc_3:* = new Pause();
            _loc_3.duration = 500;
            this.m_FadeSequence.addChild(_loc_3);
            _loc_2 = new Fade();
            _loc_2.alphaFrom = 0.7;
            _loc_2.alphaTo = 0;
            _loc_2.duration = 700;
            this.m_FadeSequence.addChild(_loc_2);
            _loc_3 = new Pause();
            _loc_3.duration = 3000;
            this.m_FadeSequence.addChild(_loc_3);
            this.m_FadeSequence.startDelay = param1;
            this.m_FadeSequence.repeatCount = int.MAX_VALUE;
            this.m_FadeSequence.target = this.m_UIEmbeddedMouseShield;
            this.m_FadeSequence.play();
            return;
        }// end function

        public function get showHintLabel() : Boolean
        {
            return this.m_ShowHintLabel;
        }// end function

        private function onResize(event:Event) : void
        {
            this.refreshMouseHoles();
            invalidateDisplayList();
            invalidateSize();
            return;
        }// end function

        public function clearMouseHoles() : void
        {
            this.m_MouseShieldHoles.length = 0;
            invalidateDisplayList();
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:* = null;
            if (!this.m_IsShown)
            {
                if (Tibia.s_GetInputHandler() != null)
                {
                    Tibia.s_GetInputHandler().captureKeyboard = false;
                }
                _loc_1 = Tibia.s_GetInstance().systemManager;
                _loc_1.addChildToSandboxRoot("popUpChildren", this);
                _loc_1.addEventListener(Event.RESIZE, this.onResize);
                Tibia.s_GetInstance().m_UITibiaRootContainer.addEventListener(Event.RESIZE, this.onResize);
                Tibia.s_GetInstance().addEventListener(Event.ACTIVATE, this.onActiveChanged);
                Tibia.s_GetInstance().addEventListener(Event.DEACTIVATE, this.onActiveChanged);
                Tibia.s_GetSecondaryTimer().addEventListener(TimerEvent.TIMER, this.onTimer);
                this.m_IsShown = true;
            }
            return;
        }// end function

        public function get captureMouse() : Boolean
        {
            return this.m_CaptureMouse;
        }// end function

        public static function getInstance() : SessiondumpMouseShield
        {
            if (s_Instance == null)
            {
                s_Instance = new SessiondumpMouseShield;
            }
            return s_Instance;
        }// end function

    }
}
