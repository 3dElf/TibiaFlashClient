package tibia.actionbar
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;
    import mx.resources.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.input.mapping.*;
    import tibia.input.staticaction.*;
    import tibia.options.*;

    public class ActionBar extends EventDispatcher
    {
        protected var m_Visible:Boolean = false;
        protected var m_Actions:Vector.<IAction> = null;
        protected var m_Location:int = -1;
        public static const NUM_ACTIONS:int = 30;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        public static const BUNDLE:String = "ActionBarWidget";
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function ActionBar(param1:int)
        {
            this.m_Actions = new Vector.<IAction>(NUM_ACTIONS, true);
            if (param1 != ActionBarSet.LOCATION_TOP && param1 != ActionBarSet.LOCATION_BOTTOM && param1 != ActionBarSet.LOCATION_LEFT && param1 != ActionBarSet.LOCATION_RIGHT)
            {
                throw new ArgumentError("ActionBar.ActionBar: Invalid location.");
            }
            this.m_Location = param1;
            this.m_Visible = false;
            return;
        }// end function

        public function get size() : int
        {
            return this.m_Actions.length;
        }// end function

        public function getTrigger(param1:int) : IAction
        {
            return StaticActionList.getActionButtonTrigger(this.m_Location, param1);
        }// end function

        public function getBindings(param1:int, param2:int = -1) : Array
        {
            return ActionBar.getBindings(this.m_Location, param1, param2);
        }// end function

        public function get length() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = this.m_Actions.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.m_Actions[_loc_2] != null)
                {
                    _loc_1++;
                }
                _loc_2 = _loc_2 - 1;
            }
            return _loc_1;
        }// end function

        public function perform(param1:int) : void
        {
            var a_Index:* = param1;
            if (this.m_Actions[a_Index] != null)
            {
                try
                {
                    this.m_Actions[a_Index].perform();
                }
                catch (_Error)
                {
                }
            }
            return;
        }// end function

        public function set location(param1:int) : void
        {
            var _loc_2:* = this.location;
            if (_loc_2 !== param1)
            {
                this._1901043637location = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "location", _loc_2, param1));
            }
            return;
        }// end function

        public function getAction(param1:int) : IAction
        {
            return this.m_Actions[param1];
        }// end function

        private function set _466743410visible(param1:Boolean) : void
        {
            this.m_Visible = param1;
            return;
        }// end function

        private function set _1901043637location(param1:int) : void
        {
            if (param1 != ActionBarSet.LOCATION_TOP && param1 != ActionBarSet.LOCATION_BOTTOM && param1 != ActionBarSet.LOCATION_LEFT && param1 != ActionBarSet.LOCATION_RIGHT)
            {
                throw new ArgumentError("ActionBar.location: Invalid location.");
            }
            this.m_Location = param1;
            return;
        }// end function

        public function get visible() : Boolean
        {
            return this.m_Visible;
        }// end function

        public function get location() : int
        {
            return this.m_Location;
        }// end function

        public function setAction(param1:int, param2:IAction) : void
        {
            var _loc_3:* = null;
            if (this.m_Actions[param1] != param2)
            {
                this.m_Actions[param1] = param2;
                _loc_3 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_3.kind = PropertyChangeEventKind.UPDATE;
                _loc_3.property = "action";
                _loc_3.newValue = param2;
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            var _loc_2:* = this.visible;
            if (_loc_2 !== param1)
            {
                this._466743410visible = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "visible", _loc_2, param1));
            }
            return;
        }// end function

        public function marshall() : XML
        {
            var _loc_3:* = null;
            var _loc_1:* = new XML("<actionbar visible=\"" + this.m_Visible + "\"></actionbar>");
            var _loc_2:* = 0;
            while (_loc_2 < this.m_Actions.length)
            {
                
                if (this.m_Actions[_loc_2] != null)
                {
                    _loc_3 = this.m_Actions[_loc_2].marshall();
                    _loc_3.@index = _loc_2;
                    _loc_1.appendChild(_loc_3);
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function getLabel(param1:int) : String
        {
            return ActionBar.getLabel(this.m_Location, param1);
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : ActionBar
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            if (param1 == null || param1.localName() != "actionbar" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("ActionBar.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_10:* = param1.@location;
            _loc_3 = param1.@location;
            if (_loc_10 == null || _loc_3.length() != 1)
            {
                return null;
            }
            var _loc_4:* = parseInt(_loc_3[0].toString());
            if (parseInt(_loc_3[0].toString()) != ActionBarSet.LOCATION_TOP && _loc_4 != ActionBarSet.LOCATION_BOTTOM && _loc_4 != ActionBarSet.LOCATION_LEFT && _loc_4 != ActionBarSet.LOCATION_RIGHT)
            {
                return null;
            }
            var _loc_5:* = new ActionBar(_loc_4);
            var _loc_10:* = param1.@visible;
            _loc_3 = param1.@visible;
            if (_loc_10 != null && _loc_3.length() == 1)
            {
                _loc_5.visible = _loc_3[0].toString() == "true";
            }
            for each (_loc_6 in param1.elements("action"))
            {
                
                _loc_7 = null;
                var _loc_12:* = _loc_6.@type;
                _loc_3 = _loc_6.@type;
                if (_loc_12 != null && _loc_3.length() == 1)
                {
                    _loc_7 = _loc_3[0].toString();
                }
                _loc_8 = null;
                switch(_loc_7)
                {
                    case "equip":
                    {
                        _loc_8 = EquipAction.s_Unmarshall(_loc_6, param2);
                        break;
                    }
                    case "spell":
                    {
                        _loc_8 = SpellAction.s_Unmarshall(_loc_6, param2);
                        break;
                    }
                    case "talk":
                    {
                        _loc_8 = TalkAction.s_Unmarshall(_loc_6, param2);
                        break;
                    }
                    case "use":
                    {
                        _loc_8 = UseAction.s_Unmarshall(_loc_6, param2);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_9 = -1;
                var _loc_12:* = _loc_6.@index;
                _loc_3 = _loc_6.@index;
                if (_loc_12 != null && _loc_3.length() == 1)
                {
                    _loc_9 = parseInt(_loc_3[0].toString());
                }
                if (_loc_9 >= 0 && _loc_9 < NUM_ACTIONS && _loc_8 != null)
                {
                    _loc_5.setAction(_loc_9, _loc_8);
                }
            }
            return _loc_5;
        }// end function

        public static function getBindings(param1:int, param2:int, param3:int = -1) : Array
        {
            if (param2 < 0 || param2 >= NUM_ACTIONS)
            {
                throw new RangeError("ActionBar.getBindings: Invalid slot index: " + param2);
            }
            var _loc_4:* = Tibia.s_GetOptions();
            if (Tibia.s_GetOptions() == null)
            {
                return [];
            }
            if (param3 < 0)
            {
                param3 = _loc_4.generalInputSetID;
            }
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = _loc_4.getMappingSet(param3);
            _loc_5 = _loc_4.getMappingSet(param3);
            var _loc_7:* = _loc_4.generalInputSetMode == MappingSet.CHAT_MODE_OFF ? (_loc_5.chatModeOff) : (_loc_5.chatModeOn);
            _loc_6 = _loc_4.generalInputSetMode == MappingSet.CHAT_MODE_OFF ? (_loc_5.chatModeOff) : (_loc_5.chatModeOn);
            if (_loc_7 == null || _loc_7 == null)
            {
                throw new ArgumentError("ActionBar.getBindings: Invalid input set: " + param3);
            }
            return _loc_6.getBindingsByAction(StaticActionList.getActionButtonTrigger(param1, param2));
        }// end function

        public static function getLabel(param1:int, param2:int) : String
        {
            if (param2 < 0 || param2 >= NUM_ACTIONS)
            {
                throw new RangeError("ActionBar.getLabel: Invalid slot: " + param2);
            }
            var _loc_3:* = null;
            switch(param1)
            {
                case ActionBarSet.LOCATION_BOTTOM:
                {
                    _loc_3 = "BAR_LABEL_BOTTOM";
                    break;
                }
                case ActionBarSet.LOCATION_LEFT:
                {
                    _loc_3 = "BAR_LABEL_LEFT";
                    break;
                }
                case ActionBarSet.LOCATION_RIGHT:
                {
                    _loc_3 = "BAR_LABEL_RIGHT";
                    break;
                }
                case ActionBarSet.LOCATION_TOP:
                {
                    _loc_3 = "BAR_LABEL_TOP";
                    break;
                }
                default:
                {
                    throw new RangeError("ActionBar.getLabel: Invalid location: " + param1);
                    break;
                }
            }
            return ResourceManager.getInstance().getString(BUNDLE, _loc_3, [(param2 + 1)]);
        }// end function

    }
}
