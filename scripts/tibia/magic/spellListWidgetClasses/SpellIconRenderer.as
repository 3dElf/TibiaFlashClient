package tibia.magic.spellListWidgetClasses
{
    import flash.display.*;
    import flash.geom.*;
    import mx.core.*;
    import tibia.magic.*;

    public class SpellIconRenderer extends UIComponent
    {
        private var m_Spell:Spell;
        private var m_Selected:Boolean = false;
        private var m_UISkinBackground:IFlexDisplayObject = null;
        private var m_UISkinUnavailable:IFlexDisplayObject = null;
        private var m_Available:Boolean = true;
        private var m_UIConstructed:Boolean = false;
        private var m_UISpellIcon:FlexShape = null;
        private var m_UISkinSelected:IFlexDisplayObject = null;
        private static var s_Rectangle:Rectangle = new Rectangle();
        private static var s_Matrix:Matrix = new Matrix();

        public function SpellIconRenderer()
        {
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "backgroundImage":
                {
                    this.m_UISkinBackground = this.updateSkin("backgroundImage");
                    invalidateDisplayList();
                    invalidateSize();
                    break;
                }
                case "overlaySelectedImage":
                {
                    this.m_UISkinSelected = this.updateSkin("overlaySelectedImage");
                    invalidateDisplayList();
                    break;
                }
                case "overlayUnavailableImage":
                {
                    this.m_UISkinUnavailable = this.updateSkin("overlayUnavailableImage");
                    invalidateDisplayList();
                    break;
                }
                default:
                {
                    super.styleChanged(param1);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function get available() : Boolean
        {
            return this.m_Available;
        }// end function

        public function set spell(param1:Spell) : void
        {
            if (this.m_Spell != param1)
            {
                this.m_Spell = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        public function set available(param1:Boolean) : void
        {
            if (this.m_Available != param1)
            {
                this.m_Available = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this.m_Selected;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            if (this.m_UISkinBackground != null)
            {
                var _loc_1:* = this.m_UISkinBackground.width;
                measuredMinWidth = this.m_UISkinBackground.width;
                measuredWidth = _loc_1;
                var _loc_1:* = this.m_UISkinBackground.height;
                measuredMinHeight = this.m_UISkinBackground.height;
                measuredHeight = _loc_1;
            }
            else
            {
                var _loc_1:* = Spell.ICON_SIZE + getStyle("paddingLeft") + getStyle("paddingRight");
                measuredMinWidth = Spell.ICON_SIZE + getStyle("paddingLeft") + getStyle("paddingRight");
                measuredWidth = _loc_1;
                var _loc_1:* = Spell.ICON_SIZE + getStyle("paddingTop") + getStyle("paddingBottom");
                measuredMinHeight = Spell.ICON_SIZE + getStyle("paddingTop") + getStyle("paddingBottom");
                measuredHeight = _loc_1;
            }
            return;
        }// end function

        private function updateSkin(param1:String) : IFlexDisplayObject
        {
            var _loc_2:* = getChildByName(param1);
            var _loc_3:* = -1;
            if (_loc_2 != null)
            {
                _loc_3 = getChildIndex(_loc_2);
                removeChild(_loc_2);
                _loc_2 = null;
            }
            var _loc_4:* = getStyle(param1) as Class;
            if (getStyle(param1) as Class != null)
            {
                _loc_2 = DisplayObject(new _loc_4);
                _loc_2.name = param1;
                _loc_2.cacheAsBitmap = true;
            }
            if (_loc_2 != null)
            {
                if (_loc_3 != -1)
                {
                    addChildAt(_loc_2, _loc_3);
                }
                else
                {
                    addChild(_loc_2);
                }
            }
            return IFlexDisplayObject(_loc_2);
        }// end function

        public function get spell() : Spell
        {
            return this.m_Spell;
        }// end function

        private function updateIcon() : void
        {
            var _loc_1:* = this.m_UISpellIcon.graphics;
            _loc_1.clear();
            var _loc_2:* = null;
            var _loc_3:* = this.spell.getIcon(s_Rectangle);
            _loc_2 = this.spell.getIcon(s_Rectangle);
            if (this.spell != null && _loc_3 != null)
            {
                s_Matrix.tx = -s_Rectangle.x;
                s_Matrix.ty = -s_Rectangle.y;
                _loc_1.beginBitmapFill(_loc_2, s_Matrix, false, false);
                _loc_1.drawRect(0, 0, s_Rectangle.width, s_Rectangle.height);
                _loc_1.endFill();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UISkinBackground = this.updateSkin("backgroundImage");
                this.m_UISpellIcon = new FlexShape();
                this.m_UISpellIcon.name = "spellIcon";
                addChild(this.m_UISpellIcon);
                this.m_UISkinUnavailable = this.updateSkin("overlayUnavailableImage");
                this.m_UISkinSelected = this.updateSkin("overlaySelectedImage");
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            if (this.m_Selected != param1)
            {
                this.m_Selected = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = 0;
            if (this.m_UISkinBackground != null)
            {
                this.m_UISkinBackground.x = (param1 - this.m_UISkinBackground.width) / 2;
                this.m_UISkinBackground.y = (param2 - this.m_UISkinBackground.height) / 2;
                this.m_UISkinBackground.visible = true;
                setChildIndex(DisplayObject(this.m_UISkinBackground), _loc_3++);
            }
            if (this.m_UISpellIcon != null)
            {
                this.updateIcon();
                this.m_UISpellIcon.x = (param1 - this.m_UISpellIcon.width) / 2;
                this.m_UISpellIcon.y = (param2 - this.m_UISpellIcon.height) / 2;
                this.m_UISpellIcon.visible = true;
                setChildIndex(this.m_UISpellIcon, _loc_3++);
            }
            if (this.m_UISkinUnavailable != null)
            {
                this.m_UISkinUnavailable.x = (param1 - this.m_UISkinUnavailable.width) / 2;
                this.m_UISkinUnavailable.y = (param2 - this.m_UISkinUnavailable.height) / 2;
                this.m_UISkinUnavailable.visible = !this.available;
                setChildIndex(DisplayObject(this.m_UISkinUnavailable), _loc_3++);
            }
            if (this.m_UISkinSelected != null)
            {
                this.m_UISkinSelected.x = (param1 - this.m_UISkinSelected.width) / 2;
                this.m_UISkinSelected.y = (param2 - this.m_UISkinSelected.height) / 2;
                this.m_UISkinSelected.visible = this.selected;
                setChildIndex(DisplayObject(this.m_UISkinSelected), _loc_3++);
            }
            return;
        }// end function

    }
}
