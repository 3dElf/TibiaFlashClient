package tibia.chat
{
   import flash.events.EventDispatcher;
   import mx.collections.IList;
   import mx.events.PropertyChangeEvent;
   import mx.events.PropertyChangeEventKind;
   import mx.events.CollectionEvent;
   import mx.collections.ArrayCollection;
   import shared.utility.RingBuffer;
   import mx.core.EventPriority;
   
   public class Channel extends EventDispatcher
   {
      
      protected static const MESSAGES_SIZE:int = 50000;
      
      public static const MAX_NAME_LENGTH:int = 30;
       
      protected var m_SendMode:int = 0;
      
      protected var m_SendAllowed:Boolean = true;
      
      protected var m_Subscribers:ArrayCollection = null;
      
      protected var m_Closable:Boolean = true;
      
      protected var m_Invitees:ArrayCollection = null;
      
      protected var m_ID = null;
      
      protected var m_Name:String = null;
      
      protected var m_Messages:IList = null;
      
      public function Channel(param1:Object, param2:String, param3:int)
      {
         super();
         this.m_ID = Channel.s_NormaliseIdentifier(param1);
         this.m_Name = param2;
         this.m_SendMode = param3;
         this.m_Messages = new RingBuffer(MESSAGES_SIZE);
         this.m_Messages.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onMessagesEvent,false,EventPriority.DEFAULT_HANDLER,false);
         this.m_Closable = true;
         this.m_SendAllowed = true;
         this.m_Subscribers = new ArrayCollection();
         this.m_Invitees = new ArrayCollection();
      }
      
      public static function s_NormaliseIdentifier(param1:Object) : Object
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(param1 is Channel)
         {
            return Channel(param1).ID;
         }
         if(param1 is int)
         {
            _loc2_ = int(param1);
            if(_loc2_ >= 0)
            {
               return _loc2_;
            }
         }
         else if(param1 is String)
         {
            _loc3_ = String(param1);
            if(_loc3_.length > 0)
            {
               return _loc3_.toLowerCase().substr(0,Channel.MAX_NAME_LENGTH);
            }
         }
         return null;
      }
      
      public function clearMessages() : void
      {
         this.m_Messages.removeAll();
      }
      
      public function get sendAllowed() : Boolean
      {
         return this.m_SendAllowed;
      }
      
      public function playerLeft(param1:String) : void
      {
         this.addNick(this.m_Invitees,param1);
         this.removeNick(this.m_Subscribers,param1);
      }
      
      public function get name() : String
      {
         return this.m_Name;
      }
      
      public function get messages() : IList
      {
         return this.m_Messages;
      }
      
      public function appendMessage(param1:ChannelMessage) : void
      {
         this.m_Messages.addItem(param1);
      }
      
      public function set sendAllowed(param1:Boolean) : void
      {
         var _loc2_:PropertyChangeEvent = null;
         if(param1 != this.m_SendAllowed)
         {
            this.m_SendAllowed = param1;
            _loc2_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc2_.kind = PropertyChangeEventKind.UPDATE;
            _loc2_.property = "sendAllowed";
            dispatchEvent(_loc2_);
         }
      }
      
      public function playerJoined(param1:String) : void
      {
         this.removeNick(this.m_Invitees,param1);
         this.addNick(this.m_Subscribers,param1);
      }
      
      public function playerInvited(param1:String) : void
      {
         this.addNick(this.m_Invitees,param1);
      }
      
      public function set closable(param1:Boolean) : void
      {
         var _loc2_:PropertyChangeEvent = null;
         if(param1 != this.m_Closable)
         {
            this.m_Closable = param1;
            _loc2_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc2_.kind = PropertyChangeEventKind.UPDATE;
            _loc2_.property = "closable";
            dispatchEvent(_loc2_);
         }
      }
      
      protected function onMessagesEvent(param1:CollectionEvent) : void
      {
         if(param1 != null && (!param1.cancelable || !param1.isDefaultPrevented()))
         {
            dispatchEvent(param1);
         }
      }
      
      public function get sendMode() : int
      {
         return this.m_SendMode;
      }
      
      public function get isRestorable() : Boolean
      {
         return (!ChatStorage.ns_chat_internal::s_IsPrivateChannel(this.m_ID) || Boolean(this.m_SendAllowed)) && Boolean(ChatStorage.ns_chat_internal::s_IsRestorableChannel(this.m_ID));
      }
      
      public function get showNicklist() : Boolean
      {
         var _loc1_:int = this.m_ID is int?int(int(this.m_ID)):-1;
         return _loc1_ == ChatStorage.GUILD_CHANNEL_ID || _loc1_ == ChatStorage.PARTY_CHANNEL_ID || _loc1_ >= ChatStorage.FIRST_PRIVATE_CHANNEL_ID && _loc1_ <= ChatStorage.LAST_PRIVATE_CHANNEL_ID;
      }
      
      public function dispose() : void
      {
         if(this.m_Messages != null)
         {
            this.m_Messages.removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.onMessagesEvent);
            this.m_Messages.removeAll();
         }
         if(this.m_Subscribers != null)
         {
            this.m_Subscribers.removeAll();
         }
         if(this.m_Invitees != null)
         {
            this.m_Invitees.removeAll();
         }
      }
      
      public function get ID() : Object
      {
         return this.m_ID;
      }
      
      public function get subscribers() : IList
      {
         return this.m_Subscribers;
      }
      
      private function addNick(param1:IList, param2:String) : Boolean
      {
         var _loc3_:int = this.getNickIndex(param1,param2);
         if(_loc3_ < 0)
         {
            param1.addItemAt(param2,-_loc3_ - 1);
            return true;
         }
         return false;
      }
      
      private function getNickIndex(param1:IList, param2:String) : int
      {
         var _loc3_:String = param2.toLowerCase();
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = param1.length - 1;
         var _loc7_:int = 0;
         while(_loc5_ <= _loc6_)
         {
            _loc7_ = _loc5_ + _loc6_ >>> 1;
            _loc4_ = String(param1.getItemAt(_loc7_)).toLowerCase();
            if(_loc4_ < _loc3_)
            {
               _loc5_ = _loc7_ + 1;
               continue;
            }
            if(_loc4_ > _loc3_)
            {
               _loc6_ = _loc7_ - 1;
               continue;
            }
            return _loc7_;
         }
         return -_loc5_ - 1;
      }
      
      public function get closable() : Boolean
      {
         return this.m_Closable;
      }
      
      public function clearNicklist() : void
      {
         this.m_Invitees.removeAll();
         this.m_Subscribers.removeAll();
      }
      
      private function removeNick(param1:IList, param2:String) : Boolean
      {
         var _loc3_:int = this.getNickIndex(param1,param2);
         if(_loc3_ > -1)
         {
            param1.removeItemAt(_loc3_);
            return true;
         }
         return false;
      }
      
      public function get invitees() : IList
      {
         return this.m_Invitees;
      }
      
      public function playerExcluded(param1:String) : void
      {
         this.removeNick(this.m_Invitees,param1);
         this.removeNick(this.m_Subscribers,param1);
      }
      
      public function get isPrivate() : Boolean
      {
         return ChatStorage.ns_chat_internal::s_IsPrivateChannel(this.m_ID);
      }
   }
}
