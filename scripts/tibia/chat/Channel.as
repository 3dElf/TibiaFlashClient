package tibia.chat
{
    import flash.events.*;
    import mx.collections.*;
    import mx.core.*;
    import mx.events.*;
    import shared.utility.*;
    import tibia.chat.chatWidgetClasses.*;

    public class Channel extends EventDispatcher
    {
        protected var m_CanModerate:Boolean = false;
        protected var m_SendMode:int = 0;
        protected var m_NicklistItems:ArrayCollection = null;
        protected var m_SendAllowed:Boolean = true;
        protected var m_Closable:Boolean = true;
        protected var m_ID:Object = null;
        protected var m_Name:String = null;
        protected var m_Messages:IList = null;
        static const MESSAGES_SIZE:int = 50000;
        public static const MAX_NAME_LENGTH:int = 30;

        public function Channel(param1:Object, param2:String, param3:int)
        {
            this.m_ID = Channel.s_NormaliseIdentifier(param1);
            this.m_Name = param2;
            this.m_SendMode = param3;
            this.m_Messages = new RingBuffer(MESSAGES_SIZE);
            this.m_Messages.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onMessagesEvent, false, EventPriority.DEFAULT_HANDLER, false);
            this.m_Closable = true;
            this.m_SendAllowed = true;
            this.m_NicklistItems = new ArrayCollection();
            return;
        }// end function

        public function clearMessages() : void
        {
            this.m_Messages.removeAll();
            return;
        }// end function

        public function get isPartyChannel() : Boolean
        {
            var _loc_1:* = ChatStorage;
            return _loc_1.ns_chat_internal::s_IsPartyChannel(this.m_ID);
        }// end function

        public function playerLeft(param1:String) : void
        {
            var _loc_2:* = this.getNicklistItem(param1, false);
            if (_loc_2 != null)
            {
                _loc_2.state = NicklistItem.STATE_INVITED;
            }
            return;
        }// end function

        public function playerJoined(param1:String) : void
        {
            var _loc_2:* = this.getNicklistItem(param1, true);
            _loc_2.state = NicklistItem.STATE_SUBSCRIBER;
            return;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function get messages() : IList
        {
            return this.m_Messages;
        }// end function

        public function get sendAllowed() : Boolean
        {
            return this.m_SendAllowed;
        }// end function

        public function get sendMode() : int
        {
            return this.m_SendMode;
        }// end function

        public function playerInvited(param1:String) : void
        {
            var _loc_2:* = this.getNicklistItem(param1, true);
            _loc_2.state = NicklistItem.STATE_INVITED;
            return;
        }// end function

        public function appendMessage(param1:ChannelMessage) : void
        {
            this.m_Messages.addItem(param1);
            return;
        }// end function

        public function get canModerate() : Boolean
        {
            return this.m_CanModerate;
        }// end function

        public function set name(param1:String) : void
        {
            this.m_Name = param1;
            return;
        }// end function

        private function getNicklistItemIndex(param1:String) : int
        {
            var _loc_2:* = param1.toLowerCase();
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = this.m_NicklistItems.length - 1;
            var _loc_6:* = 0;
            while (_loc_4 <= _loc_5)
            {
                
                _loc_6 = _loc_4 + _loc_5 >>> 1;
                _loc_3 = NicklistItem(this.m_NicklistItems.getItemAt(_loc_6)).name.toLowerCase();
                if (_loc_3 < _loc_2)
                {
                    _loc_4 = _loc_6 + 1;
                    continue;
                }
                if (_loc_3 > _loc_2)
                {
                    _loc_5 = _loc_6 - 1;
                    continue;
                }
                return _loc_6;
            }
            return -_loc_4 - 1;
        }// end function

        public function set sendAllowed(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (param1 != this.m_SendAllowed)
            {
                this.m_SendAllowed = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "sendAllowed";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function get ID() : Object
        {
            return this.m_ID;
        }// end function

        public function set closable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (param1 != this.m_Closable)
            {
                this.m_Closable = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "closable";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function get showNicklist() : Boolean
        {
            var _loc_1:* = this.m_ID is int ? (int(this.m_ID)) : (-1);
            return this.isGuildChannel || this.isPartyChannel || this.isPrivate;
        }// end function

        public function dispose() : void
        {
            if (this.m_Messages != null)
            {
                this.m_Messages.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onMessagesEvent);
                this.m_Messages.removeAll();
            }
            if (this.m_NicklistItems != null)
            {
                this.m_NicklistItems.removeAll();
            }
            return;
        }// end function

        public function get isRestorable() : Boolean
        {
            var _loc_1:* = ChatStorage;
            var _loc_1:* = ChatStorage;
            return (!_loc_1.ns_chat_internal::s_IsPrivateChannel(this.m_ID) || this.m_SendAllowed) && _loc_1.ns_chat_internal::s_IsRestorableChannel(this.m_ID);
        }// end function

        public function playerExcluded(param1:String) : void
        {
            this.removeNicklistItem(param1);
            return;
        }// end function

        public function set canModerate(param1:Boolean) : void
        {
            this.m_CanModerate = param1;
            return;
        }// end function

        public function get closable() : Boolean
        {
            return this.m_Closable;
        }// end function

        public function get safeID() : int
        {
            if (this.m_ID is int)
            {
                return int(this.m_ID);
            }
            return -1;
        }// end function

        public function get isGuildChannel() : Boolean
        {
            var _loc_1:* = ChatStorage;
            return _loc_1.ns_chat_internal::s_IsGuildChannel(this.m_ID);
        }// end function

        private function getNicklistItem(param1:String, param2:Boolean = false) : NicklistItem
        {
            var _loc_4:* = null;
            var _loc_3:* = this.getNicklistItemIndex(param1);
            if (_loc_3 < 0)
            {
                if (param2 == true)
                {
                    _loc_4 = new NicklistItem(param1);
                    this.m_NicklistItems.addItemAt(_loc_4, -_loc_3 - 1);
                    return _loc_4;
                }
                return null;
            }
            else
            {
            }
            return this.m_NicklistItems.getItemAt(_loc_3) as NicklistItem;
        }// end function

        public function clearNicklist() : void
        {
            this.m_NicklistItems.removeAll();
            return;
        }// end function

        private function removeNicklistItem(param1:String) : Boolean
        {
            var _loc_2:* = this.getNicklistItemIndex(param1);
            if (_loc_2 > -1)
            {
                this.m_NicklistItems.removeItemAt(_loc_2);
                return true;
            }
            return false;
        }// end function

        protected function onMessagesEvent(event:CollectionEvent) : void
        {
            if (event != null && (!event.cancelable || !event.isDefaultPrevented()))
            {
                dispatchEvent(event);
            }
            return;
        }// end function

        public function playerPending(param1:String) : void
        {
            var _loc_2:* = this.getNicklistItem(param1, true);
            _loc_2.state = NicklistItem.STATE_PENDING;
            return;
        }// end function

        private function isNicklistItemExisting(param1:String) : Boolean
        {
            return this.getNicklistItem(param1) != null;
        }// end function

        public function get isPrivate() : Boolean
        {
            var _loc_1:* = ChatStorage;
            return _loc_1.ns_chat_internal::s_IsPrivateChannel(this.m_ID);
        }// end function

        public function get nicklistItems() : IList
        {
            return this.m_NicklistItems;
        }// end function

        public static function s_NormaliseIdentifier(param1:Object) : Object
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1 is Channel)
            {
                return Channel.Channel(param1).ID;
            }
            if (param1 is int)
            {
                _loc_2 = int(param1);
                if (_loc_2 >= 0)
                {
                    return _loc_2;
                }
            }
            else if (param1 is String)
            {
                _loc_3 = String(param1);
                if (_loc_3.length > 0)
                {
                    return _loc_3.toLowerCase().substr(0, Channel.MAX_NAME_LENGTH);
                }
            }
            return null;
        }// end function

    }
}
