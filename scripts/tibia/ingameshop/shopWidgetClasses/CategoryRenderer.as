package tibia.ingameshop.shopWidgetClasses
{
    import flash.display.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import tibia.ingameshop.*;

    public class CategoryRenderer extends HBox
    {
        private var m_UITextBox:Text;
        private var m_UISpecialIcon:Image;
        private var m_UncommittedCategory:Boolean;
        private var m_UIIcon:DynamicallyLoadedImage;
        private static const SPECIAL_ICON_OFFSET:Point = new Point(0, 0);

        public function CategoryRenderer()
        {
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.commitProperties();
            if (this.m_UncommittedCategory)
            {
                _loc_1 = data as IngameShopCategory;
                if (_loc_1 != null)
                {
                    this.m_UITextBox.text = _loc_1.name;
                    this.m_UIIcon.setImageIdentifier(_loc_1.iconIdentifiers != null && _loc_1.iconIdentifiers.length > 0 ? (_loc_1.iconIdentifiers[0]) : (null));
                    toolTip = _loc_1.description;
                    _loc_2 = this.m_UISpecialIcon.getChildAt(0) as Bitmap;
                    _loc_2.bitmapData = OfferRenderer.ICON_SALE;
                    this.m_UISpecialIcon.setActualSize(OfferRenderer.ICON_SALE.width, OfferRenderer.ICON_SALE.height);
                    this.m_UISpecialIcon.visible = _loc_1.hasSaleOffer() || _loc_1.hasNewOffer() || _loc_1.hasTimedOffer();
                    if (_loc_1.hasSaleOffer())
                    {
                        _loc_2.bitmapData = OfferRenderer.ICON_SALE;
                    }
                    else if (_loc_1.hasNewOffer())
                    {
                        _loc_2.bitmapData = OfferRenderer.ICON_NEW;
                    }
                    else if (_loc_1.hasTimedOffer())
                    {
                        _loc_2.bitmapData = OfferRenderer.ICON_EXPIRING;
                    }
                    if (this.m_UISpecialIcon.visible)
                    {
                        this.m_UISpecialIcon.setActualSize(_loc_2.bitmapData.width, _loc_2.bitmapData.height);
                    }
                }
                this.m_UncommittedCategory = false;
            }
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            super.data = param1;
            this.m_UncommittedCategory = true;
            invalidateProperties();
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            verticalScrollPolicy = ScrollPolicy.OFF;
            horizontalScrollPolicy = ScrollPolicy.OFF;
            this.m_UIIcon = new DynamicallyLoadedImage(32);
            this.m_UIIcon.resizeToImage = false;
            addChild(this.m_UIIcon);
            this.m_UITextBox = new Text();
            addChild(this.m_UITextBox);
            this.m_UISpecialIcon = new Image();
            this.m_UISpecialIcon.addChild(new Bitmap());
            rawChildren.addChild(this.m_UISpecialIcon);
            this.m_UISpecialIcon.move(SPECIAL_ICON_OFFSET.x, SPECIAL_ICON_OFFSET.y);
            return;
        }// end function

    }
}
