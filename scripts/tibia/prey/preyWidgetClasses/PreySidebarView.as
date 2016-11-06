package tibia.prey.preyWidgetClasses
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.events.*;
    import tibia.prey.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class PreySidebarView extends WidgetView
    {
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedPreyList:Boolean = true;
        private var m_UIBox:VBox = null;
        private static const BUNDLE:String = "PreyWidget";

        public function PreySidebarView()
        {
            titleText = resourceManager.getString(BUNDLE, "TITLE");
            verticalScrollPolicy = ScrollPolicy.OFF;
            horizontalScrollPolicy = ScrollPolicy.OFF;
            minHeight = PreyListRenderer.HEIGHT_HINT;
            PreyManager.getInstance().addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPreyManagerDataChanged);
            return;
        }// end function

        protected function onMouseClick(event:MouseEvent) : void
        {
            PreyWidget.s_ShowIfAppropriate();
            return;
        }// end function

        protected function onPreyManagerDataChanged(event:PropertyChangeEvent) : void
        {
            if (event.property == "prey")
            {
                this.m_UncommittedPreyList = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            super.commitProperties();
            if (this.m_UncommittedPreyList)
            {
                _loc_1 = PreyManager.getInstance().preys;
                while (this.m_UIBox.getChildren().length != _loc_1.length)
                {
                    
                    if (this.m_UIBox.getChildren().length > _loc_1.length)
                    {
                        this.m_UIBox.removeChildAt((this.m_UIBox.getChildren().length - 1));
                        continue;
                    }
                    _loc_3 = new PreyListRenderer();
                    _loc_3.percentWidth = 100;
                    this.m_UIBox.addChild(_loc_3);
                }
                _loc_2 = 0;
                while (_loc_2 < _loc_1.length && _loc_2 < this.m_UIBox.getChildren().length)
                {
                    
                    (this.m_UIBox.getChildAt(_loc_2) as PreyListRenderer).data = _loc_1[_loc_2];
                    _loc_2++;
                }
                invalidateSize();
                invalidateDisplayList();
                this.m_UncommittedPreyList = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            if (!this.m_UIConstructed)
            {
                this.m_UIBox = new VBox();
                this.m_UIBox.percentHeight = 100;
                this.m_UIBox.percentWidth = 100;
                this.m_UIBox.addEventListener(MouseEvent.CLICK, this.onMouseClick);
                addChild(this.m_UIBox);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

    }
}
