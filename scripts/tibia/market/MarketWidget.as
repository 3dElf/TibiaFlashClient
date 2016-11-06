package tibia.market
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.containers.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.appearances.*;
    import tibia.container.*;
    import tibia.game.*;
    import tibia.ingameshop.*;
    import tibia.market.marketWidgetClasses.*;
    import tibia.network.*;
    import tibia.options.*;

    public class MarketWidget extends PopUpBase implements ITypeComponent, IViewContainer
    {
        private var m_BrowseStatistics:Array = null;
        private var m_UITabNavigator:TabNavigator = null;
        private var m_UncommittedSelectedView:Boolean = true;
        private var m_SelectedView:uint = 0;
        private var m_AccountBalance:Number = 0;
        private var m_ResponsePending:Boolean = false;
        private var m_UncommittedSelectedType:Boolean = true;
        private var m_SelectedType:AppearanceType = null;
        private var m_BrowseDetail:Array = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UITabMarket:MarketTab = null;
        private var m_LastDepotTypeID:int = 0;
        private var m_LastDepotAmount:int = 0;
        private var m_DepotContent:Array = null;
        private var m_PendingTypeID:int = -1;
        private var m_PendingDelay:Timer = null;
        private var m_ActiveOffers:int = 0;
        private var m_BrowsePriceAverage:uint = 0;
        private var m_BrowseOffers:Array = null;
        private var m_UITabOwn:OwnTab = null;
        public static const REQUEST_VALIDITY:int = 10000;
        public static const ACCOUNT_BALANCE_CHANGE:String = "accountBalanceChange";
        public static const DETAIL_FIELD_RESTRICT_MAGICLEVEL:int = 8;
        public static const CATEGORY_AMMUNITION:int = 16;
        public static const DETAIL_FIELD_RESTRICT_PROFESSION:int = 9;
        public static const VIEW_OWN_HISTORY:uint = 4;
        public static const CATEGORY_META_WEAPONS:int = 255;
        public static const CATEGORY_BOOTS:int = 3;
        public static const DETAIL_FIELD_WEAPON_TYPE:int = 13;
        public static const DETAIL_NAME_LENGTH:int = 30;
        public static const DETAIL_FIELD_CAPACITY:int = 2;
        public static const CATEGORY_TOOLS:int = 14;
        public static const OFFER_MAX_AMOUNT_CUMULATIVE:int = 64000;
        public static const CATEGORY_VALUABLES:int = 15;
        public static const DETAIL_FIELD_IMBUEMENT_SLOTS:int = 15;
        public static const DETAIL_FIELD_EXPIRE:int = 5;
        public static const OFFER_MAX_ACTIVE:int = 100;
        public static const DETAIL_FIELD_RESTRICT_LEVEL:int = 7;
        public static const DETAIL_FIELD_DEFENCE:int = 3;
        public static const REQUEST_OWN_OFFERS:int = 65534;
        public static const BROWSE_OFFERS_CHANGE:String = "browseOffersChange";
        public static const VIEW_OWN_OFFERS:uint = 3;
        private static var s_BrowseTypeID:int = 0;
        public static const CATEGORY_ARMORS:int = 1;
        public static const DETAIL_FIELD_RUNE_SPELL:int = 10;
        public static const CATEGORY_SWORDS:int = 20;
        public static const DETAIL_FIELD_ATTACK:int = 1;
        private static const BUNDLE:String = "MarketWidget";
        public static const OFFER_MAX_AMOUNT_NONCUMULATIVE:int = 2000;
        public static const DETAIL_FIELD_DESCRIPTION:int = 4;
        private static var s_BrowseTimeout:Number = 0;
        public static const DETAIL_FIELD_ARMOR:int = 0;
        public static const CATEGORY_DISTANCE_WEAPONS:int = 19;
        public static const CATEGORY_DECORATION:int = 5;
        public static const REQUEST_DELAY:int = 300;
        public static const DETAIL_FIELD_PROTECTION:int = 6;
        public static const CATEGORY_AMULETS:int = 2;
        public static const CATEGORY_RINGS:int = 11;
        public static const DETAIL_FIELD_SKILLBOOST:int = 11;
        public static const CATEGORY_TIBIA_COINS:int = 23;
        public static const DETAIL_FIELD_WEIGHT:int = 14;
        public static const SELECTED_TYPE_CHANGE:String = "selectedTypeChange";
        public static const DETAIL_FIELD_USES:int = 12;
        public static const BROWSE_DETAILS_CHANGE:String = "browseDetailsChange";
        public static const OFFER_MAX_TOTALPRICE:Number = 999999999;
        public static const CATEGORY_OTHERS:int = 9;
        public static const REQUEST_OWN_HISTORY:int = 65535;
        public static const CATEGORY_LEGS:int = 8;
        public static const CATEGORY_SHIELDS:int = 13;
        public static const CATEGORY_AXES:int = 17;
        public static const CATEGORY_RUNES:int = 12;
        public static const CATEGORY_WANDS_RODS:int = 21;
        public static const CATEGORY_CLUBS:int = 18;
        public static const CATEGORY_PREMIUM_SCROLLS:int = 22;
        public static const ACTIVE_OFFERS_CHANGE:String = "activeOffersChange";
        public static const VIEW_MARKET_OFFERS:uint = 0;
        public static const DEPOT_CONTENT_CHANGE:String = "depotContentChange";
        public static const SELECTED_VIEW_CHANGE:String = "selectedViewChange";
        public static const CATEGORY_HELMETS_HATS:int = 7;
        public static const CATEGORY_CONTAINERS:int = 4;
        public static const CATEGORY_POTIONS:int = 10;
        public static const VIEW_MARKET_DETAILS:uint = 1;
        public static const VIEW_MARKET_STATISTICS:uint = 2;
        public static const CATEGORY_FOOD:int = 6;

        public function MarketWidget()
        {
            height = 512;
            width = 700;
            title = resourceManager.getString(BUNDLE, "TITLE");
            buttonFlags = PopUpBase.BUTTON_CANCEL;
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            this.m_PendingDelay = new Timer(REQUEST_DELAY, 1);
            this.m_PendingDelay.addEventListener(TimerEvent.TIMER_COMPLETE, this.onBrowseMarket);
            var _loc_1:* = Tibia.s_GetOptions();
            if (_loc_1 != null)
            {
                this.selectedView = _loc_1.marketSelectedView;
                this.selectedType = _loc_1.marketSelectedType;
            }
            addEventListener(SELECTED_TYPE_CHANGE, this.onTypeChange);
            addEventListener(SELECTED_VIEW_CHANGE, this.onViewChange);
            IngameShopManager.getInstance().addEventListener(IngameShopEvent.CREDIT_BALANCE_CHANGED, this.onCoinBalanceChange);
            return;
        }// end function

        private function onCoinBalanceChange(event:IngameShopEvent) : void
        {
            dispatchEvent(new Event(DEPOT_CONTENT_CHANGE));
            return;
        }// end function

        public function cancelOffer(param1:Offer) : void
        {
            if (this.serverResponsePending || param1 == null)
            {
                return;
            }
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning)
            {
                _loc_2.sendCMARKETCANCEL(param1);
            }
            this.serverResponsePending = true;
            s_BrowseTypeID = REQUEST_OWN_OFFERS;
            s_BrowseTimeout = Number.NEGATIVE_INFINITY;
            return;
        }// end function

        private function browseMarket(param1) : void
        {
            var _loc_4:* = false;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1 is AppearanceType && AppearanceType(param1).isMarket)
            {
                _loc_2 = AppearanceType(param1).marketTradeAs;
            }
            else
            {
                var _loc_5:* = Tibia.s_GetAppearanceStorage();
                _loc_3 = Tibia.s_GetAppearanceStorage();
                if (param1 is int && _loc_5 != null && _loc_3.getMarketObjectType(int(param1)) != null)
                {
                    _loc_2 = int(param1);
                }
            }
            if (this.m_PendingTypeID != _loc_2)
            {
                _loc_4 = this.m_PendingTypeID == -1;
                this.m_PendingTypeID = _loc_2;
                if (_loc_4)
                {
                    dispatchEvent(new Event(BROWSE_DETAILS_CHANGE));
                    dispatchEvent(new Event(BROWSE_OFFERS_CHANGE));
                }
                this.m_PendingDelay.reset();
                this.m_PendingDelay.start();
            }
            return;
        }// end function

        public function mergeBrowseOffers(param1:int, param2:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (param1 == s_BrowseTypeID)
            {
                if (this.m_BrowseOffers == null)
                {
                    this.m_BrowseOffers = [];
                }
                _loc_3 = null;
                if (this.m_BrowseOffers.length > 0)
                {
                    _loc_3 = this.m_BrowseOffers[(this.m_BrowseOffers.length - 1)];
                }
                _loc_4 = param2 != null ? (param2.length) : (0);
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_6 = Offer(param2[_loc_5]);
                    if (this.m_BrowsePriceAverage > 0)
                    {
                        if (_loc_6.kind == Offer.BUY_OFFER)
                        {
                            _loc_6.isDubious = _loc_6.piecePrice <= this.m_BrowsePriceAverage - Math.floor(this.m_BrowsePriceAverage / 4);
                        }
                        else
                        {
                            _loc_6.isDubious = _loc_6.piecePrice >= this.m_BrowsePriceAverage + Math.floor(this.m_BrowsePriceAverage / 4);
                        }
                    }
                    else
                    {
                        _loc_6.isDubious = false;
                    }
                    if (_loc_3 == null || _loc_3.isLessThan(_loc_6))
                    {
                        this.m_BrowseOffers.push(_loc_6);
                        _loc_3 = _loc_6;
                    }
                    else
                    {
                        _loc_7 = 0;
                        _loc_8 = this.m_BrowseOffers.length;
                        while (_loc_7 < _loc_8 && Offer(this.m_BrowseOffers[_loc_7]).isLessThan(_loc_6))
                        {
                            
                            _loc_7++;
                        }
                        if (_loc_7 < _loc_8 && Offer(this.m_BrowseOffers[_loc_7]).isEqual(_loc_6))
                        {
                            if (_loc_6.amount == 0)
                            {
                                this.m_BrowseOffers.splice(_loc_7, 1);
                                _loc_8 = _loc_8 - 1;
                            }
                            else
                            {
                                this.m_BrowseOffers[_loc_7] = _loc_6;
                            }
                        }
                        else
                        {
                            this.m_BrowseOffers.splice(_loc_7, 0, _loc_6);
                        }
                        if (_loc_8 > 0)
                        {
                            _loc_3 = this.m_BrowseOffers[(_loc_8 - 1)];
                        }
                        else
                        {
                            _loc_3 = null;
                        }
                    }
                    _loc_5++;
                }
                dispatchEvent(new Event(BROWSE_OFFERS_CHANGE));
            }
            return;
        }// end function

        public function mayCreateOffer(param1:int, param2, param3:int, param4:uint) : Boolean
        {
            var _loc_5:* = null;
            _loc_5 = Tibia.s_GetAppearanceStorage();
            var _loc_6:* = _loc_5 != null ? (_loc_5.getMarketObjectType(param2)) : (null);
            var _loc_7:* = (_loc_6).isCumulative ? (OFFER_MAX_AMOUNT_CUMULATIVE) : (OFFER_MAX_AMOUNT_NONCUMULATIVE);
            return !this.serverResponsePending && (param1 == Offer.BUY_OFFER || param1 == Offer.SELL_OFFER) && _loc_6 != null && param3 > 0 && param3 <= _loc_7 && param4 > 0 && param3 * param4 <= OFFER_MAX_TOTALPRICE && this.activeOffers < OFFER_MAX_ACTIVE && this.getOfferTotalPrice(param1, param3, param4) <= this.accountBalance && (param1 != Offer.SELL_OFFER || this.getDepotAmount(_loc_6) >= param3);
        }// end function

        public function get depotContent() : Array
        {
            return this.m_DepotContent;
        }// end function

        public function getOfferCreationFee(param1:int, param2:int, param3:uint) : Number
        {
            return Math.max(20, Math.min(Math.ceil(param2 * param3 / 100), 1000));
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UITabNavigator = new SimpleTabNavigator();
                this.m_UITabNavigator.percentHeight = 100;
                this.m_UITabNavigator.percentWidth = 100;
                this.m_UITabNavigator.styleName = "marketWidgetTabNavigator";
                this.m_UITabNavigator.addEventListener(IndexChangedEvent.CHANGE, this.onViewChange);
                this.m_UITabNavigator.setStyle("tabWidth", 95);
                addChild(this.m_UITabNavigator);
                this.m_UITabMarket = new MarketTab(this);
                this.m_UITabMarket.percentHeight = 100;
                this.m_UITabMarket.percentWidth = 100;
                this.m_UITabMarket.styleName = "marketWidgetTabContainer";
                this.m_UITabNavigator.addChild(this.m_UITabMarket);
                this.m_UITabOwn = new OwnTab(this);
                this.m_UITabOwn.percentHeight = 100;
                this.m_UITabOwn.percentWidth = 100;
                this.m_UITabOwn.styleName = "marketWidgetTabContainer";
                this.m_UITabNavigator.addChild(this.m_UITabOwn);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set serverResponsePending(param1:Boolean) : void
        {
            this.m_ResponsePending = param1;
            return;
        }// end function

        public function getOfferTotalPrice(param1:int, param2:int, param3:uint) : Number
        {
            var _loc_4:* = this.getOfferCreationFee(param1, param2, param3);
            if (param1 == Offer.BUY_OFFER)
            {
                _loc_4 = _loc_4 + param2 * param3;
            }
            return _loc_4;
        }// end function

        public function acceptOffer(param1:Offer, param2:int) : void
        {
            if (this.serverResponsePending || param1 == null || param2 < 1 || param2 > Math.min(param1.amount, Math.max(OFFER_MAX_AMOUNT_NONCUMULATIVE, OFFER_MAX_AMOUNT_CUMULATIVE)))
            {
                return;
            }
            var _loc_3:* = Tibia.s_GetCommunication();
            if (_loc_3 != null && _loc_3.isGameRunning)
            {
                _loc_3.sendCMARKETACCEPT(param1, param2);
            }
            this.serverResponsePending = true;
            s_BrowseTypeID = param1.typeID;
            s_BrowseTimeout = Number.NEGATIVE_INFINITY;
            return;
        }// end function

        public function get activeOffers() : uint
        {
            return this.m_ActiveOffers;
        }// end function

        public function set selectedView(param1:uint) : void
        {
            if (this.m_SelectedView != param1 && (param1 == VIEW_MARKET_OFFERS || param1 == VIEW_MARKET_DETAILS || param1 == VIEW_MARKET_STATISTICS || param1 == VIEW_OWN_OFFERS || param1 == VIEW_OWN_HISTORY))
            {
                this.m_SelectedView = param1;
                this.m_UncommittedSelectedView = true;
                invalidateProperties();
                invalidateFocus();
                if (this.m_SelectedView == VIEW_OWN_OFFERS || this.m_SelectedView == VIEW_OWN_HISTORY)
                {
                    this.selectedType = null;
                }
                dispatchEvent(new Event(SELECTED_VIEW_CHANGE, true, false));
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            if (!param1)
            {
                _loc_2 = Tibia.s_GetCommunication();
                if (_loc_2 != null && _loc_2.isGameRunning)
                {
                    _loc_2.sendCMARKETLEAVE();
                }
            }
            this.m_PendingDelay.reset();
            super.hide(param1);
            return;
        }// end function

        public function set depotContent(param1:Array) : void
        {
            if (this.m_DepotContent != param1)
            {
                this.m_DepotContent = param1;
                this.m_LastDepotTypeID = 0;
                this.m_LastDepotAmount = 0;
                dispatchEvent(new Event(DEPOT_CONTENT_CHANGE));
            }
            return;
        }// end function

        public function get browseStatistics() : Array
        {
            return this.m_PendingTypeID == -1 ? (this.m_BrowseStatistics) : (null);
        }// end function

        public function createOffer(param1:int, param2:int, param3:int, param4:uint, param5:Boolean) : void
        {
            var _loc_6:* = null;
            if (this.mayCreateOffer(param1, param2, param3, param4))
            {
                _loc_6 = Tibia.s_GetCommunication();
                if (_loc_6 != null && _loc_6.isGameRunning)
                {
                    _loc_6.sendCMARKETCREATE(param1, param2, param3, param4, param5);
                }
                this.serverResponsePending = true;
                s_BrowseTypeID = param2;
                s_BrowseTimeout = 0;
                this.m_BrowseOffers = [];
                dispatchEvent(new Event(BROWSE_OFFERS_CHANGE));
            }
            return;
        }// end function

        public function get browseOffers() : Array
        {
            return this.m_PendingTypeID == -1 ? (this.m_BrowseOffers) : (null);
        }// end function

        public function showMessage(param1:String) : void
        {
            var _loc_2:* = null;
            if (param1 != null && param1.length > 0)
            {
                _loc_2 = new EmbeddedDialog();
                _loc_2.buttonFlags = EmbeddedDialog.CLOSE;
                _loc_2.text = param1;
                _loc_2.title = resourceManager.getString(BUNDLE, "MARKET_DIALOG_GENERIC_TITLE");
                enqueueEmbeddedDialog(_loc_2);
            }
            return;
        }// end function

        public function get serverResponsePending() : Boolean
        {
            return this.m_ResponsePending;
        }// end function

        private function onTypeChange(event:Event) : void
        {
            this.selectedType = ITypeComponent(event.target).selectedType;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = Tibia.s_GetOptions();
            if (this.m_UncommittedSelectedType)
            {
                if (_loc_1 != null)
                {
                    _loc_1.marketSelectedType = this.selectedType;
                }
                this.browseMarket(this.selectedType);
                this.m_UITabMarket.selectedType = this.selectedType;
                this.m_UITabOwn.selectedType = this.selectedType;
                this.m_UncommittedSelectedType = false;
            }
            if (this.m_UncommittedSelectedView)
            {
                if (_loc_1 != null)
                {
                    _loc_1.marketSelectedView = this.selectedView;
                }
                switch(this.selectedView)
                {
                    case VIEW_MARKET_OFFERS:
                    case VIEW_MARKET_DETAILS:
                    case VIEW_MARKET_STATISTICS:
                    {
                        this.m_UITabNavigator.selectedChild = this.m_UITabMarket;
                        break;
                    }
                    case VIEW_OWN_OFFERS:
                    {
                        this.browseMarket(REQUEST_OWN_OFFERS);
                        this.m_UITabNavigator.selectedChild = this.m_UITabOwn;
                        break;
                    }
                    case VIEW_OWN_HISTORY:
                    {
                        this.browseMarket(REQUEST_OWN_HISTORY);
                        this.m_UITabNavigator.selectedChild = this.m_UITabOwn;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.m_UITabMarket.selectedView = this.selectedView;
                this.m_UITabOwn.selectedView = this.selectedView;
                this.m_UncommittedSelectedView = false;
            }
            super.commitProperties();
            return;
        }// end function

        public function set accountBalance(param1:Number) : void
        {
            if (this.m_AccountBalance != param1)
            {
                this.m_AccountBalance = param1;
                dispatchEvent(new Event(ACCOUNT_BALANCE_CHANGE));
            }
            return;
        }// end function

        public function mergeBrowseDetail(param1:int, param2:Array, param3:Array) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            if (param1 == s_BrowseTypeID)
            {
                this.m_BrowseDetail = param2;
                this.m_BrowsePriceAverage = 0;
                this.m_BrowseStatistics = param3;
                if (this.m_BrowseStatistics != null)
                {
                    _loc_4 = 0;
                    _loc_5 = 0;
                    _loc_6 = 0;
                    for each (_loc_7 in this.m_BrowseStatistics)
                    {
                        
                        if (_loc_7.kind == Offer.SELL_OFFER && _loc_7.totalTransactions > 0)
                        {
                            _loc_4++;
                            _loc_5 = _loc_5 + _loc_7.totalTransactions;
                            _loc_6 = _loc_6 + _loc_7.totalPrice;
                        }
                    }
                    if (_loc_4 >= 5 && _loc_5 >= 10)
                    {
                        this.m_BrowsePriceAverage = Math.round(_loc_6 / _loc_5);
                    }
                }
                dispatchEvent(new Event(BROWSE_DETAILS_CHANGE));
            }
            return;
        }// end function

        override protected function get focusRoot() : DisplayObjectContainer
        {
            return this.m_UITabNavigator.selectedChild;
        }// end function

        public function set selectedType(param1) : void
        {
            var _loc_2:* = Tibia.s_GetAppearanceStorage();
            if (_loc_2 != null)
            {
                param1 = _loc_2.getMarketObjectType(param1);
            }
            else
            {
                param1 = null;
            }
            if (this.m_SelectedType != param1)
            {
                this.m_SelectedType = param1;
                this.m_UncommittedSelectedType = true;
                invalidateProperties();
                if (this.m_SelectedType != null && this.selectedView != VIEW_MARKET_OFFERS && this.selectedView != VIEW_MARKET_DETAILS && this.selectedView != VIEW_MARKET_STATISTICS)
                {
                    this.selectedView = VIEW_MARKET_OFFERS;
                }
                dispatchEvent(new Event(SELECTED_TYPE_CHANGE, true, false));
            }
            return;
        }// end function

        private function onBrowseMarket(event:TimerEvent) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                if (this.m_PendingTypeID == 0 || this.m_PendingTypeID != s_BrowseTypeID || Tibia.s_FrameTibiaTimestamp > s_BrowseTimeout)
                {
                    this.m_BrowseDetail = null;
                    this.m_BrowseOffers = null;
                    this.m_BrowsePriceAverage = 0;
                    this.m_BrowseStatistics = null;
                    s_BrowseTimeout = Tibia.s_FrameTibiaTimestamp + REQUEST_VALIDITY;
                    s_BrowseTypeID = this.m_PendingTypeID;
                    _loc_2 = null;
                    var _loc_3:* = Tibia.s_GetCommunication();
                    _loc_2 = Tibia.s_GetCommunication();
                    if (s_BrowseTypeID != 0 && _loc_3 != null && _loc_2.isGameRunning)
                    {
                        _loc_2.sendCMARKETBROWSE(s_BrowseTypeID);
                    }
                    this.m_PendingTypeID = -1;
                }
                else
                {
                    this.m_PendingTypeID = -1;
                    dispatchEvent(new Event(BROWSE_DETAILS_CHANGE));
                    dispatchEvent(new Event(BROWSE_OFFERS_CHANGE));
                }
            }
            return;
        }// end function

        private function onViewChange(event:Event) : void
        {
            if (event.currentTarget == this.m_UITabNavigator)
            {
                this.selectedView = IViewContainer(this.m_UITabNavigator.selectedChild).selectedView;
            }
            else
            {
                this.selectedView = IViewContainer(event.target).selectedView;
            }
            return;
        }// end function

        public function get selectedType() : AppearanceType
        {
            return this.m_SelectedType;
        }// end function

        public function get accountBalance() : Number
        {
            return this.m_AccountBalance;
        }// end function

        public function get selectedView() : uint
        {
            return this.m_SelectedView;
        }// end function

        public function set activeOffers(param1:uint) : void
        {
            if (this.m_ActiveOffers != param1)
            {
                this.m_ActiveOffers = param1;
                dispatchEvent(new Event(ACTIVE_OFFERS_CHANGE));
            }
            return;
        }// end function

        public function get browseDetail() : Array
        {
            return this.m_PendingTypeID == -1 ? (this.m_BrowseDetail) : (null);
        }// end function

        public function getDepotAmount(param1) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            if (param1 is AppearanceType && AppearanceType(param1).isMarket)
            {
                _loc_2 = AppearanceType(param1).marketTradeAs;
            }
            else if (param1 is int)
            {
                _loc_2 = int(param1);
            }
            else
            {
                return 0;
            }
            if (_loc_2 == IngameShopManager.TIBIA_COINS_APPEARANCE_TYPE_ID)
            {
                return IngameShopManager.getInstance().getConfirmedCreditBalance();
            }
            if (this.m_LastDepotTypeID == _loc_2)
            {
                return this.m_LastDepotAmount;
            }
            this.m_LastDepotTypeID = _loc_2;
            this.m_LastDepotAmount = 0;
            if (this.m_DepotContent != null)
            {
                _loc_3 = this.m_DepotContent.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    _loc_4 = InventoryTypeInfo(this.m_DepotContent[_loc_3]);
                    if (_loc_4.ID == this.m_LastDepotTypeID)
                    {
                        this.m_LastDepotAmount = _loc_4.count;
                        break;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return this.m_LastDepotAmount;
        }// end function

        public function get browseTypeID() : int
        {
            return this.m_PendingTypeID == -1 ? (s_BrowseTypeID) : (-1);
        }// end function

        public static function isValidCategoryID(param1:int) : Boolean
        {
            return param1 > 0 && param1 <= CATEGORY_TIBIA_COINS;
        }// end function

        public static function isValidTypeID(param1:int) : Boolean
        {
            var _loc_2:* = Tibia.s_GetAppearanceStorage();
            return _loc_2.getMarketObjectType(param1) != null;
        }// end function

    }
}
