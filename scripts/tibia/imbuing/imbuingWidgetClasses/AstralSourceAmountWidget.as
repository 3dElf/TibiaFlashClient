package tibia.imbuing.imbuingWidgetClasses
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import shared.controls.*;
    import tibia.appearances.widgetClasses.*;

    public class AstralSourceAmountWidget extends VBox
    {
        private var m_UIAstralSourceAppearance:SimpleAppearanceRenderer = null;
        private var m_UncomittedAstralSource:Boolean = false;
        private var m_AppearanceTypeID:uint = 0;
        private var m_AmountInInventory:uint = 0;
        private var m_UILabel:Label = null;
        private var m_UIConstructed:Boolean = false;
        private var m_AmountNeeded:uint = 0;

        public function AstralSourceAmountWidget()
        {
            return;
        }// end function

        private function onMouseOver(event:MouseEvent) : void
        {
            return;
        }// end function

        public function refreshData(param1:uint, param2:uint, param3:uint) : void
        {
            this.m_AppearanceTypeID = param1;
            this.m_AmountInInventory = param2;
            this.m_AmountNeeded = param3;
            this.m_UncomittedAstralSource = true;
            invalidateProperties();
            return;
        }// end function

        public function get empty() : Boolean
        {
            return this.m_AppearanceTypeID == 0;
        }// end function

        private function onMouseOut(event:MouseEvent) : void
        {
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncomittedAstralSource)
            {
                if (this.empty)
                {
                    this.m_UIAstralSourceAppearance.appearance = null;
                    this.m_UILabel.text = "";
                }
                else
                {
                    this.m_UIAstralSourceAppearance.appearance = Tibia.s_GetAppearanceStorage().createObjectInstance(this.m_AppearanceTypeID, 0);
                    ShapeWrapper(this.m_UIAstralSourceAppearance.parent).invalidateSize();
                    ShapeWrapper(this.m_UIAstralSourceAppearance.parent).invalidateDisplayList();
                    this.m_UILabel.text = this.m_AmountInInventory + "/" + this.m_AmountNeeded;
                    if (this.m_AmountInInventory < this.m_AmountNeeded)
                    {
                        this.m_UILabel.styleName = "astralSourceLabelAmountMissing";
                    }
                    else
                    {
                        this.m_UILabel.styleName = "astralSourceLabel";
                    }
                }
                this.m_UncomittedAstralSource = false;
            }
            return;
        }// end function

        public function clear() : void
        {
            this.m_AppearanceTypeID = 0;
            this.m_AmountInInventory = 0;
            this.m_AmountNeeded = 0;
            this.m_UncomittedAstralSource = true;
            invalidateProperties();
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
                _loc_1 = new HBox();
                _loc_2 = new ShapeWrapper();
                this.m_UIAstralSourceAppearance = new SimpleAppearanceRenderer();
                this.m_UIAstralSourceAppearance.scale = 2;
                this.m_UIAstralSourceAppearance.overlay = false;
                _loc_2.addChild(this.m_UIAstralSourceAppearance);
                _loc_2.percentWidth = 100;
                _loc_2.percentHeight = 100;
                _loc_1.width = 70;
                _loc_1.height = 70;
                _loc_1.addChild(_loc_2);
                _loc_1.verticalScrollPolicy = "off";
                _loc_1.horizontalScrollPolicy = "off";
                addChild(_loc_1);
                _loc_3 = new HBox();
                _loc_3.percentWidth = 100;
                this.m_UILabel = new Label();
                this.m_UILabel.percentWidth = 100;
                _loc_3.addChild(this.m_UILabel);
                addChild(_loc_3);
                _loc_1.styleName = "astralSourceBox";
                _loc_2.styleName = "astralSourceImageWrapper";
                this.m_UILabel.styleName = "astralSourceLabel";
                _loc_3.styleName = "astralSourceBox";
                this.m_UIConstructed = true;
            }
            return;
        }// end function

    }
}
