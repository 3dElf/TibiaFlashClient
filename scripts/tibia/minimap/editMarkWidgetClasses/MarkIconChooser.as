package tibia.minimap.editMarkWidgetClasses
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import tibia.minimap.*;

    public class MarkIconChooser extends UIComponent
    {
        private var m_UncommittedSelectedIcon:Boolean = false;
        protected var m_SelectedIcon:int = 0;
        protected var m_UIRenderer:Vector.<MarkIconRenderer> = null;

        public function MarkIconChooser()
        {
            return;
        }// end function

        public function set selectedIcon(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            param1 = Math.max(-1, Math.min(param1, (MiniMapStorage.MARK_ICON_COUNT - 1)));
            if (this.m_SelectedIcon != param1)
            {
                _loc_2 = this.m_SelectedIcon;
                this.m_SelectedIcon = param1;
                this.m_UncommittedSelectedIcon = true;
                invalidateProperties();
                _loc_3 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_3.kind = PropertyChangeEventKind.UPDATE;
                _loc_3.property = "selectedIcon";
                _loc_3.oldValue = _loc_2;
                _loc_3.newValue = this.m_SelectedIcon;
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            super.commitProperties();
            if (this.m_UncommittedSelectedIcon)
            {
                _loc_1 = this.m_UIRenderer.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    this.m_UIRenderer[_loc_1].highlight = this.m_UIRenderer[_loc_1].ID == this.m_SelectedIcon;
                    _loc_1 = _loc_1 - 1;
                }
                this.m_UncommittedSelectedIcon = false;
            }
            return;
        }// end function

        public function get selectedIcon() : int
        {
            return this.m_SelectedIcon;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("paddingLeft");
            var _loc_4:* = getStyle("paddingTop");
            var _loc_5:* = getStyle("horizontalGap");
            var _loc_6:* = getStyle("verticalGap");
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            _loc_9 = 0;
            _loc_10 = this.m_UIRenderer.length;
            while (_loc_9 < _loc_10)
            {
                
                _loc_12 = this.m_UIRenderer[_loc_9];
                _loc_8 = Math.max(_loc_8, _loc_12.getExplicitOrMeasuredHeight());
                _loc_7 = Math.max(_loc_7, _loc_12.getExplicitOrMeasuredWidth());
                _loc_9++;
            }
            _loc_9 = 0;
            _loc_10 = this.m_UIRenderer.length;
            _loc_11 = Math.round(_loc_10 / 2);
            while (_loc_9 < _loc_10)
            {
                
                _loc_12 = this.m_UIRenderer[_loc_9];
                _loc_12.move(_loc_3 + _loc_9 % _loc_11 * (_loc_7 + _loc_5), _loc_4 + Math.floor(_loc_9 / _loc_11) * (_loc_8 + _loc_6));
                _loc_12.setActualSize(_loc_7, _loc_8);
                _loc_9++;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = 0;
            super.createChildren();
            if (this.m_UIRenderer == null)
            {
                this.m_UIRenderer = new Vector.<MarkIconRenderer>(MiniMapStorage.MARK_ICON_COUNT, true);
                _loc_1 = 0;
                while (_loc_1 < this.m_UIRenderer.length)
                {
                    
                    this.m_UIRenderer[_loc_1] = new MarkIconRenderer();
                    this.m_UIRenderer[_loc_1].ID = _loc_1;
                    this.m_UIRenderer[_loc_1].highlight = _loc_1 == this.m_SelectedIcon;
                    this.m_UIRenderer[_loc_1].styleName = "withBackground";
                    this.m_UIRenderer[_loc_1].addEventListener(MouseEvent.MOUSE_DOWN, this.onSelectionChange);
                    addChild(this.m_UIRenderer[_loc_1]);
                    _loc_1++;
                }
            }
            return;
        }// end function

        protected function onSelectionChange(event:Event) : void
        {
            if (event != null)
            {
                this.selectedIcon = MarkIconRenderer(event.currentTarget).ID;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            super.measure();
            var _loc_1:* = 0;
            _loc_2 = 0;
            if (this.m_UIRenderer.length > 1)
            {
                _loc_3 = this.m_UIRenderer.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    _loc_5 = this.m_UIRenderer[_loc_3];
                    _loc_2 = Math.max(_loc_2, _loc_5.getExplicitOrMeasuredHeight());
                    _loc_1 = Math.max(_loc_1, _loc_5.getExplicitOrMeasuredWidth());
                    _loc_3 = _loc_3 - 1;
                }
                _loc_4 = Math.ceil(this.m_UIRenderer.length / 2);
                _loc_2 = 2 * _loc_2 + getStyle("verticalGap");
                _loc_1 = _loc_4 * _loc_1 + (_loc_4 - 1) * getStyle("horizontalGap");
            }
            var _loc_6:* = getStyle("paddingLeft") + _loc_1 + getStyle("paddingRight");
            measuredWidth = getStyle("paddingLeft") + _loc_1 + getStyle("paddingRight");
            measuredMinWidth = _loc_6;
            var _loc_6:* = getStyle("paddingTop") + _loc_2 + getStyle("paddingBottom");
            measuredHeight = getStyle("paddingTop") + _loc_2 + getStyle("paddingBottom");
            measuredMinHeight = _loc_6;
            return;
        }// end function

        private static function s_InitializeStyle() : void
        {
            var Decl:* = StyleManager.getStyleDeclaration("MarkIconChooser");
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.horizontalGap = 2;
                this.verticalGap = 2;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration("MarkIconChooser", Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}
