package tibia.input.mapping
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.ui.*;
    import mx.collections.*;
    import tibia.input.*;

    public class MouseMapping extends Object
    {
        protected var m_MouseBindings:Vector.<MouseBinding>;
        private var m_ShowMouseCursorForAction:Boolean = true;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        private static const KEYMODIFIED_LEFT_CLICK_BINDINGS:Array = [new MouseBinding(MOUSE_BUTTON_LEFT, 0, ACTION_AUTOWALK), new MouseBinding(MOUSE_BUTTON_MIDDLE, 0, ACTION_ATTACK_OR_TALK), new MouseBinding(MOUSE_BUTTON_RIGHT, 0, ACTION_CONTEXT_MENU), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.SHIFT, ACTION_LOOK), new MouseBinding(MOUSE_BUTTON_RIGHT, Keyboard.SHIFT, ACTION_LOOK), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.CONTROL, ACTION_USE_OR_OPEN), new MouseBinding(MOUSE_BUTTON_RIGHT, Keyboard.CONTROL, ACTION_USE_OR_OPEN), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.ALTERNATE, ACTION_ATTACK_OR_TALK), new MouseBinding(MOUSE_BUTTON_RIGHT, Keyboard.ALTERNATE, ACTION_ATTACK_OR_TALK)];
        private static const ACTION_LOOK:int = 6;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        private static const ACTION_SMARTCLICK:int = 100;
        private static const ACTION_TALK:int = 9;
        static const NUM_EFFECTS:int = 200;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        private static const SMART_LEFT_CLICK_BINDINGS:Array = [new MouseBinding(MOUSE_BUTTON_LEFT, 0, ACTION_SMARTCLICK), new MouseBinding(MOUSE_BUTTON_MIDDLE, 0, ACTION_AUTOWALK), new MouseBinding(MOUSE_BUTTON_RIGHT, 0, ACTION_CONTEXT_MENU), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.SHIFT, ACTION_LOOK), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.CONTROL, ACTION_AUTOWALK)];
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const FIELD_HEIGHT:int = 24;
        public static const PRESET_KEYMODIFIED_LEFT_CLICK:MouseMapping = new MouseMapping(KEYMODIFIED_LEFT_CLICK_BINDINGS);
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        static const UNDERGROUND_LAYER:int = 2;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        static const FIELD_CACHESIZE:int = 32;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const PLAYER_OFFSET_X:int = 8;
        static const PLAYER_OFFSET_Y:int = 6;
        private static const EMPTY_BINDING:Array = [new MouseBinding(MOUSE_BUTTON_LEFT, 0, 0), new MouseBinding(MOUSE_BUTTON_MIDDLE, 0, 0), new MouseBinding(MOUSE_BUTTON_RIGHT, 0, 0), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.SHIFT, 0), new MouseBinding(MOUSE_BUTTON_MIDDLE, Keyboard.SHIFT, 0), new MouseBinding(MOUSE_BUTTON_RIGHT, Keyboard.SHIFT, 0), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.CONTROL, 0), new MouseBinding(MOUSE_BUTTON_MIDDLE, Keyboard.CONTROL, 0), new MouseBinding(MOUSE_BUTTON_RIGHT, Keyboard.CONTROL, 0), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.ALTERNATE, 0), new MouseBinding(MOUSE_BUTTON_MIDDLE, Keyboard.ALTERNATE, 0), new MouseBinding(MOUSE_BUTTON_RIGHT, Keyboard.ALTERNATE, 0), new MouseBinding(MOUSE_BUTTON_BOTH, 0, 0)];
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
        static const MAP_MAX_Z:int = 15;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        public static const PRESET_SMART_RIGHT_CLICK:MouseMapping = new MouseMapping(SMART_RIGHT_CLICK_BINDINGS);
        private static const ACTION_ATTACK:int = 1;
        private static const ACTION_CONTEXT_MENU:int = 5;
        static const GROUND_LAYER:int = 7;
        static const MAP_HEIGHT:int = 11;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        private static const ACTION_NONE:int = 0;
        static const NUM_FIELDS:int = 2016;
        private static const ACTION_OPEN:int = 8;
        private static const ACTION_ATTACK_OR_TALK:int = 102;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        private static const ACTION_UNSET:int = -1;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        private static const ACTION_USE_OR_OPEN:int = 101;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        private static const ACTION_USE:int = 7;
        private static const ACTION_AUTOWALK:int = 3;
        static const MAP_WIDTH:int = 15;
        public static const PRESET_SMART_LEFT_CLICK:MouseMapping = new MouseMapping(SMART_LEFT_CLICK_BINDINGS);
        private static const SMART_RIGHT_CLICK_BINDINGS:Array = [new MouseBinding(MOUSE_BUTTON_LEFT, 0, ACTION_AUTOWALK), new MouseBinding(MOUSE_BUTTON_MIDDLE, 0, ACTION_LOOK), new MouseBinding(MOUSE_BUTTON_RIGHT, 0, ACTION_SMARTCLICK), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.SHIFT, ACTION_LOOK), new MouseBinding(MOUSE_BUTTON_RIGHT, Keyboard.SHIFT, ACTION_LOOK), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.CONTROL, ACTION_CONTEXT_MENU), new MouseBinding(MOUSE_BUTTON_RIGHT, Keyboard.CONTROL, ACTION_CONTEXT_MENU), new MouseBinding(MOUSE_BUTTON_LEFT, Keyboard.ALTERNATE, ACTION_SMARTCLICK), new MouseBinding(MOUSE_BUTTON_RIGHT, Keyboard.ALTERNATE, ACTION_SMARTCLICK), new MouseBinding(MOUSE_BUTTON_BOTH, 0, ACTION_LOOK)];

        public function MouseMapping(param1 = null)
        {
            this.m_MouseBindings = new Vector.<MouseBinding>(EMPTY_BINDING.length, true);
            var _loc_2:* = 0;
            while (_loc_2 < EMPTY_BINDING.length)
            {
                
                this.m_MouseBindings[_loc_2] = EMPTY_BINDING[_loc_2].clone();
                _loc_2++;
            }
            if (param1 != null)
            {
                this.addAll(param1);
            }
            return;
        }// end function

        public function addAll(param1) : void
        {
            if (!(param1 is Array) && !(param1 is Vector.<MouseBinding>) && !(param1 is IList))
            {
                throw new ArgumentError("MouseMapping.addAll: Invalid input(1).");
            }
            var _loc_2:* = param1.length;
            var _loc_3:* = this.m_MouseBindings.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                if (param1[_loc_4] == null)
                {
                    throw new ArgumentError("MouseMapping.addAll: Invalid input(2).");
                }
                this.setBinding(param1[_loc_4]);
                _loc_4++;
            }
            return;
        }// end function

        public function get showMouseCursorForAction() : Boolean
        {
            return this.m_ShowMouseCursorForAction;
        }// end function

        public function setBinding(param1:MouseBinding) : void
        {
            if (param1 == null)
            {
                throw new ArgumentError("MouseMapping.setBinding: Invalid input.");
            }
            var _loc_2:* = this.findBinding(param1.mouseButton, param1.modifierKey);
            if (_loc_2 != null)
            {
                _loc_2.action = param1.action;
            }
            return;
        }// end function

        public function set showMouseCursorForAction(param1:Boolean) : void
        {
            this.m_ShowMouseCursorForAction = param1;
            return;
        }// end function

        public function findBindingForLeftMouseButtonAndPressedModifierKey() : MouseBinding
        {
            return this.findBinding(MOUSE_BUTTON_LEFT, this.internalGetModifierKey());
        }// end function

        public function get mouseBindings() : Vector.<MouseBinding>
        {
            return this.m_MouseBindings;
        }// end function

        public function findBinding(param1:uint, param2:uint) : MouseBinding
        {
            var _loc_3:* = null;
            for each (_loc_3 in this.m_MouseBindings)
            {
                
                if (_loc_3.appliesTo(param1, param2))
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function replaceAll(param1) : void
        {
            if (!(param1 is Array) && !(param1 is Vector.<MouseBinding>) && !(param1 is IList))
            {
                throw new ArgumentError("MouseMapping.addAll: Invalid input(1).");
            }
            this.addAll(EMPTY_BINDING);
            this.addAll(param1);
            return;
        }// end function

        public function marshall() : XML
        {
            var _loc_2:* = null;
            var _loc_1:* = new XML("<mousemapping showMouseCursorForAction=\"" + this.m_ShowMouseCursorForAction + "\"></mousemapping>");
            for each (_loc_2 in this.m_MouseBindings)
            {
                
                _loc_1.appendChild(_loc_2.marshall());
            }
            return _loc_1;
        }// end function

        private function internalGetModifierKey() : uint
        {
            var _loc_1:* = Tibia.s_GetInputHandler();
            if (_loc_1.isKeyPressed(Keyboard.CONTROL))
            {
                return Keyboard.CONTROL;
            }
            if (_loc_1.isKeyPressed(Keyboard.SHIFT))
            {
                return Keyboard.SHIFT;
            }
            if (_loc_1.isKeyPressed(Keyboard.ALTERNATE))
            {
                return Keyboard.ALTERNATE;
            }
            return 0;
        }// end function

        public function equals(param1:MouseMapping) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.m_MouseBindings)
            {
                
                if (!_loc_2.equals(param1.findBinding(_loc_2.mouseButton, _loc_2.modifierKey)))
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function initialiseDefaultBindings() : void
        {
            this.addAll(EMPTY_BINDING);
            this.addAll(SMART_LEFT_CLICK_BINDINGS);
            return;
        }// end function

        public function findBindingByMouseEvent(event:MouseEvent) : MouseBinding
        {
            if (event == null)
            {
                return null;
            }
            var _loc_2:* = 0;
            if (event is MouseClickBothEvent)
            {
                _loc_2 = MOUSE_BUTTON_BOTH;
            }
            else if (event.type == MouseEvent.CLICK || event.type == MouseEvent.ROLL_OUT || event.type == MouseEvent.ROLL_OVER || event.type == MouseEvent.MOUSE_DOWN || event.type == MouseEvent.MOUSE_UP || event.type == MouseEvent.MOUSE_OVER || event.type == MouseEvent.MOUSE_OUT || event.type == MouseEvent.MOUSE_MOVE)
            {
                _loc_2 = MOUSE_BUTTON_LEFT;
            }
            else if (event.type == MouseEvent.RIGHT_CLICK || event.type == MouseEvent.RIGHT_MOUSE_DOWN || event.type == MouseEvent.RIGHT_MOUSE_UP)
            {
                _loc_2 = MOUSE_BUTTON_RIGHT;
            }
            else if (event.type == MouseEvent.MIDDLE_CLICK || event.type == MouseEvent.MIDDLE_MOUSE_DOWN || event.type == MouseEvent.MIDDLE_MOUSE_UP)
            {
                _loc_2 = MOUSE_BUTTON_MIDDLE;
            }
            var _loc_3:* = 0;
            if (event.ctrlKey)
            {
                _loc_3 = Keyboard.CONTROL;
            }
            else if (event.shiftKey)
            {
                _loc_3 = Keyboard.SHIFT;
            }
            else if (event.altKey)
            {
                _loc_3 = Keyboard.ALTERNATE;
            }
            return this.findBinding(_loc_2, _loc_3);
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number, param3:MouseMapping) : MouseMapping
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param1 == null || param1.localName() != "mousemapping" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("MouseMapping.s_Unmarshall: Invalid input.");
            }
            if (param3 == null)
            {
                throw new Error("MouseMapping.s_Unmarshall: Invalid mapping.");
            }
            var _loc_4:* = null;
            var _loc_7:* = param1.@showMouseCursorForAction;
            _loc_4 = param1.@showMouseCursorForAction;
            if (_loc_7 == null || _loc_4.length() != 1)
            {
                return null;
            }
            param3.showMouseCursorForAction = _loc_4[0].toString() == "true";
            for each (_loc_5 in param1.elements("mousebinding"))
            {
                
                _loc_6 = MouseBinding.s_Unmarshall(_loc_5, param2);
                if (_loc_6 != null)
                {
                    param3.setBinding(_loc_6);
                }
            }
            return param3;
        }// end function

    }
}
