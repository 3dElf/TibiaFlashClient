package tibia.creatures.editBuddyWidgetClasses
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.styles.*;
    import tibia.creatures.buddylistClasses.*;
    import tibia.creatures.buddylistWidgetClasses.*;

    public class BuddyIconChooser extends HBox
    {
        private var m_UncommittedDataProvider:Boolean = false;
        protected var m_SelectedIndex:int = -1;
        private var m_UncommittedSelectedIndex:Boolean = false;
        protected var m_DataProvider:Vector.<BuddyIcon> = null;

        public function BuddyIconChooser()
        {
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            return;
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            if (this.m_DataProvider != null)
            {
                param1 = Math.max(0, Math.min(param1, (this.m_DataProvider.length - 1)));
            }
            else
            {
                param1 = -1;
            }
            if (this.m_SelectedIndex != param1)
            {
                this.m_SelectedIndex = param1;
                this.m_UncommittedSelectedIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.m_UncommittedDataProvider)
            {
                _loc_1 = numChildren - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_3 = BuddyIconRenderer(removeChildAt(_loc_1));
                    _loc_3.removeEventListener(MouseEvent.MOUSE_DOWN, this.onSelectionChange);
                    _loc_1 = _loc_1 - 1;
                }
                if (this.m_DataProvider != null)
                {
                    _loc_1 = 0;
                    _loc_2 = this.m_DataProvider.length;
                    while (_loc_1 < _loc_2)
                    {
                        
                        _loc_3 = BuddyIconRenderer(addChild(new BuddyIconRenderer()));
                        _loc_3.ID = this.m_DataProvider[_loc_1].ID;
                        _loc_3.styleName = "withBackground";
                        _loc_3.addEventListener(MouseEvent.MOUSE_DOWN, this.onSelectionChange);
                        _loc_1++;
                    }
                }
                this.m_UncommittedDataProvider = false;
            }
            if (this.m_UncommittedSelectedIndex)
            {
                _loc_1 = numChildren - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_3 = BuddyIconRenderer(getChildAt(_loc_1));
                    _loc_3.highlight = this.m_SelectedIndex == _loc_1;
                    _loc_1 = _loc_1 - 1;
                }
                this.m_UncommittedSelectedIndex = false;
            }
            return;
        }// end function

        protected function onSelectionChange(event:Event) : void
        {
            if (event != null)
            {
                this.selectedID = BuddyIconRenderer(event.currentTarget).ID;
            }
            return;
        }// end function

        public function set dataProvider(param1:Vector.<BuddyIcon>) : void
        {
            this.m_DataProvider = param1;
            this.m_UncommittedDataProvider = true;
            invalidateProperties();
            this.selectedIndex = this.m_DataProvider != null ? (0) : (-1);
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return this.m_SelectedIndex;
        }// end function

        public function set selectedID(param1:int) : void
        {
            var _loc_2:* = -1;
            if (this.m_DataProvider != null)
            {
                _loc_2 = this.m_DataProvider.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    if (this.m_DataProvider[_loc_2].ID == param1)
                    {
                        break;
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            this.selectedIndex = _loc_2;
            return;
        }// end function

        public function get dataProvider() : Vector.<BuddyIcon>
        {
            return this.m_DataProvider;
        }// end function

        public function get selectedID() : int
        {
            if (this.m_SelectedIndex > -1)
            {
                return this.m_DataProvider[this.m_SelectedIndex].ID;
            }
            return BuddyIcon.DEFAULT_ICON;
        }// end function

        private static function s_InitialiseStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration(Selector);
            }
            Decl.defaultFactory = function () : void
            {
                this.horizontalGap = 2;
                this.verticalGap = 2;
                this.paddingBottom = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitialiseStyle();
    }
}
