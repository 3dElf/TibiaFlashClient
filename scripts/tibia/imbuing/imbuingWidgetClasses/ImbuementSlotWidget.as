package tibia.imbuing.imbuingWidgetClasses
{
    import flash.display.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.controls.*;

    public class ImbuementSlotWidget extends HBox
    {
        private var m_UncomittedImageIndex:Boolean = false;
        private var m_UIImage:Image = null;
        private var m_IsSelected:Boolean = false;
        private var m_UncomittedStyle:Boolean = false;
        private var m_MouseIsInWidget:Boolean = false;
        private var m_ImageIndex:int = -1;
        private var m_UIConstructed:Boolean = false;
        private var m_BorderStyle:uint = 0;
        private var m_TemporaryBitmapData:BitmapData;
        public static const BORDER_STYLE_NONE:uint = 0;
        private static const IMBUING_IMAGES_CLASS:Class = ImbuementSlotWidget_IMBUING_IMAGES_CLASS;
        public static const IMBUING_SLOT_EMPTY:BitmapData = Bitmap(new IMBUING_SLOT_EMPTY_CLASS()).bitmapData;
        private static const IMBUING_SLOT_DISABLED_CLASS:Class = ImbuementSlotWidget_IMBUING_SLOT_DISABLED_CLASS;
        public static const IMBUING_IMAGES:BitmapData = Bitmap(new IMBUING_IMAGES_CLASS()).bitmapData;
        public static const IMBUING_SLOT_DISABLED:BitmapData = Bitmap(new IMBUING_SLOT_DISABLED_CLASS()).bitmapData;
        public static const IMBUING_IMAGE_DISABLED:int = -2;
        public static const IMBUING_IMAGE_EMPTY:int = -1;
        private static const IMBUING_SLOT_EMPTY_CLASS:Class = ImbuementSlotWidget_IMBUING_SLOT_EMPTY_CLASS;
        public static const BORDER_STYLE_HOVER:uint = 1;
        public static const BORDER_STYLE_SELECTED:uint = 2;

        public function ImbuementSlotWidget()
        {
            this.m_TemporaryBitmapData = new BitmapData(64, 64);
            return;
        }// end function

        public function set borderStyle(param1:uint) : void
        {
            if (param1 != this.m_BorderStyle)
            {
                this.m_BorderStyle = param1;
                this.m_UncomittedStyle = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get empty() : Boolean
        {
            return this.m_ImageIndex == IMBUING_IMAGE_EMPTY;
        }// end function

        public function get imbuingImage() : int
        {
            return this.m_ImageIndex;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncomittedStyle)
            {
                switch(this.m_BorderStyle)
                {
                    case BORDER_STYLE_NONE:
                    {
                        styleName = "";
                        break;
                    }
                    case BORDER_STYLE_HOVER:
                    {
                        styleName = "hovered";
                        break;
                    }
                    case BORDER_STYLE_SELECTED:
                    {
                        styleName = "selected";
                        break;
                    }
                    default:
                    {
                        styleName = "";
                        break;
                        break;
                    }
                }
                this.m_UncomittedStyle = false;
            }
            if (this.m_UncomittedImageIndex)
            {
                if (this.m_ImageIndex == IMBUING_IMAGE_EMPTY)
                {
                    this.m_UIImage.addChild(new Bitmap(IMBUING_SLOT_EMPTY));
                }
                else if (this.m_ImageIndex == IMBUING_IMAGE_DISABLED)
                {
                    this.m_UIImage.addChild(new Bitmap(IMBUING_SLOT_DISABLED));
                }
                else if (this.m_ImageIndex >= 1 && this.m_ImageIndex <= IMBUING_IMAGES.width / IMBUING_IMAGES.height + 1)
                {
                    _loc_1 = new Rectangle(IMBUING_IMAGES.height * (this.m_ImageIndex - 1), 0, IMBUING_IMAGES.height, IMBUING_IMAGES.height);
                    this.m_TemporaryBitmapData.copyPixels(IMBUING_IMAGES, _loc_1, new Point(0, 0));
                    this.m_UIImage.addChild(new Bitmap(this.m_TemporaryBitmapData));
                }
            }
            return;
        }// end function

        public function set empty(param1:Boolean) : void
        {
            if (param1 != (this.m_ImageIndex == IMBUING_IMAGE_EMPTY))
            {
                this.m_ImageIndex = IMBUING_IMAGE_EMPTY;
                this.m_UncomittedImageIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this.m_IsSelected;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new HBox();
                this.m_UIImage = new Image();
                this.m_UIImage.width = 64;
                this.m_UIImage.height = 64;
                _loc_1.addChild(this.m_UIImage);
                _loc_1.styleName = "border";
                addChild(_loc_1);
                _loc_2 = 7;
                setStyle("paddingLeft", _loc_2);
                setStyle("paddingRight", _loc_2);
                setStyle("paddingTop", _loc_2);
                setStyle("paddingBottom", _loc_2);
                this.m_UncomittedImageIndex = true;
                invalidateProperties();
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function get borderStyle() : uint
        {
            return this.m_BorderStyle;
        }// end function

        public function set imbuingImage(param1:int) : void
        {
            if (param1 != this.m_ImageIndex)
            {
                this.m_ImageIndex = param1;
                this.m_UncomittedImageIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            if (param1 != this.m_IsSelected)
            {
                this.m_IsSelected = param1;
                this.m_UncomittedStyle = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set disabled(param1:Boolean) : void
        {
            if (param1 != (this.m_ImageIndex == IMBUING_IMAGE_DISABLED))
            {
                this.m_ImageIndex = IMBUING_IMAGE_DISABLED;
                this.m_UncomittedImageIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get disabled() : Boolean
        {
            return this.m_ImageIndex == IMBUING_IMAGE_DISABLED;
        }// end function

    }
}
