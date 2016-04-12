package tibia.input.mapping
{
    import __AS3__.vec.*;
    import tibia.input.*;
    import tibia.input.staticaction.*;

    public class Mapping extends Object
    {
        protected var m_Binding:Vector.<Binding>;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function Mapping()
        {
            this.m_Binding = new Vector.<Binding>;
            return;
        }// end function

        public function addAll(param1) : Boolean
        {
            if (!(param1 is Array) && !(param1 is Vector.<Binding>))
            {
                throw new ArgumentError("Mapping.addAll: Invalid input(1).");
            }
            var _loc_2:* = param1.length;
            var _loc_3:* = this.m_Binding.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                if (param1[_loc_4] == null)
                {
                    throw new ArgumentError("Mapping.addAll: Invalid input(2).");
                }
                if (this.getConflictingBinding(param1[_loc_4]) != null)
                {
                    this.m_Binding.length = _loc_3;
                    return false;
                }
                this.m_Binding.push(param1[_loc_4].clone());
                _loc_4++;
            }
            return true;
        }// end function

        public function clone() : Mapping
        {
            var _loc_1:* = new Mapping();
            var _loc_2:* = this.m_Binding.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_1.m_Binding[_loc_3] = this.m_Binding[_loc_3].clone();
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function get binding() : Vector.<Binding>
        {
            return this.m_Binding;
        }// end function

        function onKeyInput(param1:uint, param2:uint, param3:uint, param4:Boolean, param5:Boolean, param6:Boolean) : void
        {
            var b:Binding;
            var _Action:IAction;
            var a_Event:* = param1;
            var a_Char:* = param2;
            var a_Key:* = param3;
            var a_Alt:* = param4;
            var a_Ctrl:* = param5;
            var a_Shift:* = param6;
            var _loc_8:* = 0;
            var _loc_9:* = this.m_Binding;
            while (_loc_9 in _loc_8)
            {
                
                b = _loc_9[_loc_8];
                if (a_Alt && (a_Ctrl || a_Shift) && b.appliesTo(a_Event, a_Key, true, false, false) || a_Ctrl && (a_Alt || a_Shift) && b.appliesTo(a_Event, a_Key, false, true, false) || a_Shift && (a_Alt || a_Ctrl) && b.appliesTo(a_Event, a_Key, false, false, true) || a_Alt && a_Ctrl && b.appliesTo(a_Event, a_Key, false, false, false) || a_Alt && a_Shift && b.appliesTo(a_Event, a_Key, false, false, false) || a_Ctrl && a_Shift && b.appliesTo(a_Event, a_Key, false, false, false) || b.appliesTo(a_Event, a_Key, a_Alt, a_Ctrl, a_Shift))
                {
                    try
                    {
                        _Action = b.action;
                        if (_Action is StaticAction)
                        {
                            StaticAction(_Action).keyCallback(a_Event, a_Char, a_Key, a_Alt, a_Ctrl, a_Shift);
                        }
                        else
                        {
                            _Action.perform(a_Event == InputEvent.KEY_REPEAT);
                        }
                    }
                    catch (e:Error)
                    {
                    }
                    break;
                }
            }
            return;
        }// end function

        public function getConflictingBinding(param1:Binding) : Binding
        {
            var _loc_2:* = null;
            if (param1 == null)
            {
                throw new ArgumentError("Mapping.getConflictingBinding: Invalid binding.");
            }
            for each (_loc_2 in this.m_Binding)
            {
                
                if (_loc_2.conflicts(param1))
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function marshall(param1:Boolean = true) : XML
        {
            var _loc_2:* = <mapping></mapping>;
            var _loc_3:* = this.m_Binding.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this.m_Binding[_loc_4] != null && (!param1 || this.m_Binding[_loc_4].editable))
                {
                    _loc_2.appendChild(this.m_Binding[_loc_4].marshall());
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function getBindingsByAction(param1:IAction) : Array
        {
            if (param1 == null)
            {
                throw new ArgumentError("Mapping.getBindingsByAction: Invalid action.");
            }
            var _loc_2:* = [];
            var _loc_3:* = this.m_Binding.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this.m_Binding[_loc_4].action.equals(param1))
                {
                    _loc_2.push(this.m_Binding[_loc_4]);
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function addItem(param1:Binding) : Boolean
        {
            if (param1 == null)
            {
                throw new ArgumentError("Mapping.addItem: Invalid binding.");
            }
            if (this.getConflictingBinding(param1) != null)
            {
                return false;
            }
            this.m_Binding.push(param1.clone());
            return true;
        }// end function

        public function removeItem(param1:Binding) : void
        {
            var _loc_2:* = this.m_Binding.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.m_Binding[_loc_2].equals(param1))
                {
                    this.m_Binding.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        private function addItemInternal(param1:Binding) : Boolean
        {
            if (param1 == null)
            {
                throw new ArgumentError("Mapping.addItemInternal: Invalid binding.");
            }
            var _loc_2:* = this.m_Binding.length - 1;
            var _loc_3:* = 0;
            while (_loc_2 >= 0)
            {
                
                if (this.m_Binding[_loc_2].conflicts(param1))
                {
                    if (!this.m_Binding[_loc_2].editable)
                    {
                        return false;
                    }
                    this.m_Binding[_loc_2] = param1;
                    return true;
                }
                if (this.m_Binding[_loc_2].action.equals(param1.action) && ++_loc_3 > 2)
                {
                    return false;
                }
                _loc_2 = _loc_2 - 1;
            }
            this.m_Binding.push(param1);
            return true;
        }// end function

        public function removeAll(param1:Boolean = true) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (!param1)
            {
                this.m_Binding.length = 0;
            }
            else
            {
                _loc_2 = this.m_Binding.length;
                _loc_3 = _loc_2 - 1;
                while (_loc_3 >= 0)
                {
                    
                    if (this.m_Binding[_loc_3] == null || this.m_Binding[_loc_3].editable)
                    {
                        _loc_2 = _loc_2 - 1;
                        _loc_4 = this.m_Binding[_loc_2];
                        this.m_Binding[_loc_2] = this.m_Binding[_loc_3];
                        this.m_Binding[_loc_3] = _loc_4;
                    }
                    _loc_3 = _loc_3 - 1;
                }
                this.m_Binding.length = _loc_2;
            }
            return;
        }// end function

        function onTextInput(param1:uint, param2:String) : void
        {
            var b:Binding;
            var a_Event:* = param1;
            var a_Text:* = param2;
            var _loc_4:* = 0;
            var _loc_5:* = this.m_Binding;
            while (_loc_5 in _loc_4)
            {
                
                b = _loc_5[_loc_4];
                if (b.appliesTo(a_Event, 0, false, false, false))
                {
                    try
                    {
                        if (b.action is StaticAction)
                        {
                            StaticAction(b.action).textCallback(a_Event, a_Text);
                        }
                        else
                        {
                            b.action.perform();
                        }
                    }
                    catch (e:Error)
                    {
                    }
                    break;
                }
            }
            return;
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number, param3:Mapping) : Mapping
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1 == null || param1.localName() != "mapping" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("Mapping.s_Unmarshall: Invalid input.");
            }
            if (param3 == null)
            {
                throw new Error("Mapping.s_Unmarshall: Invalid mapping.");
            }
            for each (_loc_4 in param1.elements("binding"))
            {
                
                _loc_5 = Binding.unmarshall(_loc_4, param2);
                if (_loc_5 != null)
                {
                    param3.addItemInternal(_loc_5);
                }
            }
            return param3;
        }// end function

    }
}
