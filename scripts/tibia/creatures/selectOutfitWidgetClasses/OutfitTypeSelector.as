package tibia.creatures.selectOutfitWidgetClasses
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import shared.controls.*;
    import tibia.appearances.widgetClasses.*;

    public class OutfitTypeSelector extends VBox
    {
        protected var m_UIButtonNext:Button = null;
        private var m_UncommittedNoOutfitLabel:Boolean = false;
        protected var m_UIAppearance:SimpleAppearanceRenderer = null;
        private var m_UncommittedAddons:Boolean = false;
        protected var m_Colours:Vector.<int>;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIButtonPrev:Button = null;
        protected var m_NoOutfitLabel:String = null;
        protected var m_UIName:Label = null;
        private var m_UncommittedColours:Boolean = false;
        protected var m_Outfits:IList = null;
        protected var m_Addons:int = 0;
        private var m_UncommittedType:Boolean = false;
        protected var m_Type:int = 0;
        private var m_UncommittedOutfits:Boolean = false;

        public function OutfitTypeSelector()
        {
            this.m_Colours = new Vector.<int>(4, true);
            return;
        }// end function

        protected function onOutfitsChange(event:CollectionEvent) : void
        {
            if (event != null)
            {
                this.m_UncommittedOutfits = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onButtonClick(event:MouseEvent) : void
        {
            if (event != null)
            {
                switch(event.currentTarget)
                {
                    case this.m_UIButtonPrev:
                    {
                        this.cycleOutfitType(-1);
                        break;
                    }
                    case this.m_UIButtonNext:
                    {
                        this.cycleOutfitType(1);
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
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new ShapeWrapper();
                _loc_1.width = 140;
                _loc_1.height = 140;
                _loc_1.setStyle("horizontalAlign", "right");
                _loc_1.setStyle("verticalAlign", "bottom");
                this.m_UIAppearance = new SimpleAppearanceRenderer();
                this.m_UIAppearance.scale = 2;
                _loc_1.addChild(this.m_UIAppearance);
                addChild(_loc_1);
                _loc_2 = new HBox();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.setStyle("horizontalAlign", "center");
                _loc_2.setStyle("horizontalGap", 2);
                _loc_2.setStyle("verticalAlign", "middle");
                _loc_2.setStyle("verticalGap", 2);
                this.m_UIButtonPrev = new CustomButton();
                this.m_UIButtonPrev.enabled = this.m_Outfits != null && this.m_Outfits.length > 0;
                this.m_UIButtonPrev.styleName = getStyle("prevButtonStyle");
                this.m_UIButtonPrev.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                _loc_2.addChild(this.m_UIButtonPrev);
                _loc_3 = new HBox();
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 100;
                _loc_3.styleName = getStyle("nameLabelStyle");
                this.m_UIName = new Label();
                _loc_3.addChild(this.m_UIName);
                _loc_2.addChild(_loc_3);
                this.m_UIButtonNext = new CustomButton();
                this.m_UIButtonNext.enabled = this.m_Outfits != null && this.m_Outfits.length > 0;
                this.m_UIButtonNext.styleName = getStyle("nextButtonStyle");
                this.m_UIButtonNext.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                _loc_2.addChild(this.m_UIButtonNext);
                addChild(_loc_2);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        private function set _1106424112outfits(param1:IList) : void
        {
            if (this.m_Outfits != param1)
            {
                if (this.m_Outfits != null)
                {
                    this.m_Outfits.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onOutfitsChange, false);
                }
                this.m_Outfits = param1;
                if (this.m_Outfits)
                {
                    this.m_Outfits.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onOutfitsChange, false, EventPriority.DEFAULT, true);
                }
                this.m_UncommittedOutfits = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set outfits(param1:IList) : void
        {
            var _loc_2:* = this.outfits;
            if (_loc_2 !== param1)
            {
                this._1106424112outfits = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outfits", _loc_2, param1));
            }
            return;
        }// end function

        private function set _1422498253addons(param1:int) : void
        {
            if (this.m_Addons != param1 || param1 == 0)
            {
                this.m_Addons = param1;
                this.m_UncommittedAddons = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function set _3575610type(param1:int) : void
        {
            var _loc_2:* = false;
            if (this.m_Outfits == null || this.m_Outfits.length < 1)
            {
                param1 = 0;
                _loc_2 = true;
            }
            else if (this.getOutfitIndex(param1) < 0)
            {
                param1 = this.m_Outfits.getItemAt(0).ID;
                _loc_2 = true;
            }
            if (this.m_Type != param1 || _loc_2)
            {
                this.m_Type = param1;
                this.m_UncommittedType = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get colours() : Vector.<int>
        {
            return this.m_Colours;
        }// end function

        public function get noOutfitLabel() : String
        {
            return this.m_NoOutfitLabel;
        }// end function

        public function get addons() : int
        {
            return this.m_Addons;
        }// end function

        public function get type() : int
        {
            return this.m_Type;
        }// end function

        private function set _949550119colours(param1:Vector.<int>) : void
        {
            var _loc_2:* = 0;
            if (param1 != null && param1.length == this.m_Colours.length)
            {
                _loc_2 = 0;
                while (_loc_2 < this.m_Colours.length)
                {
                    
                    this.m_Colours[_loc_2] = param1[_loc_2];
                    _loc_2++;
                }
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < this.m_Colours.length)
                {
                    
                    this.m_Colours[_loc_2] = 0;
                    _loc_2++;
                }
            }
            this.m_UncommittedColours = true;
            invalidateProperties();
            return;
        }// end function

        public function set colours(param1) : void
        {
            var _loc_2:* = this.colours;
            if (_loc_2 !== param1)
            {
                this._949550119colours = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colours", _loc_2, param1));
            }
            return;
        }// end function

        public function get outfits() : IList
        {
            return this.m_Outfits;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = 0;
            super.commitProperties();
            if (this.m_UncommittedOutfits)
            {
                _loc_1 = this.m_Outfits != null && this.m_Outfits.length > 0;
                this.m_UIButtonPrev.enabled = _loc_1;
                this.m_UIButtonNext.enabled = _loc_1;
                this.m_UncommittedType = true;
                this.m_UncommittedOutfits = false;
            }
            if (this.m_UncommittedColours)
            {
                this.m_UncommittedType = true;
                this.m_UncommittedColours = false;
            }
            if (this.m_UncommittedAddons)
            {
                this.m_UncommittedType = true;
                this.m_UncommittedAddons = false;
            }
            if (this.m_UncommittedType)
            {
                _loc_2 = this.getOutfitIndex(this.m_Type);
                if (_loc_2 > -1)
                {
                    this.m_UIAppearance.appearance = Tibia.s_GetAppearanceStorage().createOutfitInstance(this.m_Outfits.getItemAt(_loc_2).ID, this.m_Colours[0], this.m_Colours[1], this.m_Colours[2], this.m_Colours[3], this.m_Addons);
                    this.m_UIAppearance.patternX = 2;
                    this.m_UIAppearance.patternY = 0;
                    this.m_UIAppearance.patternZ = 0;
                    this.m_UIName.text = this.m_Outfits.getItemAt(_loc_2).name;
                }
                else
                {
                    this.m_UIAppearance.appearance = null;
                    this.m_UIName.text = this.m_NoOutfitLabel;
                }
                ShapeWrapper(this.m_UIAppearance.parent).invalidateSize();
                ShapeWrapper(this.m_UIAppearance.parent).invalidateDisplayList();
                this.m_UncommittedType = false;
            }
            return;
        }// end function

        private function cycleOutfitType(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (this.m_Outfits != null && this.m_Outfits.length > 0)
            {
                _loc_2 = this.getOutfitIndex(this.m_Type);
                _loc_3 = this.m_Outfits.length;
                _loc_2 = _loc_2 + param1 % _loc_3;
                if (_loc_2 < 0)
                {
                    _loc_2 = _loc_2 + _loc_3;
                }
                if (_loc_2 >= _loc_3)
                {
                    _loc_2 = _loc_2 - _loc_3;
                }
                _loc_4 = this.m_Outfits.getItemAt(_loc_2);
                if (_loc_4 != null)
                {
                    this.type = _loc_4.ID;
                    this.addons = _loc_4.addons;
                }
            }
            return;
        }// end function

        public function set addons(param1:int) : void
        {
            var _loc_2:* = this.addons;
            if (_loc_2 !== param1)
            {
                this._1422498253addons = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addons", _loc_2, param1));
            }
            return;
        }// end function

        public function set noOutfitLabel(param1:String) : void
        {
            if (this.m_NoOutfitLabel != param1)
            {
                this.m_NoOutfitLabel = param1;
                this.m_UncommittedNoOutfitLabel = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function getOutfitIndex(param1:int) : int
        {
            var _loc_2:* = 0;
            if (this.m_Outfits != null)
            {
                _loc_2 = this.m_Outfits.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    if (this.m_Outfits.getItemAt(_loc_2).ID == param1)
                    {
                        return _loc_2;
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            return -1;
        }// end function

        public function set type(param1:int) : void
        {
            var _loc_2:* = this.type;
            if (_loc_2 !== param1)
            {
                this._3575610type = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type", _loc_2, param1));
            }
            return;
        }// end function

        private static function s_InitializeStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration(Selector);
            }
            Decl.defaultFactory = function () : void
            {
                this.verticalGap = 2;
                this.horizontalGap = 2;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingBottom = 2;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}
