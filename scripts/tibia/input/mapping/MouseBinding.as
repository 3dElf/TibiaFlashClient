package tibia.input.mapping
{
    import flash.ui.*;
    import mx.resources.*;

    public class MouseBinding extends Object
    {
        private var m_MouseButton:uint = 1;
        private var m_Action:uint = 0;
        private var m_ModifierKey:uint = 16;
        private static const ACTION_UNSET:int = -1;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        private static const ACTION_USE_OR_OPEN:int = 101;
        private static const ACTION_LOOK:int = 6;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        private static const ACTION_SMARTCLICK:int = 100;
        private static const ACTION_TALK:int = 9;
        private static const BUNDLE:String = "InputHandler";
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
        private static const ACTION_USE:int = 7;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        private static const ACTION_NONE:int = 0;
        private static const ACTION_AUTOWALK:int = 3;
        private static const ACTION_ATTACK:int = 1;
        private static const ACTION_OPEN:int = 8;
        private static const ACTION_CONTEXT_MENU:int = 5;
        private static const ACTION_ATTACK_OR_TALK:int = 102;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;

        public function MouseBinding(param1:uint, param2:uint, param3:uint)
        {
            this.m_MouseButton = param1;
            this.m_ModifierKey = param2;
            this.m_Action = param3;
            return;
        }// end function

        public function toString() : String
        {
            return this.formatAsString();
        }// end function

        public function appliesTo(param1:uint, param2:uint) : Boolean
        {
            return this.m_MouseButton == param1 && this.m_ModifierKey == param2;
        }// end function

        public function set action(param1:uint) : void
        {
            this.m_Action = param1;
            return;
        }// end function

        public function marshall() : XML
        {
            var _loc_1:* = new XML("<mousebinding mouseButton=\"" + this.m_MouseButton + "\" modifierCode=\"" + this.m_ModifierKey + "\" action=\"" + this.m_Action + "\"/>");
            return _loc_1;
        }// end function

        public function get modifierKey() : uint
        {
            return this.m_ModifierKey;
        }// end function

        public function clone() : MouseBinding
        {
            return new MouseBinding(this.m_MouseButton, this.m_ModifierKey, this.m_Action);
        }// end function

        public function get mouseButton() : uint
        {
            return this.m_MouseButton;
        }// end function

        private function formatAsString() : String
        {
            var _loc_1:* = ResourceManager.getInstance();
            var _loc_2:* = null;
            if (this.m_ModifierKey == Keyboard.ALTERNATE)
            {
                _loc_2 = _loc_1.getString(BUNDLE, "BINDING_KEY_ALTERNATE") + " + ";
            }
            else if (this.m_ModifierKey == Keyboard.CONTROL)
            {
                _loc_2 = _loc_1.getString(BUNDLE, "BINDING_KEY_CONTROL") + " + ";
            }
            else if (this.m_ModifierKey == Keyboard.SHIFT)
            {
                _loc_2 = _loc_1.getString(BUNDLE, "BINDING_KEY_SHIFT") + " + ";
            }
            else
            {
                _loc_2 = "";
            }
            var _loc_3:* = 0;
            if (this.m_MouseButton == MOUSE_BUTTON_LEFT)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "MOUSE_BINDING_BUTTON_LEFT");
            }
            else if (this.m_MouseButton == MOUSE_BUTTON_MIDDLE)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "MOUSE_BINDING_BUTTON_MIDDLE");
            }
            else if (this.m_MouseButton == MOUSE_BUTTON_RIGHT)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "MOUSE_BINDING_BUTTON_RIGHT");
            }
            else if (this.m_MouseButton == MOUSE_BUTTON_BOTH)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "MOUSE_BINDING_BUTTON_BOTH");
            }
            else
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "MOUSE_BINDING_UNKNOWN");
            }
            return _loc_2;
        }// end function

        public function get action() : uint
        {
            return this.m_Action;
        }// end function

        public function equals(param1:MouseBinding) : Boolean
        {
            return param1 != null && this.appliesTo(param1.mouseButton, param1.modifierKey) && this.m_Action == param1.action;
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : MouseBinding
        {
            if (param1 == null || param1.localName() != "mousebinding" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("MouseBinding.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_7:* = param1.@mouseButton;
            _loc_3 = param1.@mouseButton;
            if (_loc_7 == null || _loc_3.length() != 1)
            {
                return null;
            }
            var _loc_4:* = parseInt(_loc_3.toString());
            if (parseInt(_loc_3.toString()) != MOUSE_BUTTON_LEFT && _loc_4 != MOUSE_BUTTON_RIGHT && _loc_4 != MOUSE_BUTTON_MIDDLE && _loc_4 != MOUSE_BUTTON_BOTH)
            {
                return null;
            }
            var _loc_7:* = param1.@modifierCode;
            _loc_3 = param1.@modifierCode;
            if (_loc_7 == null || _loc_3.length() != 1)
            {
                return null;
            }
            var _loc_5:* = parseInt(_loc_3.toString());
            if (parseInt(_loc_3.toString()) != 0 && _loc_5 != Keyboard.CONTROL && _loc_5 != Keyboard.ALTERNATE && _loc_5 != Keyboard.SHIFT)
            {
                return null;
            }
            var _loc_7:* = param1.@action;
            _loc_3 = param1.@action;
            if (_loc_7 == null || _loc_3.length() != 1)
            {
                return null;
            }
            var _loc_6:* = parseInt(_loc_3.toString());
            if (parseInt(_loc_3.toString()) != ACTION_NONE && _loc_6 != ACTION_ATTACK_OR_TALK && _loc_6 != ACTION_USE_OR_OPEN && _loc_6 != ACTION_LOOK && _loc_6 != ACTION_AUTOWALK && _loc_6 != ACTION_CONTEXT_MENU && _loc_6 != ACTION_SMARTCLICK)
            {
                return null;
            }
            return new MouseBinding(_loc_4, _loc_5, _loc_6);
        }// end function

    }
}
