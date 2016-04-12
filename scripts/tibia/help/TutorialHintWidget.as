package tibia.help
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import tibia.game.*;

    public class TutorialHintWidget extends PopUpBase
    {
        private var m_UIImages:Container = null;
        private var m_UncommittedImages:Boolean = false;
        private var m_Images:Array = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UIText:Text = null;
        private var m_UncommittedText:Boolean = false;
        private static const BUNDLE:String = "TutorialHintWidget";

        public function TutorialHintWidget()
        {
            title = resourceManager.getString(BUNDLE, "TITLE");
            buttonFlags = PopUpBase.BUTTON_OKAY;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            super.commitProperties();
            if (this.m_UncommittedImages)
            {
                this.m_UIImages.removeAllChildren();
                _loc_1 = this.images != null ? (this.images.length) : (0);
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _loc_3 = new Image();
                    _loc_3.source = this.images[_loc_2];
                    this.m_UIImages.addChild(_loc_3);
                    _loc_2++;
                }
                this.m_UncommittedImages = false;
            }
            return;
        }// end function

        public function set images(param1:Array) : void
        {
            if (this.m_Images != param1)
            {
                this.m_Images = param1;
                this.m_UncommittedImages = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get images() : Array
        {
            return this.m_Images;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new VBox();
                _loc_1.percentWidth = 100;
                _loc_1.percentHeight = 100;
                _loc_1.setStyle("backgroundColor", "0x000000");
                _loc_1.setStyle("backgroundAlpha", 0.5);
                this.m_UIImages = new HBox();
                this.m_UIImages.percentWidth = 100;
                this.m_UIImages.setStyle("horizontalAlign", "center");
                this.m_UIImages.setStyle("verticalAlign", "middle");
                addChild(_loc_1);
                _loc_1.addChild(this.m_UIImages);
            }
            return;
        }// end function

    }
}
