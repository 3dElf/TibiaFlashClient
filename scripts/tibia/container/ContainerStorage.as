package tibia.container
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.game.*;
    import tibia.options.*;
    import tibia.sidebar.*;

    public class ContainerStorage extends EventDispatcher
    {
        protected var m_MultiuseDelay:Delay = null;
        protected var m_PlayerInventory:Vector.<InventoryTypeInfo> = null;
        protected var m_PlayerGoods:Vector.<InventoryTypeInfo> = null;
        protected var m_BodyContainerView:BodyContainerView = null;
        protected var m_PlayerMoney:Number = 0;
        protected var m_ContainerViews:Vector.<ContainerView> = null;
        protected var m_ContainerViewWidgets:Vector.<int> = null;
        public static const MAX_CONTAINER_VIEWS:int = 16;
        public static const MIN_MULTI_USE_DELAY:int = 1000;
        public static const INVENTORY_ANY:Vector3D = new Vector3D(65535, 0, 0);
        public static const MIN_USE_DELAY:int = 100;
        public static const MAX_NAME_LENGTH:int = 30;

        public function ContainerStorage()
        {
            this.m_BodyContainerView = new BodyContainerView();
            this.m_BodyContainerView.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onBodyContainerChange);
            this.m_MultiuseDelay = new Delay(0, 0);
            this.m_ContainerViews = new Vector.<ContainerView>(MAX_CONTAINER_VIEWS, true);
            this.m_ContainerViewWidgets = new Vector.<int>(MAX_CONTAINER_VIEWS, true);
            var _loc_1:* = 0;
            while (_loc_1 < MAX_CONTAINER_VIEWS)
            {
                
                this.m_ContainerViewWidgets[_loc_1] = -1;
                _loc_1++;
            }
            this.m_PlayerInventory = new Vector.<InventoryTypeInfo>;
            this.reset();
            return;
        }// end function

        public function getPlayerInventory() : Vector.<InventoryTypeInfo>
        {
            return this.m_PlayerInventory;
        }// end function

        public function getAvailableGoods(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (this.m_PlayerGoods != null)
            {
                _loc_3 = 0;
                _loc_4 = this.m_PlayerGoods.length - 1;
                _loc_5 = 0;
                _loc_6 = 0;
                while (_loc_3 <= _loc_4)
                {
                    
                    _loc_5 = _loc_3 + _loc_4 >>> 1;
                    _loc_6 = AppearanceTypeRef.s_CompareExternal(this.m_PlayerGoods[_loc_5], param1, param2);
                    if (_loc_6 < 0)
                    {
                        _loc_3 = _loc_5 + 1;
                        continue;
                    }
                    if (_loc_6 > 0)
                    {
                        _loc_4 = _loc_5 - 1;
                        continue;
                    }
                    return this.m_PlayerGoods[_loc_5].count;
                }
            }
            return 0;
        }// end function

        public function getBodyContainerView() : BodyContainerView
        {
            return this.m_BodyContainerView;
        }// end function

        public function reset() : void
        {
            this.m_BodyContainerView.reset();
            var _loc_1:* = 0;
            while (_loc_1 < MAX_CONTAINER_VIEWS)
            {
                
                if (this.m_ContainerViews[_loc_1] != null)
                {
                    this.m_ContainerViews[_loc_1].removeAll();
                    this.m_ContainerViews[_loc_1] = null;
                }
                _loc_1++;
            }
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            if (_loc_2 != null)
            {
                _loc_3 = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            }
            var _loc_4:* = 0;
            while (_loc_4 < MAX_CONTAINER_VIEWS)
            {
                
                if (this.m_ContainerViewWidgets[_loc_4] > -1 && _loc_3 != null)
                {
                    _loc_3.hideWidgetByID(this.m_ContainerViewWidgets[_loc_4]);
                }
                this.m_ContainerViewWidgets[_loc_4] = -1;
                _loc_4++;
            }
            this.m_MultiuseDelay = new Delay(0, 0);
            this.m_PlayerMoney = 0;
            this.m_PlayerGoods = null;
            this.m_PlayerInventory.length = 0;
            return;
        }// end function

        public function getContainerView(param1:int) : ContainerView
        {
            if (param1 < 0 || param1 >= MAX_CONTAINER_VIEWS)
            {
                throw new RangeError("ContainerStorage.getOpenContainer: Invalid container number: " + param1);
            }
            return this.m_ContainerViews[param1];
        }// end function

        public function setMultiUseDelay(param1:Number) : void
        {
            this.m_MultiuseDelay.start = Tibia.s_FrameTibiaTimestamp;
            this.m_MultiuseDelay.end = Tibia.s_FrameTibiaTimestamp + param1;
            return;
        }// end function

        public function getAvailableInventory(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (this.m_PlayerInventory != null)
            {
                _loc_3 = 0;
                _loc_4 = this.m_PlayerInventory.length - 1;
                _loc_5 = 0;
                _loc_6 = 0;
                while (_loc_3 <= _loc_4)
                {
                    
                    _loc_5 = _loc_3 + _loc_4 >>> 1;
                    _loc_6 = AppearanceTypeRef.s_CompareExternal(this.m_PlayerInventory[_loc_5], param1, param2);
                    if (_loc_6 < 0)
                    {
                        _loc_3 = _loc_5 + 1;
                        continue;
                    }
                    if (_loc_6 > 0)
                    {
                        _loc_4 = _loc_5 - 1;
                        continue;
                    }
                    return this.m_PlayerInventory[_loc_5].count;
                }
            }
            return 0;
        }// end function

        public function setPlayerMoney(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this.m_PlayerMoney != param1)
            {
                this.m_PlayerMoney = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "playerMoney";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function getMultiUseDelay() : Delay
        {
            return this.m_MultiuseDelay.clone();
        }// end function

        public function getFreeContainerViewID() : int
        {
            var _loc_1:* = 0;
            while (_loc_1 < MAX_CONTAINER_VIEWS)
            {
                
                if (this.m_ContainerViews[_loc_1] == null)
                {
                    return _loc_1;
                }
                _loc_1++;
            }
            return MAX_CONTAINER_VIEWS - _loc_1;
        }// end function

        public function getPlayerMoney() : Number
        {
            return this.m_PlayerMoney;
        }// end function

        public function createContainerView(param1:int, param2:ObjectInstance, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:int, param8:int, param9:int) : ContainerView
        {
            var _loc_13:* = null;
            if (param1 < 0 || param1 >= MAX_CONTAINER_VIEWS)
            {
                throw new RangeError("ContainerStorage.setOpenContainer: Invalid container number: " + param1);
            }
            var _loc_10:* = new ContainerView(param1, param2, param3, param4, param5, param6, param7, param8, param9);
            this.m_ContainerViews[param1] = _loc_10;
            var _loc_11:* = Tibia.s_GetOptions();
            var _loc_12:* = null;
            var _loc_14:* = _loc_11.getSideBarSet(SideBarSet.DEFAULT_SET);
            _loc_12 = _loc_11.getSideBarSet(SideBarSet.DEFAULT_SET);
            if (_loc_11 != null && _loc_14 != null)
            {
                _loc_13 = null;
                if (this.m_ContainerViewWidgets[param1] > -1)
                {
                    _loc_13 = _loc_12.getWidgetByID(this.m_ContainerViewWidgets[param1]) as ContainerViewWidget;
                }
                if (_loc_13 == null)
                {
                    _loc_13 = ContainerViewWidget(_loc_12.showWidgetType(Widget.TYPE_CONTAINER, -1, -1));
                }
                _loc_13.container = _loc_10;
                this.m_ContainerViewWidgets[param1] = _loc_13.ID;
            }
            return _loc_10;
        }// end function

        public function closeContainerView(param1:int) : void
        {
            if (param1 < 0 || param1 >= MAX_CONTAINER_VIEWS)
            {
                throw new RangeError("ContainerStorage.closeContainerView: Invalid container number: " + param1);
            }
            this.m_ContainerViews[param1] = null;
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            if (this.m_ContainerViewWidgets[param1] > -1)
            {
                var _loc_4:* = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
                _loc_3 = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
                if (_loc_2 != null && _loc_4 != null)
                {
                    _loc_3.hideWidgetByID(this.m_ContainerViewWidgets[param1]);
                }
                this.m_ContainerViewWidgets[param1] = -1;
            }
            return;
        }// end function

        protected function onBodyContainerChange(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = null;
            if ((!event.cancelable || !event.isDefaultPrevented()) && event.property == "objects")
            {
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "bodyItem";
                _loc_2.source = event.currentTarget;
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function setPlayerInventory(param1:Vector.<InventoryTypeInfo>) : void
        {
            var _loc_2:* = null;
            if (param1 == null)
            {
                throw new ArgumentError("ContainerStorage.setPlayerInventory: Invalid inventory.");
            }
            if (this.m_PlayerInventory != param1)
            {
                this.m_PlayerInventory = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "playerInventory";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function setPlayerGoods(param1:Vector.<InventoryTypeInfo>) : void
        {
            var _loc_2:* = null;
            if (param1 == null)
            {
                throw new ArgumentError("ContainerStorage.setPlayerGoods: Invalid goods.");
            }
            if (this.m_PlayerGoods != param1)
            {
                this.m_PlayerGoods = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "playerGoods";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function getPlayerGoods() : Vector.<InventoryTypeInfo>
        {
            return this.m_PlayerGoods;
        }// end function

    }
}
