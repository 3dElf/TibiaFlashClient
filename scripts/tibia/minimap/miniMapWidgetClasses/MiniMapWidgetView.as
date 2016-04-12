package tibia.minimap.miniMapWidgetClasses
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.managers.*;
    import shared.controls.*;
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.cursors.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.input.mapping.*;
    import tibia.minimap.*;
    import tibia.options.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class MiniMapWidgetView extends WidgetView
    {
        private var m_MouseCursorOverWidget:Boolean = false;
        private var m_UncommittedZoom:Boolean = false;
        protected var m_Zoom:int = 0;
        protected var m_UIButtonEast:Button = null;
        private var m_UncommittedMiniMapStorage:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIButtonSouth:Button = null;
        private var m_UncommittedHighlightEnd:Boolean = false;
        protected var m_HighlightEnd:Number = 0;
        protected var m_UIButtonDown:Button = null;
        protected var m_UIButtonUp:Button = null;
        protected var m_UIButtonWest:Button = null;
        private var m_UncommittedPosition:Boolean = false;
        protected var m_PositionX:int = -1;
        protected var m_PositionY:int = -1;
        protected var m_PositionZ:int = -1;
        protected var m_UIButtonZoomOut:Button = null;
        private var m_CursorHelper:CursorHelper;
        protected var m_MiniMapStorage:MiniMapStorage = null;
        protected var m_UIView:MiniMapRenderer = null;
        protected var m_UIButtonCenter:Button = null;
        protected var m_UIButtonNorth:Button = null;
        protected var m_UIButtonZoomIn:Button = null;
        private static const ACTION_UNSET:int = -1;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        private static const ACTION_USE_OR_OPEN:int = 101;
        private static const WIDGET_VIEW_HEIGHT:Number = 108;
        private static const ACTION_SMARTCLICK:int = 100;
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        private static const ACTION_LOOK:int = 6;
        public static const BUNDLE:String = "MiniMapWidget";
        private static const ACTION_TALK:int = 9;
        private static const VALID_ACTIONS:Vector.<uint> = MiniMapWidgetView.Vector.<uint>([ACTION_AUTOWALK, ACTION_CONTEXT_MENU]);
        private static const ACTION_USE:int = 7;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        private static const ACTION_NONE:int = 0;
        private static const WIDGET_VIEW_WIDTH:Number = 176;
        private static const ACTION_AUTOWALK:int = 3;
        private static const WIDGET_COMPONENT_POSITIONS:Array = [{left:1, top:1, width:NaN, height:NaN}, {left:158, top:23, width:NaN, height:NaN}, {left:133, top:8, width:NaN, height:NaN}, {left:118, top:23, width:NaN, height:NaN}, {left:133, top:48, width:NaN, height:NaN}, {left:122, top:71, width:NaN, height:NaN}, {left:122, top:91, width:NaN, height:NaN}, {left:150, top:72, width:NaN, height:NaN}, {left:151, top:95, width:NaN, height:NaN}, {left:134, top:24, width:NaN, height:NaN}];
        private static const ACTION_ATTACK:int = 1;
        private static const ACTION_OPEN:int = 8;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
        private static const ACTION_CONTEXT_MENU:int = 5;
        private static var m_TempPoint:Point = new Point();
        private static const ACTION_ATTACK_OR_TALK:int = 102;

        public function MiniMapWidgetView()
        {
            this.m_CursorHelper = new CursorHelper(CursorManagerPriority.MEDIUM);
            titleText = resourceManager.getString(BUNDLE, "TITLE");
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            Tibia.s_GetInputHandler().addEventListener(ModifierKeyEvent.MODIFIER_KEYS_CHANGED, this.onModifierKeyEvent);
            return;
        }// end function

        function get highlightEnd() : Number
        {
            return this.m_HighlightEnd;
        }// end function

        protected function onButtonClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (event != null && widgetInstance is MiniMapWidget)
            {
                _loc_2 = MiniMapWidget(widgetInstance);
                _loc_3 = 1;
                if (event.shiftKey)
                {
                    _loc_3 = 10;
                }
                switch(event.currentTarget)
                {
                    case this.m_UIButtonEast:
                    {
                        _loc_2.translatePosition(_loc_3, 0, 0);
                        break;
                    }
                    case this.m_UIButtonNorth:
                    {
                        _loc_2.translatePosition(0, -_loc_3, 0);
                        break;
                    }
                    case this.m_UIButtonWest:
                    {
                        _loc_2.translatePosition(-_loc_3, 0, 0);
                        break;
                    }
                    case this.m_UIButtonSouth:
                    {
                        _loc_2.translatePosition(0, _loc_3, 0);
                        break;
                    }
                    case this.m_UIButtonUp:
                    {
                        _loc_2.translatePosition(0, 0, -1);
                        break;
                    }
                    case this.m_UIButtonDown:
                    {
                        _loc_2.translatePosition(0, 0, 1);
                        break;
                    }
                    case this.m_UIButtonZoomIn:
                    {
                        (_loc_2.zoom + 1);
                        break;
                    }
                    case this.m_UIButtonZoomOut:
                    {
                        (_loc_2.zoom - 1);
                        break;
                    }
                    case this.m_UIButtonCenter:
                    {
                        _loc_2.centerPosition();
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIView = new MiniMapRenderer();
                this.m_UIView.addEventListener(MouseEvent.CLICK, this.onViewClick);
                this.m_UIView.addEventListener(MouseEvent.RIGHT_CLICK, this.onViewClick);
                this.m_UIView.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
                this.m_UIView.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
                this.m_UIView.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
                addChild(this.m_UIView);
                this.m_UIButtonEast = new CustomButton();
                this.m_UIButtonEast.styleName = getStyle("buttonEastStyle");
                this.m_UIButtonEast.toolTip = resourceManager.getString(BUNDLE, "BTN_TOOLTIP_EAST");
                this.m_UIButtonEast.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                addChild(this.m_UIButtonEast);
                this.m_UIButtonNorth = new CustomButton();
                this.m_UIButtonNorth.styleName = getStyle("buttonNorthStyle");
                this.m_UIButtonNorth.toolTip = resourceManager.getString(BUNDLE, "BTN_TOOLTIP_NORTH");
                this.m_UIButtonNorth.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                addChild(this.m_UIButtonNorth);
                this.m_UIButtonWest = new CustomButton();
                this.m_UIButtonWest.styleName = getStyle("buttonWestStyle");
                this.m_UIButtonWest.toolTip = resourceManager.getString(BUNDLE, "BTN_TOOLTIP_WEST");
                this.m_UIButtonWest.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                addChild(this.m_UIButtonWest);
                this.m_UIButtonSouth = new CustomButton();
                this.m_UIButtonSouth.styleName = getStyle("buttonSouthStyle");
                this.m_UIButtonSouth.toolTip = resourceManager.getString(BUNDLE, "BTN_TOOLTIP_SOUTH");
                this.m_UIButtonSouth.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                addChild(this.m_UIButtonSouth);
                this.m_UIButtonUp = new CustomButton();
                this.m_UIButtonUp.styleName = getStyle("buttonUpStyle");
                this.m_UIButtonUp.toolTip = resourceManager.getString(BUNDLE, "BTN_TOOLTIP_UP");
                this.m_UIButtonUp.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                addChild(this.m_UIButtonUp);
                this.m_UIButtonDown = new CustomButton();
                this.m_UIButtonDown.styleName = getStyle("buttonDownStyle");
                this.m_UIButtonDown.toolTip = resourceManager.getString(BUNDLE, "BTN_TOOLTIP_DOWN");
                this.m_UIButtonDown.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                addChild(this.m_UIButtonDown);
                this.m_UIButtonZoomIn = new CustomButton();
                this.m_UIButtonZoomIn.styleName = getStyle("buttonZoomInStyle");
                this.m_UIButtonZoomIn.toolTip = resourceManager.getString(BUNDLE, "BTN_TOOLTIP_ZOOMIN");
                this.m_UIButtonZoomIn.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                addChild(this.m_UIButtonZoomIn);
                this.m_UIButtonZoomOut = new CustomButton();
                this.m_UIButtonZoomOut.styleName = getStyle("buttonZoomOutStyle");
                this.m_UIButtonZoomOut.toolTip = resourceManager.getString(BUNDLE, "BTN_TOOLTIP_ZOOMOUT");
                this.m_UIButtonZoomOut.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                addChild(this.m_UIButtonZoomOut);
                this.m_UIButtonCenter = new CustomButton();
                this.m_UIButtonCenter.styleName = getStyle("buttonCenterStyle");
                this.m_UIButtonCenter.toolTip = resourceManager.getString(BUNDLE, "BTN_TOOLTIP_CENTER");
                this.m_UIButtonCenter.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                addChild(this.m_UIButtonCenter);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        function set highlightEnd(param1:Number) : void
        {
            if (this.m_HighlightEnd != param1)
            {
                this.m_HighlightEnd = param1;
                this.m_UncommittedHighlightEnd = true;
                invalidateProperties();
            }
            return;
        }// end function

        function set zoom(param1:int) : void
        {
            if (this.m_Zoom != param1)
            {
                this.m_Zoom = param1;
                this.m_UncommittedZoom = true;
                invalidateProperties();
            }
            return;
        }// end function

        function setPosition(param1:int, param2:int, param3:int) : void
        {
            if (this.m_PositionX != param1 || this.m_PositionY != param2 || this.m_PositionZ != param3)
            {
                this.m_PositionX = param1;
                this.m_PositionY = param2;
                this.m_PositionZ = param3;
                this.m_UncommittedPosition = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onRollOut(event:MouseEvent) : void
        {
            this.m_MouseCursorOverWidget = false;
            this.m_CursorHelper.resetCursor();
            return;
        }// end function

        function get miniMapStorage() : MiniMapStorage
        {
            return this.m_MiniMapStorage;
        }// end function

        protected function onViewMouseEvent(event:MouseEvent) : void
        {
            if (event != null && widgetInstance is MiniMapWidget && m_Options != null && m_Options.mouseMapping != null && m_Options.mouseMapping.showMouseCursorForAction && ContextMenuBase.getCurrent() == null && PopUpBase.getCurrent() == null)
            {
                this.determineAction(event, false, true);
            }
            else
            {
                this.m_CursorHelper.resetCursor();
            }
            return;
        }// end function

        public function releaseInstance() : void
        {
            super.releaseInstance();
            this.m_UIButtonCenter.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.m_UIButtonDown.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.m_UIButtonEast.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.m_UIButtonNorth.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.m_UIButtonSouth.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.m_UIButtonUp.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.m_UIButtonWest.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.m_UIButtonZoomIn.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.m_UIButtonZoomOut.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.m_UIView.removeEventListener(MouseEvent.CLICK, this.onViewClick);
            this.m_UIView.removeEventListener(MouseEvent.RIGHT_CLICK, this.onViewClick);
            this.m_UIView.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            Tibia.s_GetInputHandler().removeEventListener(ModifierKeyEvent.MODIFIER_KEYS_CHANGED, this.onModifierKeyEvent);
            return;
        }// end function

        protected function onViewClick(event:MouseEvent) : void
        {
            this.determineAction(event, true, false);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedMiniMapStorage)
            {
                this.m_UIView.miniMapStorage = this.miniMapStorage;
                this.m_UncommittedMiniMapStorage = false;
            }
            if (this.m_UncommittedPosition)
            {
                this.m_UIView.setPosition(this.positionX, this.positionY, this.positionZ);
                this.m_UncommittedPosition = false;
            }
            if (this.m_UncommittedZoom)
            {
                this.m_UIView.zoom = this.zoom;
                this.m_UncommittedZoom = false;
            }
            if (this.m_UncommittedHighlightEnd)
            {
                this.m_UIView.highlightEnd = this.highlightEnd;
                this.m_UncommittedHighlightEnd = false;
            }
            return;
        }// end function

        function get positionX() : int
        {
            return this.m_PositionX;
        }// end function

        function get positionZ() : int
        {
            return this.m_PositionZ;
        }// end function

        function get zoom() : int
        {
            return this.m_Zoom;
        }// end function

        function get positionY() : int
        {
            return this.m_PositionY;
        }// end function

        function set miniMapStorage(param1:MiniMapStorage) : void
        {
            if (this.m_MiniMapStorage != param1)
            {
                this.m_MiniMapStorage = param1;
                this.m_UncommittedMiniMapStorage = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function onModifierKeyEvent(event:ModifierKeyEvent) : void
        {
            this.determineAction(null, false, true);
            return;
        }// end function

        protected function onMouseWheel(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event != null && widgetInstance is MiniMapWidget)
            {
                _loc_2 = MiniMapWidget(widgetInstance);
                if (event.delta > 0)
                {
                    (_loc_2.zoom + 1);
                }
                else if (event.delta < 0)
                {
                    (_loc_2.zoom - 1);
                }
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = viewMetricsAndPadding;
            var _loc_2:* = _loc_1.left + WIDGET_VIEW_WIDTH + _loc_1.right;
            measuredWidth = _loc_1.left + WIDGET_VIEW_WIDTH + _loc_1.right;
            measuredMinWidth = _loc_2;
            var _loc_2:* = _loc_1.top + WIDGET_VIEW_HEIGHT + _loc_1.bottom;
            measuredHeight = _loc_1.top + WIDGET_VIEW_HEIGHT + _loc_1.bottom;
            measuredMinHeight = _loc_2;
            return;
        }// end function

        protected function determineAction(event:MouseEvent, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (this.m_MouseCursorOverWidget == false)
            {
                return;
            }
            var _loc_4:* = Tibia.s_GetOptions();
            var _loc_5:* = Tibia.s_GetInputHandler();
            var _loc_6:* = null;
            var _loc_7:* = ACTION_NONE;
            if (!(widgetInstance is MiniMapWidget))
            {
                return;
            }
            if (event != null)
            {
                m_TempPoint.setTo(event.localX, event.localY);
            }
            else
            {
                m_TempPoint.setTo(this.mouseX, this.mouseY);
            }
            var _loc_8:* = this.m_UIView.pointToMark(m_TempPoint.x, m_TempPoint.y);
            if (this.m_UIView.pointToMark(m_TempPoint.x, m_TempPoint.y) != null)
            {
                _loc_6 = new Vector3D(_loc_8.x, _loc_8.y, _loc_8.z);
            }
            else
            {
                _loc_6 = this.m_UIView.pointToAbsolute(m_TempPoint.x, m_TempPoint.y);
            }
            var _loc_9:* = null;
            if (event != null)
            {
                if (event is MouseClickBothEvent)
                {
                    _loc_9 = _loc_4.mouseMapping.findBindingByMouseEvent(event);
                }
                else if (_loc_5.isModifierKeyPressed(event) == false && (event.type == MouseEvent.CLICK || event.type == MouseEvent.ROLL_OVER))
                {
                    _loc_7 = ACTION_AUTOWALK;
                }
                else if (event.type == MouseEvent.RIGHT_CLICK && _loc_5.isModifierKeyPressed(event) == false)
                {
                    _loc_7 = ACTION_CONTEXT_MENU;
                }
                else
                {
                    _loc_9 = _loc_4.mouseMapping.findBindingByMouseEvent(event);
                }
            }
            else if (_loc_5.isModifierKeyPressed())
            {
                _loc_9 = _loc_4.mouseMapping.findBindingForLeftMouseButtonAndPressedModifierKey();
            }
            else
            {
                _loc_7 = ACTION_AUTOWALK;
            }
            if (_loc_9 != null)
            {
                _loc_7 = _loc_9.action;
            }
            if (VALID_ACTIONS.indexOf(_loc_7) == -1)
            {
                _loc_7 = ACTION_NONE;
            }
            if (param3 && m_Options != null && m_Options.mouseMapping != null && m_Options.mouseMapping.showMouseCursorForAction)
            {
                this.m_CursorHelper.setCursor(MouseActionHelper.actionToMouseCursor(_loc_7));
            }
            if (param2 && _loc_6 != null)
            {
                switch(_loc_7)
                {
                    case ACTION_AUTOWALK:
                    {
                        _loc_10 = Tibia.s_GetPlayer();
                        if (_loc_10 != null)
                        {
                            _loc_12 = Tibia.s_GameActionFactory.createAutowalkAction(_loc_6.x, _loc_6.y, _loc_6.z, false, false);
                            _loc_12.perform();
                        }
                        break;
                    }
                    case ACTION_CONTEXT_MENU:
                    {
                        _loc_11 = MiniMapWidget(widgetInstance).miniMapStorage;
                        if (_loc_11 != null)
                        {
                            this.m_CursorHelper.resetCursor();
                            new MiniMapWidgetContextMenu(_loc_11, _loc_6.x, _loc_6.y, _loc_6.z).display(this, event.stageX, event.stageY);
                        }
                        break;
                    }
                    case ACTION_NONE:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = 0;
            while (_loc_3 < WIDGET_COMPONENT_POSITIONS.length)
            {
                
                _loc_4 = UIComponent(getChildAt(_loc_3));
                _loc_4.move(WIDGET_COMPONENT_POSITIONS[_loc_3].left, WIDGET_COMPONENT_POSITIONS[_loc_3].top);
                _loc_5 = WIDGET_COMPONENT_POSITIONS[_loc_3].width;
                _loc_6 = WIDGET_COMPONENT_POSITIONS[_loc_3].height;
                if (isNaN(_loc_5))
                {
                    _loc_5 = _loc_4.getExplicitOrMeasuredHeight();
                }
                if (isNaN(_loc_6))
                {
                    _loc_6 = _loc_4.getExplicitOrMeasuredWidth();
                }
                _loc_4.setActualSize(_loc_6, _loc_5);
                _loc_3++;
            }
            return;
        }// end function

        protected function onRollOver(event:MouseEvent) : void
        {
            this.m_MouseCursorOverWidget = true;
            if (event != null && widgetInstance is MiniMapWidget && m_Options != null && m_Options.mouseMapping != null && m_Options.mouseMapping.showMouseCursorForAction)
            {
                this.determineAction(event, false, true);
            }
            return;
        }// end function

    }
}
