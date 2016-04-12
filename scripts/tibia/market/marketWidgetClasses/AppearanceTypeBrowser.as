package tibia.market.marketWidgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.game.*;
    import tibia.market.*;
    import tibia.market.marketWidgetClasses.*;
    import tibia.options.*;

    public class AppearanceTypeBrowser extends VBox implements IAppearanceTypeFilterEditor
    {
        private var m_AppearanceTypes:Array = null;
        private var m_UIEditorStack:ViewStack = null;
        private var m_UncommittedLayout:Boolean = true;
        private var m_Editor:int = 0;
        private var m_FilterFunction:Function = null;
        private var m_UncommittedDepot:Boolean = true;
        private var m_UncommittedAppearanceTypes:Boolean = false;
        private var m_UncommittedSelectedType:int = 0;
        private var m_SelectedType:AppearanceType = null;
        private var m_UIViewToggle:Button = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UIEditor:Vector.<IAppearanceTypeFilterEditor>;
        private var m_UIDepot:Button = null;
        private var m_Depot:Boolean = false;
        private var m_AppearanceTypesView:ArrayCollection = null;
        private var m_Layout:int = 1;
        private var m_UncommittedEditor:Boolean = false;
        private var m_UncommittedFilterFunction:Boolean = false;
        private var m_UIEditorToggle:TabBar = null;
        private var m_UIView:ListBase = null;
        private var m_CreationComplete:Boolean = false;
        private static const ACTION_NONE:int = 0;
        private static const BUNDLE:String = "MarketWidget";
        public static const LAYOUT_TILE:int = 1;
        public static const EDITOR_CATEGORY:int = 0;
        public static const LAYOUT_LIST:int = 0;
        public static const FILTER_CHANGE:String = "filterChange";
        private static const ACTION_CONTEXT_MENU:int = 3;
        public static const EDITOR_NAME:int = 1;

        public function AppearanceTypeBrowser()
        {
            this.m_UIEditor = new Vector.<IAppearanceTypeFilterEditor>;
            var _loc_1:* = new Sort();
            _loc_1.compareFunction = Utility.compareAppearanceType;
            this.m_AppearanceTypesView = new ArrayCollection();
            this.m_AppearanceTypesView.sort = _loc_1;
            var _loc_2:* = Tibia.s_GetAppearanceStorage();
            if (_loc_2 != null)
            {
                this.appearanceTypes = _loc_2.marketObjectTypes;
            }
            var _loc_3:* = Tibia.s_GetOptions();
            if (_loc_3 != null)
            {
                this.viewLayout = _loc_3.marketBrowserLayout;
                this.filterEditor = _loc_3.marketBrowserEditor;
                this.filterDepot = _loc_3.marketBrowserDepot;
            }
            var _loc_4:* = PopUpBase.getCurrent() as MarketWidget;
            if (PopUpBase.getCurrent() as MarketWidget != null)
            {
                _loc_4.addEventListener(MarketWidget.DEPOT_CONTENT_CHANGE, this.onFilterChange, false, EventPriority.DEFAULT, true);
            }
            addEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
            return;
        }// end function

        private function get filterEditor() : int
        {
            return this.m_Editor;
        }// end function

        private function set filterEditor(param1:int) : void
        {
            if (param1 != EDITOR_CATEGORY && param1 != EDITOR_NAME)
            {
                param1 = EDITOR_CATEGORY;
            }
            if (this.m_Editor != param1)
            {
                this.m_Editor = param1;
                this.m_UncommittedEditor = true;
                this.invalidateFilterFunction();
                invalidateProperties();
            }
            return;
        }// end function

        public function invalidateFilterFunction() : void
        {
            this.m_FilterFunction = null;
            dispatchEvent(new Event(FILTER_CHANGE));
            this.m_UncommittedFilterFunction = true;
            invalidateProperties();
            return;
        }// end function

        private function get filterDepot() : Boolean
        {
            return this.m_Depot;
        }// end function

        private function set _selectedType(param1:AppearanceType) : void
        {
            if (this.m_SelectedType != param1)
            {
                this.m_SelectedType = param1;
                this.m_UncommittedSelectedType = 1;
                invalidateProperties();
                dispatchEvent(new Event(Event.CHANGE));
            }
            return;
        }// end function

        public function get viewLayout() : int
        {
            return this.m_Layout;
        }// end function

        private function onCreationComplete(event:Event) : void
        {
            removeEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
            this.m_CreationComplete = true;
            this.invalidateFilterFunction();
            return;
        }// end function

        private function onViewMouseEvent(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (event != null)
            {
                _loc_2 = event.currentTarget as ListBase;
                _loc_3 = _loc_2 != null ? (var _loc_6:* = _loc_2, _loc_6.mx_internal::mouseEventToItemRendererOrEditor(event) as AppearanceTypeTileRenderer) : (null);
                _loc_4 = _loc_3 != null ? (_loc_3.data as AppearanceType) : (null);
                _loc_5 = ACTION_NONE;
                if (event.type == MouseEvent.CLICK && !event.altKey && !event.ctrlKey && !event.shiftKey)
                {
                    _loc_5 = ACTION_NONE;
                }
                else if (event.altKey)
                {
                    _loc_5 = ACTION_NONE;
                }
                else if (event.ctrlKey)
                {
                    _loc_5 = ACTION_CONTEXT_MENU;
                }
                else if (event.shiftKey)
                {
                    _loc_5 = ACTION_NONE;
                }
                else
                {
                    _loc_5 = ACTION_CONTEXT_MENU;
                }
                switch(_loc_5)
                {
                    case ACTION_CONTEXT_MENU:
                    {
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

        override protected function createChildren() : void
        {
            var _TabContainer:VBox;
            var _FilterContainer:VBox;
            var _ViewContainer:VBox;
            var _BarContainer:HBox;
            var _Spacer:Spacer;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                setStyle("horizontalGap", 0);
                setStyle("verticalGap", 0);
                setStyle("paddingBottom", 0);
                setStyle("paddingLeft", 0);
                setStyle("paddingRight", 0);
                setStyle("paddingTop", 0);
                _TabContainer = new VBox();
                _TabContainer.percentHeight = 100;
                _TabContainer.percentWidth = 100;
                _TabContainer.styleName = "marketWidgetRootContainer";
                _TabContainer.setStyle("verticalGap", 4);
                _FilterContainer = new VBox();
                _FilterContainer.percentWidth = 100;
                _FilterContainer.styleName = "marketWidgetFilter";
                this.m_UIEditorStack = new ViewStack();
                this.m_UIEditorStack.height = 70;
                this.m_UIEditorStack.percentWidth = 100;
                this.m_UIEditorStack.addEventListener(IndexChangedEvent.CHANGE, function (event:Event) : void
            {
                filterEditor = m_UIEditorStack.selectedIndex;
                return;
            }// end function
            );
                _FilterContainer.addChild(this.m_UIEditorStack);
                this.m_UIEditor[EDITOR_CATEGORY] = new AppearanceTypeCategoryFilterEditor();
                this.m_UIEditor[EDITOR_CATEGORY].percentHeight = 100;
                this.m_UIEditor[EDITOR_CATEGORY].percentWidth = 100;
                this.m_UIEditor[EDITOR_CATEGORY].addEventListener(FILTER_CHANGE, this.onFilterChange);
                this.m_UIEditor[EDITOR_CATEGORY].setStyle("borderColor", "");
                this.m_UIEditor[EDITOR_CATEGORY].setStyle("borderStyle", "none");
                this.m_UIEditor[EDITOR_CATEGORY].setStyle("borderThickness", 0);
                this.m_UIEditor[EDITOR_CATEGORY].setStyle("horizontalAlign", "center");
                this.m_UIEditor[EDITOR_CATEGORY].setStyle("horizontalGap", 2);
                this.m_UIEditor[EDITOR_CATEGORY].setStyle("verticalAlign", "middle");
                this.m_UIEditor[EDITOR_CATEGORY].setStyle("verticalGap", 2);
                this.m_UIEditorStack.addChild(this.m_UIEditor[0] as DisplayObject);
                this.m_UIEditor[EDITOR_NAME] = new AppearanceTypeNameFilterEditor();
                this.m_UIEditor[EDITOR_NAME].percentHeight = 100;
                this.m_UIEditor[EDITOR_NAME].percentWidth = 100;
                this.m_UIEditor[EDITOR_NAME].addEventListener(FILTER_CHANGE, this.onFilterChange);
                this.m_UIEditor[EDITOR_NAME].setStyle("borderColor", "");
                this.m_UIEditor[EDITOR_NAME].setStyle("borderStyle", "none");
                this.m_UIEditor[EDITOR_NAME].setStyle("borderThickness", 0);
                this.m_UIEditor[EDITOR_NAME].setStyle("horizontalAlign", "center");
                this.m_UIEditor[EDITOR_NAME].setStyle("horizontalGap", 2);
                this.m_UIEditor[EDITOR_NAME].setStyle("verticalAlign", "middle");
                this.m_UIEditor[EDITOR_NAME].setStyle("verticalGap", 2);
                this.m_UIEditorStack.addChild(this.m_UIEditor[1] as DisplayObject);
                this.m_UIDepot = new CustomButton();
                this.m_UIDepot.label = resourceManager.getString(BUNDLE, "RESTRICT_DEPOT_LABEL");
                this.m_UIDepot.percentWidth = 100;
                this.m_UIDepot.toggle = true;
                this.m_UIDepot.toolTip = resourceManager.getString(BUNDLE, "RESTRICT_DEPOT_TOOLTIP");
                this.m_UIDepot.addEventListener(Event.CHANGE, function (event:Event) : void
            {
                filterDepot = m_UIDepot.selected;
                return;
            }// end function
            );
                this.m_UIDepot.setStyle("fontSize", 9);
                this.m_UIDepot.setStyle("paddingLeft", 0);
                this.m_UIDepot.setStyle("paddingRight", 0);
                _FilterContainer.addChild(this.m_UIDepot);
                _TabContainer.addChild(_FilterContainer);
                _ViewContainer = new VBox();
                _ViewContainer.percentHeight = 100;
                _ViewContainer.percentWidth = 100;
                _ViewContainer.styleName = "marketWidgetView";
                this.m_UIView = this.createFilterView(this.viewLayout);
                this.m_UIView.dataProvider = this.m_AppearanceTypesView;
                this.m_UIView.selectedItem = this.selectedType;
                this.m_UIView.verticalScrollPosition = 0;
                this.m_UIView.addEventListener(ListEvent.CHANGE, this.onSelectedTypeChange);
                this.m_UIView.addEventListener(MouseEvent.CLICK, this.onViewMouseEvent);
                this.m_UIView.addEventListener(MouseEvent.RIGHT_CLICK, this.onViewMouseEvent);
                _ViewContainer.addChild(this.m_UIView);
                _TabContainer.addChild(_ViewContainer);
                _BarContainer = new HBox();
                _BarContainer.percentWidth = 100;
                _BarContainer.setStyle("horizontalGap", 0);
                this.m_UIEditorToggle = new SimpleTabBar();
                this.m_UIEditorToggle.dataProvider = this.m_UIEditorStack;
                this.m_UIEditorToggle.styleName = "marketWidgetTabNavigator";
                this.m_UIEditorToggle.setStyle("paddingBottom", -1);
                this.m_UIEditorToggle.setStyle("paddingLeft", 0);
                this.m_UIEditorToggle.setStyle("paddingRight", 0);
                this.m_UIEditorToggle.setStyle("paddingTop", 0);
                this.m_UIEditorToggle.setStyle("tabWidth", 55);
                _BarContainer.addChild(this.m_UIEditorToggle);
                _Spacer = new Spacer();
                _Spacer.percentWidth = 100;
                _BarContainer.addChild(_Spacer);
                this.m_UIViewToggle = new CustomButton();
                this.m_UIViewToggle.selected = this.viewLayout == LAYOUT_TILE;
                this.m_UIViewToggle.styleName = "marketWidgetViewToggle";
                this.m_UIViewToggle.toggle = true;
                this.m_UIViewToggle.addEventListener(Event.CHANGE, function (event:Event) : void
            {
                if (viewLayout == LAYOUT_TILE)
                {
                    viewLayout = LAYOUT_LIST;
                }
                else
                {
                    viewLayout = LAYOUT_TILE;
                }
                return;
            }// end function
            );
                _BarContainer.addChild(this.m_UIViewToggle);
                addChild(_BarContainer);
                addChild(_TabContainer);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        private function set filterDepot(param1:Boolean) : void
        {
            if (this.m_Depot != param1)
            {
                this.m_Depot = param1;
                this.m_UncommittedDepot = true;
                this.invalidateFilterFunction();
                invalidateProperties();
            }
            return;
        }// end function

        private function onFilterChange(event:Event) : void
        {
            this.invalidateFilterFunction();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_3:* = null;
            super.commitProperties();
            var _loc_1:* = Tibia.s_GetOptions();
            if (this.m_UncommittedAppearanceTypes)
            {
                this.m_AppearanceTypesView.filterFunction = this.filterFunction;
                this.m_AppearanceTypesView.source = this.appearanceTypes;
                this.m_AppearanceTypesView.refresh();
                this.m_UncommittedAppearanceTypes = false;
            }
            var _loc_2:* = false;
            if (this.m_UncommittedSelectedType == 2)
            {
                for each (_loc_3 in this.m_UIEditor)
                {
                    
                    _loc_3.adjustFilterFunction(this._selectedType);
                }
                this.adjustFilterFunction(this._selectedType);
                this.m_UncommittedSelectedType = 1;
            }
            if (this.m_UncommittedFilterFunction)
            {
                this.m_AppearanceTypesView.filterFunction = this.filterFunction;
                this.m_AppearanceTypesView.refresh();
                if (this.filterFunction != null && !this.filterFunction(this._selectedType))
                {
                    this._selectedType = null;
                }
                _loc_2 = true;
                this.m_UncommittedFilterFunction = false;
            }
            if (this.m_UncommittedSelectedType == 1)
            {
                this.m_UIView.selectedItem = this._selectedType;
                _loc_2 = true;
                this.m_UncommittedSelectedType = 0;
            }
            if (this.m_UncommittedLayout)
            {
                if (_loc_1 != null)
                {
                    _loc_1.marketBrowserLayout = this.viewLayout;
                }
                this.m_UIView.removeEventListener(ListEvent.CHANGE, this.onSelectedTypeChange);
                this.m_UIView.removeEventListener(MouseEvent.CLICK, this.onViewMouseEvent);
                this.m_UIView.removeEventListener(MouseEvent.RIGHT_CLICK, this.onViewMouseEvent);
                this.m_UIView = this.replaceChild(this.m_UIView, this.createFilterView(this.viewLayout)) as ListBase;
                this.m_UIView.dataProvider = this.m_AppearanceTypesView;
                this.m_UIView.selectedItem = this.selectedType;
                this.m_UIView.verticalScrollPosition = 0;
                this.m_UIView.addEventListener(ListEvent.CHANGE, this.onSelectedTypeChange);
                this.m_UIView.addEventListener(MouseEvent.CLICK, this.onViewMouseEvent);
                this.m_UIView.addEventListener(MouseEvent.RIGHT_CLICK, this.onViewMouseEvent);
                this.m_UIViewToggle.selected = this.viewLayout == LAYOUT_TILE;
                this.m_UncommittedLayout = false;
            }
            if (this.m_UncommittedDepot)
            {
                if (_loc_1 != null)
                {
                    _loc_1.marketBrowserDepot = this.filterDepot;
                }
                this.m_UIDepot.selected = this.filterDepot;
                this.m_UncommittedDepot = false;
            }
            if (this.m_UncommittedEditor)
            {
                if (_loc_1 != null)
                {
                    _loc_1.marketBrowserEditor = this.filterEditor;
                }
                this.m_UIEditorStack.selectedIndex = this.filterEditor;
                this.m_UncommittedEditor = false;
            }
            if (_loc_2)
            {
                if (this.m_UIView.selectedIndex > -1)
                {
                    this.m_UIView.validateNow();
                }
                if (this.m_UIView.selectedIndex > -1)
                {
                    this.m_UIView.scrollToIndex(this.m_UIView.selectedIndex);
                }
                else
                {
                    this.m_UIView.verticalScrollPosition = 0;
                }
                _loc_2 = false;
            }
            return;
        }// end function

        private function onSelectedTypeChange(event:ListEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.currentTarget as ListBase;
            _loc_2 = event.currentTarget as ListBase;
            if (event != null && _loc_3 != null)
            {
                this._selectedType = _loc_2.selectedItem as AppearanceType;
            }
            return;
        }// end function

        private function replaceChild(param1:DisplayObject, param2:DisplayObject) : DisplayObject
        {
            var _loc_3:* = null;
            _loc_3 = param1.parent;
            var _loc_4:* = _loc_3.getChildIndex(param1);
            _loc_3.removeChildAt(_loc_4);
            return _loc_3.addChildAt(param2, _loc_4);
        }// end function

        private function createFilterView(param1:int) : ListBase
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            switch(param1)
            {
                case LAYOUT_LIST:
                {
                    _loc_2 = new CustomList();
                    _loc_2.itemRenderer = new ClassFactory(AppearanceTypeListRenderer);
                    _loc_2.setStyle("backgroundAlpha", 0.5);
                    _loc_2.setStyle("backgroundColor", undefined);
                    _loc_2.setStyle("alternatingItemAlphas", [0.5, 0.5]);
                    _loc_2.setStyle("alternatingItemColors", [2768716, 1977654]);
                    _loc_2.setStyle("rollOverColor", undefined);
                    _loc_2.setStyle("selectionColor", undefined);
                    _loc_2.setStyle("paddingBottom", 1);
                    _loc_2.setStyle("paddingTop", 1);
                    break;
                }
                case LAYOUT_TILE:
                {
                    _loc_3 = new ClassFactory();
                    _loc_3.generator = AppearanceTypeTileRenderer;
                    _loc_3.properties = {height:36, width:36, horizontalScrollPolicy:ScrollPolicy.OFF, verticalScrollPolicy:ScrollPolicy.OFF, styleName:{paddingLeft:1, paddingRight:1, paddingTop:1, paddingBottom:1}};
                    _loc_2 = new CustomTileList();
                    _loc_2.columnCount = 4;
                    _loc_2.columnWidth = _loc_3.properties.width;
                    _loc_2.itemRenderer = _loc_3;
                    _loc_2.rowHeight = _loc_3.properties.height;
                    _loc_2.setStyle("backgroundColor", 0);
                    _loc_2.setStyle("backgroundAlpha", 0);
                    _loc_2.setStyle("borderAlpha", 0);
                    _loc_2.setStyle("borderColor", 0);
                    _loc_2.setStyle("borderStyle", "none");
                    _loc_2.setStyle("borderThickness", 0);
                    _loc_2.setStyle("paddingBottom", 0);
                    _loc_2.setStyle("paddingTop", 0);
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2.percentHeight = 100;
            _loc_2.percentWidth = 100;
            _loc_2.verticalScrollPolicy = ScrollPolicy.ON;
            return _loc_2;
        }// end function

        private function get _selectedType() : AppearanceType
        {
            return this.m_SelectedType;
        }// end function

        public function adjustFilterFunction(param1:AppearanceType) : void
        {
            if (param1 == null || !param1.isMarket)
            {
                return;
            }
            var _loc_2:* = PopUpBase.getCurrent() as MarketWidget;
            this.filterDepot = this.filterDepot && (_loc_2 != null && _loc_2.getDepotAmount(param1) > 0);
            return;
        }// end function

        public function set viewLayout(param1:int) : void
        {
            if (param1 != LAYOUT_LIST && param1 != LAYOUT_TILE)
            {
                param1 = LAYOUT_TILE;
            }
            if (this.m_Layout != param1)
            {
                this.m_Layout = param1;
                this.m_UncommittedLayout = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set selectedType(param1) : void
        {
            param1 = this.mapToAppearanceTypes(param1);
            if (this._selectedType != param1)
            {
                this._selectedType = param1;
                this.m_UncommittedSelectedType = 2;
                invalidateProperties();
            }
            return;
        }// end function

        public function get appearanceTypes() : Array
        {
            return this.m_AppearanceTypes;
        }// end function

        public function get filterFunction() : Function
        {
            var Market:MarketWidget;
            var Filter:Function;
            if (this.m_FilterFunction == null && this.m_CreationComplete)
            {
                Market;
                if (this.filterDepot)
                {
                    Market = PopUpBase.getCurrent() as MarketWidget;
                }
                Filter;
                if (this.filterEditor > -1)
                {
                    Filter = this.m_UIEditor[this.filterEditor].filterFunction;
                }
                this.m_FilterFunction = closure({market:Market, filter:Filter}, function (param1:AppearanceType) : Boolean
            {
                var _loc_2:* = this;
                return param1 != null && param1.isMarket && (this["market"] == null || this["market"].getDepotAmount(param1)) && (this["filter"] == null || _loc_2["filter"](param1));
            }// end function
            );
            }
            return this.m_FilterFunction;
        }// end function

        public function set appearanceTypes(param1:Array) : void
        {
            if (this.m_AppearanceTypes != param1)
            {
                this.m_AppearanceTypes = param1;
                this.m_UncommittedAppearanceTypes = true;
                invalidateProperties();
                this._selectedType = null;
            }
            return;
        }// end function

        public function get selectedType() : AppearanceType
        {
            return this._selectedType;
        }// end function

        private function mapToAppearanceTypes(param1) : AppearanceType
        {
            var _loc_3:* = null;
            var _loc_2:* = -1;
            if (param1 is AppearanceType && AppearanceType(param1).isMarket)
            {
                _loc_2 = AppearanceType(param1).marketTradeAs;
            }
            else
            {
                _loc_2 = int(param1);
            }
            for each (_loc_3 in this.appearanceTypes)
            {
                
                if (_loc_3.marketTradeAs == _loc_2)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

    }
}
