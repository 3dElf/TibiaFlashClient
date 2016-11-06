package tibia.market.marketWidgetClasses
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import tibia.market.*;

    public class MarketDetailsView extends MarketComponent
    {
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedSelectedType:Boolean = false;
        private var m_UIForm:Form = null;
        private static const FIELDS:Array = [{index:MarketWidget.DETAIL_FIELD_DESCRIPTION, name:"DETAIL_FIELD_DESCRIPTION"}, {index:MarketWidget.DETAIL_FIELD_CAPACITY, name:"DETAIL_FIELD_CAPACITY"}, {index:MarketWidget.DETAIL_FIELD_RUNE_SPELL, name:"DETAIL_FIELD_RUNE_SPELL"}, {index:MarketWidget.DETAIL_FIELD_WEIGHT, name:"DETAIL_FIELD_WEIGHT"}, {index:MarketWidget.DETAIL_FIELD_IMBUEMENT_SLOTS, name:"DETAIL_FIELD_IMBUEMENT_SLOTS"}, {index:MarketWidget.DETAIL_FIELD_WEAPON_TYPE, name:"DETAIL_FIELD_WEAPON_TYPE"}, {index:MarketWidget.DETAIL_FIELD_ATTACK, name:"DETAIL_FIELD_ATTACK"}, {index:MarketWidget.DETAIL_FIELD_ARMOR, name:"DETAIL_FIELD_ARMOR"}, {index:MarketWidget.DETAIL_FIELD_DEFENCE, name:"DETAIL_FIELD_DEFENCE"}, {index:MarketWidget.DETAIL_FIELD_PROTECTION, name:"DETAIL_FIELD_PROTECTION"}, {index:MarketWidget.DETAIL_FIELD_SKILLBOOST, name:"DETAIL_FIELD_SKILLBOOST"}, {index:MarketWidget.DETAIL_FIELD_EXPIRE, name:"DETAIL_FIELD_EXPIRE"}, {index:MarketWidget.DETAIL_FIELD_USES, name:"DETAIL_FIELD_USES"}, {index:MarketWidget.DETAIL_FIELD_RESTRICT_LEVEL, name:"DETAIL_FIELD_RESTRICT_LEVEL"}, {index:MarketWidget.DETAIL_FIELD_RESTRICT_MAGICLEVEL, name:"DETAIL_FIELD_RESTRICT_MAGICLEVEL"}, {index:MarketWidget.DETAIL_FIELD_RESTRICT_PROFESSION, name:"DETAIL_FIELD_RESTRICT_PROFESSION"}];
        private static const BUNDLE:String = "MarketWidget";

        public function MarketDetailsView(param1:MarketWidget)
        {
            super(param1);
            direction = BoxDirection.VERTICAL;
            label = resourceManager.getString(BUNDLE, "MARKET_DETAILS_VIEW_LABEL");
            market.addEventListener(MarketWidget.BROWSE_DETAILS_CHANGE, this.onDetailsChange);
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

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedSelectedType)
            {
                this.m_UIForm.removeAllChildren();
                this.m_UncommittedSelectedType = false;
            }
            return;
        }// end function

        private function onDetailsChange(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (event != null)
            {
                this.m_UIForm.removeAllChildren();
                if (market == null || market.browseDetail == null || market.browseDetail.length != FIELDS.length)
                {
                    return;
                }
                _loc_2 = 0;
                while (_loc_2 < FIELDS.length)
                {
                    
                    _loc_3 = market.browseDetail[FIELDS[_loc_2].index];
                    if (_loc_3 != null && _loc_3.length > 0)
                    {
                        _loc_4 = new Text();
                        _loc_4.text = _loc_3;
                        _loc_4.width = 250;
                        _loc_4.setStyle("fontWeight", "bold");
                        _loc_5 = new FormItem();
                        _loc_5.label = resourceManager.getString(BUNDLE, FIELDS[_loc_2].name);
                        _loc_5.addChild(_loc_4);
                        this.m_UIForm.addChild(_loc_5);
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIForm = new Form();
                this.m_UIForm.horizontalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIForm.percentHeight = 100;
                this.m_UIForm.setStyle("labelWidth", 185);
                this.m_UIForm.setStyle("paddingBottom", 0);
                this.m_UIForm.setStyle("paddingTop", 0);
                addChild(this.m_UIForm);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

    }
}
