package tibia.input.mapping
{
    import flash.ui.*;
    import mx.resources.*;
    import tibia.input.*;
    import tibia.input.staticaction.*;

    public class Binding extends Object
    {
        private var m_RawText:String = null;
        private var m_RawKey:uint = 0;
        private var m_Editable:Boolean = true;
        private var m_ToString:String = null;
        private var m_Action:IAction = null;
        private var m_RawMod:uint = 0;
        private var m_EventMask:uint = 0;
        private var m_RawChar:uint = 0;
        private static const LOCALE_MAPPING:Array = [{key:48, modifier:16, result:48}, {key:48, modifier:16, text:"=", result:48}, {key:49, modifier:16, result:49}, {key:50, modifier:16, result:50}, {key:50, modifier:16, text:"\"", result:50}, {key:51, modifier:16, result:51}, {key:51, modifier:16, text:"§", result:51}, {key:52, modifier:16, result:52}, {key:53, modifier:16, result:53}, {key:54, modifier:16, result:54}, {key:54, modifier:16, text:"&", result:54}, {char:94, key:54, modifier:16, result:54}, {key:55, modifier:16, result:55}, {key:55, modifier:16, text:"/", result:55}, {key:56, modifier:16, result:56}, {key:56, modifier:16, text:"(", result:56}, {key:57, modifier:16, result:57}, {key:57, modifier:16, text:")", result:57}, {key:186, modifier:16, result:59}, {key:186, modifier:16, text:"Ü", result:252}, {char:252, key:186, modifier:17, result:252}, {char:186, key:186, modifier:0, text:"ł", result:321}, {char:186, key:186, modifier:16, text:"Ł", result:321}, {char:186, key:186, modifier:17, result:321}, {char:231, key:186, modifier:16, text:"Ç", result:231}, {char:231, key:186, modifier:17, result:231}, {key:187, modifier:16, result:61}, {key:187, modifier:16, text:"*", result:43}, {char:43, key:187, modifier:16, text:"?", result:43}, {key:188, modifier:16, result:44}, {key:188, modifier:16, text:";", result:44}, {key:189, modifier:16, result:45}, {key:190, modifier:16, result:46}, {key:190, modifier:16, text:":", result:46}, {key:191, modifier:16, result:47}, {key:191, modifier:16, text:"\'", result:35}, {char:34, key:191, modifier:16, text:"*", result:39}, {key:191, modifier:16, text:":", result:59}, {key:192, modifier:16, result:96}, {key:192, modifier:16, text:"Ö", result:246}, {char:192, key:192, modifier:0, result:731}, {char:192, key:192, modifier:16, result:731}, {char:192, key:192, modifier:17, result:731}, {char:34, key:192, modifier:16, text:"\"", result:39}, {key:219, modifier:16, result:91}, {key:219, modifier:16, text:"?", result:223}, {char:219, key:219, modifier:0, text:"ż", result:380}, {char:219, key:219, modifier:16, text:"ń", result:380}, {char:219, key:219, modifier:17, result:380}, {char:219, key:219, modifier:0, result:180}, {char:219, key:219, modifier:16, result:180}, {char:219, key:219, modifier:17, result:180}, {key:220, modifier:16, result:92}, {char:220, key:220, modifier:0, result:94}, {char:220, key:220, modifier:16, result:94}, {char:220, key:220, modifier:17, result:94}, {char:243, key:220, modifier:16, text:"ź", result:243}, {char:125, key:220, modifier:16, text:"}", result:93}, {key:221, modifier:16, result:93}, {char:221, key:221, modifier:0, result:180}, {char:221, key:221, modifier:16, result:180}, {char:221, key:221, modifier:17, result:180}, {char:221, key:221, modifier:0, text:"ś", result:347}, {char:221, key:221, modifier:16, text:"ć", result:347}, {char:221, key:221, modifier:17, result:347}, {char:123, key:221, modifier:16, text:"{", result:91}, {key:222, modifier:16, result:39}, {key:222, modifier:16, text:"Ä", result:228}, {char:222, key:222, modifier:0, text:"ą", result:261}, {char:222, key:222, modifier:16, text:"ę", result:261}, {char:222, key:222, modifier:17, result:261}, {char:222, key:222, modifier:0, result:126}, {char:222, key:222, modifier:16, result:126}, {char:222, key:222, modifier:17, result:126}, {key:226, modifier:16, result:92}, {key:226, modifier:16, text:"\\", result:60}, {char:60, key:226, modifier:16, text:">", result:60}];
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        private static const BUNDLE:String = "InputHandler";
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function Binding(param1:IAction, param2, param3:uint, param4:uint, param5:String = null, param6:Boolean = true)
        {
            if (param1 == null)
            {
                throw new ArgumentError("Binding.Binding: Invalid action.");
            }
            this.m_Action = param1;
            if (param1 is StaticAction)
            {
                this.m_EventMask = (param1 as StaticAction).eventMask;
            }
            else
            {
                this.m_EventMask = InputEvent.KEY_DOWN;
            }
            if ((this.m_EventMask & ~(InputEvent.KEY_ANY | InputEvent.TEXT_ANY)) != 0)
            {
                throw new ArgumentError("Binding.Binding: Invalid event mask: " + this.m_EventMask);
            }
            var _loc_7:* = 0;
            if (param2 is String && String(param2).length == 1)
            {
                _loc_7 = String(param2).charCodeAt(0);
            }
            else if (param2 is uint)
            {
                _loc_7 = uint(param2);
            }
            this.update(_loc_7, param3, param4, param5);
            this.m_Editable = param6;
            return;
        }// end function

        private function formatAsString() : String
        {
            var _loc_1:* = ResourceManager.getInstance();
            if ((this.m_EventMask & InputEvent.TEXT_ANY) != 0)
            {
                return _loc_1.getString(BUNDLE, "BINDING_TEXT");
            }
            if (this.m_RawKey == 0)
            {
                return _loc_1.getString(BUNDLE, "BINDING_EMPTY");
            }
            var _loc_2:* = null;
            if (this.m_RawMod == Keyboard.ALTERNATE)
            {
                _loc_2 = _loc_1.getString(BUNDLE, "BINDING_KEY_ALTERNATE") + " + ";
            }
            else if (this.m_RawMod == Keyboard.CONTROL)
            {
                _loc_2 = _loc_1.getString(BUNDLE, "BINDING_KEY_CONTROL") + " + ";
            }
            else if (this.m_RawMod == Keyboard.SHIFT)
            {
                _loc_2 = _loc_1.getString(BUNDLE, "BINDING_KEY_SHIFT") + " + ";
            }
            else
            {
                _loc_2 = "";
            }
            if (this.m_RawKey >= Keyboard.NUMPAD_0 && this.m_RawKey <= Keyboard.NUMPAD_DIVIDE)
            {
                _loc_2 = _loc_2 + (_loc_1.getString(BUNDLE, "BINDING_KEY_NUMPAD_PREFIX") + "-");
            }
            var _loc_3:* = 0;
            if (this.m_RawKey == Keyboard.BACKSPACE)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_BACKSPACE");
            }
            else if (this.m_RawKey == Keyboard.TAB)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_TAB");
            }
            else if (this.m_RawKey == Keyboard.ENTER)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_ENTER");
            }
            else if (this.m_RawKey == Keyboard.COMMAND)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_COMMAND");
            }
            else if (this.m_RawKey == Keyboard.CAPS_LOCK)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_CAPS_LOCK");
            }
            else if (this.m_RawKey == Keyboard.NUMPAD)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_NUMPAD");
            }
            else if (this.m_RawKey == Keyboard.ESCAPE)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_ESCAPE");
            }
            else if (this.m_RawKey == Keyboard.SPACE)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_SPACE");
            }
            else if (this.m_RawKey == Keyboard.PAGE_UP)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_PAGE_UP");
            }
            else if (this.m_RawKey == Keyboard.PAGE_DOWN)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_PAGE_DOWN");
            }
            else if (this.m_RawKey == Keyboard.END)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_END");
            }
            else if (this.m_RawKey == Keyboard.HOME)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_HOME");
            }
            else if (this.m_RawKey == Keyboard.LEFT)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_LEFT");
            }
            else if (this.m_RawKey == Keyboard.UP)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_UP");
            }
            else if (this.m_RawKey == Keyboard.RIGHT)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_RIGHT");
            }
            else if (this.m_RawKey == Keyboard.DOWN)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_DOWN");
            }
            else if (this.m_RawKey == Keyboard.INSERT)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_INSERT");
            }
            else if (this.m_RawKey == Keyboard.DELETE)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_DELETE");
            }
            else if (this.m_RawKey >= Keyboard.NUMPAD_0 && this.m_RawKey <= Keyboard.NUMPAD_9)
            {
                _loc_2 = _loc_2 + String.fromCharCode(48 + this.m_RawKey - Keyboard.NUMPAD_0);
            }
            else if (this.m_RawKey == Keyboard.NUMPAD_MULTIPLY)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_NUMPAD_MULTIPLY");
            }
            else if (this.m_RawKey == Keyboard.NUMPAD_ADD)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_NUMPAD_ADD");
            }
            else if (this.m_RawKey == Keyboard.NUMPAD_ENTER)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_NUMPAD_ENTER");
            }
            else if (this.m_RawKey == Keyboard.NUMPAD_SUBTRACT)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_NUMPAD_SUBTRACT");
            }
            else if (this.m_RawKey == Keyboard.NUMPAD_DECIMAL)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_NUMPAD_DECIMAL");
            }
            else if (this.m_RawKey == Keyboard.NUMPAD_DIVIDE)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_NUMPAD_DIVIDE");
            }
            else if (this.m_RawKey >= Keyboard.F1 && this.m_RawKey <= Keyboard.F15)
            {
                _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_KEY_FUNCTION", [1 + this.m_RawKey - Keyboard.F1]);
            }
            else
            {
                var _loc_4:* = this.mapCharCode();
                _loc_3 = this.mapCharCode();
                if (this.m_RawKey != 0 && _loc_4 != 0)
                {
                    _loc_2 = _loc_2 + String.fromCharCode(_loc_3).toUpperCase();
                }
                else
                {
                    _loc_2 = _loc_2 + _loc_1.getString(BUNDLE, "BINDING_UNKNOWN");
                }
            }
            return _loc_2;
        }// end function

        public function update(param1, param2:uint = 0, param3:uint = 0, param4:String = null) : void
        {
            var _loc_6:* = null;
            if (!this.m_Editable)
            {
                return;
            }
            if (param1 is Binding)
            {
                _loc_6 = Binding(param1);
                this.update(_loc_6.m_RawChar, _loc_6.m_RawKey, _loc_6.m_RawMod, _loc_6.m_RawText);
                return;
            }
            var _loc_5:* = uint(param1);
            if ((this.m_EventMask & InputEvent.KEY_ANY) != 0)
            {
                if (!isBindable(param2))
                {
                    throw new ArgumentError("Binding.set updateBinding: Invalid keyCode: " + param2);
                }
                if (!isControlKey(param2) && _loc_5 == 0)
                {
                    throw new ArgumentError("Binding.set updateBinding: Invalid keyCode/charCode combination: " + param2 + "/" + _loc_5);
                }
                if (param3 != 0 && param3 != Keyboard.ALTERNATE && param3 != Keyboard.CONTROL && param3 != Keyboard.SHIFT)
                {
                    throw new ArgumentError("Binding.set updateBinding: Invalid modifier: " + param3);
                }
            }
            else
            {
                _loc_5 = 0;
                param2 = 0;
                param3 = 0;
                param4 = null;
            }
            if (this.m_RawChar != _loc_5 || this.m_RawKey != param2 || this.m_RawMod != param3 || this.m_RawText != param4)
            {
                this.m_RawChar = _loc_5;
                this.m_RawKey = param2;
                this.m_RawMod = param3;
                this.m_RawText = param4;
                this.m_ToString = null;
            }
            return;
        }// end function

        public function marshall() : XML
        {
            var _loc_1:* = new XML("<binding keyCode=\"" + this.m_RawKey + "\" modifierCode=\"" + this.m_RawMod + "\">\r\n                    " + this.m_Action.marshall() + "\r\n                  </binding>");
            if (this.m_RawChar != 0)
            {
                _loc_1.@charCode = this.m_RawChar;
            }
            if (this.m_RawText != null)
            {
                _loc_1.@text = this.m_RawText;
            }
            return _loc_1;
        }// end function

        public function toString() : String
        {
            if (this.m_ToString == null)
            {
                this.m_ToString = this.formatAsString();
            }
            return this.m_ToString;
        }// end function

        public function clone() : Binding
        {
            if (this.m_Editable)
            {
                return new Binding(this.m_Action.clone(), this.m_RawChar, this.m_RawKey, this.m_RawMod, this.m_RawText, this.m_Editable);
            }
            return this;
        }// end function

        public function conflicts(param1:Binding) : Boolean
        {
            var _loc_2:* = false;
            var _loc_3:* = false;
            if (param1 != null)
            {
                _loc_2 = (this.m_EventMask & InputEvent.KEY_ANY) != 0;
                _loc_3 = (param1.m_EventMask & InputEvent.KEY_ANY) != 0;
                if (_loc_2 == _loc_3 && (this.m_RawKey == param1.m_RawKey && this.m_RawMod == param1.m_RawMod))
                {
                    return true;
                }
                if (_loc_2 && !_loc_3 && (this.m_RawMod == 0 || this.m_RawMod == Keyboard.SHIFT) && !isControlKey(this.m_RawKey))
                {
                    return true;
                }
                if (!_loc_2 && _loc_3 && (param1.m_RawMod == 0 || param1.m_RawMod == Keyboard.SHIFT) && !isControlKey(param1.m_RawKey))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function get modifierCode() : uint
        {
            return this.m_RawMod;
        }// end function

        private function mapCharCode() : uint
        {
            var _loc_4:* = null;
            if (isControlKey(this.m_RawKey))
            {
                return 0;
            }
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = this.m_RawChar;
            for each (_loc_4 in LOCALE_MAPPING)
            {
                
                _loc_2 = 0;
                if (_loc_4.hasOwnProperty("char"))
                {
                    if (_loc_4.char != this.m_RawChar)
                    {
                        continue;
                    }
                    _loc_2++;
                }
                if (_loc_4.hasOwnProperty("key"))
                {
                    if (_loc_4.key != this.m_RawKey)
                    {
                        continue;
                    }
                    _loc_2++;
                }
                if (_loc_4.hasOwnProperty("modifier"))
                {
                    if (_loc_4.modifier != this.m_RawMod)
                    {
                        continue;
                    }
                    _loc_2++;
                }
                if (_loc_4.hasOwnProperty("text"))
                {
                    if (_loc_4.text != this.m_RawText)
                    {
                        continue;
                    }
                    _loc_2++;
                }
                if (_loc_2 > _loc_1)
                {
                    _loc_1 = _loc_2;
                    _loc_3 = _loc_4.result;
                    continue;
                }
                if (_loc_2 == _loc_1)
                {
                }
            }
            return _loc_3;
        }// end function

        public function appliesTo(param1:uint, param2:uint, param3:Boolean, param4:Boolean, param5:Boolean) : Boolean
        {
            return (this.m_EventMask & param1) != 0 && this.m_RawKey == param2 && (this.m_RawMod != 0 || !param3 && !param4 && !param5) && (this.m_RawMod != Keyboard.ALTERNATE || param3 && !param4 && !param5) && (this.m_RawMod != Keyboard.CONTROL || !param3 && param4 && !param5) && (this.m_RawMod != Keyboard.SHIFT || !param3 && !param4 && param5);
        }// end function

        public function get editable() : Boolean
        {
            return this.m_Editable;
        }// end function

        public function get keyCode() : uint
        {
            return this.m_RawKey;
        }// end function

        public function get action() : IAction
        {
            return this.m_Action;
        }// end function

        public function equals(param1:Binding) : Boolean
        {
            return param1 != null && this.m_Action.equals(param1.m_Action) && this.m_EventMask == param1.m_EventMask && this.m_RawKey == param1.m_RawKey && this.m_RawMod == param1.m_RawMod && this.m_Editable == param1.m_Editable;
        }// end function

        public static function isBindable(param1:uint, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : Boolean
        {
            return param1 != Keyboard.ALTERNATE && param1 != Keyboard.COMMAND && param1 != Keyboard.CONTROL && param1 != Keyboard.SHIFT && param1 != 12 && param1 != 19 && param1 != 20 && param1 != 44 && param1 != 91 && param1 != 92 && param1 != 93 && param1 != 144 && param1 != 145 && (!param2 && !param3 && !param4 || param2 && !param3 && !param4 || !param2 && param3 && !param4 || !param2 && !param3 && param4);
        }// end function

        public static function unmarshall(param1:XML, param2:Number) : Binding
        {
            if (param1 == null || param1.localName() != "binding" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("Binding.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_9:* = param1.@charCode;
            _loc_3 = param1.@charCode;
            if (_loc_9 != null && _loc_3.length() == 1)
            {
                _loc_4 = parseInt(_loc_3.toString());
            }
            var _loc_9:* = param1.@keyCode;
            _loc_3 = param1.@keyCode;
            if (_loc_9 == null || _loc_3.length() != 1)
            {
                return null;
            }
            var _loc_5:* = parseInt(_loc_3[0].toString());
            var _loc_6:* = null;
            var _loc_9:* = param1.@text;
            _loc_3 = param1.@text;
            if (_loc_9 != null && _loc_3.length() == 1)
            {
                _loc_6 = _loc_3[0].toString();
            }
            var _loc_9:* = param1.@modifierCode;
            _loc_3 = param1.@modifierCode;
            if (_loc_9 == null || _loc_3.length() != 1)
            {
                return null;
            }
            var _loc_7:* = parseInt(_loc_3.toString());
            var _loc_9:* = param1.action;
            _loc_3 = param1.action;
            if (_loc_9 == null || _loc_3.length() < 1)
            {
                return null;
            }
            var _loc_8:* = StaticAction.s_Unmarshall(_loc_3[0], param2);
            if (StaticAction.s_Unmarshall(_loc_3[0], param2) != null)
            {
                return new Binding(_loc_8, _loc_4, _loc_5, _loc_7, _loc_6);
            }
            return null;
        }// end function

        public static function isControlKey(param1:uint) : Boolean
        {
            return param1 == 0 || param1 == Keyboard.BACKSPACE || param1 == Keyboard.TAB || param1 == Keyboard.ENTER || param1 >= Keyboard.COMMAND && param1 <= Keyboard.ALTERNATE || param1 >= Keyboard.CAPS_LOCK && param1 <= Keyboard.NUMPAD || param1 == Keyboard.ESCAPE || param1 >= Keyboard.PAGE_UP && param1 <= Keyboard.DOWN || param1 >= Keyboard.INSERT && param1 <= Keyboard.DELETE || param1 >= Keyboard.NUMPAD_0 && param1 <= Keyboard.NUMPAD_DIVIDE || param1 >= Keyboard.F1 && param1 <= Keyboard.F15 || param1 == 91 || param1 == 92 || param1 == 93;
        }// end function

        public static function toModifierCode(param1:Boolean, param2:Boolean, param3:Boolean) : uint
        {
            return param1 ? (Keyboard.ALTERNATE) : (param2 ? (Keyboard.CONTROL) : (param3 ? (Keyboard.SHIFT) : (0)));
        }// end function

    }
}
