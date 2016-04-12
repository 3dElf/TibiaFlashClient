package tibia.sidebar.sideBarWidgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import shared.controls.*;
    import tibia.options.*;
    import tibia.sidebar.*;

    public class WidgetView extends Box
    {
        private var m_MeasuredMaxHeight:Number = NaN;
        private var m_UncommittedWidgetCollapsible:Boolean = false;
        private var m_UncommittedWidgetCollapsed:Boolean = false;
        protected var m_WidgetInstance:Widget = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedWidgetHeight:Boolean = false;
        protected var m_WidgetHeight:Number = NaN;
        private var m_MeasuredMaxWidth:Number = NaN;
        private var m_UncommittedWidgetInstance:Boolean = false;
        private var m_UncommittedWidgetResizable:Boolean = false;
        protected var m_WidgetClosable:Boolean = false;
        private var m_UncommittedWidgetClosed:Boolean = false;
        protected var m_WidgetClosed:Boolean = false;
        protected var m_UICollapseButton:Button = null;
        protected var m_WidgetCollapsed:Boolean = false;
        protected var m_Options:OptionsStorage = null;
        protected var m_WidgetCollapsible:Boolean = false;
        private var m_UncommittedWidgetClosable:Boolean = false;
        protected var m_UICloseButton:Button = null;
        private var m_UncommittedTitle:Boolean = false;
        private var m_UITitleLabel:CustomLabel = null;
        protected var m_UIHeader:HBox = null;
        protected var m_WidgetResizable:Boolean = false;
        private var m_UIFooter:HBox = null;
        protected var m_Title:String = null;
        private var m_UITitleIcon:IFlexDisplayObject = null;
        static const DEFAULT_WIDGET_HEIGHT:Number = 200;
        private static const TITLE_LABEL_STYLE_FILTER:Object = {titleFontFamily:"fontFamily", titleFontSize:"fontSize", titleFontWeight:"fontWeight", titleFontColor:"color"};
        static const DEFAULT_WIDGET_WIDTH:Number = 184;
        private static const FOOTER_STYLE_FILTER:Object = {footerPaddingBottom:"paddingBottom", footerPaddingLeft:"paddingLeft", footerPaddingRight:"paddingRight", footerPaddingTop:"paddingTop", footerHorizontalAlign:"horizontalAlign", footerHorizontalGap:"horizontalGap", footerVerticalAlign:"verticalAlign", footerVerticalGap:"verticalGap"};
        private static const HEADER_STYLE_FILTER:Object = {headerPaddingBottom:"paddingBottom", headerPaddingLeft:"paddingLeft", headerPaddingRight:"paddingRight", headerPaddingTop:"paddingTop", headerHorizontalAlign:"horizontalAlign", headerHorizontalGap:"horizontalGap", headerVerticalAlign:"verticalAlign", headerVerticalGap:"verticalGap"};

        public function WidgetView()
        {
            focusEnabled = false;
            tabEnabled = false;
            tabChildren = false;
            return;
        }// end function

        public function set measuredMaxHeight(param1:Number) : void
        {
            this.m_MeasuredMaxHeight = param1;
            return;
        }// end function

        function invalidateWidgetInstance() : void
        {
            this.m_UncommittedWidgetInstance = true;
            invalidateProperties();
            return;
        }// end function

        function set widgetHeight(param1:Number) : void
        {
            if (this.m_WidgetHeight != param1)
            {
                this.m_WidgetHeight = param1;
                this.m_UncommittedWidgetHeight = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        protected function getFooterHeight() : Number
        {
            if (mx_internal::border is WidgetViewSkin)
            {
                return WidgetViewSkin(mx_internal::border).footerHeight;
            }
            return viewMetrics.bottom;
        }// end function

        function get widgetRequiredHeight() : Number
        {
            if (this.m_WidgetCollapsible)
            {
                return this.getHeaderHeight();
            }
            if (this.m_WidgetResizable && !isNaN(explicitMinHeight))
            {
                return explicitMinHeight;
            }
            if (this.m_WidgetResizable && !isNaN(measuredMinHeight))
            {
                return measuredMinHeight;
            }
            return getExplicitOrMeasuredHeight();
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIHeader = new HBox();
                this.m_UIHeader.doubleClickEnabled = true;
                this.m_UIHeader.horizontalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIHeader.percentHeight = NaN;
                this.m_UIHeader.percentWidth = 100;
                this.m_UIHeader.styleName = new StyleProxy(this, HEADER_STYLE_FILTER);
                this.m_UIHeader.verticalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIHeader.addEventListener(MouseEvent.DOUBLE_CLICK, this.onHeaderDoubleClick);
                rawChildren.addChild(this.m_UIHeader);
                this.m_UITitleLabel = new CustomLabel();
                this.m_UITitleLabel.percentHeight = NaN;
                this.m_UITitleLabel.percentWidth = 100;
                this.m_UITitleLabel.styleName = new StyleProxy(this, TITLE_LABEL_STYLE_FILTER);
                this.setFilteredStyles(this.m_UITitleLabel, TITLE_LABEL_STYLE_FILTER);
                this.m_UIHeader.addChild(this.m_UITitleLabel);
                this.m_UICollapseButton = new CustomButton();
                this.m_UICollapseButton.toggle = true;
                this.m_UICollapseButton.selected = this.m_WidgetCollapsed;
                this.m_UICollapseButton.styleName = getStyle("collapseButtonStyle");
                this.m_UICollapseButton.addEventListener(MouseEvent.CLICK, this.onHeaderClick);
                this.m_UIHeader.addChild(this.m_UICollapseButton);
                this.m_UICloseButton = new CustomButton();
                this.m_UICloseButton.styleName = getStyle("closeButtonStyle");
                this.m_UICloseButton.addEventListener(MouseEvent.CLICK, this.onHeaderClick);
                this.m_UIHeader.addChild(this.m_UICloseButton);
                this.m_UIFooter = new HBox();
                this.m_UIFooter.horizontalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIFooter.percentHeight = NaN;
                this.m_UIFooter.percentWidth = 100;
                this.m_UIFooter.styleName = new StyleProxy(this, FOOTER_STYLE_FILTER);
                this.m_UIFooter.verticalScrollPolicy = ScrollPolicy.OFF;
                rawChildren.addChild(this.m_UIFooter);
                this.titleIcon = this.getStyleInstance("iconImage");
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        function hitTestDragHandle(param1:Number, param2:Number) : Boolean
        {
            var _loc_3:* = globalToLocal(new Point(param1, param2));
            return this.m_WidgetInstance.draggable && _loc_3.x >= 0 && _loc_3.x < width && _loc_3.y >= 0 && _loc_3.y < this.getHeaderHeight();
        }// end function

        function get widgetCollapsible() : Boolean
        {
            return this.m_WidgetCollapsible;
        }// end function

        function set options(param1:OptionsStorage) : void
        {
            if (this.m_Options != param1)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_Options = param1;
                if (this.m_Options != null)
                {
                    this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.commitOptions();
            }
            return;
        }// end function

        function get widgetSuggestedHeight() : Number
        {
            if (this.widgetCollapsed)
            {
                return this.getHeaderHeight();
            }
            return getExplicitOrMeasuredHeight();
        }// end function

        public function set titleText(param1:String) : void
        {
            if (this.m_Title != param1)
            {
                this.m_Title = param1;
                this.m_UncommittedTitle = true;
                invalidateProperties();
            }
            return;
        }// end function

        function get widgetClosable() : Boolean
        {
            return this.m_WidgetClosable;
        }// end function

        function set widgetCollapsible(param1:Boolean) : void
        {
            if (this.m_WidgetCollapsible != param1)
            {
                this.m_WidgetCollapsible = param1;
                this.m_UncommittedWidgetCollapsible = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            return;
        }// end function

        public function set measuredMaxWidth(param1:Number) : void
        {
            this.m_MeasuredMaxWidth = param1;
            return;
        }// end function

        private function onHeaderDoubleClick(event:MouseEvent) : void
        {
            if (this.widgetInstance != null && this.widgetInstance.collapsible)
            {
                this.widgetInstance.collapsed = !this.widgetInstance.collapsed;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = viewMetricsAndPadding;
            var _loc_2:* = getStyle("verticalGap");
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = numChildren;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (_loc_5 > 0)
            {
                if (direction == BoxDirection.VERTICAL)
                {
                    var _loc_8:* = -_loc_2;
                    _loc_7 = -_loc_2;
                    _loc_6 = _loc_8;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_5)
                    {
                        
                        _loc_3 = UIComponent(getChildAt(_loc_4));
                        _loc_6 = _loc_6 + (_loc_3.getExplicitOrMeasuredHeight() + _loc_2);
                        _loc_7 = _loc_7 + (_loc_2 + (!isNaN(_loc_3.explicitMinHeight) ? (_loc_3.explicitMinHeight) : (_loc_3.measuredMinHeight)));
                        _loc_4++;
                    }
                }
                else
                {
                    _loc_4 = 0;
                    while (_loc_4 < _loc_5)
                    {
                        
                        _loc_3 = UIComponent(getChildAt(_loc_4));
                        _loc_6 = Math.max(_loc_6, _loc_3.getExplicitOrMeasuredHeight());
                        _loc_7 = Math.max(_loc_7, !isNaN(_loc_3.explicitMinHeight) ? (_loc_3.explicitMinHeight) : (_loc_3.measuredMinHeight));
                        _loc_4++;
                    }
                }
            }
            _loc_6 = _loc_6 + (_loc_1.top + _loc_1.bottom);
            _loc_7 = _loc_7 + (_loc_1.top + _loc_1.bottom);
            measuredMinWidth = DEFAULT_WIDGET_WIDTH;
            measuredWidth = DEFAULT_WIDGET_WIDTH;
            measuredMinHeight = Math.max(_loc_7, this.header.getExplicitOrMeasuredHeight());
            measuredHeight = Math.max(_loc_7, _loc_6);
            return;
        }// end function

        function hitTestResizeHandle(param1:Number, param2:Number) : Boolean
        {
            var _loc_3:* = globalToLocal(new Point(param1, param2));
            return !this.m_WidgetCollapsed && _loc_3.x >= 0 && _loc_3.x < width && _loc_3.y >= height - this.getFooterHeight() && _loc_3.y < height;
        }// end function

        protected function commitOptions() : void
        {
            return;
        }// end function

        override public function setStyle(param1:String, param2) : void
        {
            if (TITLE_LABEL_STYLE_FILTER[param1] != null)
            {
                this.m_UITitleLabel.setStyle(TITLE_LABEL_STYLE_FILTER[param1], param2);
            }
            else
            {
                super.setStyle(param1, param2);
            }
            return;
        }// end function

        function get widgetCollapsed() : Boolean
        {
            return this.m_WidgetCollapsed;
        }// end function

        function resizeWidgetDelta(param1:Number, param2:Boolean) : Number
        {
            return this.resizeWidgetAbsolute(getExplicitOrMeasuredHeight() + param1, param2);
        }// end function

        protected function getHeaderHeight() : Number
        {
            if (mx_internal::border is WidgetViewSkin)
            {
                return WidgetViewSkin(mx_internal::border).headerHeight;
            }
            return viewMetrics.top;
        }// end function

        function get widgetHeight() : Number
        {
            return this.m_WidgetHeight;
        }// end function

        public function get measuredMaxHeight() : Number
        {
            return this.m_MeasuredMaxHeight;
        }// end function

        protected function get header() : Container
        {
            return this.m_UIHeader;
        }// end function

        function set widgetResizable(param1:Boolean) : void
        {
            if (this.m_WidgetResizable != param1)
            {
                this.m_WidgetResizable = param1;
                this.m_UncommittedWidgetResizable = true;
                invalidateProperties();
            }
            return;
        }// end function

        function set widgetClosable(param1:Boolean) : void
        {
            if (this.m_WidgetClosable != param1)
            {
                this.m_WidgetClosable = param1;
                this.m_UncommittedWidgetClosable = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function get footer() : Container
        {
            return this.m_UIFooter;
        }// end function

        private function onHeaderClick(event:MouseEvent) : void
        {
            if (this.widgetInstance != null)
            {
                if (event.currentTarget == this.m_UICloseButton)
                {
                    if (this.widgetInstance.closable)
                    {
                        this.widgetInstance.close();
                    }
                }
                else if (event.currentTarget == this.m_UICollapseButton)
                {
                    if (this.widgetInstance.collapsible)
                    {
                        this.widgetInstance.collapsed = !this.widgetInstance.collapsed;
                    }
                }
            }
            return;
        }// end function

        function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        function set widgetClosed(param1:Boolean) : void
        {
            if (this.m_WidgetClosed != param1)
            {
                this.m_WidgetClosed = param1;
                this.m_UncommittedWidgetClosed = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function get unscaledInnerWidth() : Number
        {
            var _loc_1:* = viewMetricsAndPadding;
            return DEFAULT_WIDGET_WIDTH - _loc_1.left - _loc_1.right;
        }// end function

        public function get titleText() : String
        {
            return this.m_Title;
        }// end function

        public function get measuredMaxWidth() : Number
        {
            return this.m_MeasuredMaxWidth;
        }// end function

        function resizeWidgetAbsolute(param1:Number, param2:Boolean) : Number
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            if (this.m_WidgetClosed || this.m_WidgetCollapsed || !this.m_WidgetResizable)
            {
                return 0;
            }
            _loc_3 = NaN;
            if (!isNaN(explicitMinHeight))
            {
                _loc_3 = explicitMinHeight;
            }
            else if (!isNaN(measuredMinHeight))
            {
                _loc_3 = measuredMinHeight;
            }
            else
            {
                _loc_3 = this.getHeaderHeight();
            }
            _loc_4 = NaN;
            if (!isNaN(explicitMaxHeight))
            {
                _loc_4 = explicitMaxHeight;
            }
            else if (!isNaN(this.measuredMaxHeight))
            {
                _loc_4 = this.measuredMaxHeight;
            }
            else
            {
                _loc_4 = measuredHeight;
            }
            _loc_5 = getExplicitOrMeasuredHeight();
            _loc_6 = NaN;
            _loc_7 = 0;
            if (_loc_5 >= _loc_4)
            {
                _loc_6 = Math.max(_loc_3, param1);
                if (_loc_6 < _loc_5)
                {
                    explicitHeight = _loc_6;
                    _loc_7 = _loc_6 - _loc_5;
                }
            }
            else
            {
                _loc_6 = Math.max(_loc_3, Math.min(param1, _loc_4));
                explicitHeight = _loc_6;
                _loc_7 = _loc_6 - _loc_5;
            }
            if (param2)
            {
                this.m_WidgetInstance.height = _loc_6;
            }
            return _loc_7;
        }// end function

        private function getStyleInstance(param1:String) : IFlexDisplayObject
        {
            var _loc_2:* = getStyle(param1) as Class;
            var _loc_3:* = null;
            if (_loc_2 != null)
            {
                _loc_3 = IFlexDisplayObject(new _loc_2);
            }
            return _loc_3;
        }// end function

        function releaseInstance() : void
        {
            this.m_UICollapseButton.removeEventListener(MouseEvent.CLICK, this.onHeaderClick);
            this.m_UICloseButton.removeEventListener(MouseEvent.CLICK, this.onHeaderClick);
            this.m_UIHeader.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onHeaderDoubleClick);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            if (this.m_UncommittedWidgetClosable)
            {
                this.m_UICloseButton.enabled = this.m_WidgetClosable;
                this.m_UncommittedWidgetClosable = false;
            }
            if (this.m_UncommittedWidgetClosed)
            {
                this.m_UncommittedWidgetClosed = false;
            }
            if (this.m_UncommittedWidgetCollapsed)
            {
                if (this.m_WidgetCollapsed)
                {
                    explicitHeight = this.getHeaderHeight();
                }
                else
                {
                    var _loc_1:* = this.m_WidgetHeight;
                    explicitHeight = this.m_WidgetHeight;
                    height = _loc_1;
                }
                this.m_UICollapseButton.selected = this.m_WidgetCollapsed;
                this.m_UIFooter.visible = !this.m_WidgetCollapsed;
                this.m_UncommittedWidgetCollapsed = false;
            }
            if (this.m_UncommittedWidgetCollapsible)
            {
                this.m_UICollapseButton.enabled = this.m_WidgetCollapsible;
                this.m_UncommittedWidgetCollapsible = false;
            }
            if (this.m_UncommittedWidgetHeight)
            {
                if (this.m_WidgetCollapsed)
                {
                    explicitHeight = this.getHeaderHeight();
                }
                else
                {
                    explicitHeight = this.m_WidgetHeight;
                }
                this.m_UICollapseButton.selected = this.m_WidgetCollapsed;
                this.m_UIFooter.visible = !this.m_WidgetCollapsed;
                this.m_UncommittedWidgetHeight = false;
            }
            if (this.m_UncommittedWidgetInstance)
            {
                this.m_UncommittedWidgetInstance = false;
            }
            if (this.m_UncommittedWidgetResizable)
            {
                this.m_UncommittedWidgetResizable = false;
            }
            super.commitProperties();
            if (this.m_UncommittedTitle)
            {
                this.m_UITitleLabel.text = this.m_Title;
                this.m_UncommittedTitle = false;
            }
            return;
        }// end function

        function get widgetResizable() : Boolean
        {
            return this.m_WidgetResizable;
        }// end function

        function get widgetClosed() : Boolean
        {
            return this.m_WidgetClosed;
        }// end function

        private function setFilteredStyles(param1:IStyleClient, param2:Object) : void
        {
            var _loc_3:* = null;
            for (_loc_3 in param2)
            {
                
                if (_loc_5[_loc_3] != null)
                {
                    param1.setStyle(_loc_5[_loc_3], getStyle(_loc_3));
                }
            }
            return;
        }// end function

        public function set titleIcon(param1:IFlexDisplayObject) : void
        {
            var _loc_2:* = null;
            if (this.m_UITitleIcon != param1)
            {
                _loc_2 = rawChildren.getChildByName("iconImage");
                if (_loc_2 != null)
                {
                    rawChildren.removeChild(_loc_2);
                }
                this.m_UITitleIcon = param1;
                if (this.m_UITitleIcon == null)
                {
                    this.m_UITitleIcon = this.getStyleInstance("iconImage");
                }
                if (this.m_UITitleIcon != null)
                {
                    this.m_UITitleIcon.name = "iconImage";
                    rawChildren.addChild(DisplayObject(this.m_UITitleIcon));
                }
            }
            return;
        }// end function

        public function get unscaledInnerHeight() : Number
        {
            var _loc_1:* = viewMetricsAndPadding;
            return unscaledHeight - _loc_1.top - _loc_1.bottom;
        }// end function

        function set widgetCollapsed(param1:Boolean) : void
        {
            if (this.m_WidgetCollapsed != param1)
            {
                this.m_WidgetCollapsed = param1;
                this.m_UncommittedWidgetCollapsed = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function get titleIcon() : IFlexDisplayObject
        {
            return this.m_UITitleIcon;
        }// end function

        function set widgetInstance(param1:Widget) : void
        {
            if (this.m_WidgetInstance != param1)
            {
                this.m_WidgetInstance = param1;
                this.m_UncommittedWidgetInstance = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (mx_internal::border is WidgetViewSkin)
            {
                _loc_7 = WidgetViewSkin(mx_internal::border).headerHeight;
                _loc_8 = WidgetViewSkin(mx_internal::border).footerHeight;
            }
            else
            {
                _loc_7 = viewMetrics.top;
                _loc_8 = viewMetrics.bottom;
            }
            if (this.m_UITitleIcon != null)
            {
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_5 = param1;
                _loc_6 = _loc_7;
                if (getStyle("iconLeft") !== undefined)
                {
                    _loc_3 = getStyle("iconLeft");
                }
                if (getStyle("iconTop") !== undefined)
                {
                    _loc_4 = getStyle("iconTop");
                }
                if (getStyle("iconWidth") !== undefined)
                {
                    _loc_5 = getStyle("iconWidth");
                }
                if (getStyle("iconHeight") !== undefined)
                {
                    _loc_6 = getStyle("iconHeight");
                }
                _loc_3 = Math.max(0, Math.min(_loc_3, param1));
                _loc_4 = Math.max(0, Math.min(_loc_4, _loc_7));
                _loc_5 = Math.max(0, Math.min(_loc_5, param1 - _loc_3));
                _loc_6 = Math.max(0, Math.min(_loc_6, _loc_7 - _loc_4));
                this.m_UITitleIcon.move(_loc_3 + (_loc_5 - this.m_UITitleIcon.measuredWidth) / 2, _loc_4 + (_loc_6 - this.m_UITitleIcon.measuredHeight) / 2);
                this.m_UITitleIcon.setActualSize(this.m_UITitleIcon.measuredWidth, this.m_UITitleIcon.measuredHeight);
            }
            _loc_3 = 0;
            _loc_4 = 0;
            _loc_5 = param1;
            _loc_6 = _loc_7;
            if (getStyle("headerLeft") !== undefined)
            {
                _loc_3 = getStyle("headerLeft");
            }
            if (getStyle("headerTop") !== undefined)
            {
                _loc_4 = getStyle("headerTop");
            }
            if (getStyle("headerWidth") !== undefined)
            {
                _loc_5 = getStyle("headerWidth");
            }
            if (getStyle("headerHeight") !== undefined)
            {
                _loc_6 = getStyle("headerHeight");
            }
            _loc_3 = Math.max(0, Math.min(_loc_3, param1));
            _loc_4 = Math.max(0, Math.min(_loc_4, _loc_7));
            _loc_5 = Math.max(0, Math.min(_loc_5, param1 - _loc_3));
            _loc_6 = Math.max(0, Math.min(_loc_6, _loc_7 - _loc_4));
            this.m_UIHeader.move(_loc_3, _loc_4);
            this.m_UIHeader.setActualSize(_loc_5, _loc_6);
            _loc_3 = 0;
            _loc_4 = 0;
            _loc_5 = param1;
            _loc_6 = _loc_8;
            if (getStyle("footerLeft") !== undefined)
            {
                _loc_3 = getStyle("footerLeft");
            }
            if (getStyle("footerTop") !== undefined)
            {
                _loc_4 = getStyle("footerTop");
            }
            if (getStyle("footerWidth") !== undefined)
            {
                _loc_5 = getStyle("footerWidth");
            }
            if (getStyle("footerHeight") !== undefined)
            {
                _loc_6 = getStyle("footerHeight");
            }
            _loc_3 = Math.max(0, Math.min(_loc_3, param1));
            _loc_4 = Math.max(0, Math.min(_loc_4, _loc_8));
            _loc_5 = Math.max(0, Math.min(_loc_5, param1 - _loc_3));
            _loc_6 = Math.max(0, Math.min(_loc_6, _loc_8 - _loc_4));
            this.m_UIFooter.move(_loc_3, param2 - _loc_8 + _loc_4);
            this.m_UIFooter.setActualSize(_loc_5, _loc_6);
            return;
        }// end function

        function get widgetInstance() : Widget
        {
            return this.m_WidgetInstance;
        }// end function

        override public function get borderMetrics() : EdgeMetrics
        {
            if (mx_internal::border is IBorder)
            {
                return IBorder(mx_internal::border).borderMetrics;
            }
            return EdgeMetrics.EMPTY;
        }// end function

        private static function s_InitializeStyle() : void
        {
            var Decl:* = StyleManager.getStyleDeclaration("WidgetView");
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.iconLeft = 0;
                this.iconTop = 0;
                this.iconWidth = 0;
                this.iconHeight = 0;
                this.iconImage = undefined;
                this.headerLeft = 0;
                this.headerTop = 0;
                this.headerWidth = 0;
                this.headerHeight = 0;
                this.titleFontFamily = undefined;
                this.titleFontWeight = undefined;
                this.titleFontSize = undefined;
                this.titleFontColor = undefined;
                this.footerTop = 0;
                this.footerLeft = 0;
                this.footerWidth = 0;
                this.footerHeight = 0;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration("WidgetView", Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}
