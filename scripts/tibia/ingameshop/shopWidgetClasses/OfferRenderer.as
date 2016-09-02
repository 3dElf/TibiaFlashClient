package tibia.ingameshop.shopWidgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import tibia.ingameshop.*;

    public class OfferRenderer extends VBox
    {
        private var m_UncommittedSaleTitle:Boolean;
        private var m_UIMainContainer:VBox;
        private var m_UIPrice:CoinWidget;
        private var m_SecondsBeforeSaleDisplaySwitch:int;
        private var m_UncommittedOffer:Boolean;
        private var m_UISpecialIcon:Image;
        private var m_UIName:Label;
        private var m_UIIcon:SliderImage;
        private static const BUNDLE:String = "IngameShopWidget";
        private static const ICON_SALE_CLASS:Class = OfferRenderer_ICON_SALE_CLASS;
        private static const ICON_EXPIRING_CLASS:Class = OfferRenderer_ICON_EXPIRING_CLASS;
        private static const ICON_NEW_CLASS:Class = OfferRenderer_ICON_NEW_CLASS;
        private static const BLACK_WHITE_FILTER:Array = [0.3, 0.59, 0.11, 0, -10, 0.3, 0.59, 0.11, 0, -10, 0.3, 0.59, 0.11, 0, -10, 0, 0, 0, 1, 0];
        public static const ICON_EXPIRING:BitmapData = Bitmap(new ICON_EXPIRING_CLASS()).bitmapData;
        public static const ICON_NEW:BitmapData = Bitmap(new ICON_NEW_CLASS()).bitmapData;
        private static const SPECIAL_ICON_OFFSET:Point = new Point(1, 24);
        public static const ICON_SALE:BitmapData = Bitmap(new ICON_SALE_CLASS()).bitmapData;
        private static const SALE_TITLE_SWITCH_SECONDS:int = 50;

        public function OfferRenderer()
        {
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            Tibia.s_GetSecondaryTimer().addEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
            return;
        }// end function

        private function getTitleStyle(param1:IngameShopOffer) : String
        {
            if (param1.disabled)
            {
                return "";
            }
            if (param1.isSale())
            {
                return "ingameShopOfferSale";
            }
            if (param1.isNew())
            {
                return "ingameShopOfferNew";
            }
            if (param1.isTimed())
            {
                return "ingameShopOfferLastChance";
            }
            return "";
        }// end function

        protected function onSecondaryTimer(event:TimerEvent) : void
        {
            if (this.m_SecondsBeforeSaleDisplaySwitch <= 1)
            {
                this.m_UncommittedSaleTitle = true;
                invalidateProperties();
                this.m_SecondsBeforeSaleDisplaySwitch = SALE_TITLE_SWITCH_SECONDS;
            }
            else
            {
                (this.m_SecondsBeforeSaleDisplaySwitch - 1);
            }
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            if (super.data != param1)
            {
                super.data = param1;
                this.m_UncommittedOffer = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_2:* = null;
            super.commitProperties();
            var _loc_1:* = data as IngameShopOffer;
            if (this.m_UncommittedOffer)
            {
                if (_loc_1 != null)
                {
                    this.m_UIName.text = _loc_1.name;
                    this.m_UIName.styleName = this.getTitleStyle(_loc_1);
                    this.m_UIIcon.setImageIdentifiers(_loc_1.iconIdentifiers);
                    this.m_UIPrice.coins = _loc_1.price;
                    this.m_UIPrice.baseCoins = _loc_1.basePrice;
                    this.setDisabledStyle(_loc_1.disabled);
                    this.m_UIMainContainer.toolTip = _loc_1.disabled ? (resourceManager.getString(BUNDLE, "LBL_CANNOT_BUY_GENERIC") + "\n" + _loc_1.disabledReason + "\n" + _loc_1.description) : (_loc_1.description);
                    _loc_2 = this.m_UISpecialIcon.getChildAt(0) as Bitmap;
                    this.m_UISpecialIcon.visible = _loc_1.isSale() || _loc_1.isNew() || _loc_1.isTimed();
                    if (_loc_1.isSale())
                    {
                        _loc_2.bitmapData = ICON_SALE;
                        this.m_UISpecialIcon.setActualSize(ICON_SALE.width, ICON_SALE.height);
                    }
                    else if (_loc_1.isNew())
                    {
                        _loc_2.bitmapData = ICON_NEW;
                        this.m_UISpecialIcon.setActualSize(ICON_NEW.width, ICON_NEW.height);
                    }
                    else if (_loc_1.isTimed())
                    {
                        _loc_2.bitmapData = ICON_EXPIRING;
                        this.m_UISpecialIcon.setActualSize(ICON_EXPIRING.width, ICON_EXPIRING.height);
                    }
                }
                else
                {
                    this.m_UIIcon.setImageIdentifiers(null);
                }
                this.m_SecondsBeforeSaleDisplaySwitch = SALE_TITLE_SWITCH_SECONDS;
                this.m_UncommittedOffer = false;
            }
            if (this.m_UncommittedSaleTitle)
            {
                if (_loc_1 != null && _loc_1.isSale())
                {
                    if (this.m_UIName.text != _loc_1.name)
                    {
                        this.m_UIName.text = _loc_1.name;
                    }
                    else
                    {
                        this.m_UIName.text = resourceManager.getString(BUNDLE, "LBL_SALE_ALTERNATIVE_TITLE", [(_loc_1.priceReductionPercent() * 100).toFixed(0), this.formatTimeLeftString(_loc_1.saleValidUntilTimestamp)]);
                    }
                }
                this.m_UncommittedSaleTitle = false;
            }
            return;
        }// end function

        private function setDisabledStyle(param1:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = [this];
            this.m_UIMainContainer.styleName = param1 ? ("ingameShopOfferRendererBoxDisabled") : ("ingameShopOfferRendererBoxEnabled");
            while (_loc_2.length > 0)
            {
                
                _loc_3 = _loc_2.pop() as IUIComponent;
                if (_loc_3 != null)
                {
                    if (param1)
                    {
                        _loc_3.filters = [new ColorMatrixFilter(BLACK_WHITE_FILTER)];
                    }
                    else
                    {
                        _loc_3.filters = [];
                    }
                }
                _loc_4 = _loc_3 as Container;
                if (_loc_4 != null)
                {
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4.getChildren().length)
                    {
                        
                        _loc_2.push(_loc_4.getChildAt(_loc_5));
                        _loc_5++;
                    }
                }
            }
            return;
        }// end function

        private function formatTimeLeftString(param1:Number) : String
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_2:* = param1 - Math.floor(new Date().time / 1000);
            if (_loc_2 > 0)
            {
                _loc_3 = _loc_2 / 86400;
                _loc_4 = _loc_2 % 86400 / (60 * 60);
                if (_loc_3 > 0)
                {
                    return resourceManager.getString(BUNDLE, "TEXT_SALE_DURATION_DAYS_SHORT", [_loc_3]);
                }
                return resourceManager.getString(BUNDLE, "TEXT_SALE_DURATION_HOURS_SHORT", [_loc_4 == 0 ? ("<1") : (String(_loc_4))]);
            }
            else
            {
            }
            return resourceManager.getString(BUNDLE, "TEXT_SALE_DURATION_HOURS_SHORT", ["<1"]);
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            var _loc_1:* = new VBox();
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            var _loc_2:* = 5;
            _loc_1.setStyle("paddingLeft", _loc_2);
            _loc_1.setStyle("paddingRight", _loc_2);
            _loc_1.setStyle("paddingTop", _loc_2);
            _loc_1.setStyle("paddingBottom", _loc_2);
            addChild(_loc_1);
            this.m_UIMainContainer = new VBox();
            this.m_UIMainContainer.percentWidth = 100;
            _loc_1.addChild(this.m_UIMainContainer);
            var _loc_3:* = new HBox();
            _loc_3.percentWidth = 100;
            _loc_3.styleName = "offerDarkBorder";
            this.m_UIMainContainer.addChild(_loc_3);
            this.m_UIName = new Label();
            this.m_UIName.maxWidth = 100;
            this.m_UIName.truncateToFit = true;
            _loc_3.addChild(this.m_UIName);
            this.m_UIIcon = new SliderImage(64);
            this.m_UIMainContainer.addChild(this.m_UIIcon);
            this.m_UIPrice = new CoinWidget();
            this.m_UIPrice.percentWidth = 100;
            this.m_UIPrice.styleName = "offerDarkBorder";
            this.m_UIMainContainer.addChild(this.m_UIPrice);
            this.m_UISpecialIcon = new Image();
            this.m_UISpecialIcon.addChild(new Bitmap());
            this.m_UIMainContainer.rawChildren.addChild(this.m_UISpecialIcon);
            this.m_UISpecialIcon.move(SPECIAL_ICON_OFFSET.x, SPECIAL_ICON_OFFSET.y);
            return;
        }// end function

    }
}
