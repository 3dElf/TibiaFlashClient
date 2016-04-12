package tibia.chat
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;
    import shared.utility.*;

    public class MessageFilterSet extends EventDispatcher
    {
        protected var m_MessageModes:Vector.<MessageMode> = null;
        protected var m_ShowTimestamps:Boolean = true;
        protected var m_ID:int = 0;
        protected var m_ShowLevels:Boolean = true;
        public static const DEFAULT_SET:int = 0;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        public static const NUM_SETS:int = 1;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function MessageFilterSet(param1:int)
        {
            this.m_ID = param1;
            this.m_MessageModes = new Vector.<MessageMode>(MessageMode.MESSAGE_BEYOND_LAST, true);
            var _loc_2:* = MessageMode.MESSAGE_NONE;
            while (_loc_2 < MessageMode.MESSAGE_BEYOND_LAST)
            {
                
                this.addMessageMode(new MessageMode(_loc_2));
                _loc_2++;
            }
            this.reset();
            return;
        }// end function

        public function get showTimestamps() : Boolean
        {
            return this.m_ShowTimestamps;
        }// end function

        public function set showTimestamps(param1:Boolean) : void
        {
            var _loc_2:* = this.showTimestamps;
            if (_loc_2 !== param1)
            {
                this._991962886showTimestamps = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showTimestamps", _loc_2, param1));
            }
            return;
        }// end function

        public function get showLevels() : Boolean
        {
            return this.m_ShowLevels;
        }// end function

        private function set _568961740showLevels(param1:Boolean) : void
        {
            this.m_ShowLevels = param1;
            return;
        }// end function

        private function set _991962886showTimestamps(param1:Boolean) : void
        {
            this.m_ShowTimestamps = param1;
            return;
        }// end function

        protected function onMessageModeChange(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = null;
            if (event != null && (!event.cancelable || !event.isDefaultPrevented()))
            {
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "messageMode";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function marshall() : XML
        {
            var _loc_1:* = new XML("<messagefilterset id=\"" + this.m_ID + "\">\r\n                         " + ("<showtimestamps>" + this.m_ShowTimestamps + "</showtimestamps>") + "\r\n                         " + ("<showlevels>" + this.m_ShowLevels + "</showlevels>") + "\r\n                       </messagefilterset>");
            var _loc_2:* = <messagemodes/>;
            var _loc_3:* = MessageMode.MESSAGE_NONE;
            while (_loc_3 < MessageMode.MESSAGE_BEYOND_LAST)
            {
                
                if (this.m_MessageModes[_loc_3].editable)
                {
                    _loc_2.appendChild(this.m_MessageModes[_loc_3].marshall());
                }
                _loc_3++;
            }
            _loc_1.appendChild(_loc_2);
            return _loc_1;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = MessageMode.MESSAGE_NONE;
            while (_loc_1 < MessageMode.MESSAGE_BEYOND_LAST)
            {
                
                this.m_MessageModes[_loc_1].initialiseDefaultValues();
                _loc_1++;
            }
            this.m_ShowLevels = true;
            this.m_ShowTimestamps = true;
            return;
        }// end function

        public function addMessageMode(param1:MessageMode) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.ID;
            if (this.m_MessageModes[_loc_2] != param1)
            {
                if (this.m_MessageModes[_loc_2] != null)
                {
                    this.m_MessageModes[_loc_2].removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onMessageModeChange);
                }
                this.m_MessageModes[_loc_2] = param1;
                this.m_MessageModes[_loc_2].addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onMessageModeChange);
                _loc_3 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_3.kind = PropertyChangeEventKind.UPDATE;
                _loc_3.property = "messageMode";
                _loc_3.newValue = param1;
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        public function getMessageMode(param1:int) : MessageMode
        {
            if (!MessageMode.s_CheckMode(param1))
            {
                throw new ArgumentError("MessageModeSet.getMessageMode: Invalid mode: " + param1 + ".");
            }
            return this.m_MessageModes[param1];
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function set showLevels(param1:Boolean) : void
        {
            var _loc_2:* = this.showLevels;
            if (_loc_2 !== param1)
            {
                this._568961740showLevels = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showLevels", _loc_2, param1));
            }
            return;
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : MessageFilterSet
        {
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1 == null || param1.localName() != "messagefilterset" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("MessageFilterSet.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_9:* = param1.@id;
            _loc_3 = param1.@id;
            if (_loc_9 == null || _loc_3.length() != 1)
            {
                return null;
            }
            _loc_4 = parseInt(_loc_3[0].toString());
            var _loc_5:* = new MessageFilterSet(_loc_4);
            for each (_loc_6 in param1.elements())
            {
                
                switch(_loc_6.localName())
                {
                    case "messagemodes":
                    {
                        for each (_loc_7 in _loc_6.elements("messagemode"))
                        {
                            
                            _loc_8 = MessageMode.s_Unmarshall(_loc_7, param2);
                            if (_loc_8 != null && _loc_8.editable)
                            {
                                _loc_5.addMessageMode(_loc_8);
                            }
                        }
                        break;
                    }
                    case "showtimestamps":
                    {
                        _loc_5.showTimestamps = XMLHelper.s_UnmarshallBoolean(_loc_6);
                        break;
                    }
                    case "showlevels":
                    {
                        _loc_5.showLevels = XMLHelper.s_UnmarshallBoolean(_loc_6);
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return _loc_5;
        }// end function

    }
}
