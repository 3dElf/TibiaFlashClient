package tibia.input
{
    import flash.events.*;
    import flash.ui.*;
    import mx.events.*;
    import mx.resources.*;
    import shared.utility.*;
    import tibia.input.mapping.*;
    import tibia.input.staticaction.*;

    public class MappingSet extends Object implements IEventDispatcher
    {
        protected var m_ChatModeOn:Mapping = null;
        protected var m_ChatModeOff:Mapping = null;
        protected var m_ID:int = 0;
        private var _bindingEventDispatcher:EventDispatcher;
        protected var m_Name:String = null;
        public static const DEFAULT_SET:int = 0;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        public static const NUM_SETS:int = 12;
        public static const CHAT_MODE_OFF_DEFAULT_BINDINGS:Array = [new Binding(StaticActionList.MISC_LOGOUT_CHARACTER, "Q", Keyboard.Q, Keyboard.CONTROL), new Binding(StaticActionList.MISC_CHANGE_CHARACTER, "F", Keyboard.F, Keyboard.CONTROL), new Binding(StaticActionList.MISC_SHOW_EDIT_OPTIONS, "Z", Keyboard.Z, Keyboard.CONTROL), new Binding(StaticActionList.MISC_SHOW_EDIT_HOTKEYS, "K", Keyboard.K, Keyboard.CONTROL), new Binding(StaticActionList.PLAYER_MOUNT, "M", Keyboard.M, Keyboard.CONTROL), new Binding(StaticActionList.PLAYER_CANCEL, 0, Keyboard.ESCAPE, 0), new Binding(StaticActionList.MISC_TOGGLE_MAPPING_MODE, 0, Keyboard.ENTER, Keyboard.CONTROL), new Binding(StaticActionList.CHAT_COPYPASTE_SELECT, "A", Keyboard.A, Keyboard.CONTROL, null, false), new Binding(StaticActionList.CHAT_COPYPASTE_COPY, "C", Keyboard.C, Keyboard.CONTROL, null, false), new Binding(StaticActionList.CHAT_SEND_TEXT, 0, Keyboard.ENTER, 0, null, false), new Binding(StaticActionList.PLAYER_MOVE_UP, 0, Keyboard.UP, 0), new Binding(StaticActionList.PLAYER_MOVE_UP, 0, Keyboard.NUMPAD_8, 0), new Binding(StaticActionList.PLAYER_MOVE_LEFT, 0, Keyboard.LEFT, 0), new Binding(StaticActionList.PLAYER_MOVE_LEFT, 0, Keyboard.NUMPAD_4, 0), new Binding(StaticActionList.PLAYER_MOVE_RIGHT, 0, Keyboard.RIGHT, 0), new Binding(StaticActionList.PLAYER_MOVE_RIGHT, 0, Keyboard.NUMPAD_6, 0), new Binding(StaticActionList.PLAYER_MOVE_DOWN, 0, Keyboard.DOWN, 0), new Binding(StaticActionList.PLAYER_MOVE_DOWN, 0, Keyboard.NUMPAD_2, 0), new Binding(StaticActionList.PLAYER_MOVE_UP_LEFT, 0, Keyboard.NUMPAD_7, 0), new Binding(StaticActionList.PLAYER_MOVE_DOWN_LEFT, 0, Keyboard.NUMPAD_1, 0), new Binding(StaticActionList.PLAYER_MOVE_UP_RIGHT, 0, Keyboard.NUMPAD_9, 0), new Binding(StaticActionList.PLAYER_MOVE_DOWN_RIGHT, 0, Keyboard.NUMPAD_3, 0), new Binding(StaticActionList.PLAYER_TURN_UP, 0, Keyboard.UP, Keyboard.CONTROL), new Binding(StaticActionList.PLAYER_TURN_LEFT, 0, Keyboard.LEFT, Keyboard.CONTROL), new Binding(StaticActionList.PLAYER_TURN_RIGHT, 0, Keyboard.RIGHT, Keyboard.CONTROL), new Binding(StaticActionList.PLAYER_TURN_DOWN, 0, Keyboard.DOWN, Keyboard.CONTROL)];
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
        private static const BUNDLE:String = "InputHandler";
        public static const CHAT_MODE_ON_DEFAULT_BINDINGS:Array = [new Binding(StaticActionList.MISC_LOGOUT_CHARACTER, "Q", Keyboard.Q, Keyboard.CONTROL), new Binding(StaticActionList.MISC_CHANGE_CHARACTER, "F", Keyboard.F, Keyboard.CONTROL), new Binding(StaticActionList.MISC_SHOW_EDIT_OPTIONS, "Z", Keyboard.Z, Keyboard.CONTROL), new Binding(StaticActionList.MISC_SHOW_EDIT_HOTKEYS, "K", Keyboard.K, Keyboard.CONTROL), new Binding(StaticActionList.PLAYER_MOUNT, "M", Keyboard.M, Keyboard.CONTROL), new Binding(StaticActionList.PLAYER_CANCEL, 0, Keyboard.ESCAPE, 0), new Binding(StaticActionList.MISC_TOGGLE_MAPPING_MODE, 0, Keyboard.ENTER, Keyboard.CONTROL), new Binding(StaticActionList.CHAT_MOVE_CURSOR_LEFT, 0, Keyboard.LEFT, Keyboard.SHIFT), new Binding(StaticActionList.CHAT_MOVE_CURSOR_RIGHT, 0, Keyboard.RIGHT, Keyboard.SHIFT), new Binding(StaticActionList.CHAT_HISTORY_PREV, 0, Keyboard.UP, Keyboard.SHIFT), new Binding(StaticActionList.CHAT_HISTORY_NEXT, 0, Keyboard.DOWN, Keyboard.SHIFT), new Binding(StaticActionList.CHAT_TEXT_INPUT, 0, 0, 0, null, false), new Binding(StaticActionList.CHAT_MOVE_CURSOR_HOME, 0, Keyboard.HOME, 0, null, false), new Binding(StaticActionList.CHAT_MOVE_CURSOR_END, 0, Keyboard.END, 0, null, false), new Binding(StaticActionList.CHAT_COPYPASTE_SELECT, "A", Keyboard.A, Keyboard.CONTROL, null, false), new Binding(StaticActionList.CHAT_COPYPASTE_COPY, "C", Keyboard.C, Keyboard.CONTROL, null, false), new Binding(StaticActionList.CHAT_COPYPASTE_INSERT, "V", Keyboard.V, Keyboard.CONTROL, null, false), new Binding(StaticActionList.CHAT_COPYPASTE_CUT, "X", Keyboard.X, Keyboard.CONTROL, null, false), new Binding(StaticActionList.CHAT_DELETE_PREV, 0, Keyboard.BACKSPACE, 0, null, false), new Binding(StaticActionList.CHAT_DELETE_NEXT, 0, Keyboard.DELETE, 0, null, false), new Binding(StaticActionList.CHAT_SEND_TEXT, 0, Keyboard.ENTER, 0, null, false), new Binding(StaticActionList.PLAYER_MOVE_UP, 0, Keyboard.UP, 0), new Binding(StaticActionList.PLAYER_MOVE_UP, 0, Keyboard.NUMPAD_8, 0), new Binding(StaticActionList.PLAYER_MOVE_LEFT, 0, Keyboard.LEFT, 0), new Binding(StaticActionList.PLAYER_MOVE_LEFT, 0, Keyboard.NUMPAD_4, 0), new Binding(StaticActionList.PLAYER_MOVE_RIGHT, 0, Keyboard.RIGHT, 0), new Binding(StaticActionList.PLAYER_MOVE_RIGHT, 0, Keyboard.NUMPAD_6, 0), new Binding(StaticActionList.PLAYER_MOVE_DOWN, 0, Keyboard.DOWN, 0), new Binding(StaticActionList.PLAYER_MOVE_DOWN, 0, Keyboard.NUMPAD_2, 0), new Binding(StaticActionList.PLAYER_MOVE_UP_LEFT, 0, Keyboard.NUMPAD_7, 0), new Binding(StaticActionList.PLAYER_MOVE_DOWN_LEFT, 0, Keyboard.NUMPAD_1, 0), new Binding(StaticActionList.PLAYER_MOVE_UP_RIGHT, 0, Keyboard.NUMPAD_9, 0), new Binding(StaticActionList.PLAYER_MOVE_DOWN_RIGHT, 0, Keyboard.NUMPAD_3, 0), new Binding(StaticActionList.PLAYER_TURN_UP, 0, Keyboard.UP, Keyboard.CONTROL), new Binding(StaticActionList.PLAYER_TURN_LEFT, 0, Keyboard.LEFT, Keyboard.CONTROL), new Binding(StaticActionList.PLAYER_TURN_RIGHT, 0, Keyboard.RIGHT, Keyboard.CONTROL), new Binding(StaticActionList.PLAYER_TURN_DOWN, 0, Keyboard.DOWN, Keyboard.CONTROL)];
        public static const CHAT_MODE_OFF:int = 1;
        public static const CHAT_MODE_ON:int = 0;
        public static const CHAT_MODE_TEMPORARY:int = 2;
        private static const MAX_NAME_LENGTH:int = 10;

        public function MappingSet(param1:int, param2:String = null) : void
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this.m_ID = param1;
            this.m_ChatModeOn = new Mapping();
            this.m_ChatModeOff = new Mapping();
            this.m_Name = s_GetSanitizedSetName(param1, param2, true);
            return;
        }// end function

        private function set _1836514214chatModeOn(param1:Mapping) : void
        {
            if (param1 != null)
            {
                this.m_ChatModeOn = param1;
            }
            else
            {
                throw new ArgumentError("MappingSet.set chatModeOn: Invalid mapping.");
            }
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return this._bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return this._bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return this._bindingEventDispatcher.dispatchEvent(event);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            this._bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            this._bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function marshall() : XML
        {
            var _loc_1:* = this.m_ChatModeOn.marshall();
            _loc_1.@mode = CHAT_MODE_ON;
            var _loc_2:* = this.m_ChatModeOff.marshall();
            _loc_2.@mode = CHAT_MODE_OFF;
            return new XML("<mappingset id=\"" + this.m_ID + "\" name=\"" + this.m_Name + "\">" + _loc_1 + _loc_2 + "</mappingset>");
        }// end function

        function changeID(param1:int) : void
        {
            this.m_ID = param1;
            return;
        }// end function

        public function get chatModeOff() : Mapping
        {
            return this.m_ChatModeOff;
        }// end function

        public function set name(param1:String) : void
        {
            var _loc_2:* = this.name;
            if (_loc_2 !== param1)
            {
                this._3373707name = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "name", _loc_2, param1));
            }
            return;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        private function set _3373707name(param1:String) : void
        {
            this.m_Name = s_GetSanitizedSetName(this.m_ID, param1, true);
            return;
        }// end function

        public function clone() : MappingSet
        {
            var _loc_1:* = new MappingSet(this.m_ID);
            _loc_1.m_ChatModeOn = this.m_ChatModeOn.clone();
            _loc_1.m_ChatModeOff = this.m_ChatModeOff.clone();
            return _loc_1;
        }// end function

        public function get chatModeOn() : Mapping
        {
            return this.m_ChatModeOn;
        }// end function

        private function set _1097365932chatModeOff(param1:Mapping) : void
        {
            if (param1 != null)
            {
                this.m_ChatModeOff = param1;
            }
            else
            {
                throw new ArgumentError("MappingSet.set chatModeOff: Invalid mapping.");
            }
            return;
        }// end function

        public function set chatModeOff(param1:Mapping) : void
        {
            var _loc_2:* = this.chatModeOff;
            if (_loc_2 !== param1)
            {
                this._1097365932chatModeOff = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chatModeOff", _loc_2, param1));
            }
            return;
        }// end function

        public function set chatModeOn(param1:Mapping) : void
        {
            var _loc_2:* = this.chatModeOn;
            if (_loc_2 !== param1)
            {
                this._1836514214chatModeOn = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chatModeOn", _loc_2, param1));
            }
            return;
        }// end function

        public function initialiseDefaultBindings() : void
        {
            this.m_ChatModeOn.removeAll(false);
            this.m_ChatModeOn.addAll(CHAT_MODE_ON_DEFAULT_BINDINGS);
            this.m_ChatModeOff.removeAll(false);
            this.m_ChatModeOff.addAll(CHAT_MODE_OFF_DEFAULT_BINDINGS);
            return;
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : MappingSet
        {
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            if (param1 == null || param1.localName() != "mappingset" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("MappingSet.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_9:* = param1.@id;
            _loc_3 = param1.@id;
            if (_loc_9 == null || _loc_3.length() != 1)
            {
                return null;
            }
            var _loc_4:* = parseInt(_loc_3[0].toString());
            var _loc_9:* = param1.@name;
            _loc_3 = param1.@name;
            if (_loc_9 == null || _loc_3.length() != 1)
            {
                return null;
            }
            _loc_5 = s_GetSanitizedSetName(_loc_4, _loc_3[0].toString(), true);
            var _loc_6:* = new MappingSet(_loc_4, _loc_5);
            _loc_6.initialiseDefaultBindings();
            if (param2 >= 4)
            {
                for each (_loc_7 in param1.elements("mapping"))
                {
                    
                    _loc_8 = -1;
                    var _loc_11:* = _loc_7.@mode;
                    _loc_3 = _loc_7.@mode;
                    if (_loc_11 != null && _loc_3.length() == 1)
                    {
                        _loc_8 = parseInt(_loc_3[0].toString());
                    }
                    if (_loc_8 == CHAT_MODE_ON)
                    {
                        _loc_6.m_ChatModeOn.removeAll();
                        Mapping.s_Unmarshall(_loc_7, param2, _loc_6.m_ChatModeOn);
                        continue;
                    }
                    if (_loc_8 == CHAT_MODE_OFF)
                    {
                        _loc_6.m_ChatModeOff.removeAll();
                        Mapping.s_Unmarshall(_loc_7, param2, _loc_6.m_ChatModeOff);
                    }
                }
            }
            return _loc_6;
        }// end function

        public static function s_GetSanitizedSetName(param1:int, param2:String, param3:Boolean) : String
        {
            if (param2 != null)
            {
                param2 = StringHelper.s_StripNewline(param2);
                param2 = StringHelper.s_TrimFront(param2);
                if (param3)
                {
                    param2 = StringHelper.s_TrimBack(param2);
                }
                param2 = param2.substr(0, MAX_NAME_LENGTH);
            }
            if (param2 == null || param2.length < 1)
            {
                param2 = ResourceManager.getInstance().getString(BUNDLE, "MAPPINGSET_DEFAULT_NAME", [(param1 + 1)]);
            }
            return param2;
        }// end function

    }
}
