package tibia.input.widgetClasses
{
    import flash.events.*;
    import flash.ui.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.controls.*;
    import tibia.game.*;

    public class SplitStackWidget extends PopUpBase
    {
        protected var m_UncommittedSelectedAmount:Boolean = false;
        protected var m_SelectedAmount:int = 0;
        private var m_ObjectInvalid:Boolean = false;
        protected var m_ObjectType:AppearanceType = null;
        private var m_UncommittedObjectType:Boolean = false;
        protected var m_InputAmount:int = 0;
        protected var m_UIAmount:CustomSlider = null;
        protected var m_ObjectInstance:ObjectInstance = null;
        private var m_UncommittedObjectAmount:Boolean = false;
        protected var m_ObjectAmount:int = 0;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIObjectInstance:SimpleAppearanceRenderer = null;
        private static const BUNDLE:String = "SplitStackWidget";

        public function SplitStackWidget()
        {
            title = resourceManager.getString(BUNDLE, "TITLE");
            setStyle("verticalAlign", "middle");
            setStyle("horizontalAlign", "center");
            addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            return;
        }// end function

        protected function onKeyDown(event:KeyboardEvent) : void
        {
            var _loc_2:* = 0;
            if (event.keyCode >= Keyboard.NUMBER_0 && event.keyCode <= Keyboard.NUMBER_9)
            {
                this.m_InputAmount = (this.m_InputAmount * 10 + (event.keyCode - Keyboard.NUMBER_0)) % 100;
                this.selectedAmount = Math.min(Math.max(1, this.m_InputAmount), this.m_ObjectAmount);
            }
            else
            {
                _loc_2 = 0;
                if (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.DOWN)
                {
                    _loc_2 = -1;
                }
                else if (event.keyCode == Keyboard.RIGHT || event.keyCode == Keyboard.UP)
                {
                    _loc_2 = 1;
                }
                if (event.shiftKey)
                {
                    _loc_2 = _loc_2 * 10;
                }
                this.selectedAmount = Math.min(Math.max(1, this.selectedAmount + _loc_2), this.m_ObjectAmount);
            }
            return;
        }// end function

        public function get objectType() : AppearanceType
        {
            return this.m_ObjectType;
        }// end function

        public function get selectedAmount() : int
        {
            return this.m_SelectedAmount;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new ShapeWrapper();
                this.m_UIObjectInstance = new SimpleAppearanceRenderer();
                this.m_UIObjectInstance.appearance = this.m_ObjectInstance;
                _loc_1.addChild(this.m_UIObjectInstance);
                addChild(_loc_1);
                this.m_UIAmount = new CustomSlider();
                this.m_UIAmount.liveDragging = true;
                this.m_UIAmount.maximum = 100;
                this.m_UIAmount.minimum = 1;
                this.m_UIAmount.minWidth = 200;
                this.m_UIAmount.percentWidth = 100;
                this.m_UIAmount.showDataTip = false;
                this.m_UIAmount.snapInterval = 1;
                this.m_UIAmount.addEventListener(SliderEvent.CHANGE, this.onSliderChange);
                addChild(this.m_UIAmount);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function invalidateObject() : void
        {
            this.m_ObjectInvalid = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedObjectType)
            {
                _loc_1 = Tibia.s_GetAppearanceStorage();
                if (_loc_1 != null)
                {
                    this.m_ObjectInstance = _loc_1.createObjectInstance(this.m_ObjectType.ID, this.m_ObjectAmount);
                }
                else
                {
                    this.m_ObjectInstance = null;
                }
                this.m_UncommittedObjectType = false;
            }
            if (this.m_UncommittedObjectAmount)
            {
                if (this.m_ObjectInstance != null)
                {
                    this.m_ObjectInstance.data = this.m_ObjectAmount;
                }
                this.m_UIAmount.minimum = 1;
                this.m_UIAmount.maximum = this.m_ObjectAmount;
                this.m_UIAmount.value = this.m_ObjectAmount;
                this.m_UIAmount.labels = [1, this.m_ObjectAmount];
                this.m_UncommittedObjectAmount = false;
            }
            if (this.m_UncommittedSelectedAmount)
            {
                if (this.m_ObjectInstance != null)
                {
                    this.m_ObjectInstance.data = this.m_SelectedAmount;
                }
                this.m_UIAmount.value = this.m_SelectedAmount;
                this.m_UncommittedSelectedAmount = false;
            }
            if (this.m_ObjectInvalid)
            {
                this.m_UIObjectInstance.appearance = this.m_ObjectInstance;
                this.m_UIObjectInstance.draw();
                ShapeWrapper(this.m_UIObjectInstance.parent).invalidateSize();
                ShapeWrapper(this.m_UIObjectInstance.parent).invalidateDisplayList();
                this.m_ObjectInvalid = false;
            }
            return;
        }// end function

        public function set selectedAmount(param1:int) : void
        {
            param1 = Math.max(0, Math.min(param1, this.m_ObjectAmount));
            if (this.m_SelectedAmount != param1)
            {
                this.m_SelectedAmount = param1;
                this.m_UncommittedSelectedAmount = true;
                this.invalidateObject();
                invalidateProperties();
            }
            return;
        }// end function

        public function set objectAmount(param1:int) : void
        {
            if (this.m_ObjectAmount != param1)
            {
                this.m_ObjectAmount = param1;
                this.m_UncommittedObjectAmount = true;
                this.m_SelectedAmount = Math.min(Math.max(0, this.m_SelectedAmount), this.m_ObjectAmount);
                this.m_UncommittedSelectedAmount = true;
                this.invalidateObject();
                invalidateProperties();
            }
            return;
        }// end function

        public function set objectType(param1:AppearanceType) : void
        {
            if (this.m_ObjectType != param1)
            {
                this.m_ObjectType = param1;
                this.m_UncommittedObjectType = true;
                this.m_ObjectAmount = 0;
                this.m_UncommittedObjectAmount = true;
                this.m_SelectedAmount = 0;
                this.m_UncommittedSelectedAmount = true;
                this.invalidateObject();
                invalidateProperties();
            }
            return;
        }// end function

        protected function onMouseWheel(event:MouseEvent) : void
        {
            if (event.delta != 0)
            {
                this.selectedAmount = this.selectedAmount + (-event.delta) / Math.abs(event.delta) * (event.shiftKey ? (10) : (1));
            }
            return;
        }// end function

        public function get objectAmount() : int
        {
            return this.m_ObjectAmount;
        }// end function

        protected function onSliderChange(event:SliderEvent) : void
        {
            this.selectedAmount = int(this.m_UIAmount.value);
            return;
        }// end function

    }
}
