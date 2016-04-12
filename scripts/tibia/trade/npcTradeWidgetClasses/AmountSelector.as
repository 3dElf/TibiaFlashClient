package tibia.trade.npcTradeWidgetClasses
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import tibia.controls.*;
    import tibia.trade.*;

    public class AmountSelector extends HBox
    {
        private var m_UncommittedMaximum:Boolean = false;
        private var m_UncommittedValue:Boolean = false;
        protected var m_UILabel:Label = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_Minimum:uint = 1;
        protected var m_Maximum:uint;
        protected var m_UISlider:CustomSlider = null;
        private var m_UncommittedMinimum:Boolean = false;
        protected var m_Value:uint = 1;

        public function AmountSelector()
        {
            this.m_Maximum = NPCTradeWidget.TRADE_MAX_AMOUNT;
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            setStyle("horizontalAlign", "center");
            setStyle("verticalAlign", "middle");
            setStyle("paddingLeft", 0);
            setStyle("paddingRight", 0);
            return;
        }// end function

        public function set maximum(param1:uint) : void
        {
            if (this.m_Maximum != param1)
            {
                this.m_Maximum = param1;
                this.m_UncommittedMaximum = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedMinimum)
            {
                this.maximum = Math.max(this.m_Minimum, this.m_Maximum);
                this.value = Math.max(this.m_Minimum, Math.min(this.m_Value, this.m_Maximum));
                this.m_UISlider.minimum = this.m_Minimum;
                this.m_UncommittedMinimum = false;
            }
            if (this.m_UncommittedMaximum)
            {
                this.minimum = Math.min(this.m_Minimum, this.m_Maximum);
                this.value = Math.max(this.m_Minimum, Math.min(this.m_Value, this.m_Maximum));
                this.m_UISlider.maximum = this.m_Maximum;
                this.m_UncommittedMaximum = false;
            }
            if (this.m_UncommittedValue)
            {
                this.m_UISlider.value = this.m_Value;
                this.m_UILabel.text = String(this.m_Value);
                this.m_UncommittedValue = false;
            }
            return;
        }// end function

        public function get minimum() : uint
        {
            return this.m_Minimum;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UISlider = new CustomSlider();
                this.m_UISlider.liveDragging = true;
                this.m_UISlider.minimum = this.m_Minimum;
                this.m_UISlider.maximum = this.m_Maximum;
                this.m_UISlider.percentHeight = NaN;
                this.m_UISlider.percentWidth = 100;
                this.m_UISlider.showDataTip = false;
                this.m_UISlider.snapInterval = 1;
                this.m_UISlider.value = this.m_Value;
                this.m_UISlider.addEventListener(Event.CHANGE, this.onSliderChange);
                addChild(this.m_UISlider);
                this.m_UILabel = new Label();
                this.m_UILabel.height = NaN;
                this.m_UILabel.text = String(this.m_Value);
                this.m_UILabel.width = 32;
                this.m_UILabel.setStyle("fontSize", 12);
                this.m_UILabel.setStyle("fontWeight", "bold");
                this.m_UILabel.setStyle("horizontalAlign", "center");
                addChild(this.m_UILabel);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set value(param1:uint) : void
        {
            var _loc_2:* = null;
            param1 = Math.max(this.m_Minimum, Math.min(param1, this.m_Maximum));
            if (this.m_Value != param1)
            {
                this.m_Value = param1;
                this.m_UncommittedValue = true;
                invalidateProperties();
                _loc_2 = new Event(Event.CHANGE);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function set minimum(param1:uint) : void
        {
            if (this.m_Minimum != param1)
            {
                this.m_Minimum = param1;
                this.m_UncommittedMinimum = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get maximum() : uint
        {
            return this.m_Maximum;
        }// end function

        public function get value() : uint
        {
            return this.m_Value;
        }// end function

        protected function onSliderChange(event:Event) : void
        {
            if (event != null)
            {
                this.value = this.m_UISlider.value;
            }
            return;
        }// end function

    }
}
