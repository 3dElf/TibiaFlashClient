package tibia.creatures
{
   import flash.events.EventDispatcher;
   import tibia.creatures.buddylistClasses.Buddy;
   import mx.events.CollectionEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.CollectionEventKind;
   import tibia.worldmap.WorldMapStorage;
   import tibia.chat.ChatStorage;
   import mx.resources.ResourceManager;
   import tibia.chat.MessageMode;
   import mx.collections.ArrayCollection;
   import mx.collections.Sort;
   import tibia.creatures.buddylistClasses.BuddyIcon;
   import tibia.network.Connection;
   import mx.collections.IList;
   
   public class BuddySet extends EventDispatcher
   {
      
      private static const BUDDIES_REFRESH:int = 1;
      
      public static const DEFAULT_SET:int = 0;
      
      protected static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 4;
      
      public static const NUM_SETS:int = 1;
      
      public static const SORT_NAME:int = 0;
      
      private static const BUDDIES_REBUILD:int = 2;
      
      private static const BUNDLE:String = "BuddylistWidget";
      
      public static const SORT_STATUS:int = 2;
      
      private static const BUDDIES_NOACTION:int = 0;
      
      public static const SORT_ICON:int = 1;
      
      protected static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
       
      protected var m_BuddiesSorted:ArrayCollection = null;
      
      protected var m_BuddiesRaw:Vector.<Buddy> = null;
      
      protected var m_BuddiesSorter:Sort = null;
      
      protected var m_SortOrder:int = 0;
      
      protected var m_Icons:Vector.<BuddyIcon> = null;
      
      protected var m_ID:int = 0;
      
      protected var m_ShowOffline:Boolean = true;
      
      protected var m_BuddiesState:int = 0;
      
      public function BuddySet(param1:int)
      {
         super();
         this.m_ID = param1;
         this.m_BuddiesRaw = new Vector.<Buddy>();
         this.m_BuddiesSorter = new Sort();
         this.m_BuddiesSorter.compareFunction = this.buddyComparator;
         this.m_BuddiesSorted = new ArrayCollection();
         this.m_BuddiesSorted.filterFunction = this.buddyFilter;
         this.m_BuddiesSorted.sort = this.m_BuddiesSorter;
         this.reset();
      }
      
      public static function s_Unmarshall(param1:XML, param2:Number) : BuddySet
      {
         var _loc4_:int = 0;
         var _loc6_:XML = null;
         var _loc7_:XML = null;
         var _loc8_:Buddy = null;
         if(param1 == null || param1.localName() != "buddyset" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("BuddySet.s_Unmarshall: Invalid input.");
         }
         var _loc3_:XMLList = null;
         if((_loc3_ = param1.@ID) == null || _loc3_.length() != 1)
         {
            log("BuddySet.s_Unmarshall: Missing attribute: ID.");
            return null;
         }
         _loc4_ = parseInt(_loc3_[0].toString());
         var _loc5_:BuddySet = new BuddySet(_loc4_);
         if((_loc3_ = param1.@sortOrder) != null && _loc3_.length() == 1)
         {
            _loc5_.sortOrder = parseInt(_loc3_[0].toString());
         }
         if((_loc3_ = param1.@showOffline) != null && _loc3_.length() == 1)
         {
            _loc5_.showOffline = _loc3_[0].toString() == "true";
         }
         for each(_loc6_ in param1.elements())
         {
            switch(_loc6_.localName())
            {
               case "buddies":
                  for each(_loc7_ in _loc6_.elements("buddy"))
                  {
                     _loc8_ = Buddy.s_Unmarshall(_loc7_,param2);
                     if(_loc8_ != null && _loc5_.length < Buddy.NUM_BUDDIES)
                     {
                        _loc5_.removeBuddyInternal(_loc8_);
                        _loc5_.addBuddyInternal(_loc8_);
                     }
                  }
                  continue;
               case "groups":
               case "icons":
                  continue;
               default:
                  continue;
            }
         }
         return _loc5_;
      }
      
      private function addBuddyInternal(param1:Buddy) : Boolean
      {
         var _loc3_:CollectionEvent = null;
         if(param1 == null || this.m_BuddiesRaw.length >= Buddy.NUM_BUDDIES)
         {
            return false;
         }
         var _loc2_:int = this.getBuddyIndex(param1.ID);
         if(_loc2_ < 0)
         {
            _loc2_ = -_loc2_ - 1;
            this.m_BuddiesRaw.splice(_loc2_,0,param1);
            this.m_BuddiesRaw[_loc2_].addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onBuddyChange);
            this.m_BuddiesState = BUDDIES_REBUILD;
            _loc3_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc3_.kind = CollectionEventKind.ADD;
            dispatchEvent(_loc3_);
            return true;
         }
         return false;
      }
      
      protected function buddyComparator(param1:Object, param2:Object, param3:Array = null) : int
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc4_:Buddy = param1 as Buddy;
         var _loc5_:Buddy = param2 as Buddy;
         var _loc6_:int = 0;
         if(_loc4_ != null && _loc5_ != null)
         {
            switch(this.m_SortOrder)
            {
               case SORT_NAME:
                  break;
               case SORT_ICON:
                  if(_loc4_.icon < _loc5_.icon)
                  {
                     _loc6_ = -1;
                  }
                  else if(_loc4_.icon > _loc5_.icon)
                  {
                     _loc6_ = 1;
                  }
                  break;
               case SORT_STATUS:
                  if(Boolean(_loc4_.online) && !_loc5_.online)
                  {
                     _loc6_ = -1;
                  }
                  else if(!_loc4_.online && Boolean(_loc5_.online))
                  {
                     _loc6_ = 1;
                  }
            }
            if(_loc6_ == 0)
            {
               _loc7_ = _loc4_.name;
               _loc8_ = _loc5_.name;
               if(_loc7_ != null)
               {
                  _loc7_ = _loc7_.toLowerCase();
               }
               if(_loc8_ != null)
               {
                  _loc8_ = _loc8_.toLowerCase();
               }
               if(_loc7_ < _loc8_)
               {
                  _loc6_ = -1;
               }
               else if(_loc7_ > _loc8_)
               {
                  _loc6_ = 1;
               }
            }
         }
         return _loc6_;
      }
      
      public function updateBuddy(param1:int, ... rest) : void
      {
         var _loc4_:String = null;
         var _loc5_:WorldMapStorage = null;
         var _loc6_:ChatStorage = null;
         var _loc7_:Buddy = null;
         var _loc3_:int = this.getBuddyIndex(param1);
         if(rest.length == 1)
         {
            if(_loc3_ > -1)
            {
               this.m_BuddiesRaw[_loc3_].online = Boolean(rest[0]);
               this.m_BuddiesRaw[_loc3_].lastUpdate = Tibia.s_FrameTimestamp;
               if(Boolean(this.m_BuddiesRaw[_loc3_].online) && Boolean(this.m_BuddiesRaw[_loc3_].notify))
               {
                  _loc4_ = ResourceManager.getInstance().getString(BUNDLE,"NOTIFICATION_MESSAGE",[this.m_BuddiesRaw[_loc3_].name]);
                  _loc5_ = Tibia.s_GetWorldMapStorage();
                  if(_loc5_ != null)
                  {
                     _loc5_.addOnscreenMessage(MessageMode.MESSAGE_STATUS,_loc4_);
                  }
                  _loc6_ = Tibia.s_GetChatStorage();
                  if(_loc6_ != null)
                  {
                     _loc6_.addChannelMessage(-1,-1,null,0,MessageMode.MESSAGE_STATUS,_loc4_);
                  }
               }
            }
            this.invalidateBuddies();
         }
         else if(rest.length == 2)
         {
            _loc7_ = null;
            if(_loc3_ > -1)
            {
               _loc7_ = this.m_BuddiesRaw[_loc3_];
            }
            else
            {
               _loc7_ = new Buddy(param1,null);
               this.addBuddyInternal(_loc7_);
            }
            _loc7_.name = String(rest[0]);
            _loc7_.online = Boolean(rest[1]);
            _loc7_.lastUpdate = Number.NEGATIVE_INFINITY;
         }
         else
         {
            throw new ArgumentError("BuddySet.updateBuddy: Invalid overload.");
         }
         this.validateBuddies();
      }
      
      private function removeBuddyInternal(param1:*) : Boolean
      {
         var _loc3_:CollectionEvent = null;
         var _loc2_:int = -1;
         if(param1 is int)
         {
            _loc2_ = this.getBuddyIndex(int(param1));
         }
         else if(param1 is Buddy)
         {
            _loc2_ = this.getBuddyIndex(Buddy(param1).ID);
         }
         if(_loc2_ > -1)
         {
            this.m_BuddiesRaw[_loc2_].removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onBuddyChange);
            this.m_BuddiesRaw.splice(_loc2_,1);
            this.m_BuddiesState = BUDDIES_REBUILD;
            _loc3_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc3_.kind = CollectionEventKind.REMOVE;
            dispatchEvent(_loc3_);
            return true;
         }
         return false;
      }
      
      public function clone() : BuddySet
      {
         var _loc1_:BuddySet = new BuddySet(this.m_ID);
         var _loc2_:int = 0;
         while(_loc2_ < this.m_BuddiesRaw.length)
         {
            _loc1_.addBuddyInternal(this.m_BuddiesRaw[_loc2_].clone());
            _loc2_++;
         }
         _loc1_.sortOrder = this.m_SortOrder;
         _loc1_.showOffline = this.m_ShowOffline;
         _loc1_.validateBuddies();
         return _loc1_;
      }
      
      public function markBuddiesOffline() : void
      {
         var _loc1_:int = this.m_BuddiesRaw.length - 1;
         while(_loc1_ >= 0)
         {
            this.m_BuddiesRaw[_loc1_].name = null;
            this.m_BuddiesRaw[_loc1_].online = false;
            this.m_BuddiesRaw[_loc1_].lastUpdate = Number.NEGATIVE_INFINITY;
            _loc1_--;
         }
         this.m_BuddiesState = BUDDIES_REBUILD;
         this.validateBuddies();
      }
      
      public function marshall() : XML
      {
         var _loc1_:XML = <buddyset ID="{this.m_ID}" sortOrder="{this.m_SortOrder}" showOffline="{this.m_ShowOffline}"/>;
         var _loc2_:XML = <buddies/>;
         var _loc3_:int = 0;
         while(_loc3_ < this.m_BuddiesRaw.length)
         {
            _loc2_.appendChild(this.m_BuddiesRaw[_loc3_].marshall());
            _loc3_++;
         }
         _loc1_.appendChild(_loc2_);
         return _loc1_;
      }
      
      private function set _26774448sortOrder(param1:int) : void
      {
         if(param1 != SORT_NAME && param1 != SORT_ICON && param1 != SORT_STATUS)
         {
            param1 = SORT_NAME;
         }
         if(this.m_SortOrder != param1)
         {
            this.m_SortOrder = param1;
            this.invalidateBuddies();
            this.validateBuddies();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set showOffline(param1:Boolean) : void
      {
         var _loc2_:Object = this.showOffline;
         if(_loc2_ !== param1)
         {
            this._1160453082showOffline = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"showOffline",_loc2_,param1));
         }
      }
      
      public function get sortOrder() : int
      {
         return this.m_SortOrder;
      }
      
      public function get ID() : int
      {
         return this.m_ID;
      }
      
      public function getBuddy(param1:*) : Buddy
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc2_:int = -1;
         if(param1 is int)
         {
            _loc2_ = this.getBuddyIndex(int(param1));
         }
         else if(param1 is String)
         {
            _loc3_ = String(param1).toLowerCase();
            _loc4_ = this.m_BuddiesRaw.length - 1;
            while(_loc4_ >= 0)
            {
               _loc5_ = this.m_BuddiesRaw[_loc4_].name;
               if(_loc5_ != null)
               {
                  _loc5_ = _loc5_.toLowerCase();
               }
               if(_loc5_ == _loc3_)
               {
                  _loc2_ = _loc4_;
                  break;
               }
               _loc4_--;
            }
         }
         if(_loc2_ > -1)
         {
            return this.m_BuddiesRaw[_loc2_];
         }
         return null;
      }
      
      [Bindable(event="propertyChange")]
      public function set sortOrder(param1:int) : void
      {
         var _loc2_:Object = this.sortOrder;
         if(_loc2_ !== param1)
         {
            this._26774448sortOrder = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sortOrder",_loc2_,param1));
         }
      }
      
      public function get icons() : Vector.<BuddyIcon>
      {
         return this.m_Icons;
      }
      
      public function removeBuddy(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:Connection = null;
         if(this.removeBuddyInternal(param1))
         {
            _loc3_ = null;
            if(Boolean(param2) && (_loc3_ = Tibia.s_GetConnection()) != null && Boolean(_loc3_.isGameRunning))
            {
               _loc3_.sendCREMOVEBUDDY(param1);
            }
            this.validateBuddies();
         }
      }
      
      public function get buddies() : IList
      {
         return this.m_BuddiesSorted;
      }
      
      public function get length() : int
      {
         return this.m_BuddiesRaw.length;
      }
      
      public function reset() : void
      {
         var _loc1_:int = this.m_BuddiesRaw.length - 1;
         while(_loc1_ >= 0)
         {
            if(this.m_BuddiesRaw[_loc1_] != null)
            {
               this.m_BuddiesRaw[_loc1_].removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onBuddyChange);
               this.m_BuddiesRaw[_loc1_] = null;
            }
            _loc1_--;
         }
         this.m_BuddiesRaw.length = 0;
         this.m_BuddiesState = BUDDIES_NOACTION;
         this.m_BuddiesSorted.removeAll();
         this.m_Icons = new Vector.<BuddyIcon>();
         var _loc2_:int = 0;
         while(_loc2_ < BuddyIcon.NUM_ICONS)
         {
            this.m_Icons.push(new BuddyIcon(_loc2_));
            _loc2_++;
         }
         this.m_ShowOffline = true;
         this.m_SortOrder = SORT_NAME;
      }
      
      public function invalidateBuddies() : void
      {
         if(this.m_BuddiesState == BUDDIES_NOACTION)
         {
            this.m_BuddiesState = BUDDIES_REFRESH;
         }
      }
      
      private function set _1160453082showOffline(param1:Boolean) : void
      {
         if(this.m_ShowOffline != param1)
         {
            this.m_ShowOffline = param1;
            this.invalidateBuddies();
            this.validateBuddies();
         }
      }
      
      public function validateBuddies() : void
      {
         var _loc1_:int = 0;
         switch(this.m_BuddiesState)
         {
            case BUDDIES_NOACTION:
               break;
            case BUDDIES_REFRESH:
               this.m_BuddiesSorted.refresh();
               break;
            case BUDDIES_REBUILD:
               this.m_BuddiesSorted.disableAutoUpdate();
               this.m_BuddiesSorted.filterFunction = null;
               this.m_BuddiesSorted.sort = null;
               this.m_BuddiesSorted.refresh();
               this.m_BuddiesSorted.removeAll();
               _loc1_ = 0;
               while(_loc1_ < this.m_BuddiesRaw.length)
               {
                  this.m_BuddiesSorted.addItem(this.m_BuddiesRaw[_loc1_]);
                  _loc1_++;
               }
               this.m_BuddiesSorted.filterFunction = this.buddyFilter;
               this.m_BuddiesSorted.sort = this.m_BuddiesSorter;
               this.m_BuddiesSorted.refresh();
               this.m_BuddiesSorted.enableAutoUpdate();
         }
         this.m_BuddiesState = BUDDIES_NOACTION;
      }
      
      private function getBuddyIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = this.m_BuddiesRaw.length - 1;
         var _loc4_:int = 0;
         while(_loc2_ <= _loc3_)
         {
            _loc4_ = _loc2_ + _loc3_ >>> 1;
            if(this.m_BuddiesRaw[_loc4_].ID < param1)
            {
               _loc2_ = _loc4_ + 1;
               continue;
            }
            if(this.m_BuddiesRaw[_loc4_].ID > param1)
            {
               _loc3_ = _loc4_ - 1;
               continue;
            }
            return _loc4_;
         }
         return -_loc2_ - 1;
      }
      
      public function get showOffline() : Boolean
      {
         return this.m_ShowOffline;
      }
      
      protected function buddyFilter(param1:Object) : Boolean
      {
         var _loc2_:Buddy = param1 as Buddy;
         return _loc2_ != null && _loc2_.name != null && (Boolean(this.showOffline) || Boolean(_loc2_.online));
      }
      
      protected function onBuddyChange(param1:PropertyChangeEvent) : void
      {
         var _loc2_:CollectionEvent = null;
         if(param1 != null && (!param1.cancelable || !param1.isDefaultPrevented()))
         {
            _loc2_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc2_.kind = CollectionEventKind.UPDATE;
            dispatchEvent(_loc2_);
            this.invalidateBuddies();
            this.validateBuddies();
         }
      }
      
      public function addBuddy(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:Connection = null;
         if(Boolean(param2) && (_loc3_ = Tibia.s_GetConnection()) != null && Boolean(_loc3_.isGameRunning))
         {
            _loc3_.sendCADDBUDDY(param1);
         }
         this.validateBuddies();
      }
   }
}
