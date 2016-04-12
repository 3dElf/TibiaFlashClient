package tibia.market.marketWidgetClasses
{
    import flash.events.*;
    import mx.containers.*;
    import tibia.appearances.*;
    import tibia.market.*;
    import tibia.market.marketWidgetClasses.*;

    public class MarketComponent extends Box implements ITypeComponent
    {
        private var m_Market:MarketWidget = null;
        private var m_SelectedType:AppearanceType = null;

        public function MarketComponent(param1:MarketWidget)
        {
            this.m_Market = param1;
            return;
        }// end function

        public function get selectedType() : AppearanceType
        {
            return this.m_SelectedType;
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
                dispatchEvent(new Event(MarketWidget.SELECTED_TYPE_CHANGE, true, false));
            }
            return;
        }// end function

        public function get market() : MarketWidget
        {
            return this.m_Market;
        }// end function

    }
}
