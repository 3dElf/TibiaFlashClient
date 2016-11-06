package tibia.imbuing.imbuingWidgetClasses
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import shared.controls.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.game.*;
    import tibia.imbuing.*;

    public class ItemInformationPane extends HBox
    {
        private var m_UncommittedImbuementSlotMouseAction:Boolean = false;
        private var m_AppearanceTypeID:uint = 0;
        private var m_ImbuingSlotImages:Vector.<int>;
        private var m_UncommittedImbuingImages:Boolean = false;
        private var m_UIImbuingItemAppearance:SimpleAppearanceRenderer = null;
        private var m_TooltipText:String = "";
        private var m_ImbuementSlots:Vector.<ImbuementSlotWidget>;
        private var m_SelectedExistingImbuementIndex:int = -1;
        private var m_CurrentlyHoveredImbuementSlotIndex:int = -1;
        private var m_UncommittedType:Boolean = false;
        private static const BUNDLE:String = "ImbuingWidget";

        public function ItemInformationPane()
        {
            this.m_ImbuingSlotImages = new Vector.<int>;
            this.m_ImbuementSlots = new Vector.<ImbuementSlotWidget>;
            return;
        }// end function

        public function get imbuingSlotImages() : Vector.<int>
        {
            return this.m_ImbuingSlotImages;
        }// end function

        private function onImbuementSlotMouseEvent(event:MouseEvent) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = null;
            var _loc_3:* = -1;
            var _loc_4:* = 0;
            while (_loc_4 < this.m_ImbuementSlots.length)
            {
                
                if (this.m_ImbuementSlots[_loc_4] == event.currentTarget)
                {
                    _loc_3 = _loc_4;
                    _loc_2 = this.m_ImbuementSlots[_loc_4];
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            if (event.type == MouseEvent.MOUSE_OVER)
            {
                if (_loc_3 < this.m_ImbuingSlotImages.length)
                {
                    this.m_CurrentlyHoveredImbuementSlotIndex = _loc_3;
                    this.m_UncommittedImbuementSlotMouseAction = true;
                    invalidateProperties();
                    this.sendTooltipEvent(resourceManager.getString(BUNDLE, "TOOLTIP_IMBUING_SLOT_AVAILABLE"));
                }
                else
                {
                    this.sendTooltipEvent(resourceManager.getString(BUNDLE, "TOOLTIP_IMBUING_SLOT_LOCKED"));
                }
            }
            else if (event.type == MouseEvent.MOUSE_OUT)
            {
                if (this.m_CurrentlyHoveredImbuementSlotIndex == _loc_3)
                {
                    this.m_CurrentlyHoveredImbuementSlotIndex = -1;
                    this.m_UncommittedImbuementSlotMouseAction = true;
                    invalidateProperties();
                }
                this.sendTooltipEvent(null);
            }
            else if (event.type == MouseEvent.CLICK)
            {
                if (_loc_3 < this.m_ImbuingSlotImages.length && this.m_SelectedExistingImbuementIndex != _loc_3)
                {
                    this.m_SelectedExistingImbuementIndex = _loc_3;
                    this.m_UncommittedImbuementSlotMouseAction = true;
                    invalidateProperties();
                    _loc_5 = new ImbuingEvent(ImbuingEvent.IMBUEMENT_SLOT_SELECTED);
                    dispatchEvent(_loc_5);
                }
            }
            return;
        }// end function

        public function set imbuingSlotImages(param1:Vector.<int>) : void
        {
            if (param1 != this.m_ImbuingSlotImages)
            {
                this.m_ImbuingSlotImages = param1;
                this.m_UncommittedImbuingImages = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            var _loc_1:* = 0;
            if (this.m_UncommittedType)
            {
                this.m_UIImbuingItemAppearance.appearance = Tibia.s_GetAppearanceStorage().createObjectInstance(this.m_AppearanceTypeID, 0);
                ShapeWrapper(this.m_UIImbuingItemAppearance.parent).invalidateSize();
                ShapeWrapper(this.m_UIImbuingItemAppearance.parent).invalidateDisplayList();
                this.m_UncommittedType = false;
            }
            if (this.m_UncommittedImbuingImages)
            {
                this.m_UncommittedImbuingImages = false;
                _loc_1 = 0;
                while (_loc_1 < this.m_ImbuementSlots.length)
                {
                    
                    if (_loc_1 < this.m_ImbuingSlotImages.length)
                    {
                        this.m_ImbuementSlots[_loc_1].imbuingImage = this.m_ImbuingSlotImages[_loc_1];
                    }
                    else
                    {
                        this.m_ImbuementSlots[_loc_1].disabled = true;
                    }
                    _loc_1 = _loc_1 + 1;
                }
            }
            if (this.m_UncommittedImbuementSlotMouseAction)
            {
                _loc_1 = 0;
                while (_loc_1 < this.m_ImbuementSlots.length)
                {
                    
                    if (_loc_1 == this.m_SelectedExistingImbuementIndex)
                    {
                        this.m_ImbuementSlots[this.m_SelectedExistingImbuementIndex].borderStyle = ImbuementSlotWidget.BORDER_STYLE_SELECTED;
                    }
                    else if (_loc_1 == this.m_CurrentlyHoveredImbuementSlotIndex)
                    {
                        this.m_ImbuementSlots[this.m_CurrentlyHoveredImbuementSlotIndex].borderStyle = ImbuementSlotWidget.BORDER_STYLE_HOVER;
                    }
                    else
                    {
                        this.m_ImbuementSlots[_loc_1].borderStyle = ImbuementSlotWidget.BORDER_STYLE_NONE;
                    }
                    _loc_1 = _loc_1 + 1;
                }
                this.m_UncommittedImbuementSlotMouseAction = false;
            }
            return;
        }// end function

        public function get selectedImbuingSlot() : int
        {
            return this.m_SelectedExistingImbuementIndex;
        }// end function

        public function get tooltipText() : String
        {
            return this.m_TooltipText;
        }// end function

        public function get apperanceTypeID() : uint
        {
            return this.m_AppearanceTypeID;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_9:* = null;
            super.createChildren();
            var _loc_1:* = new VBox();
            _loc_1.percentWidth = 100;
            var _loc_2:* = new Label();
            _loc_2.text = resourceManager.getString(BUNDLE, "LBL_ITEM_INFORMATION");
            _loc_1.addChild(_loc_2);
            var _loc_3:* = new HBox();
            _loc_3.percentWidth = 100;
            var _loc_4:* = new ShapeWrapper();
            this.m_UIImbuingItemAppearance = new SimpleAppearanceRenderer();
            this.m_UIImbuingItemAppearance.scale = 2;
            _loc_4.addChild(this.m_UIImbuingItemAppearance);
            var _loc_5:* = new HBox();
            var _loc_6:* = new Label();
            _loc_2.text = resourceManager.getString(BUNDLE, "LBL_SLOTS_INFORMATION");
            _loc_5.addChild(_loc_6);
            var _loc_7:* = 0;
            while (_loc_7 < 3)
            {
                
                _loc_9 = new ImbuementSlotWidget();
                _loc_5.addChild(_loc_9);
                _loc_9.addEventListener(MouseEvent.MOUSE_OVER, this.onImbuementSlotMouseEvent);
                _loc_9.addEventListener(MouseEvent.MOUSE_OUT, this.onImbuementSlotMouseEvent);
                _loc_9.addEventListener(MouseEvent.CLICK, this.onImbuementSlotMouseEvent);
                this.m_ImbuementSlots.push(_loc_9);
                _loc_7 = _loc_7 + 1;
            }
            this.m_ImbuementSlots[0].selected = true;
            _loc_3.addChild(_loc_4);
            var _loc_8:* = new Spacer();
            _loc_8.percentWidth = 100;
            _loc_3.addChild(_loc_8);
            _loc_3.addChild(_loc_5);
            _loc_1.addChild(_loc_3);
            addChild(_loc_1);
            _loc_2.styleName = "headerLabel";
            _loc_3.styleName = "itemAndSlotBox";
            _loc_5.styleName = "slotsBox";
            this.styleName = "sectionBorder";
            return;
        }// end function

        public function set selectedImbuingSlot(param1:int) : void
        {
            this.m_SelectedExistingImbuementIndex = param1;
            this.m_UncommittedImbuementSlotMouseAction = true;
            invalidateProperties();
            return;
        }// end function

        public function dispose() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.m_ImbuementSlots)
            {
                
                _loc_1.removeEventListener(MouseEvent.MOUSE_OVER, this.onImbuementSlotMouseEvent);
                _loc_1.removeEventListener(MouseEvent.MOUSE_OUT, this.onImbuementSlotMouseEvent);
                _loc_1.removeEventListener(MouseEvent.CLICK, this.onImbuementSlotMouseEvent);
            }
            return;
        }// end function

        public function set apperanceTypeID(param1:uint) : void
        {
            if (param1 != this.m_AppearanceTypeID)
            {
                this.m_AppearanceTypeID = param1;
                this.m_UncommittedType = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function sendTooltipEvent(param1:String) : void
        {
            var _loc_2:* = null;
            if (param1 != null && param1.length > 0)
            {
                _loc_2 = new ExtendedTooltipEvent(ExtendedTooltipEvent.SHOW, true, false, param1);
                dispatchEvent(_loc_2);
            }
            else
            {
                _loc_2 = new ExtendedTooltipEvent(ExtendedTooltipEvent.HIDE);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

    }
}
