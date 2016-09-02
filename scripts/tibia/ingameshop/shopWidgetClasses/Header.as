package tibia.ingameshop.shopWidgetClasses
{
    import flash.display.*;
    import flash.errors.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import tibia.ingameshop.*;
    import tibia.ingameshop.shopWidgetClasses.*;

    public class Header extends HBox implements IIngameShopWidgetComponent, IDataRenderer
    {
        private var m_UILabelHeader:Text;
        private var m_UIIcon:SliderImage;
        private var m_UncommittedSelection:Boolean;
        private var m_UIDetailsStack:ViewStack;
        private var m_UILabelDescription:Text;
        private var m_UILabelPrice:CoinWidget;
        private var m_ShopWindow:IngameShopWidget;
        private static const VIEW_OFFER:int = 1;
        private static const BUNDLE:String = "IngameShopWidget";
        public static const STATIC_HEADER_TRANSACTION_HISTORY:int = 0;
        private static const ICON_COINS_CLASS:Class = Header_ICON_COINS_CLASS;
        private static const VIEW_CATEGORY:int = 0;
        private static const ICON_COINS:BitmapData = Bitmap(new ICON_COINS_CLASS()).bitmapData;

        public function Header()
        {
            return;
        }// end function

        public function set shopWidget(param1:IngameShopWidget) : void
        {
            if (this.m_ShopWindow != null)
            {
                throw new IllegalOperationError("IngameShopOfferList.shopWidget: Attempted to set reference twice");
            }
            this.m_ShopWindow = param1;
            return;
        }// end function

        public function setStaticHeader(param1:int) : void
        {
            this.data = {staticHeader:param1};
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            setStyle("verticalAlign", "middle");
            this.m_UIIcon = new SliderImage(64);
            addChild(this.m_UIIcon);
            var _loc_1:* = new VBox();
            _loc_1.percentWidth = 100;
            _loc_1.setStyle("verticalGap", 2);
            addChild(_loc_1);
            this.m_UILabelHeader = new Text();
            this.m_UILabelHeader.styleName = "ingameShopBold";
            _loc_1.addChild(this.m_UILabelHeader);
            this.m_UIDetailsStack = new ViewStack();
            this.m_UIDetailsStack.percentWidth = 100;
            this.m_UIDetailsStack.resizeToContent = true;
            _loc_1.addChild(this.m_UIDetailsStack);
            var _loc_2:* = new HBox();
            _loc_2.percentWidth = 100;
            this.m_UIDetailsStack.addChild(_loc_2);
            this.m_UILabelDescription = new Text();
            this.m_UILabelDescription.percentWidth = 100;
            this.m_UILabelDescription.styleName = "ingameShopCategoryDescription";
            _loc_2.addChild(this.m_UILabelDescription);
            this.m_UILabelPrice = new CoinWidget();
            this.m_UILabelPrice.percentWidth = 100;
            this.m_UIDetailsStack.addChild(this.m_UILabelPrice);
            this.m_UncommittedSelection = true;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            super.commitProperties();
            if (this.m_UncommittedSelection && this.m_ShopWindow != null)
            {
                _loc_1 = data as IngameShopCategory;
                _loc_2 = data as IngameShopOffer;
                _loc_3 = data != null && data.hasOwnProperty("staticHeader") ? (data.staticHeader) : (-1);
                if (_loc_2 != null)
                {
                    this.m_UILabelHeader.text = _loc_2.name;
                    this.m_UILabelPrice.coins = _loc_2.price;
                    this.m_UILabelPrice.baseCoins = _loc_2.basePrice;
                    this.m_UIIcon.setImageIdentifiers(_loc_2.iconIdentifiers);
                    this.m_UIDetailsStack.selectedIndex = VIEW_OFFER;
                }
                else if (_loc_1 != null)
                {
                    this.m_UILabelHeader.text = _loc_1.name;
                    this.m_UILabelDescription.text = _loc_1.description;
                    this.m_UIIcon.setImageIdentifiers(_loc_1.iconIdentifiers);
                    this.m_UIDetailsStack.selectedIndex = VIEW_CATEGORY;
                }
                else if (_loc_3 == STATIC_HEADER_TRANSACTION_HISTORY)
                {
                    this.m_UILabelHeader.text = resourceManager.getString(BUNDLE, "TITLE_TRANSACTION_HISTORY");
                    this.m_UILabelDescription.text = resourceManager.getString(BUNDLE, "LBL_TRANSACTION_HISTORY");
                    _loc_4 = new DynamicImage();
                    _loc_4.bitmapData = ICON_COINS;
                    this.m_UIIcon.dynamicImage = _loc_4;
                    this.m_UIDetailsStack.selectedIndex = VIEW_CATEGORY;
                }
                else
                {
                    this.m_UILabelHeader.text = "";
                    this.m_UILabelDescription.text = "";
                    this.m_UIIcon.dynamicImage = null;
                    this.m_UIDetailsStack.selectedIndex = VIEW_CATEGORY;
                }
                this.m_UncommittedSelection = false;
            }
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            super.data = param1;
            this.m_UncommittedSelection = true;
            invalidateProperties();
            return;
        }// end function

        public function dispose() : void
        {
            this.m_UIIcon.dispose();
            this.m_ShopWindow = null;
            return;
        }// end function

    }
}
