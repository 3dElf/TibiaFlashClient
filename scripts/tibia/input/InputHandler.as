package tibia.input
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.cryptography.*;
    import shared.utility.*;
    import tibia.input.mapping.*;
    import tibia.input.staticaction.*;
    import tibia.options.*;

    public class InputHandler extends UIComponent
    {
        private var m_UncommittedCaptureKeyboard:Boolean = true;
        protected var m_MouseRepeatEvent:MouseRepeatEvent = null;
        protected var m_MovementBindings:Vector.<Binding> = null;
        protected var m_MouseEventTime:int = 0;
        protected var m_KeyboardTextTarget:InteractiveObject = null;
        protected var m_MouseEventTarget:WeakReference;
        private var m_UITextInput:TextInput = null;
        protected var m_MouseEventPoint:Point;
        protected var m_MouseEventState:int = 0;
        protected var m_Options:OptionsStorage = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_MouseRepeatTrigger:Boolean = false;
        protected var m_MouseEventCode:uint = 0;
        protected var m_MouseRepeatTimer:Timer = null;
        protected var m_Numlock:Boolean = false;
        private var m_UncommittedOptions:Boolean = false;
        protected var m_KeyboardHandlerActive:Boolean = false;
        private var m_InternetExplorer:Boolean = false;
        protected var m_Mapping:Mapping = null;
        protected var m_MouseRepeatTarget:WeakReference;
        protected var m_CaptureKeyboard:Boolean = true;
        protected var m_KeyPressed:Vector.<int>;
        protected var m_KeyCode:uint = 0;
        private var m_CaptureDisableCount:int = 0;
        protected var m_MouseDown:Vector.<Boolean>;
        protected var m_MouseHandlerActive:Boolean = false;
        private static const ACTION_UNSET:int = -1;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        private static const ACTION_USE_OR_OPEN:int = 101;
        private static const ACTION_SMARTCLICK:int = 100;
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        private static const ACTION_LOOK:int = 6;
        private static const MOUSE_CLICK_MOVE:Number = 8;
        private static const ACTION_TALK:int = 9;
        private static const MOUSE_LEFT:uint = 0;
        private static const ACTION_USE:int = 7;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        private static const ACTION_NONE:int = 0;
        private static const MOUSE_RIGHT:uint = 1;
        private static const ACTION_AUTOWALK:int = 3;
        private static const ACTION_ATTACK:int = 1;
        private static const KEY_REPEAT_MIN_DELAY:uint = 250;
        private static const ACTION_OPEN:int = 8;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
        private static const ACTION_CONTEXT_MENU:int = 5;
        private static const MOUSE_REPEAT_TIMEOUT:int = 500;
        private static const ACTION_ATTACK_OR_TALK:int = 102;
        private static const MOUSE_DOUBLECLICK_TIMEOUT:int = 250;

        public function InputHandler()
        {
            this.m_MouseDown = new Vector.<Boolean>(2);
            this.m_MouseEventPoint = new Point(-1, -1);
            this.m_MouseEventTarget = new WeakReference();
            this.m_MouseRepeatTarget = new WeakReference();
            this.m_KeyPressed = new Vector.<int>(256);
            this.m_InternetExplorer = BrowserHelper.s_GetBrowserID() == BrowserHelper.INTERNETEXPLORER;
            this.m_MouseRepeatTimer = new Timer(0, 0);
            addEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
            Tibia.s_GetSecondaryTimer().addEventListener(TimerEvent.TIMER, this.onKeyboardRepeatTimer);
            return;
        }// end function

        private function registerSandboxListeners() : void
        {
            var _loc_1:* = systemManager.getSandboxRoot();
            if (_loc_1 != null)
            {
                _loc_1.addEventListener(FocusEvent.FOCUS_IN, this.onSandboxFocus, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(FocusEvent.FOCUS_OUT, this.onSandboxFocus, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.onSandboxFocus, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.onSandboxFocus, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(KeyboardEvent.KEY_DOWN, this.onSandboxKeyboard, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(KeyboardEvent.KEY_UP, this.onSandboxKeyboard, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.CLICK, this.onSandboxMouse, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.DOUBLE_CLICK, this.onSandboxMouse, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.MOUSE_DOWN, this.onSandboxMouse, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.MOUSE_UP, this.onSandboxMouse, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.RIGHT_CLICK, this.onSandboxMouse, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onSandboxMouse, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onSandboxMouse, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(TextEvent.TEXT_INPUT, this.onSandboxText, true, int.MAX_VALUE, false);
            }
            return;
        }// end function

        protected function onMouseRepeatTimer(event:TimerEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            if (this.m_MouseRepeatTrigger && this.m_MouseRepeatEvent != null && this.m_MouseRepeatTarget.value is InteractiveObject)
            {
                if (this.m_MouseRepeatTimer.currentCount == 1 && this.m_MouseRepeatTimer.repeatCount == 1)
                {
                    this.m_MouseRepeatTimer.delay = this.m_MouseRepeatEvent.repeatInterval;
                    this.m_MouseRepeatTimer.repeatCount = 0;
                    this.m_MouseRepeatTimer.reset();
                    this.m_MouseRepeatTimer.start();
                }
                _loc_2 = this.m_MouseRepeatTarget.value as InteractiveObject;
                _loc_3 = this.m_MouseRepeatEvent.type == MouseEvent.MOUSE_DOWN ? (MouseRepeatEvent.REPEAT_MOUSE_DOWN) : (MouseRepeatEvent.REPEAT_RIGHT_MOUSE_DOWN);
                _loc_4 = this.m_MouseRepeatEvent.localX - _loc_2.mouseX;
                _loc_5 = this.m_MouseRepeatEvent.localY - _loc_2.mouseY;
                _loc_6 = Math.sqrt(_loc_4 * _loc_4 + _loc_5 * _loc_5);
                _loc_7 = new MouseRepeatEvent(_loc_3, this.m_MouseRepeatEvent.bubbles, this.m_MouseRepeatEvent.cancelable);
                _loc_7.localX = _loc_2.mouseX;
                _loc_7.localY = _loc_2.mouseY;
                _loc_7.ctrlKey = this.m_MouseRepeatEvent.ctrlKey;
                _loc_7.altKey = this.m_MouseRepeatEvent.altKey;
                _loc_7.shiftKey = this.m_MouseRepeatEvent.shiftKey;
                _loc_7.buttonDown = true;
                _loc_7.delta = _loc_6;
                _loc_7.repeatEnabled = this.m_MouseRepeatEvent.repeatEnabled;
                _loc_7.repeatInterval = this.m_MouseRepeatEvent.repeatInterval;
                _loc_2.dispatchEvent(_loc_7);
                if (!_loc_7.cancelable || !_loc_7.isDefaultPrevented())
                {
                    if (!_loc_7.repeatEnabled)
                    {
                        this.finishMouseRepeat();
                    }
                    else if (_loc_7.repeatInterval != this.m_MouseRepeatEvent.repeatInterval)
                    {
                        this.m_MouseRepeatTimer.delay = _loc_7.repeatInterval;
                    }
                }
            }
            return;
        }// end function

        protected function onMouseRepeatPause(event:Event) : void
        {
            this.m_MouseRepeatTrigger = event.type == MouseEvent.ROLL_OVER;
            return;
        }// end function

        private function finishMouseRepeat() : void
        {
            var _loc_1:* = null;
            this.m_MouseRepeatTrigger = false;
            this.m_MouseRepeatEvent = null;
            if (this.m_MouseRepeatTarget.value is InteractiveObject)
            {
                _loc_1 = this.m_MouseRepeatTarget.value as InteractiveObject;
                _loc_1.removeEventListener(MouseEvent.ROLL_OUT, this.onMouseRepeatPause);
                _loc_1.removeEventListener(MouseEvent.ROLL_OVER, this.onMouseRepeatPause);
                this.m_MouseRepeatTarget.value = null;
            }
            if (this.m_MouseRepeatTimer != null)
            {
                this.m_MouseRepeatTimer.removeEventListener(TimerEvent.TIMER, this.onMouseRepeatTimer);
                this.m_MouseRepeatTimer.reset();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UITextInput = new TextInput();
                addChild(this.m_UITextInput);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function isKeyPressed(param1:uint) : Boolean
        {
            return this.m_KeyPressed[param1] != 0;
        }// end function

        protected function onSandboxMouse(event:MouseEvent) : void
        {
            if (this.m_MouseHandlerActive)
            {
                return;
            }
            this.m_MouseHandlerActive = true;
            this.cancelEvent(event);
            if (event.type == MouseEvent.MOUSE_DOWN || event.type == MouseEvent.RIGHT_MOUSE_DOWN)
            {
                this.internalMouseDown(event);
            }
            else if (event.type == MouseEvent.MOUSE_UP || event.type == MouseEvent.RIGHT_MOUSE_UP)
            {
                this.internalMouseUp(event);
            }
            this.m_MouseHandlerActive = false;
            return;
        }// end function

        public function set captureKeyboard(param1:Boolean) : void
        {
            if (!param1)
            {
                var _loc_3:* = this;
                var _loc_4:* = this.m_CaptureDisableCount + 1;
                _loc_3.m_CaptureDisableCount = _loc_4;
            }
            else
            {
                var _loc_3:* = this;
                var _loc_4:* = this.m_CaptureDisableCount - 1;
                _loc_3.m_CaptureDisableCount = _loc_4;
            }
            var _loc_2:* = this.m_CaptureDisableCount <= 0;
            if (_loc_2)
            {
                this.m_CaptureDisableCount = 0;
            }
            if (this.m_CaptureKeyboard != _loc_2)
            {
                this.m_CaptureKeyboard = _loc_2;
                this.m_UncommittedCaptureKeyboard = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function internalMouseUp(event:MouseEvent) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_13:* = null;
            Random.s_PoolPutUnsignedInt(event.stageX << 16 | event.stageY);
            var _loc_2:* = event.type == MouseEvent.MOUSE_UP ? (MOUSE_LEFT) : (MOUSE_RIGHT);
            this.m_MouseDown[_loc_2] = false;
            _loc_3 = this.m_MouseEventPoint.x - event.stageX;
            _loc_4 = this.m_MouseEventPoint.y - event.stageY;
            var _loc_5:* = Math.sqrt(_loc_3 * _loc_3 + _loc_4 * _loc_4);
            var _loc_6:* = getTimer();
            var _loc_7:* = this.getMouseTarget(event.stageX, event.stageY);
            var _loc_8:* = event.altKey;
            var _loc_9:* = event.ctrlKey;
            var _loc_10:* = event.shiftKey;
            var _loc_11:* = null;
            var _loc_12:* = false;
            if (this.m_MouseEventState == 1)
            {
                this.m_MouseEventState = 2;
            }
            else if (this.m_MouseEventState == 2)
            {
                _loc_12 = true;
                _loc_11 = MouseEvent.CLICK;
                this.m_MouseEventState = 0;
            }
            else if (this.m_MouseEventState == 3)
            {
                this.m_MouseEventState = 0;
            }
            else if (_loc_5 < MOUSE_CLICK_MOVE && this.m_MouseEventCode == _loc_2 && this.m_MouseEventCode == MOUSE_LEFT && this.m_MouseEventTime + MOUSE_DOUBLECLICK_TIMEOUT > _loc_6 && _loc_7 == this.m_MouseEventTarget.value && (_loc_7 == null || _loc_7.doubleClickEnabled))
            {
                _loc_11 = MouseEvent.DOUBLE_CLICK;
                this.m_MouseEventState = 0;
                this.m_MouseEventTime = 0;
            }
            else if (_loc_5 < MOUSE_CLICK_MOVE && this.m_MouseEventCode == _loc_2 && _loc_7 == this.m_MouseEventTarget.value)
            {
                _loc_11 = event.type == MouseEvent.MOUSE_UP ? (MouseEvent.CLICK) : (MouseEvent.RIGHT_CLICK);
                this.m_MouseEventState = 0;
                this.m_MouseEventTime = _loc_6;
            }
            else
            {
                this.m_MouseEventState = 0;
            }
            if (this.m_MouseRepeatTarget.value is InteractiveObject && this.m_MouseRepeatEvent != null && (event.type != MouseEvent.MOUSE_UP || this.m_MouseRepeatEvent.type == MouseEvent.MOUSE_DOWN) && (event.type != MouseEvent.RIGHT_MOUSE_UP || this.m_MouseRepeatEvent.type == MouseEvent.RIGHT_MOUSE_DOWN))
            {
                if (this.m_MouseRepeatTimer == null || this.m_MouseRepeatTimer.currentCount > 0)
                {
                    _loc_11 = null;
                }
                this.finishMouseRepeat();
            }
            if (_loc_7 != null)
            {
                _loc_13 = new MouseEvent(event.type, true, true);
                _loc_13.localX = _loc_7.mouseX;
                _loc_13.localY = _loc_7.mouseY;
                _loc_13.relatedObject = event.relatedObject;
                _loc_13.altKey = _loc_8;
                _loc_13.ctrlKey = _loc_9;
                _loc_13.shiftKey = _loc_10;
                _loc_13.buttonDown = false;
                _loc_13.delta = _loc_5;
                _loc_7.dispatchEvent(_loc_13);
                if ((!_loc_13.cancelable || !_loc_13.isDefaultPrevented()) && _loc_11 != null)
                {
                    if (_loc_12)
                    {
                        _loc_13 = new MouseClickBothEvent(_loc_11, true, true);
                    }
                    else
                    {
                        _loc_13 = new MouseEvent(_loc_11, true, true);
                    }
                    _loc_13.localX = _loc_7.mouseX;
                    _loc_13.localY = _loc_7.mouseY;
                    _loc_13.relatedObject = event.relatedObject;
                    _loc_13.altKey = _loc_8;
                    _loc_13.ctrlKey = _loc_9;
                    _loc_13.shiftKey = _loc_10;
                    _loc_13.buttonDown = false;
                    _loc_13.delta = _loc_5;
                    _loc_7.dispatchEvent(_loc_13);
                }
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        protected function onKeyboardRepeatTimer(event:TimerEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = Tibia.s_GetTibiaTimer();
            if (this.m_CaptureKeyboard && this.m_MovementBindings != null)
            {
                for each (_loc_3 in this.m_MovementBindings)
                {
                    
                    if (this.isKeyPressed(_loc_3.keyCode) && this.m_KeyPressed[_loc_3.keyCode] + KEY_REPEAT_MIN_DELAY < _loc_2 && _loc_3.appliesTo((_loc_3.action as PlayerMove).eventMask, _loc_3.keyCode, this.isKeyPressed(Keyboard.ALTERNATE), this.isKeyPressed(Keyboard.CONTROL), this.isKeyPressed(Keyboard.SHIFT)))
                    {
                        _loc_3.action.perform(true);
                    }
                }
            }
            return;
        }// end function

        private function internalMouseDown(event:MouseEvent) : void
        {
            var _loc_5:* = null;
            Random.s_PoolPutUnsignedInt(event.stageX << 16 | event.stageY);
            var _loc_2:* = event.type == MouseEvent.MOUSE_DOWN ? (MOUSE_LEFT) : (MOUSE_RIGHT);
            this.m_MouseDown[_loc_2] = true;
            this.m_MouseEventCode = _loc_2;
            this.m_MouseEventPoint.setTo(event.stageX, event.stageY);
            var _loc_3:* = null;
            var _loc_6:* = this.m_Options.mouseMapping.findBinding(MOUSE_BUTTON_BOTH, 0);
            _loc_3 = this.m_Options.mouseMapping.findBinding(MOUSE_BUTTON_BOTH, 0);
            if (this.m_Options != null && this.m_Options.mouseMapping != null && _loc_6 != null && _loc_3.action != 0 && (this.m_MouseDown[MOUSE_LEFT] && this.m_MouseDown[MOUSE_RIGHT]) && this.m_MouseRepeatTarget.value == null)
            {
                this.m_MouseEventState = 1;
            }
            else
            {
                this.m_MouseEventState = 0;
            }
            var _loc_4:* = this.getMouseTarget(event.stageX, event.stageY);
            if (this.getMouseTarget(event.stageX, event.stageY) != this.m_MouseEventTarget.value)
            {
                this.m_MouseEventTarget.value = _loc_4;
                this.m_MouseEventTime = 0;
            }
            if (_loc_4 != null)
            {
                _loc_5 = new MouseRepeatEvent(event.type, true, true);
                _loc_5.localX = _loc_4.mouseX;
                _loc_5.localY = _loc_4.mouseY;
                _loc_5.relatedObject = event.relatedObject;
                _loc_5.ctrlKey = event.ctrlKey;
                _loc_5.altKey = event.altKey;
                _loc_5.shiftKey = event.shiftKey;
                _loc_5.buttonDown = true;
                _loc_5.delta = 0;
                _loc_4.dispatchEvent(_loc_5);
                if (_loc_5.cancelable && _loc_5.isDefaultPrevented())
                {
                    this.m_MouseEventState = 3;
                }
                else if ((!_loc_5.cancelable || !_loc_5.isDefaultPrevented()) && _loc_5.repeatEnabled && this.m_MouseDown[MOUSE_LEFT] != this.m_MouseDown[MOUSE_RIGHT] && this.m_MouseRepeatTarget.value == null)
                {
                    this.initMouseRepeat(_loc_4, _loc_5);
                }
            }
            return;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            if (this.m_Options != param1)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_Options = param1;
                if (this.m_Options != null)
                {
                    this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_UncommittedOptions = true;
                invalidateProperties();
                this.updateMapping();
            }
            return;
        }// end function

        private function cancelEvent(event:Event) : void
        {
            if (event)
            {
                if (event.cancelable)
                {
                    event.preventDefault();
                }
                event.stopImmediatePropagation();
                event.stopPropagation();
            }
            return;
        }// end function

        public function dispose() : void
        {
            this.captureKeyboard = false;
            this.unregisterSandboxListeners();
            Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER, this.onKeyboardRepeatTimer);
            var _loc_1:* = 0;
            _loc_1 = this.m_KeyPressed.length - 1;
            while (_loc_1 >= 0)
            {
                
                this.m_KeyPressed[_loc_1] = 0;
                _loc_1 = _loc_1 - 1;
            }
            _loc_1 = this.m_MouseDown.length - 1;
            while (_loc_1 >= 0)
            {
                
                this.m_MouseDown[_loc_1] = false;
                _loc_1 = _loc_1 - 1;
            }
            this.m_MovementBindings = null;
            return;
        }// end function

        protected function onSandboxText(event:TextEvent) : void
        {
            var _loc_3:* = null;
            if (this.m_KeyboardHandlerActive)
            {
                return;
            }
            if (this.m_KeyboardTextTarget != null)
            {
                _loc_3 = this.m_KeyboardTextTarget;
                while (_loc_3 != null)
                {
                    
                    _loc_3 = _loc_3.parent as InteractiveObject;
                    if (event.target == _loc_3)
                    {
                        return;
                    }
                }
            }
            this.m_KeyboardHandlerActive = true;
            this.m_KeyboardTextTarget = event.target as InteractiveObject;
            var _loc_2:* = this.m_KeyCode >= Keyboard.NUMPAD_0 && this.m_KeyCode <= Keyboard.NUMPAD_DIVIDE;
            if (_loc_2)
            {
                this.cancelEvent(event);
            }
            if (this.m_CaptureKeyboard && this.m_Mapping != null && !_loc_2)
            {
                this.cancelEvent(event);
                this.m_Mapping.onTextInput(InputEvent.TEXT_INPUT, event.text);
            }
            this.m_KeyboardHandlerActive = false;
            return;
        }// end function

        protected function onCreationComplete(event:FlexEvent) : void
        {
            removeEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
            if (this.m_UITextInput != null)
            {
                this.m_UITextInput.setFocus();
                this.m_UITextInput.drawFocus(false);
            }
            this.registerSandboxListeners();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedOptions)
            {
                this.m_UncommittedOptions = false;
            }
            if (this.m_UncommittedCaptureKeyboard)
            {
                if (this.m_CaptureKeyboard)
                {
                    if (this.m_UITextInput != null)
                    {
                        this.m_UITextInput.setFocus();
                        this.m_UITextInput.drawFocus(false);
                    }
                    focusManager.deactivate();
                }
                else
                {
                    focusManager.activate();
                }
                this.m_UncommittedCaptureKeyboard = false;
            }
            return;
        }// end function

        public function clearPressedKeys() : void
        {
            var _loc_1:* = 0;
            if (this.m_KeyPressed != null)
            {
                _loc_1 = this.m_KeyPressed.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    this.m_KeyPressed[_loc_1] = 0;
                    _loc_1 = _loc_1 - 1;
                }
            }
            return;
        }// end function

        private function updateMapping() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_4:* = this.m_Options.getMappingSet(this.m_Options.generalInputSetID);
            _loc_1 = this.m_Options.getMappingSet(this.m_Options.generalInputSetID);
            if (this.m_Options != null && _loc_4 != null)
            {
                if (this.m_Options.generalInputSetMode == MappingSet.CHAT_MODE_OFF)
                {
                    _loc_2 = _loc_1.chatModeOff;
                }
                else
                {
                    _loc_2 = _loc_1.chatModeOn;
                }
            }
            if (_loc_2 != null && _loc_2.binding != null)
            {
                this.m_MovementBindings = new Vector.<Binding>;
                for each (_loc_3 in _loc_2.binding)
                {
                    
                    if (_loc_3.action != null && _loc_3.action is PlayerMove)
                    {
                        this.m_MovementBindings.push(_loc_3);
                    }
                }
            }
            this.m_Mapping = _loc_2;
            return;
        }// end function

        protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            switch(event.property)
            {
                case "generalInputSetID":
                case "generalInputSetMode":
                case "mappingSet":
                case "*":
                {
                    this.updateMapping();
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        protected function onSandboxFocus(event:FocusEvent) : void
        {
            if (this.m_CaptureKeyboard)
            {
                this.cancelEvent(event);
                if (this.m_UITextInput != null)
                {
                    this.m_UITextInput.setFocus();
                    this.m_UITextInput.drawFocus(false);
                }
            }
            this.clearPressedKeys();
            return;
        }// end function

        public function isModifierKeyPressed(event:MouseEvent = null) : Boolean
        {
            if (event != null)
            {
                return event.ctrlKey || event.shiftKey || event.altKey;
            }
            return this.isKeyPressed(Keyboard.CONTROL) || this.isKeyPressed(Keyboard.SHIFT) || this.isKeyPressed(Keyboard.ALTERNATE);
        }// end function

        private function unregisterSandboxListeners() : void
        {
            var _loc_1:* = systemManager.getSandboxRoot();
            if (_loc_1 != null)
            {
                _loc_1.removeEventListener(FocusEvent.FOCUS_IN, this.onSandboxFocus, true);
                _loc_1.removeEventListener(FocusEvent.FOCUS_OUT, this.onSandboxFocus, true);
                _loc_1.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.onSandboxFocus, true);
                _loc_1.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.onSandboxFocus, true);
                _loc_1.removeEventListener(KeyboardEvent.KEY_DOWN, this.onSandboxKeyboard, true);
                _loc_1.removeEventListener(KeyboardEvent.KEY_UP, this.onSandboxKeyboard, true);
                _loc_1.removeEventListener(MouseEvent.CLICK, this.onSandboxMouse, true);
                _loc_1.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onSandboxMouse, true);
                _loc_1.removeEventListener(MouseEvent.MOUSE_DOWN, this.onSandboxMouse, true);
                _loc_1.removeEventListener(MouseEvent.MOUSE_UP, this.onSandboxMouse, true);
                _loc_1.removeEventListener(MouseEvent.RIGHT_CLICK, this.onSandboxMouse, true);
                _loc_1.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onSandboxMouse, true);
                _loc_1.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onSandboxMouse, true);
                _loc_1.removeEventListener(TextEvent.TEXT_INPUT, this.onSandboxText, true);
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = 0;
            measuredWidth = 0;
            measuredMinWidth = _loc_1;
            var _loc_1:* = 0;
            measuredHeight = 0;
            measuredMinHeight = _loc_1;
            return;
        }// end function

        public function get captureKeyboard() : Boolean
        {
            return this.m_CaptureKeyboard;
        }// end function

        private function getMouseTarget(param1:Number, param2:Number) : InteractiveObject
        {
            var _loc_3:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            _loc_3 = DisplayObjectContainer(systemManager.getSandboxRoot());
            var _loc_4:* = _loc_3.getObjectsUnderPoint(new Point(param1, param2));
            if (_loc_3.getObjectsUnderPoint(new Point(param1, param2)) == null)
            {
                return _loc_3;
            }
            var _loc_5:* = _loc_4.length - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_6 = null;
                _loc_7 = null;
                _loc_8 = null;
                _loc_6 = _loc_4[_loc_5] as DisplayObject;
                while (_loc_6 != null && _loc_6 != _loc_3)
                {
                    
                    if (_loc_6.visible && _loc_6 is DisplayObjectContainer && DisplayObjectContainer(_loc_6).mouseEnabled && !DisplayObjectContainer(_loc_6).mouseChildren)
                    {
                        _loc_7 = DisplayObjectContainer(_loc_6);
                    }
                    _loc_6 = _loc_6.parent;
                }
                if (_loc_7 != null)
                {
                    return _loc_7;
                }
                _loc_6 = _loc_4[_loc_5] as DisplayObject;
                while (_loc_6 != null && _loc_6 != _loc_3)
                {
                    
                    if (_loc_6.visible && _loc_6 is InteractiveObject && InteractiveObject(_loc_6).mouseEnabled)
                    {
                        _loc_8 = InteractiveObject(_loc_6);
                        break;
                    }
                    _loc_6 = _loc_6.parent;
                }
                if (_loc_8 != null)
                {
                    return _loc_8;
                }
                _loc_5 = _loc_5 - 1;
            }
            return _loc_3;
        }// end function

        protected function onSandboxKeyboard(event:KeyboardEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = false;
            if (this.m_KeyboardHandlerActive)
            {
                return;
            }
            this.m_KeyboardHandlerActive = true;
            if (event.keyCode > this.m_KeyPressed.length)
            {
                event.keyCode = 0;
            }
            if (event.type == KeyboardEvent.KEY_UP)
            {
                _loc_2 = this.m_KeyPressed[event.keyCode] != 0;
                this.m_KeyPressed[event.keyCode] = 0;
                if (Keyboard.numLock != this.m_Numlock)
                {
                    this.clearPressedKeys();
                    this.m_Numlock = Keyboard.numLock;
                }
            }
            if (this.m_CaptureKeyboard && this.m_Mapping != null && !(event.altKey && event.ctrlKey))
            {
                this.cancelEvent(event);
                if (event.type == KeyboardEvent.KEY_DOWN || this.isInternetExplorer && event.ctrlKey)
                {
                    _loc_3 = this.m_KeyPressed[event.keyCode] != 0 ? (InputEvent.KEY_REPEAT) : (InputEvent.KEY_DOWN);
                    this.m_Mapping.onKeyInput(_loc_3, event.charCode, event.keyCode, event.altKey, event.ctrlKey, event.shiftKey);
                }
                if (event.type == KeyboardEvent.KEY_UP)
                {
                    this.m_Mapping.onKeyInput(InputEvent.KEY_UP, event.charCode, event.keyCode, event.altKey, event.ctrlKey, event.shiftKey);
                }
            }
            if (event.type == KeyboardEvent.KEY_DOWN)
            {
                this.m_KeyCode = event.keyCode;
                _loc_2 = this.m_KeyPressed[event.keyCode] != 0 != (!this.isInternetExplorer || event.keyCode != Keyboard.TAB);
                this.m_KeyPressed[event.keyCode] = !this.isInternetExplorer || event.keyCode != Keyboard.TAB ? (Tibia.s_GetTibiaTimer()) : (0);
            }
            if (_loc_2)
            {
                _loc_4 = new ModifierKeyEvent(ModifierKeyEvent.MODIFIER_KEYS_CHANGED, event.bubbles, event.cancelable, event.charCode, event.keyCode, event.keyLocation, event.ctrlKey, event.altKey, event.shiftKey);
                this.dispatchEvent(_loc_4);
            }
            this.m_KeyboardHandlerActive = false;
            return;
        }// end function

        private function initMouseRepeat(param1:InteractiveObject, param2:MouseRepeatEvent) : void
        {
            var _loc_3:* = null;
            this.m_MouseRepeatTrigger = true;
            this.m_MouseRepeatEvent = param2;
            this.m_MouseRepeatTarget.value = param1;
            if (this.m_MouseRepeatTarget.value is InteractiveObject)
            {
                _loc_3 = this.m_MouseRepeatTarget.value as InteractiveObject;
                _loc_3.addEventListener(MouseEvent.ROLL_OUT, this.onMouseRepeatPause, false, EventPriority.DEFAULT, true);
                _loc_3.addEventListener(MouseEvent.ROLL_OVER, this.onMouseRepeatPause, false, EventPriority.DEFAULT, true);
            }
            if (this.m_MouseRepeatTimer != null)
            {
                this.m_MouseRepeatTimer.delay = MOUSE_REPEAT_TIMEOUT;
                this.m_MouseRepeatTimer.repeatCount = 1;
                this.m_MouseRepeatTimer.addEventListener(TimerEvent.TIMER, this.onMouseRepeatTimer);
                this.m_MouseRepeatTimer.start();
            }
            return;
        }// end function

        private function get isInternetExplorer() : Boolean
        {
            return this.m_InternetExplorer;
        }// end function

    }
}
