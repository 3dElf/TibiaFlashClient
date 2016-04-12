package tibia.ingameshop.shopWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import tibia.ingameshop.*;

    public class CategoryRenderer extends HBox
    {
        private var m_UIIcon:DynamicallyLoadedImage;
        private var m_UITextBox:Text;
        private var m_UncommittedCategory:Boolean;

        public function CategoryRenderer()
        {
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
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            super.data = param1;
            this.m_UncommittedCategory = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedCategory)
            {
                _loc_1 = data as IngameShopCategory;
                if (_loc_1 != null)
                {
                    this.m_UITextBox.text = _loc_1.name;
                    this.m_UIIcon.setImageIdentifier(_loc_1.iconIdentifiers != null && _loc_1.iconIdentifiers.length > 0 ? (_loc_1.iconIdentifiers[0]) : (null));
                    toolTip = _loc_1.description;
                }
                this.m_UncommittedCategory = false;
            }
            return;
        }// end function

    }
}
