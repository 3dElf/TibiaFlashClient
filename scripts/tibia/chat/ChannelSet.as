package tibia.chat
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;
    import shared.utility.*;

    public class ChannelSet extends EventDispatcher
    {
        protected var m_Channels:Vector.<uint> = null;
        protected var m_ID:int = 0;
        public static const DEFAULT_SET:int = 0;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        public static const NUM_SETS:int = 1;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function ChannelSet(param1:int)
        {
            this.m_ID = param1;
            this.m_Channels = new Vector.<uint>;
            return;
        }// end function

        public function get length() : int
        {
            return this.m_Channels.length;
        }// end function

        public function addItemAt(param1:int, param2:int) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_3:* = this.m_Channels.indexOf(param1);
            if (param2 < 0 || _loc_3 < 0 && param2 > this.m_Channels.length || _loc_3 > -1 && param2 >= this.m_Channels.length)
            {
                throw new RangeError("ChannelSet.addItemAt: Index " + param2 + " is out of range.");
            }
            var _loc_8:* = ChatStorage;
            if (_loc_8.ns_chat_internal::s_IsRestorableChannel(param1))
            {
                _loc_4 = false;
                if (_loc_3 < 0)
                {
                    this.m_Channels.splice(param2, 0, param1);
                    _loc_4 = true;
                }
                else if (_loc_3 != param2)
                {
                    _loc_5 = _loc_3;
                    _loc_6 = _loc_3 < param2 ? (1) : (-1);
                    while (_loc_5 != param2)
                    {
                        
                        this.m_Channels[_loc_5] = this.m_Channels[_loc_5 + _loc_6];
                        _loc_5 = _loc_5 + _loc_6;
                    }
                    this.m_Channels[param2] = param1;
                    _loc_4 = true;
                }
                if (_loc_4)
                {
                    _loc_7 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                    _loc_7.kind = PropertyChangeEventKind.UPDATE;
                    _loc_7.property = "channels";
                    dispatchEvent(_loc_7);
                }
            }
            return;
        }// end function

        public function setItemAt(param1:uint, param2:int) : int
        {
            var _loc_4:* = null;
            if (param2 < 0 || param2 >= this.m_Channels.length)
            {
                throw new RangeError("ChannelSet.setItemAt: Index " + param2 + " is out of range.");
            }
            var _loc_3:* = this.m_Channels[param2];
            var _loc_5:* = ChatStorage;
            if (_loc_5.ns_chat_internal::s_IsRestorableChannel(param1))
            {
                this.m_Channels[param2] = param1;
                _loc_4 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_4.kind = PropertyChangeEventKind.UPDATE;
                _loc_4.property = "channels";
                dispatchEvent(_loc_4);
            }
            return _loc_3;
        }// end function

        public function getItemIndex(param1:int) : int
        {
            return this.m_Channels.indexOf(param1);
        }// end function

        public function removeItemAt(param1:int) : int
        {
            if (param1 < 0 || param1 >= this.m_Channels.length)
            {
                throw new RangeError("ChannelSet.removeItemAt: Index " + param1 + " is out of range.");
            }
            var _loc_2:* = int(this.m_Channels.splice(param1, 1));
            var _loc_3:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_3.kind = PropertyChangeEventKind.UPDATE;
            _loc_3.property = "channels";
            dispatchEvent(_loc_3);
            return _loc_2;
        }// end function

        public function set length(param1:int) : void
        {
            var _loc_2:* = null;
            if (param1 < 0 || param1 > this.m_Channels.length)
            {
                throw new RangeError("ChannelSet.set length: Length " + param1 + " is invalid.");
            }
            if (this.m_Channels.length != param1)
            {
                this.m_Channels.length = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "channels";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function marshall() : XML
        {
            var _loc_1:* = new XML("<channelset id=\"" + this.m_ID + "\"></channelset>");
            var _loc_2:* = 0;
            while (_loc_2 < this.m_Channels.length)
            {
                
                _loc_1.appendChild(new XML("<channel>" + this.m_Channels[_loc_2] + "</channel>"));
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function addItem(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = ChatStorage;
            if (_loc_3.ns_chat_internal::s_IsRestorableChannel(param1) && this.m_Channels.indexOf(param1) < 0)
            {
                this.m_Channels.push(param1);
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "channels";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function getItemAt(param1:int) : int
        {
            if (param1 < 0 || param1 >= this.m_Channels.length)
            {
                throw new RangeError("ChannelSet.getItemAt: Index " + param1 + " is out of range.");
            }
            return this.m_Channels[param1];
        }// end function

        public function removeAll() : void
        {
            this.m_Channels.length = 0;
            var _loc_1:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_1.kind = PropertyChangeEventKind.UPDATE;
            _loc_1.property = "channels";
            dispatchEvent(_loc_1);
            return;
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : ChannelSet
        {
            var _loc_4:* = 0;
            var _loc_6:* = null;
            if (param1 == null || param1.localName() != "channelset" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("ChannelSet.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_7:* = param1.@id;
            _loc_3 = param1.@id;
            if (_loc_7 == null || _loc_3.length() != 1)
            {
                return null;
            }
            _loc_4 = parseInt(_loc_3[0].toString());
            var _loc_5:* = new ChannelSet(_loc_4);
            for each (_loc_6 in param1.elements("channel"))
            {
                
                _loc_5.addItem(XMLHelper.s_UnmarshallInteger(_loc_6));
            }
            return _loc_5;
        }// end function

    }
}
