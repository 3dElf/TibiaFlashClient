package tibia.market.marketWidgetClasses
{
    import mx.controls.*;
    import shared.controls.*;
    import tibia.appearances.*;

    public class AppearanceTypeListRenderer extends AppearanceTypeTileRenderer
    {
        private var m_UIName:Label = null;
        private var m_UncommittedAppearance:Boolean = false;

        public function AppearanceTypeListRenderer()
        {
            return;
        }// end function

        override protected function set appearance(param1:AppearanceType) : void
        {
            if (super.appearance != param1)
            {
                super.appearance = param1;
                this.m_UncommittedAppearance = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedAppearance)
            {
                if (super.appearance != null)
                {
                    this.m_UIName.text = super.appearance.marketName;
                }
                else
                {
                    this.m_UIName.text = null;
                }
                this.m_UncommittedAppearance = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIName = new CustomLabel();
            this.m_UIName.percentWidth = 100;
            this.m_UIName.truncateToFit = true;
            addChild(this.m_UIName);
            return;
        }// end function

    }
}
