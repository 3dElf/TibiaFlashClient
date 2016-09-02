package tibia.ingameshop.shopWidgetClasses
{
    import flash.display.*;
    import flash.text.*;
    import mx.containers.*;
    import mx.controls.*;
    import shared.utility.i18n.*;

    public class CoinWidget extends HBox
    {
        private var m_UIUpdatingText:Label;
        private var m_UICoinsText:Label;
        private var m_Coins:Number;
        private var m_UncommittedCoins:Boolean = true;
        private var m_UICoinsIcon:Image;
        private var m_UIBaseCoinsText:Label;
        private var m_CoinsAreFinal:Boolean = true;
        private var m_BaseCoins:Number;
        private static const ICON_COINS_CLASS:Class = CoinWidget_ICON_COINS_CLASS;
        private static const BUNDLE:String = "IngameShopWidget";
        public static const ICON_COINS:BitmapData = Bitmap(new ICON_COINS_CLASS()).bitmapData;

        public function CoinWidget()
        {
            this.m_Coins = NaN;
            this.m_BaseCoins = NaN;
            this.m_CoinsAreFinal = true;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            super.updateDisplayList(param1, param2);
            if (this.m_UIBaseCoinsText.visible)
            {
                _loc_3 = this.m_UIBaseCoinsText.getLineMetrics(0);
                _loc_4 = _loc_3.height * 0.5 + 2;
                this.m_UIBaseCoinsText.graphics.clear();
                this.m_UIBaseCoinsText.graphics.lineStyle(1, this.m_UIBaseCoinsText.getStyle("color"), 1, true);
                this.m_UIBaseCoinsText.graphics.moveTo(0, _loc_4);
                this.m_UIBaseCoinsText.graphics.lineTo(_loc_3.width + 3, _loc_4);
            }
            return;
        }// end function

        public function set coins(param1:Number) : void
        {
            if (param1 != this.m_Coins)
            {
                this.m_Coins = param1;
                this.m_UncommittedCoins = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = false;
            super.commitProperties();
            if (this.m_UncommittedCoins)
            {
                _loc_1 = !isNaN(this.m_Coins);
                this.m_UICoinsText.text = _loc_1 ? (resourceManager.getString(BUNDLE, "LBL_CREDITS_VALUE", [i18nFormatNumber(this.m_Coins)])) : ("-");
                this.m_UICoinsIcon.visible = _loc_1;
                this.m_UICoinsIcon.includeInLayout = _loc_1;
                _loc_2 = !isNaN(this.m_BaseCoins) && this.m_BaseCoins != this.m_Coins;
                this.m_UIBaseCoinsText.text = _loc_2 ? (resourceManager.getString(BUNDLE, "LBL_CREDITS_VALUE", [i18nFormatNumber(this.m_BaseCoins)])) : ("-");
                this.m_UIBaseCoinsText.visible = _loc_2;
                this.m_UIBaseCoinsText.includeInLayout = _loc_2;
                this.m_UIUpdatingText.visible = !this.m_CoinsAreFinal;
                this.m_UIUpdatingText.includeInLayout = !this.m_CoinsAreFinal;
                invalidateSize();
                this.m_UncommittedCoins = false;
            }
            return;
        }// end function

        public function set coinsAreFinal(param1:Boolean) : void
        {
            if (param1 != this.m_CoinsAreFinal)
            {
                this.m_CoinsAreFinal = param1;
                this.m_UncommittedCoins = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set baseCoins(param1:Number) : void
        {
            if (param1 != this.m_BaseCoins)
            {
                this.m_BaseCoins = param1;
                this.m_UncommittedCoins = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIBaseCoinsText = new Label();
            this.m_UIBaseCoinsText.visible = false;
            this.m_UIBaseCoinsText.includeInLayout = false;
            this.m_UIBaseCoinsText.styleName = "basePrice";
            addChild(this.m_UIBaseCoinsText);
            this.m_UICoinsText = new Label();
            addChild(this.m_UICoinsText);
            this.m_UICoinsIcon = new Image();
            this.m_UICoinsIcon.addChild(new Bitmap(ICON_COINS));
            this.m_UICoinsIcon.width = ICON_COINS.width;
            this.m_UICoinsIcon.height = ICON_COINS.height;
            addChild(this.m_UICoinsIcon);
            this.m_UIUpdatingText = new Label();
            this.m_UIUpdatingText.text = resourceManager.getString(BUNDLE, "LBL_CREDITS_UPDATING");
            addChild(this.m_UIUpdatingText);
            return;
        }// end function

    }
}
