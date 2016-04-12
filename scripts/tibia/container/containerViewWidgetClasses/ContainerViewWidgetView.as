package tibia.container.containerViewWidgetClasses
{
    import __AS3__.vec.*;
    import build.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;
    import shared.controls.*;
    import shared.skins.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.container.*;
    import tibia.cursors.*;
    import tibia.game.*;
    import tibia.help.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.input.mapping.*;
    import tibia.network.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class ContainerViewWidgetView extends WidgetView implements IUseWidget, IMoveWidget
    {
        private const m_DragHandler:ObjectDragImpl;
        private var m_Container:ContainerView = null;
        private var m_UISlotHolder:ContainerSlotHolder = null;
        private var m_UIPageLabel:Label = null;
        private var m_RolloverSlot:ContainerSlot = null;
        private var m_UIPageLeftButton:Button = null;
        private var m_UIPageFooter:HBox = null;
        private var m_CursorHelper:CursorHelper;
        private var m_UIPageRightButton:Button = null;
        private var m_TempVector:Vector3D;
        private var m_UncommittedContainer:Boolean = false;
        private var m_UIUpButton:Button = null;
        private static const BUNDLE:String = "ContainerViewWidget";
        private static const ACTION_SMARTCLICK:int = 100;
        static const DRAG_TYPE_CHANNEL:String = "channel";
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        private static const ACTION_TALK:int = 9;
        private static const ACTION_NONE:int = 0;
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        private static const ACTION_LOOK:int = 6;
        static const DRAG_TYPE_SPELL:String = "spell";
        static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
        private static const ACTION_OPEN:int = 8;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        private static const ACTION_UNSET:int = -1;
        private static const ACTION_ATTACK_OR_TALK:int = 102;
        private static const ACTION_USE_OR_OPEN:int = 101;
        static const DEFAULT_WIDGET_WIDTH:Number = 184;
        static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
        static const DRAG_TYPE_ACTION:String = "action";
        private static const SLOT_HOLDER_STYLE_FILTER:Object = {slotHorizontalAlign:"horizontalAlign", slotVerticalAlign:"verticalAlign", slotHorizontalGap:"horizontalGap", slotVerticalGap:"verticalGap", slotPaddingBottom:"paddingBottom", slotPaddingLeft:"paddingLeft", slotPaddingRight:"paddingRight", slotPaddingTop:"paddingTop"};
        static const DRAG_TYPE_OBJECT:String = "object";
        static const DRAG_OPACITY:Number = 0.75;
        private static const ACTION_AUTOWALK:int = 3;
        static const DEFAULT_WIDGET_HEIGHT:Number = 200;
        private static const ACTION_USE:int = 7;
        private static const ACTION_ATTACK:int = 1;
        private static const ACTION_CONTEXT_MENU:int = 5;
        private static const VALID_ACTIONS:Vector.<uint> = ContainerViewWidgetView.Vector.<uint>([ACTION_USE, ACTION_OPEN, ACTION_LOOK, ACTION_CONTEXT_MENU]);

        public function ContainerViewWidgetView()
        {
            this.m_DragHandler = ObjectDragImplFactory.s_CreateObjectDragImpl();
            this.m_CursorHelper = new CursorHelper(CursorManagerPriority.MEDIUM);
            this.m_TempVector = new Vector3D();
            direction = BoxDirection.VERTICAL;
            titleIcon = null;
            titleText = resourceManager.getString(BUNDLE, "TITLE");
            Tibia.s_GetInputHandler().addEventListener(ModifierKeyEvent.MODIFIER_KEYS_CHANGED, this.onModifierKeyEvent);
            Tibia.s_GetUIEffectsManager().addEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
            return;
        }// end function

        function get container() : ContainerView
        {
            return this.m_Container;
        }// end function

        function set container(param1:ContainerView) : void
        {
            if (param1 != this.m_Container)
            {
                if (this.m_Container != null)
                {
                    this.m_Container.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onContainerChanged);
                }
                this.m_Container = param1;
                if (this.m_Container != null)
                {
                    this.m_Container.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onContainerChanged);
                }
                this.m_UncommittedContainer = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        private function onSlotClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.target as ContainerSlot;
            _loc_2 = event.target as ContainerSlot;
            if (this.container != null && _loc_3 != null)
            {
                this.determineAction(event, true, false);
            }
            return;
        }// end function

        protected function onSlotRollOver(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.target as ContainerSlot;
            _loc_2 = event.target as ContainerSlot;
            if (this.container != null && _loc_3 != null)
            {
                this.m_RolloverSlot = _loc_2;
                this.determineAction(event, false, true);
            }
            return;
        }// end function

        private function onPageButtonClick(event:MouseEvent) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning && this.container != null)
            {
                if (event.currentTarget == this.m_UIPageLeftButton && this.container.indexOfFirstObject >= this.container.numberOfSlotsPerPage)
                {
                    _loc_2.sendCSEEKINCONTAINER(this.container.ID, this.container.indexOfFirstObject - this.container.numberOfSlotsPerPage);
                }
                else if (event.currentTarget == this.m_UIPageRightButton && this.container.indexOfFirstObject + this.container.numberOfSlotsPerPage < this.container.numberOfTotalObjects)
                {
                    _loc_2.sendCSEEKINCONTAINER(this.container.ID, this.container.indexOfFirstObject + this.container.numberOfSlotsPerPage);
                }
            }
            return;
        }// end function

        private function destroySlot(param1:int) : void
        {
            var _loc_2:* = ContainerSlot(this.m_UISlotHolder.removeChildAt(param1));
            _loc_2.appearance = null;
            _loc_2.removeEventListener(MouseEvent.CLICK, this.onSlotClick);
            _loc_2.removeEventListener(MouseEvent.MIDDLE_CLICK, this.onSlotClick);
            _loc_2.removeEventListener(MouseEvent.RIGHT_CLICK, this.onSlotClick);
            return;
        }// end function

        private function createSlot(param1:ObjectInstance = null, param2:int = -1) : ContainerSlot
        {
            var _loc_3:* = new ContainerSlot();
            _loc_3.appearance = param1;
            _loc_3.position = param2;
            _loc_3.styleName = getStyle("slotStyleName");
            _loc_3.addEventListener(MouseEvent.CLICK, this.onSlotClick);
            _loc_3.addEventListener(MouseEvent.MIDDLE_CLICK, this.onSlotClick);
            _loc_3.addEventListener(MouseEvent.RIGHT_CLICK, this.onSlotClick);
            _loc_3.addEventListener(MouseEvent.ROLL_OVER, this.onSlotRollOver);
            _loc_3.addEventListener(MouseEvent.MOUSE_MOVE, this.onSlotRollOver);
            _loc_3.addEventListener(MouseEvent.ROLL_OUT, this.onSlotRollOut);
            this.m_UISlotHolder.addChild(DisplayObject(_loc_3));
            return _loc_3;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIPageFooter = new HBox();
            this.m_UIPageFooter.percentWidth = 100;
            this.m_UIPageFooter.styleName = getStyle("pageFooterStyle");
            this.m_UIPageLeftButton = new CustomButton();
            this.m_UIPageLeftButton.styleName = getStyle("pageLeftButtonStyle");
            this.m_UIPageLeftButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onPageButtonDown);
            this.m_UIPageLeftButton.addEventListener(MouseEvent.CLICK, this.onPageButtonClick);
            this.m_UIPageLeftButton.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onPageButtonClick);
            this.m_UIPageLeftButton.setStyle("repeatDelay", 500);
            this.m_UIPageFooter.addChild(this.m_UIPageLeftButton);
            this.m_UIPageLabel = new CustomLabel();
            this.m_UIPageLabel.percentWidth = 100;
            this.m_UIPageLabel.setStyle("textAlign", "center");
            this.m_UIPageFooter.addChild(this.m_UIPageLabel);
            this.m_UIPageRightButton = new CustomButton();
            this.m_UIPageRightButton.styleName = getStyle("pageRightButtonStyle");
            this.m_UIPageRightButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onPageButtonDown);
            this.m_UIPageRightButton.addEventListener(MouseEvent.CLICK, this.onPageButtonClick);
            this.m_UIPageRightButton.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onPageButtonClick);
            this.m_UIPageRightButton.setStyle("repeatDelay", 500);
            this.m_UIPageFooter.addChild(this.m_UIPageRightButton);
            this.m_UISlotHolder = new ContainerSlotHolder();
            this.m_UISlotHolder.height = NaN;
            this.m_UISlotHolder.horizontalScrollPolicy = ScrollPolicy.OFF;
            this.m_UISlotHolder.percentWidth = NaN;
            this.m_UISlotHolder.percentHeight = 100;
            this.m_UISlotHolder.styleName = new StyleProxy(this, SLOT_HOLDER_STYLE_FILTER);
            this.m_UISlotHolder.verticalScrollPolicy = ScrollPolicy.ON;
            this.m_UISlotHolder.width = unscaledInnerWidth;
            this.m_UISlotHolder.addEventListener(DragEvent.DRAG_ENTER, this.onSlotHolderDragEnter, false, (EventPriority.DEFAULT + 1));
            this.m_UISlotHolder.setStyle("backgroundAlpha", 0);
            this.m_UISlotHolder.setStyle("backgroundColor", 65280);
            this.m_UISlotHolder.setStyle("borderAlpha", 0);
            this.m_UISlotHolder.setStyle("borderColor", 65280);
            this.m_UISlotHolder.setStyle("borderSkin", VectorBorderSkin);
            this.m_UISlotHolder.setStyle("borderThickness", 0);
            this.m_DragHandler.addDragComponent(this.m_UISlotHolder);
            addChild(this.m_UISlotHolder);
            this.m_UIUpButton = new CustomButton();
            this.m_UIUpButton.styleName = getStyle("upButtonStyle");
            this.m_UIUpButton.visible = this.container != null && this.container.isSubContainer;
            this.m_UIUpButton.addEventListener(MouseEvent.CLICK, this.onUpButtonClick);
            header.addChildAt(this.m_UIUpButton, header.numChildren - 2);
            return;
        }// end function

        private function onPageButtonDown(event:MouseEvent) : void
        {
            if (event is MouseRepeatEvent)
            {
                MouseRepeatEvent(event).repeatEnabled = true;
            }
            return;
        }// end function

        public function getMoveObjectUnderPoint(param1:Point) : Object
        {
            return this.getUseObjectUnderPoint(param1);
        }// end function

        public function getUseObjectUnderPoint(param1:Point) : Object
        {
            var _loc_2:* = null;
            var _loc_3:* = getClassInstanceUnderPoint(stage, param1, ContainerSlot);
            _loc_2 = getClassInstanceUnderPoint(stage, param1, ContainerSlot);
            if (this.container != null && _loc_3 != null)
            {
                return {object:_loc_2.appearance, absolute:new Vector3D(65535, 64 + this.container.ID, _loc_2.position), position:_loc_2.position};
            }
            return null;
        }// end function

        public function pointToMap(param1:Point) : Vector3D
        {
            return null;
        }// end function

        public function releaseInstance() : void
        {
            super.releaseInstance();
            this.m_DragHandler.removeDragComponent(this.m_UISlotHolder as UIComponent);
            this.m_UISlotHolder.removeEventListener(DragEvent.DRAG_ENTER, this.onSlotHolderDragEnter);
            var _loc_1:* = this.m_UISlotHolder.numChildren - 1;
            while (_loc_1 >= 0)
            {
                
                this.destroySlot(_loc_1);
                _loc_1 = _loc_1 - 1;
            }
            this.m_UIUpButton.removeEventListener(MouseEvent.CLICK, this.onUpButtonClick);
            Tibia.s_GetInputHandler().removeEventListener(ModifierKeyEvent.MODIFIER_KEYS_CHANGED, this.onModifierKeyEvent);
            Tibia.s_GetUIEffectsManager().removeEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
            return;
        }// end function

        private function onUpButtonClick(event:MouseEvent) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning && this.container != null)
            {
                _loc_2.sendCUPCONTAINER(this.container.ID);
            }
            if (this.m_UIUpButton != null)
            {
                this.m_UIUpButton.enabled = false;
            }
            return;
        }// end function

        private function updateFooter() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this.container != null)
            {
                if (this.container.isPaginationEnabled)
                {
                    _loc_1 = this.container.indexOfFirstObject / this.container.numberOfSlotsPerPage;
                    _loc_2 = (this.container.numberOfTotalObjects + this.container.numberOfSlotsPerPage - 1) / this.container.numberOfSlotsPerPage;
                    this.m_UIPageLabel.text = resourceManager.getString(BUNDLE, "PAGE_LABEL", [(_loc_1 + 1), Math.max(_loc_2, 1)]);
                    var _loc_3:* = _loc_1 > 0;
                    this.m_UIPageLeftButton.visible = _loc_1 > 0;
                    this.m_UIPageLeftButton.enabled = _loc_3;
                    var _loc_3:* = _loc_1 < (_loc_2 - 1);
                    this.m_UIPageRightButton.visible = _loc_1 < (_loc_2 - 1);
                    this.m_UIPageRightButton.enabled = _loc_3;
                }
                if (!contains(this.m_UIPageFooter) && this.container.isPaginationEnabled)
                {
                    addChild(this.m_UIPageFooter);
                }
                else if (contains(this.m_UIPageFooter) && !this.container.isPaginationEnabled)
                {
                    removeChild(this.m_UIPageFooter);
                }
            }
            else if (contains(this.m_UIPageFooter))
            {
                removeChild(this.m_UIPageFooter);
            }
            return;
        }// end function

        public function pointToAbsolute(param1:Point) : Vector3D
        {
            var _loc_2:* = null;
            var _loc_3:* = getClassInstanceUnderPoint(stage, param1, ContainerSlot);
            _loc_2 = getClassInstanceUnderPoint(stage, param1, ContainerSlot);
            if (this.container != null && _loc_3 != null)
            {
                return new Vector3D(65535, 64 + this.container.ID, _loc_2.position);
            }
            if (this.container != null && getClassInstanceUnderPoint(stage, param1, ContainerSlotHolder) != null)
            {
                return new Vector3D(65535, 64 + this.container.ID, 255);
            }
            return null;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            if (this.m_UncommittedContainer)
            {
                this.updateFooter();
                this.updateSlots();
                if (this.container != null)
                {
                    _loc_1 = new SimpleAppearanceRenderer();
                    _loc_1.appearance = this.container.icon;
                    _loc_1.size = 19;
                    titleIcon = _loc_1;
                    titleText = StringHelper.s_Capitalise(this.container.name);
                    var _loc_2:* = this.container.isSubContainer;
                    this.m_UIUpButton.visible = this.container.isSubContainer;
                    this.m_UIUpButton.enabled = _loc_2;
                }
                else
                {
                    titleIcon = null;
                    titleText = resourceManager.getString(BUNDLE, "TITLE");
                    var _loc_2:* = false;
                    this.m_UIUpButton.visible = false;
                    this.m_UIUpButton.enabled = _loc_2;
                }
                this.m_UISlotHolder.verticalScrollPosition = 0;
                this.determineAction(null, false, true);
                this.m_UncommittedContainer = false;
            }
            super.commitProperties();
            return;
        }// end function

        protected function onSlotRollOut(event:MouseEvent) : void
        {
            this.m_RolloverSlot = null;
            this.m_CursorHelper.resetCursor();
            return;
        }// end function

        public function getMultiUseObjectUnderPoint(param1:Point) : Object
        {
            return this.getUseObjectUnderPoint(param1);
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = viewMetricsAndPadding;
            var _loc_2:* = getStyle("verticalGap");
            measuredMaxWidth = DEFAULT_WIDGET_WIDTH;
            measuredMinWidth = DEFAULT_WIDGET_WIDTH;
            measuredWidth = DEFAULT_WIDGET_WIDTH;
            if (isNaN(measuredMaxHeight))
            {
                measuredHeight = _loc_1.top + _loc_1.bottom + this.m_UISlotHolder.getExplicitOrMeasuredHeight();
                if (contains(this.m_UIPageFooter))
                {
                    measuredHeight = measuredHeight + (_loc_2 + this.m_UIPageFooter.getExplicitOrMeasuredHeight());
                }
            }
            measuredMaxHeight = _loc_1.top + _loc_1.bottom;
            measuredMinHeight = _loc_1.top + _loc_1.bottom;
            if (!isNaN(this.m_UISlotHolder.explicitMaxHeight))
            {
                measuredMaxHeight = measuredMaxHeight + this.m_UISlotHolder.explicitMaxHeight;
            }
            else
            {
                measuredMaxHeight = measuredMaxHeight + this.m_UISlotHolder.measuredMaxHeight;
            }
            if (!isNaN(this.m_UISlotHolder.explicitMinHeight))
            {
                measuredMinHeight = measuredMinHeight + this.m_UISlotHolder.explicitMinHeight;
            }
            else
            {
                measuredMinHeight = measuredMinHeight + this.m_UISlotHolder.measuredMinHeight;
            }
            if (contains(this.m_UIPageFooter))
            {
                measuredMaxHeight = measuredMaxHeight + _loc_2;
                measuredMinHeight = measuredMinHeight + _loc_2;
                if (!isNaN(this.m_UIPageFooter.explicitMaxHeight))
                {
                    measuredMaxHeight = measuredMaxHeight + this.m_UIPageFooter.explicitMaxHeight;
                }
                else
                {
                    measuredMaxHeight = measuredMaxHeight + this.m_UIPageFooter.getExplicitOrMeasuredHeight();
                }
                if (!isNaN(this.m_UIPageFooter.explicitMinHeight))
                {
                    measuredMinHeight = measuredMinHeight + this.m_UIPageFooter.explicitMinHeight;
                }
                else
                {
                    measuredMinHeight = measuredMinHeight + this.m_UIPageFooter.measuredMinHeight;
                }
            }
            if (measuredHeight < measuredMinHeight)
            {
                measuredHeight = measuredMinHeight;
            }
            if (explicitHeight < measuredMinHeight)
            {
                explicitHeight = measuredMinHeight;
            }
            return;
        }// end function

        private function updateSlots() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (this.container != null)
            {
                _loc_1 = this.m_UISlotHolder.numChildren - 1;
                while (_loc_1 >= this.container.numberOfSlotsPerPage)
                {
                    
                    this.destroySlot(_loc_1);
                    _loc_1 = _loc_1 - 1;
                }
                _loc_2 = this.m_UISlotHolder.numChildren;
                while (_loc_2 < this.container.numberOfSlotsPerPage)
                {
                    
                    this.createSlot(null, _loc_2);
                    _loc_2++;
                }
                _loc_3 = 0;
                while (_loc_3 < this.container.numberOfSlotsPerPage)
                {
                    
                    _loc_4 = ContainerSlot(this.m_UISlotHolder.getChildAt(_loc_3));
                    if (_loc_3 < this.container.numberOfObjects)
                    {
                        _loc_4.appearance = this.container.getObject(this.container.indexOfFirstObject + _loc_3);
                    }
                    else
                    {
                        _loc_4.appearance = null;
                    }
                    _loc_3++;
                }
            }
            else
            {
                _loc_5 = 0;
                while (_loc_5 < this.m_UISlotHolder.numChildren)
                {
                    
                    this.destroySlot(_loc_5);
                    _loc_5++;
                }
            }
            return;
        }// end function

        private function onModifierKeyEvent(event:ModifierKeyEvent) : void
        {
            this.determineAction(null, false, true);
            return;
        }// end function

        private function onContainerChanged(event:PropertyChangeEvent) : void
        {
            if (event.property == "objects")
            {
                this.updateFooter();
                this.updateSlots();
            }
            return;
        }// end function

        override public function setStyle(param1:String, param2) : void
        {
            if (SLOT_HOLDER_STYLE_FILTER[param1] != null)
            {
                this.m_UISlotHolder.setStyle(SLOT_HOLDER_STYLE_FILTER[param1], param2);
            }
            else
            {
                super.setStyle(param1, param2);
            }
            return;
        }// end function

        protected function determineAction(event:MouseEvent, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_6:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_6 = null;
            var _loc_7:* = ACTION_NONE;
            _loc_8 = this.m_TempVector;
            if (m_Options == null)
            {
                return;
            }
            if (event != null)
            {
                _loc_5 = m_Options.mouseMapping.findBindingByMouseEvent(event);
                _loc_4 = event.target as ContainerSlot;
            }
            else
            {
                _loc_5 = m_Options.mouseMapping.findBindingForLeftMouseButtonAndPressedModifierKey();
                _loc_4 = this.m_RolloverSlot;
            }
            if (_loc_5 != null)
            {
                _loc_7 = _loc_5.action;
            }
            if (_loc_4 == null)
            {
                return;
            }
            _loc_6 = _loc_4.appearance;
            _loc_8.setComponents(65535, 64 + this.container.ID, _loc_4.position);
            if (_loc_6 != null)
            {
                _loc_7 = MouseActionHelper.resolveActionForAppearanceOrCreature(_loc_7, _loc_6, VALID_ACTIONS);
            }
            else
            {
                _loc_7 = ACTION_NONE;
            }
            if (param3 && m_Options.mouseMapping != null && m_Options.mouseMapping.showMouseCursorForAction)
            {
                this.m_CursorHelper.setCursor(MouseActionHelper.actionToMouseCursor(_loc_7));
            }
            if (param2)
            {
                switch(_loc_7)
                {
                    case ACTION_USE:
                    case ACTION_OPEN:
                    {
                        Tibia.s_GameActionFactory.createUseAction(_loc_8, _loc_6, _loc_8.z, UseActionImpl.TARGET_AUTO).perform();
                        break;
                    }
                    case ACTION_LOOK:
                    {
                        new LookActionImpl(_loc_8, _loc_6, _loc_8.z).perform();
                        break;
                    }
                    case ACTION_CONTEXT_MENU:
                    {
                        _loc_9 = {position:_loc_8.z, object:_loc_6};
                        new ObjectContextMenu(_loc_8, _loc_9, _loc_9, null).display(this, event.stageX, event.stageY);
                        break;
                    }
                    case ACTION_NONE:
                    {
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

        private function onSlotHolderDragEnter(event:DragEvent) : void
        {
            if (event.dragSource == null || !event.dragSource.hasFormat("dragType") || event.dragSource.dataForFormat("dragType") != DRAG_TYPE_OBJECT || this.container == null || !this.container.isDragAndDropEnabled)
            {
                event.preventDefault();
            }
            return;
        }// end function

        private function onUIEffectsCommandEvent(event:UIEffectsRetrieveComponentCommandEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (event.type == UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT && event.identifier == ContainerViewWidgetView)
            {
                _loc_2 = event.subIdentifier as Object;
                if ("id" in _loc_2 && "slot" in _loc_2)
                {
                    _loc_3 = _loc_2["id"] as uint;
                    _loc_4 = _loc_2["slot"] as uint;
                    if (_loc_3 == this.container.ID)
                    {
                        event.resultUIComponent = this.m_UISlotHolder.getChildAt(_loc_4) as ContainerSlot;
                    }
                }
            }
            return;
        }// end function

    }
}
