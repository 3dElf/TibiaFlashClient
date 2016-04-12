package tibia.market.marketWidgetClasses
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.market.*;
    import tibia.market.marketWidgetClasses.*;

    public class MarketTab extends MarketComponent implements IViewContainer
    {
        private var m_UIBrowser:AppearanceTypeBrowser = null;
        private var m_UncommittedSelectedView:Boolean = true;
        private var m_SelectedView:uint = 0;
        private var m_UIViewDetails:MarketDetailsView = null;
        private var m_UIName:Label = null;
        private var m_UIViewStack:ViewStack = null;
        private var m_UIViewToggle:TabBar = null;
        private var m_UncommittedSelectedType:Boolean = false;
        private var m_UIViewStatistics:MarketStatisticsView = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UIViewOffers:MarketOffersView = null;
        private var m_UIEditor:MarketOfferEditor = null;
        private var m_UIIcon:SkinnedAppearanceRenderer = null;
        private static const BUNDLE:String = "MarketWidget";

        public function MarketTab(param1:MarketWidget)
        {
            super(param1);
            direction = BoxDirection.HORIZONTAL;
            label = resourceManager.getString(BUNDLE, "MARKET_OFFERS_LABEL");
            return;
        }// end function

        public function set selectedView(param1:uint) : void
        {
            if (this.m_SelectedView != param1 && (param1 == MarketWidget.VIEW_MARKET_OFFERS || param1 == MarketWidget.VIEW_MARKET_DETAILS || param1 == MarketWidget.VIEW_MARKET_STATISTICS))
            {
                this.m_SelectedView = param1;
                this.m_UncommittedSelectedView = true;
                invalidateProperties();
                dispatchEvent(new Event(MarketWidget.SELECTED_VIEW_CHANGE, true, false));
            }
            return;
        }// end function

        private function onTypeChange(event:Event) : void
        {
            if (event != null)
            {
                this.selectedType = this.m_UIBrowser.selectedType;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedSelectedView)
            {
                switch(this.m_SelectedView)
                {
                    case MarketWidget.VIEW_MARKET_OFFERS:
                    {
                        this.m_UIViewStack.selectedChild = this.m_UIViewOffers;
                        break;
                    }
                    case MarketWidget.VIEW_MARKET_DETAILS:
                    {
                        this.m_UIViewStack.selectedChild = this.m_UIViewDetails;
                        break;
                    }
                    case MarketWidget.VIEW_MARKET_STATISTICS:
                    {
                        this.m_UIViewStack.selectedChild = this.m_UIViewStatistics;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.m_UncommittedSelectedView = false;
            }
            if (this.m_UncommittedSelectedType)
            {
                if (selectedType != null)
                {
                    _loc_1 = Tibia.s_GetAppearanceStorage();
                    this.m_UIIcon.appearance = _loc_1 != null ? (_loc_1.getObjectType(selectedType.marketShowAs)) : (null);
                    this.m_UIName.text = selectedType.marketName;
                }
                else
                {
                    this.m_UIIcon.appearance = null;
                    this.m_UIName.text = resourceManager.getString(BUNDLE, "MARKET_OFFERS_NO_TYPE");
                }
                this.m_UIBrowser.selectedType = selectedType;
                this.m_UIViewOffers.selectedType = selectedType;
                this.m_UIViewDetails.selectedType = selectedType;
                this.m_UIViewStatistics.selectedType = selectedType;
                this.m_UIEditor.selectedType = selectedType;
                this.m_UncommittedSelectedType = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIBrowser = new AppearanceTypeBrowser();
                this.m_UIBrowser.percentHeight = 100;
                this.m_UIBrowser.width = 177;
                this.m_UIBrowser.addEventListener(Event.CHANGE, this.onTypeChange);
                addChild(this.m_UIBrowser);
                _loc_1 = new VBox();
                _loc_1.percentHeight = 100;
                _loc_1.percentWidth = 100;
                _loc_1.setStyle("horizontalGap", 0);
                _loc_1.setStyle("verticalGap", 0);
                _loc_1.setStyle("paddingBottom", 0);
                _loc_1.setStyle("paddingLeft", 0);
                _loc_1.setStyle("paddingRight", 0);
                _loc_1.setStyle("paddingTop", 0);
                _loc_2 = new VBox();
                _loc_2.percentHeight = 100;
                _loc_2.percentWidth = 100;
                _loc_2.styleName = "marketWidgetRootContainer";
                _loc_3 = new HBox();
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 100;
                _loc_3.setStyle("horizontalAlign", "left");
                _loc_3.setStyle("vertcialAlign", "middle");
                _loc_3.setStyle("fontSize", 12);
                _loc_3.setStyle("fontWeight", "bold");
                this.m_UIIcon = new SkinnedAppearanceRenderer();
                _loc_3.addChild(this.m_UIIcon);
                this.m_UIName = new CustomLabel();
                this.m_UIName.percentHeight = NaN;
                this.m_UIName.percentWidth = 100;
                this.m_UIName.text = resourceManager.getString(BUNDLE, "MARKET_OFFERS_NO_TYPE");
                this.m_UIName.truncateToFit = true;
                _loc_3.addChild(this.m_UIName);
                _loc_2.addChild(_loc_3);
                this.m_UIViewStack = new ViewStack();
                this.m_UIViewStack.percentHeight = 100;
                this.m_UIViewStack.percentWidth = 100;
                this.m_UIViewStack.addEventListener(IndexChangedEvent.CHANGE, this.onViewChange);
                _loc_2.addChild(this.m_UIViewStack);
                this.m_UIViewOffers = new MarketOffersView(market);
                this.m_UIViewOffers.percentHeight = 100;
                this.m_UIViewOffers.percentWidth = 100;
                this.m_UIViewOffers.styleName = "marketWidgetView";
                this.m_UIViewStack.addChild(this.m_UIViewOffers);
                this.m_UIViewDetails = new MarketDetailsView(market);
                this.m_UIViewDetails.percentHeight = 100;
                this.m_UIViewDetails.percentWidth = 100;
                this.m_UIViewDetails.styleName = "marketWidgetView";
                this.m_UIViewStack.addChild(this.m_UIViewDetails);
                this.m_UIViewStatistics = new MarketStatisticsView(market);
                this.m_UIViewStatistics.percentHeight = 100;
                this.m_UIViewStatistics.percentWidth = 100;
                this.m_UIViewStatistics.styleName = "marketWidgetView";
                this.m_UIViewStack.addChild(this.m_UIViewStatistics);
                this.m_UIEditor = new MarketOfferEditor(market);
                this.m_UIEditor.percentHeight = NaN;
                this.m_UIEditor.percentWidth = 100;
                this.m_UIEditor.styleName = "marketWidgetView";
                _loc_2.addChild(this.m_UIEditor);
                _loc_4 = new VBox();
                _loc_4.percentHeight = NaN;
                _loc_4.percentWidth = 100;
                _loc_4.setStyle("horizontalAlign", "right");
                this.m_UIViewToggle = new SimpleTabBar();
                this.m_UIViewToggle.dataProvider = this.m_UIViewStack;
                this.m_UIViewToggle.percentHeight = NaN;
                this.m_UIViewToggle.percentWidth = NaN;
                this.m_UIViewToggle.styleName = "marketWidgetTabNavigator";
                this.m_UIViewToggle.setStyle("paddingBottom", -1);
                this.m_UIViewToggle.setStyle("paddingLeft", 0);
                this.m_UIViewToggle.setStyle("paddingRight", 0);
                this.m_UIViewToggle.setStyle("paddingTop", 0);
                this.m_UIViewToggle.setStyle("tabWidth", 65);
                _loc_4.addChild(this.m_UIViewToggle);
                _loc_1.addChild(_loc_4);
                _loc_1.addChild(_loc_2);
                addChild(_loc_1);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function get selectedView() : uint
        {
            return this.m_SelectedView;
        }// end function

        override public function set selectedType(param1) : void
        {
            if (selectedType != param1)
            {
                super.selectedType = param1;
                this.m_UncommittedSelectedType = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function onViewChange(event:Event) : void
        {
            if (event != null)
            {
                switch(this.m_UIViewStack.selectedChild)
                {
                    case this.m_UIViewOffers:
                    {
                        this.selectedView = MarketWidget.VIEW_MARKET_OFFERS;
                        break;
                    }
                    case this.m_UIViewDetails:
                    {
                        this.selectedView = MarketWidget.VIEW_MARKET_DETAILS;
                        break;
                    }
                    case this.m_UIViewStatistics:
                    {
                        this.selectedView = MarketWidget.VIEW_MARKET_STATISTICS;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

    }
}
