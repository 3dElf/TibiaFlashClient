package tibia.ingameshop.shopWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import shared.controls.*;
    import tibia.creatures.*;
    import tibia.ingameshop.*;

    public class CharacterNameChangeWidget extends EmbeddedDialog
    {
        private var m_UIName:TextInput;
        private var m_OfferID:int;
        private static const BUNDLE:String = "IngameShopWidget";

        public function CharacterNameChangeWidget(param1:int)
        {
            this.m_OfferID = param1;
            title = resourceManager.getString(BUNDLE, "TITLE_NAME_CHANGE");
            buttonFlags = EmbeddedDialog.OKAY | EmbeddedDialog.CANCEL;
            width = IngameShopWidget.EMBEDDED_DIALOG_WIDTH;
            return;
        }// end function

        override public function setFocus() : void
        {
            super.setFocus();
            this.m_UIName.setFocus();
            return;
        }// end function

        public function get offerID() : int
        {
            return this.m_OfferID;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            super.createChildren();
            text = resourceManager.getString(BUNDLE, "LBL_CHARACTER_NAME_CHANGE");
            _loc_1 = new HBox();
            _loc_1.percentWidth = 100;
            content.addChild(_loc_1);
            var _loc_2:* = new Label();
            _loc_2.text = resourceManager.getString(BUNDLE, "LBL_CHARACTER_NAME_CHANGE_NEW_NAME");
            _loc_1.addChild(_loc_2);
            this.m_UIName = new TextInput();
            this.m_UIName.percentWidth = 100;
            this.m_UIName.maxChars = Creature.MAX_NAME_LENGHT;
            _loc_1.addChild(this.m_UIName);
            return;
        }// end function

        public function get desiredName() : String
        {
            return this.m_UIName.text;
        }// end function

    }
}
