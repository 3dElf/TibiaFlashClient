package tibia.trade
{
    import mx.collections.*;
    import tibia.appearances.*;
    import tibia.container.*;
    import tibia.creatures.*;
    import tibia.network.*;
    import tibia.sidebar.*;
    import tibia.sidebar.sideBarWidgetClasses.*;
    import tibia.trade.npcTradeWidgetClasses.*;

    public class NPCTradeWidget extends Widget
    {
        protected var m_AppearanceStorage:AppearanceStorage = null;
        protected var m_Categories:IList = null;
        protected var m_Player:Player = null;
        protected var m_NPCName:String = null;
        protected var m_BuyObjects:IList = null;
        protected var m_ContainerStorage:ContainerStorage = null;
        protected var m_SellObjects:IList = null;
        public static const TRADE_BACKPACK_PRICE:int = 20;
        public static const CATEGORY_ALL_NAME:String = "All";
        public static const TRADE_BACKPACK_WEIGHT:int = 1800;
        public static const TRADE_MAX_AMOUNT:int = 100;
        public static const CATEGORY_ALL_TYPEDATA:int = 0;
        public static const MAX_WARE_NAME_LENGTH:int = 35;
        public static const CATEGORY_ALL_TYPEID:int = 2472;
        public static const TRADE_BACKPACK_CAPACITY:int = 20;

        public function NPCTradeWidget()
        {
            return;
        }// end function

        override public function releaseViewInstance() : void
        {
            this.appearanceStorage = null;
            this.containerStorage = null;
            options = null;
            this.player = null;
            super.releaseViewInstance();
            return;
        }// end function

        public function set player(param1:Player) : void
        {
            if (this.m_Player != param1)
            {
                this.m_Player = param1;
                if (m_ViewInstance is NPCTradeWidgetView)
                {
                    NPCTradeWidgetView(m_ViewInstance).player = this.m_Player;
                }
            }
            return;
        }// end function

        public function set sellObjects(param1:IList) : void
        {
            if (this.m_SellObjects != param1)
            {
                this.m_SellObjects = param1;
                if (m_ViewInstance is NPCTradeWidgetView)
                {
                    NPCTradeWidgetView(m_ViewInstance).sellObjects = this.m_SellObjects;
                }
            }
            return;
        }// end function

        public function get npcName() : String
        {
            return this.m_NPCName;
        }// end function

        override public function acquireViewInstance(param1:Boolean = true) : WidgetView
        {
            this.appearanceStorage = Tibia.s_GetAppearanceStorage();
            this.containerStorage = Tibia.s_GetContainerStorage();
            options = Tibia.s_GetOptions();
            this.player = Tibia.s_GetPlayer();
            var _loc_2:* = super.acquireViewInstance(param1) as NPCTradeWidgetView;
            if (_loc_2 != null)
            {
                _loc_2.appearanceStorage = this.m_AppearanceStorage;
                _loc_2.containerStorage = this.m_ContainerStorage;
                _loc_2.options = m_Options;
                _loc_2.player = this.m_Player;
                _loc_2.buyObjects = this.m_BuyObjects;
                _loc_2.sellObjects = this.m_SellObjects;
                _loc_2.categories = this.m_Categories;
            }
            return _loc_2;
        }// end function

        public function set buyObjects(param1:IList) : void
        {
            if (this.m_BuyObjects != param1)
            {
                this.m_BuyObjects = param1;
                if (m_ViewInstance is NPCTradeWidgetView)
                {
                    NPCTradeWidgetView(m_ViewInstance).buyObjects = this.m_BuyObjects;
                }
            }
            return;
        }// end function

        public function set npcName(param1:String) : void
        {
            if (this.m_NPCName != param1)
            {
                this.m_NPCName = param1;
                if (m_ViewInstance is NPCTradeWidgetView)
                {
                    NPCTradeWidgetView(m_ViewInstance).npcName = this.m_NPCName;
                }
            }
            return;
        }// end function

        public function get player() : Player
        {
            return this.m_Player;
        }// end function

        public function get sellObjects() : IList
        {
            return this.m_SellObjects;
        }// end function

        public function get categories() : IList
        {
            return this.m_Categories;
        }// end function

        public function set appearanceStorage(param1:AppearanceStorage) : void
        {
            if (this.m_AppearanceStorage != param1)
            {
                this.m_AppearanceStorage = param1;
                if (m_ViewInstance is NPCTradeWidgetView)
                {
                    NPCTradeWidgetView(m_ViewInstance).appearanceStorage = this.m_AppearanceStorage;
                }
            }
            return;
        }// end function

        public function get buyObjects() : IList
        {
            return this.m_BuyObjects;
        }// end function

        public function get appearanceStorage() : AppearanceStorage
        {
            return this.m_AppearanceStorage;
        }// end function

        public function set categories(param1:IList) : void
        {
            if (this.m_Categories != param1)
            {
                this.m_Categories = param1;
                if (m_ViewInstance is NPCTradeWidgetView)
                {
                    NPCTradeWidgetView(m_ViewInstance).categories = this.m_Categories;
                }
            }
            return;
        }// end function

        public function get containerStorage() : ContainerStorage
        {
            return this.m_ContainerStorage;
        }// end function

        public function set containerStorage(param1:ContainerStorage) : void
        {
            if (this.m_ContainerStorage != param1)
            {
                this.m_ContainerStorage = param1;
                if (m_ViewInstance is NPCTradeWidgetView)
                {
                    NPCTradeWidgetView(m_ViewInstance).containerStorage = this.m_ContainerStorage;
                }
            }
            return;
        }// end function

        override public function close(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            super.close(param1);
            if (closed)
            {
                _loc_2 = Tibia.s_GetCommunication();
                if (_loc_2 != null && _loc_2.isGameRunning)
                {
                    _loc_2.sendCCLOSENPCTRADE();
                }
            }
            return;
        }// end function

    }
}
