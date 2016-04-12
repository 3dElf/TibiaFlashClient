package tibia.input.staticaction
{
    import __AS3__.vec.*;
    import mx.resources.*;
    import tibia.input.*;

    public class StaticAction extends Object implements IAction
    {
        protected var m_Label:String = null;
        protected var m_ID:int = 0;
        protected var m_EventMask:uint = 0;
        protected var m_Hidden:Boolean = true;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        static const BUNDLE:String = "StaticAction";
        static const s_Action:Vector.<StaticAction> = new Vector.<StaticAction>;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function StaticAction(param1:int, param2:String = null, param3:uint = 0, param4:Boolean = false)
        {
            if (param1 < 0 || param1 > 65535)
            {
                throw new ArgumentError("StaticAction.StaticAction: ID out of range: " + param1);
            }
            this.m_ID = param1;
            this.m_Label = param2;
            this.m_EventMask = param3;
            this.m_Hidden = param4;
            StaticAction.s_RegisterAction(this);
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            throw new Error("StaticAction.perform: Needs to be implemented by a subclass.");
        }// end function

        public function get eventMask() : uint
        {
            return this.m_EventMask;
        }// end function

        public function get hidden() : Boolean
        {
            return this.m_Hidden;
        }// end function

        function keyCallback(param1:uint, param2:uint, param3:uint, param4:Boolean, param5:Boolean, param6:Boolean) : void
        {
            this.perform(param1 == InputEvent.KEY_REPEAT);
            return;
        }// end function

        public function marshall() : XML
        {
            return new XML("<action type=\"static\" object=\"" + this.m_ID + "\"/>");
        }// end function

        function textCallback(param1:uint, param2:String) : void
        {
            this.perform(false);
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = ResourceManager.getInstance();
            var _loc_2:* = null;
            if (this.m_Label != null)
            {
                _loc_2 = _loc_1.getString(BUNDLE, this.m_Label);
            }
            else
            {
                _loc_2 = _loc_1.getString(BUNDLE, "UNKNOWN_ACTION");
            }
            if (_loc_2 == null || _loc_2.length < 1)
            {
                _loc_2 = this.m_Label;
            }
            return _loc_2;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function clone() : IAction
        {
            return this;
        }// end function

        public function equals(param1:IAction) : Boolean
        {
            return param1 === this;
        }// end function

        public static function s_GetAction(param1:int) : StaticAction
        {
            var _loc_2:* = s_Action.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (s_Action[_loc_2].ID == param1)
                {
                    return s_Action[_loc_2];
                }
                _loc_2 = _loc_2 - 1;
            }
            return null;
        }// end function

        public static function s_RegisterAction(param1:StaticAction) : void
        {
            if (param1 == null)
            {
                throw new ArgumentError("StaticActionList.s_RegisterAction: Invalid action.");
            }
            if (s_GetAction(param1.ID) != null)
            {
                throw new ArgumentError("StaticActionList.s_RegsiterAction: Action " + param1.ID + " is not unique.");
            }
            s_Action.push(param1);
            return;
        }// end function

        public static function s_GetAllActions() : Vector.<StaticAction>
        {
            return s_Action.slice();
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : IAction
        {
            var _loc_4:* = 0;
            if (param1 == null || param1.localName() != "action" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("StaticAction.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_5:* = param1.@type;
            _loc_3 = param1.@type;
            if (_loc_5 == null || _loc_3.length() != 1 || _loc_3[0].toString() != "static")
            {
                return null;
            }
            var _loc_5:* = param1.@object;
            _loc_3 = param1.@object;
            if (_loc_5 != null && _loc_3.length() == 1)
            {
                _loc_4 = parseInt(_loc_3[0].toString());
                return StaticAction.s_GetAction(_loc_4);
            }
            return null;
        }// end function

    }
}
