package tibia.trade.npcTradeWidgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.core.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.input.gameaction.*;
    import tibia.options.*;
    import tibia.trade.*;

    public class ObjectRefSelectorBase extends UIComponent
    {
        protected var m_SelectedIndex:int = -1;
        private var m_UncommittedTradeMode:Boolean = false;
        protected var m_SortOrder:int = 0;
        private var m_UncommittedSelectedIndex:Boolean = false;
        private var m_UncommittedDataProvider:Boolean = false;
        protected var m_DataProvider:IList = null;
        protected var m_TradeMode:int;
        private var m_UncommittedSortOrder:Boolean = true;
        private static const ACTION_UNSET:int = -1;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        private static const ACTION_USE_OR_OPEN:int = 101;
        private static const ACTION_SMARTCLICK:int = 100;
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        public static const SORT_NAME:int = 0;
        private static const ACTION_LOOK:int = 6;
        public static const LAYOUT_LIST:int = 0;
        private static const ACTION_TALK:int = 9;
        public static const LAYOUT_GRID:int = 1;
        private static const ACTION_USE:int = 7;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        private static const ACTION_NONE:int = 0;
        private static const ACTION_AUTOWALK:int = 3;
        private static const ACTION_ATTACK:int = 1;
        private static const ACTION_OPEN:int = 8;
        public static const SORT_PRICE:int = 2;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
        private static const ACTION_CONTEXT_MENU:int = 5;
        public static const SORT_WEIGHT:int = 1;
        private static const ACTION_ATTACK_OR_TALK:int = 102;

        public function ObjectRefSelectorBase()
        {
            this.m_TradeMode = NPCTradeWidgetView.MODE_BUY;
            addEventListener(MouseEvent.CLICK, this.onMouseClick);
            addEventListener(MouseEvent.MIDDLE_CLICK, this.onMouseClick);
            addEventListener(MouseEvent.RIGHT_CLICK, this.onMouseClick);
            return;
        }// end function

        public function set tradeMode(param1:int) : void
        {
            if (param1 != NPCTradeWidgetView.MODE_BUY && param1 != NPCTradeWidgetView.MODE_SELL)
            {
                param1 = NPCTradeWidgetView.MODE_BUY;
            }
            if (this.m_TradeMode != param1)
            {
                this.m_TradeMode = param1;
                this.m_UncommittedTradeMode = true;
                this.m_UncommittedSortOrder = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get sortOrder() : int
        {
            return this.m_SortOrder;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.commitProperties();
            if (this.m_UncommittedDataProvider)
            {
                this.selectedIndex = -1;
                this.m_UncommittedDataProvider = false;
            }
            if (this.m_UncommittedSortOrder)
            {
                _loc_1 = this.selectedObject;
                if (this.dataProvider is ICollectionView)
                {
                    _loc_2 = [];
                    if (this.tradeMode == NPCTradeWidgetView.MODE_SELL)
                    {
                        _loc_2.push(new SortField("amount", false, true, true));
                    }
                    switch(this.sortOrder)
                    {
                        case SORT_NAME:
                        {
                            break;
                        }
                        case SORT_PRICE:
                        {
                            _loc_2.push(new SortField("price", false, false, true));
                            break;
                        }
                        case SORT_WEIGHT:
                        {
                            _loc_2.push(new SortField("weight", false, false, true));
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_2.push(new SortField("name"), new SortField("ID", false, false, true));
                    _loc_3 = new Sort();
                    _loc_3.fields = _loc_2;
                    ICollectionView(this.dataProvider).sort = _loc_3;
                    ICollectionView(this.dataProvider).refresh();
                }
                if (this.dataProvider != null)
                {
                    this.selectedIndex = this.dataProvider.getItemIndex(_loc_1);
                }
                this.m_UncommittedSortOrder = false;
            }
            if (this.m_UncommittedTradeMode)
            {
                this.selectedIndex = -1;
                this.m_UncommittedTradeMode = false;
            }
            if (this.m_UncommittedSelectedIndex)
            {
                this.m_UncommittedSelectedIndex = false;
            }
            return;
        }// end function

        public function set sortOrder(param1:int) : void
        {
            if (param1 != SORT_NAME && param1 != SORT_WEIGHT && param1 != SORT_PRICE)
            {
                param1 = SORT_NAME;
            }
            if (this.m_SortOrder != param1)
            {
                this.m_SortOrder = param1;
                this.m_UncommittedSortOrder = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onMouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (event != null)
            {
                _loc_2 = this.getTradeObjectByDisplayObject(DisplayObject(event.target));
                _loc_3 = ACTION_UNSET;
                if (event.type == MouseEvent.CLICK && !event.altKey && !event.ctrlKey && !event.shiftKey)
                {
                    if (_loc_2 != null)
                    {
                        this.selectedObject = _loc_2;
                    }
                    _loc_3 = ACTION_NONE;
                }
                else if (event.altKey)
                {
                    _loc_3 = ACTION_NONE;
                }
                else if (event.ctrlKey)
                {
                    _loc_3 = ACTION_CONTEXT_MENU;
                }
                else if (event.shiftKey)
                {
                    _loc_3 = ACTION_LOOK;
                }
                else
                {
                    _loc_3 = ACTION_CONTEXT_MENU;
                }
                switch(_loc_3)
                {
                    case ACTION_NONE:
                    {
                        break;
                    }
                    case ACTION_LOOK:
                    {
                        if (_loc_2 != null)
                        {
                            new InspectNPCTradeActionImpl(_loc_2).perform();
                        }
                        break;
                    }
                    case ACTION_CONTEXT_MENU:
                    {
                        _loc_4 = Tibia.s_GetOptions();
                        if (_loc_4 != null)
                        {
                            new NPCTradeContextMenu(_loc_4, this.m_TradeMode, _loc_2).display(this, event.stageX, event.stageY);
                        }
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get tradeMode() : int
        {
            return this.m_TradeMode;
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            var _loc_2:* = null;
            if (this.dataProvider != null && param1 > -1)
            {
                param1 = Math.max(0, Math.min(param1, (this.dataProvider.length - 1)));
            }
            else
            {
                param1 = -1;
            }
            if (this.selectedIndex != param1)
            {
                this.m_SelectedIndex = param1;
                this.m_UncommittedSelectedIndex = true;
                invalidateProperties();
                _loc_2 = new Event(Event.CHANGE);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function get layout() : int
        {
            throw new Error("ObjectRefSelectorBase.get layout: This method needs to be overridden in a subclass.");
        }// end function

        public function set selectedObject(param1:TradeObjectRef) : void
        {
            var _loc_2:* = 0;
            if (this.dataProvider != null && param1 != null)
            {
                _loc_2 = this.dataProvider.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    if (TradeObjectRef(this.dataProvider.getItemAt(_loc_2)).equals(param1))
                    {
                        this.selectedIndex = _loc_2;
                        return;
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            this.selectedIndex = -1;
            return;
        }// end function

        public function set dataProvider(param1:IList) : void
        {
            if (this.m_DataProvider != param1)
            {
                this.m_DataProvider = param1;
                this.m_UncommittedDataProvider = true;
                this.m_UncommittedSortOrder = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return this.m_SelectedIndex;
        }// end function

        public function get selectedObject() : TradeObjectRef
        {
            if (this.dataProvider != null && this.selectedIndex > -1 && this.selectedIndex < this.dataProvider.length)
            {
                return TradeObjectRef(this.dataProvider.getItemAt(this.selectedIndex));
            }
            return null;
        }// end function

        public function get dataProvider() : IList
        {
            return this.m_DataProvider;
        }// end function

        protected function getTradeObjectByDisplayObject(param1:DisplayObject) : TradeObjectRef
        {
            while (param1 != null && !(param1 is Stage))
            {
                
                if (param1 is ListObjectRefItemRenderer)
                {
                    return ListObjectRefItemRenderer(param1).data as TradeObjectRef;
                }
                if (param1 is SkinnedAppearanceRenderer)
                {
                    return SkinnedAppearanceRenderer(param1).appearance as TradeObjectRef;
                }
                param1 = DisplayObject(param1.parent);
            }
            return null;
        }// end function

        public static function s_Create(param1:int) : ObjectRefSelectorBase
        {
            switch(param1)
            {
                case LAYOUT_GRID:
                {
                    return new GridObjectRefSelector();
                }
                case LAYOUT_LIST:
                {
                }
                default:
                {
                    return new ListObjectRefSelector();
                    break;
                }
            }
        }// end function

    }
}
