package tibia.imbuing.imbuingWidgetClasses
{
    import mx.containers.*;
    import shared.controls.*;
    import tibia.controls.*;

    public class ImbuementButtonWidget extends Canvas
    {
        private var m_UIConstructed:Boolean = false;
        private var m_UIButton:CustomButton;
        private var m_UICurrencyView:TibiaCurrencyView;

        public function ImbuementButtonWidget()
        {
            this.m_UIButton = new CustomButton();
            this.m_UICurrencyView = new TibiaCurrencyView();
            return;
        }// end function

        public function get currencyView() : TibiaCurrencyView
        {
            return this.m_UICurrencyView;
        }// end function

        public function get button() : CustomButton
        {
            return this.m_UIButton;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
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
                _loc_1 = new VBox();
                _loc_1.percentHeight = 100;
                _loc_1.percentWidth = 100;
                _loc_2 = new HBox();
                this.m_UIButton.percentWidth = 100;
                this.m_UIButton.percentHeight = 100;
                _loc_2.addChild(this.m_UIButton);
                _loc_2.percentWidth = 100;
                _loc_2.percentHeight = 100;
                _loc_1.addChild(_loc_2);
                _loc_3 = new HBox();
                _loc_3.percentWidth = 100;
                this.m_UICurrencyView.percentWidth = 100;
                _loc_3.addChild(this.m_UICurrencyView);
                _loc_1.addChild(_loc_3);
                addChild(_loc_1);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

    }
}
