package tibia.market.marketWidgetClasses
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import shared.utility.i18n.*;
    import tibia.market.*;

    public class MarketStatisticsView extends MarketComponent
    {
        private var m_UIBuyMaximum:Label = null;
        private var m_UISellTransactions:Label = null;
        private var m_UISellMinimum:Label = null;
        private var m_UISellAverage:Label = null;
        private var m_UncommittedSelectedType:Boolean = false;
        private var m_UISellMaximum:Label = null;
        private var m_UIBuyMinimum:Label = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UIBuyTransactions:Label = null;
        private var m_UIBuyAverage:Label = null;
        private static const BUNDLE:String = "MarketWidget";

        public function MarketStatisticsView(param1:MarketWidget)
        {
            super(param1);
            direction = BoxDirection.VERTICAL;
            label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_LABEL");
            horizontalScrollPolicy = ScrollPolicy.OFF;
            market.addEventListener(MarketWidget.BROWSE_DETAILS_CHANGE, this.onStatisticsChange);
            return;
        }// end function

        private function resetForm() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in [this.m_UIBuyTransactions, this.m_UIBuyAverage, this.m_UIBuyMaximum, this.m_UIBuyMinimum, this.m_UISellTransactions, this.m_UISellAverage, this.m_UISellMaximum, this.m_UISellMinimum])
            {
                
                _loc_1.text = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_EMPTY");
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedSelectedType)
            {
                this.resetForm();
                this.m_UncommittedSelectedType = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new Form();
                _loc_1.percentHeight = 100;
                _loc_1.percentWidth = 100;
                _loc_1.setStyle("paddingBottom", 0);
                _loc_1.setStyle("paddingLeft", 0);
                _loc_1.setStyle("paddingRight", 0);
                _loc_1.setStyle("paddingTop", 0);
                _loc_1.setStyle("horizontalGap", 8);
                _loc_1.setStyle("verticalGap", 6);
                _loc_2 = new FormHeading();
                _loc_2.label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_BUYOFFERS");
                _loc_1.addChild(_loc_2);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_TOTALTRANSACTIONS");
                this.m_UIBuyTransactions = new Label();
                this.m_UIBuyTransactions.text = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_EMPTY");
                this.m_UIBuyTransactions.setStyle("fontWeight", "bold");
                _loc_3.addChild(this.m_UIBuyTransactions);
                _loc_1.addChild(_loc_3);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_MAXIMUM");
                this.m_UIBuyMaximum = new Label();
                this.m_UIBuyMaximum.text = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_EMPTY");
                this.m_UIBuyMaximum.setStyle("fontWeight", "bold");
                _loc_3.addChild(this.m_UIBuyMaximum);
                _loc_1.addChild(_loc_3);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_AVERAGE");
                this.m_UIBuyAverage = new Label();
                this.m_UIBuyAverage.text = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_EMPTY");
                this.m_UIBuyAverage.setStyle("fontWeight", "bold");
                _loc_3.addChild(this.m_UIBuyAverage);
                _loc_1.addChild(_loc_3);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_MINIMUM");
                this.m_UIBuyMinimum = new Label();
                this.m_UIBuyMinimum.text = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_EMPTY");
                this.m_UIBuyMinimum.setStyle("fontWeight", "bold");
                _loc_3.addChild(this.m_UIBuyMinimum);
                _loc_1.addChild(_loc_3);
                _loc_2 = new FormHeading();
                _loc_2.label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_SELLOFFERS");
                _loc_1.addChild(_loc_2);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_TOTALTRANSACTIONS");
                this.m_UISellTransactions = new Label();
                this.m_UISellTransactions.text = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_EMPTY");
                this.m_UISellTransactions.setStyle("fontWeight", "bold");
                _loc_3.addChild(this.m_UISellTransactions);
                _loc_1.addChild(_loc_3);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_MAXIMUM");
                this.m_UISellMaximum = new Label();
                this.m_UISellMaximum.text = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_EMPTY");
                this.m_UISellMaximum.setStyle("fontWeight", "bold");
                _loc_3.addChild(this.m_UISellMaximum);
                _loc_1.addChild(_loc_3);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_AVERAGE");
                this.m_UISellAverage = new Label();
                this.m_UISellAverage.text = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_EMPTY");
                this.m_UISellAverage.setStyle("fontWeight", "bold");
                _loc_3.addChild(this.m_UISellAverage);
                _loc_1.addChild(_loc_3);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_MINIMUM");
                this.m_UISellMinimum = new Label();
                this.m_UISellMinimum.text = resourceManager.getString(BUNDLE, "MARKET_STATISTICS_VIEW_EMPTY");
                this.m_UISellMinimum.setStyle("fontWeight", "bold");
                _loc_3.addChild(this.m_UISellMinimum);
                _loc_1.addChild(_loc_3);
                addChild(_loc_1);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        private function onStatisticsChange(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            if (event != null)
            {
                _loc_2 = null;
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_5 = 0;
                _loc_6 = 0;
                if (market.browseStatistics != null)
                {
                    var _loc_7:* = 0;
                    _loc_4 = 0;
                    _loc_3 = _loc_7;
                    _loc_5 = Number.NEGATIVE_INFINITY;
                    _loc_6 = Number.POSITIVE_INFINITY;
                    for each (_loc_2 in market.browseStatistics)
                    {
                        
                        if (_loc_2.kind != Offer.BUY_OFFER)
                        {
                            continue;
                        }
                        _loc_3 = _loc_3 + _loc_2.totalTransactions;
                        _loc_4 = _loc_4 + _loc_2.totalPrice;
                        if (_loc_2.maximumPrice > _loc_5)
                        {
                            _loc_5 = _loc_2.maximumPrice;
                        }
                        if (_loc_2.minimumPrice < _loc_6)
                        {
                            _loc_6 = _loc_2.minimumPrice;
                        }
                    }
                    _loc_5 = Math.max(0, _loc_5);
                    _loc_6 = Math.min(_loc_6, _loc_5);
                    this.m_UIBuyTransactions.text = String(_loc_3);
                    this.m_UIBuyAverage.text = _loc_3 > 0 ? (i18nFormatNumber(Math.round(_loc_4 / _loc_3))) : ("0");
                    this.m_UIBuyMaximum.text = i18nFormatNumber(_loc_5);
                    this.m_UIBuyMinimum.text = i18nFormatNumber(_loc_6);
                    var _loc_7:* = 0;
                    _loc_4 = 0;
                    _loc_3 = _loc_7;
                    _loc_5 = Number.NEGATIVE_INFINITY;
                    _loc_6 = Number.POSITIVE_INFINITY;
                    for each (_loc_2 in market.browseStatistics)
                    {
                        
                        if (_loc_2.kind != Offer.SELL_OFFER)
                        {
                            continue;
                        }
                        _loc_3 = _loc_3 + _loc_2.totalTransactions;
                        _loc_4 = _loc_4 + _loc_2.totalPrice;
                        if (_loc_2.maximumPrice > _loc_5)
                        {
                            _loc_5 = _loc_2.maximumPrice;
                        }
                        if (_loc_2.minimumPrice < _loc_6)
                        {
                            _loc_6 = _loc_2.minimumPrice;
                        }
                    }
                    _loc_5 = Math.max(0, _loc_5);
                    _loc_6 = Math.min(_loc_6, _loc_5);
                    this.m_UISellTransactions.text = String(_loc_3);
                    this.m_UISellAverage.text = _loc_3 > 0 ? (i18nFormatNumber(Math.round(_loc_4 / _loc_3))) : ("0");
                    this.m_UISellMaximum.text = i18nFormatNumber(_loc_5);
                    this.m_UISellMinimum.text = i18nFormatNumber(_loc_6);
                }
                else
                {
                    this.resetForm();
                }
            }
            return;
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

    }
}
