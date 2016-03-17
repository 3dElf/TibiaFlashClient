package tibia.container
{
   import flash.events.EventDispatcher;
   import shared.utility.Vector3D;
   import tibia.game.Delay;
   import tibia.options.OptionsStorage;
   import tibia.sidebar.SideBarSet;
   import tibia.appearances.AppearanceTypeRef;
   import tibia.network.Connection;
   import mx.events.PropertyChangeEvent;
   import mx.events.PropertyChangeEventKind;
   import tibia.sidebar.Widget;
   import tibia.appearances.AppearanceInstance;
   import tibia.appearances.AppearanceType;
   import tibia.appearances.AppearanceStorage;
   
   public class ContainerStorage extends EventDispatcher
   {
      
      public static const ITEMS_PER_CONTAINER:int = 36;
      
      public static const BODY_BOTH_HANDS:int = 0;
      
      public static const INVENTORY_ANY:Vector3D = new Vector3D(65535,0,0);
      
      public static const BODY_LEFT_HAND:int = 6;
      
      public static const BODY_RIGHT_HAND:int = 5;
      
      public static const NUM_BODY_SLOTS:int = 11;
      
      public static const MIN_MULTI_USE_DELAY:int = 1000;
      
      public static const BODY_HIP:int = 10;
      
      public static const BODY_NECK:int = 2;
      
      public static const BODY_HEAD:int = 1;
      
      public static const BODY_BACK:int = 3;
      
      public static const BODY_FINGER:int = 9;
      
      public static const OPEN_CONTAINERS:int = 16;
      
      public static const BODY_LEGS:int = 7;
      
      public static const BODY_FEET:int = 8;
      
      public static const BODY_PURSE:int = 11;
      
      public static const BODY_TORSO:int = 4;
      
      public static const MIN_USE_DELAY:int = 100;
       
      protected var m_MultiuseDelay:Delay = null;
      
      protected var m_PlayerInventory:Vector.<tibia.container.InventoryTypeInfo> = null;
      
      protected var m_PlayerGoods:Vector.<tibia.container.InventoryTypeInfo> = null;
      
      protected var m_BodyContainer:tibia.container.Container = null;
      
      protected var m_OpenWidgets:Vector.<int> = null;
      
      protected var m_PlayerMoney:uint = 0;
      
      protected var m_OpenContainers:Vector.<tibia.container.Container> = null;
      
      public function ContainerStorage()
      {
         super();
         this.m_BodyContainer = new tibia.container.Container(-1,null,"",NUM_BODY_SLOTS,false);
         this.m_BodyContainer.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onBodyChange);
         this.m_MultiuseDelay = new Delay(0,0);
         this.m_OpenContainers = new Vector.<tibia.container.Container>(OPEN_CONTAINERS,true);
         this.m_OpenWidgets = new Vector.<int>(OPEN_CONTAINERS,true);
         var _loc1_:int = 0;
         while(_loc1_ < OPEN_CONTAINERS)
         {
            this.m_OpenWidgets[_loc1_] = -1;
            _loc1_++;
         }
         this.m_PlayerInventory = new Vector.<tibia.container.InventoryTypeInfo>();
         this.reset();
      }
      
      public function getPlayerInventory() : Vector.<tibia.container.InventoryTypeInfo>
      {
         return this.m_PlayerInventory;
      }
      
      public function getFreeContainer() : int
      {
         var _loc1_:int = 0;
         while(_loc1_ < OPEN_CONTAINERS)
         {
            if(this.m_OpenContainers[_loc1_] == null)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return OPEN_CONTAINERS - _loc1_;
      }
      
      public function reset() : void
      {
         this.m_BodyContainer.removeAll();
         var _loc1_:int = this.m_BodyContainer.capacity;
         while(_loc1_ > 0)
         {
            this.m_BodyContainer.appendItem(null);
            _loc1_--;
         }
         this.m_MultiuseDelay = new Delay(0,0);
         var _loc2_:int = 0;
         while(_loc2_ < OPEN_CONTAINERS)
         {
            if(this.m_OpenContainers[_loc2_] != null)
            {
               this.m_OpenContainers[_loc2_].removeAll();
               this.m_OpenContainers[_loc2_] = null;
            }
            _loc2_++;
         }
         var _loc3_:OptionsStorage = Tibia.s_GetOptions();
         var _loc4_:SideBarSet = null;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.getSideBarSet(SideBarSet.DEFAULT_SET);
         }
         var _loc5_:int = 0;
         while(_loc5_ < OPEN_CONTAINERS)
         {
            if(this.m_OpenWidgets[_loc5_] > -1 && _loc4_ != null)
            {
               _loc4_.hideWidgetByID(this.m_OpenWidgets[_loc5_]);
            }
            this.m_OpenWidgets[_loc5_] = -1;
            _loc5_++;
         }
         this.m_PlayerMoney = 0;
         this.m_PlayerGoods = null;
         this.m_PlayerInventory.length = 0;
      }
      
      public function getAvailableInventory(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = this.m_PlayerInventory.length - 1;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc3_ <= _loc4_)
         {
            _loc5_ = _loc3_ + _loc4_ >>> 1;
            _loc6_ = AppearanceTypeRef.s_CompareExternal(this.m_PlayerInventory[_loc5_],param1,param2);
            if(_loc6_ < 0)
            {
               _loc3_ = _loc5_ + 1;
               continue;
            }
            if(_loc6_ > 0)
            {
               _loc4_ = _loc5_ - 1;
               continue;
            }
            return this.m_PlayerInventory[_loc5_].count;
         }
         return 0;
      }
      
      public function sendCloseContainer(param1:tibia.container.Container) : void
      {
         if(param1 == null || param1.window < 0)
         {
            log("ContainerStorage.sendCloseContainer: Container is null or invalid; ignored");
            return;
         }
         var _loc2_:Connection = Tibia.s_GetConnection();
         if(_loc2_ != null && Boolean(_loc2_.isGameRunning))
         {
            _loc2_.sendCCLOSECONTAINER(param1.window);
         }
      }
      
      public function closeOpenContainer(param1:int) : void
      {
         if(param1 < 0 || param1 >= OPEN_CONTAINERS)
         {
            throw new RangeError("ContainerStorage.closeOpenContainer: Invalid container number: " + param1);
         }
         this.m_OpenContainers[param1] = null;
         var _loc2_:OptionsStorage = Tibia.s_GetOptions();
         var _loc3_:SideBarSet = null;
         if(this.m_OpenWidgets[param1] > -1)
         {
            if(_loc2_ != null && (_loc3_ = _loc2_.getSideBarSet(SideBarSet.DEFAULT_SET)) != null)
            {
               _loc3_.hideWidgetByID(this.m_OpenWidgets[param1]);
            }
            this.m_OpenWidgets[param1] = -1;
         }
      }
      
      public function getBodyContainer() : tibia.container.Container
      {
         return this.m_BodyContainer;
      }
      
      public function getAvailableGoods(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = this.m_PlayerGoods.length - 1;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc3_ <= _loc4_)
         {
            _loc5_ = _loc3_ + _loc4_ >>> 1;
            _loc6_ = AppearanceTypeRef.s_CompareExternal(this.m_PlayerGoods[_loc5_],param1,param2);
            if(_loc6_ < 0)
            {
               _loc3_ = _loc5_ + 1;
               continue;
            }
            if(_loc6_ > 0)
            {
               _loc4_ = _loc5_ - 1;
               continue;
            }
            return this.m_PlayerGoods[_loc5_].count;
         }
         return 0;
      }
      
      public function setPlayerMoney(param1:uint) : void
      {
         var _loc2_:PropertyChangeEvent = null;
         if(this.m_PlayerMoney != param1)
         {
            this.m_PlayerMoney = param1;
            _loc2_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc2_.kind = PropertyChangeEventKind.UPDATE;
            _loc2_.property = "playerMoney";
            dispatchEvent(_loc2_);
         }
      }
      
      public function getMultiUseDelay() : Delay
      {
         return this.m_MultiuseDelay.clone();
      }
      
      public function getOpenContainer(param1:int) : tibia.container.Container
      {
         if(param1 < 0 || param1 >= OPEN_CONTAINERS)
         {
            throw new RangeError("ContainerStorage.getOpenContainer: Invalid container number: " + param1);
         }
         return this.m_OpenContainers[param1];
      }
      
      public function setMultiUseDelay(param1:Number) : void
      {
         this.m_MultiuseDelay.start = Tibia.s_FrameTimestamp;
         this.m_MultiuseDelay.end = Tibia.s_FrameTimestamp + param1;
      }
      
      public function setOpenContainer(param1:int, param2:tibia.container.Container) : void
      {
         var _loc5_:ContainerWidget = null;
         if(param1 < 0 || param1 >= OPEN_CONTAINERS)
         {
            throw new RangeError("ContainerStorage.setOpenContainer: Invalid container number: " + param1);
         }
         this.m_OpenContainers[param1] = param2;
         var _loc3_:OptionsStorage = Tibia.s_GetOptions();
         var _loc4_:SideBarSet = null;
         if(_loc3_ != null && (_loc4_ = _loc3_.getSideBarSet(SideBarSet.DEFAULT_SET)) != null)
         {
            _loc5_ = null;
            if(this.m_OpenWidgets[param1] > -1)
            {
               _loc5_ = _loc4_.getWidgetByID(this.m_OpenWidgets[param1]) as ContainerWidget;
            }
            if(_loc5_ == null)
            {
               _loc5_ = ContainerWidget(_loc4_.showWidgetType(Widget.TYPE_CONTAINER,-1,-1));
            }
            _loc5_.container = param2;
            this.m_OpenWidgets[param1] = _loc5_.ID;
         }
      }
      
      public function getPlayerMoney() : uint
      {
         return this.m_PlayerMoney;
      }
      
      public function isEquipped(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:AppearanceInstance = null;
         var _loc2_:AppearanceType = null;
         var _loc3_:AppearanceStorage = Tibia.s_GetAppearanceStorage();
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getObjectType(param1);
         }
         if(_loc2_ != null && Boolean(_loc2_.isCloth))
         {
            _loc4_ = _loc2_.clothSlot;
            if(_loc4_ == BODY_BOTH_HANDS)
            {
               _loc4_ = BODY_LEFT_HAND;
            }
            if(this.m_BodyContainer != null)
            {
               _loc5_ = this.m_BodyContainer.getItemAt(_loc4_ - BODY_HEAD);
               return _loc5_ != null && _loc5_.ID == param1;
            }
         }
         return false;
      }
      
      protected function onBodyChange(param1:PropertyChangeEvent) : void
      {
         var _loc2_:PropertyChangeEvent = null;
         if((!param1.cancelable || !param1.isDefaultPrevented()) && param1.property == "item")
         {
            _loc2_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc2_.kind = PropertyChangeEventKind.UPDATE;
            _loc2_.property = "bodyItem";
            _loc2_.source = param1.currentTarget;
            dispatchEvent(_loc2_);
         }
      }
      
      public function setPlayerInventory(param1:Vector.<tibia.container.InventoryTypeInfo>) : void
      {
         var _loc2_:PropertyChangeEvent = null;
         if(param1 == null)
         {
            throw new ArgumentError("ContainerStorage.setPlayerInventory: Invalid inventory.");
         }
         if(this.m_PlayerInventory != param1)
         {
            this.m_PlayerInventory = param1;
            _loc2_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc2_.kind = PropertyChangeEventKind.UPDATE;
            _loc2_.property = "playerInventory";
            dispatchEvent(_loc2_);
         }
      }
      
      public function setPlayerGoods(param1:Vector.<tibia.container.InventoryTypeInfo>) : void
      {
         var _loc2_:PropertyChangeEvent = null;
         if(param1 == null)
         {
            throw new ArgumentError("ContainerStorage.setPlayerGoods: Invalid goods.");
         }
         if(this.m_PlayerGoods != param1)
         {
            this.m_PlayerGoods = param1;
            _loc2_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc2_.kind = PropertyChangeEventKind.UPDATE;
            _loc2_.property = "playerGoods";
            dispatchEvent(_loc2_);
         }
      }
      
      public function sendUpContainer(param1:tibia.container.Container) : void
      {
         if(param1 == null || param1.window < 0 || !param1.isSubContainer)
         {
            log("ContainerStorage.sendUpContainer: Container is null or invalid; ignored");
            return;
         }
         var _loc2_:Connection = Tibia.s_GetConnection();
         if(_loc2_ != null && Boolean(_loc2_.isGameRunning))
         {
            _loc2_.sendCUPCONTAINER(param1.window);
         }
      }
      
      public function getPlayerGoods() : Vector.<tibia.container.InventoryTypeInfo>
      {
         return this.m_PlayerGoods;
      }
   }
}
