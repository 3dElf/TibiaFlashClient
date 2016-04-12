package tibia.creatures
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.creatures.selectOutfitWidgetClasses.*;
    import tibia.game.*;
    import tibia.ingameshop.*;
    import tibia.network.*;

    public class SelectOutfitWidget extends PopUpBase
    {
        protected var m_UIPlayerColours:Vector.<OutfitColourSelector>;
        protected var m_MountType:int = -1;
        protected var m_UIMountOutfit:OutfitTypeSelector = null;
        protected var m_PlayerColours:Vector.<int>;
        private var m_UncommittedPlayerOutfits:Boolean = true;
        private var m_UncommittedPlayerAddons:Boolean = false;
        protected var m_PlayerAddons:int = 0;
        protected var m_UIOpenStoreMountsCategory:Button = null;
        private var m_UncommittedPlayerType:Boolean = false;
        private var m_UncommittedMountOutfits:Boolean = true;
        protected var m_MountOutfits:IList = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIPlayerAddons:Vector.<CheckBox>;
        protected var m_PlayerOutfits:IList = null;
        private var m_UncommittedMountType:Boolean = false;
        protected var m_UIPlayerBody:SimpleTabNavigator = null;
        protected var m_PlayerType:int = -1;
        protected var m_UIPlayerOutift:OutfitTypeSelector = null;
        private var m_UncommittedPlayerColours:Boolean = false;
        protected var m_UIOpenStoreOutfitsCategory:Button = null;
        private static const BUNDLE:String = "SelectOutfitWidget";
        private static const BODY_PARTS:Array = ["LABEL_COLOUR_HEAD", "LABEL_COLOUR_PRIMARY", "LABEL_COLOUR_SECONDARY", "LABEL_COLOUR_DETAIL"];

        public function SelectOutfitWidget()
        {
            this.m_PlayerColours = new Vector.<int>(4, true);
            this.m_UIPlayerColours = new Vector.<OutfitColourSelector>(4, true);
            this.m_UIPlayerAddons = new Vector.<CheckBox>(3, true);
            title = resourceManager.getString(BUNDLE, "TITLE");
            return;
        }// end function

        protected function onPlayerAddonsChange(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (event != null)
            {
                _loc_2 = 0;
                _loc_3 = this.m_UIPlayerAddons.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    if (this.m_UIPlayerAddons[_loc_3].enabled && this.m_UIPlayerAddons[_loc_3].selected)
                    {
                        _loc_2 = _loc_2 | int(this.m_UIPlayerAddons[_loc_3].data);
                    }
                    _loc_3 = _loc_3 - 1;
                }
                this.playerAddons = _loc_2;
            }
            return;
        }// end function

        public function get playerColours()
        {
            return this.m_PlayerColours;
        }// end function

        public function set playerColours(... args) : void
        {
            args = 0;
            if (args.length == this.m_PlayerColours.length)
            {
                args = 0;
                while (args < 4)
                {
                    
                    this.m_PlayerColours[args] = int(args[args]);
                    args++;
                }
            }
            else if (args.length == 1 && args[0] is Vector.<int> && this.Vector.<int>(args[0]).length == this.m_PlayerColours.length)
            {
                args = 0;
                while (args < 4)
                {
                    
                    this.m_PlayerColours[args] = this.Vector.<int>(args[0])[args];
                    args++;
                }
            }
            else if (args.length == 1 && args[0] is Array && args[0].length == this.m_PlayerColours.length)
            {
                args = 0;
                while (args < this.m_PlayerColours.length)
                {
                    
                    this.m_PlayerColours[args] = args[0][args];
                    args++;
                }
            }
            else
            {
                throw new ArgumentError("SelectOutfitWidget.setPlayerColours: Invalid overload.");
            }
            this.m_UncommittedPlayerColours = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            super.commitProperties();
            if (this.m_UncommittedPlayerOutfits)
            {
                this.m_UIPlayerOutift.outfits = this.m_PlayerOutfits;
                this.m_UIPlayerOutift.type = this.m_PlayerType;
                this.updateCheckboxAddonsPlayer();
                this.m_UncommittedPlayerOutfits = false;
            }
            if (this.m_UncommittedPlayerType)
            {
                this.m_UIPlayerOutift.type = this.m_PlayerType;
                this.updateCheckboxAddonsPlayer();
                this.m_UncommittedPlayerType = false;
            }
            if (this.m_UncommittedPlayerAddons)
            {
                this.m_UIPlayerOutift.addons = this.m_PlayerAddons;
                this.updateCheckboxAddonsPlayer();
                this.m_UncommittedPlayerAddons = false;
            }
            if (this.m_UncommittedPlayerColours)
            {
                _loc_1 = 0;
                while (_loc_1 < this.m_PlayerColours.length)
                {
                    
                    if (this.m_UIPlayerColours[_loc_1] != null)
                    {
                        this.m_UIPlayerColours[_loc_1].HSI = this.m_PlayerColours[_loc_1];
                    }
                    _loc_1++;
                }
                this.m_UIPlayerOutift.colours = this.m_PlayerColours;
                this.m_UncommittedPlayerColours = false;
            }
            if (this.m_UncommittedMountOutfits)
            {
                this.m_UIMountOutfit.enabled = this.m_MountOutfits != null && this.m_MountOutfits.length > 0;
                this.m_UIMountOutfit.outfits = this.m_MountOutfits;
                this.m_UIMountOutfit.type = this.m_MountType;
                this.m_UncommittedMountOutfits = false;
            }
            if (this.m_UncommittedMountType)
            {
                this.m_UIMountOutfit.type = this.m_MountType;
                this.m_UncommittedMountType = false;
            }
            return;
        }// end function

        protected function onOpenStoreMountsCategoryClick(event:MouseEvent) : void
        {
            IngameShopManager.getInstance().openShopWindow(true, IngameShopProduct.SERVICE_TYPE_MOUNTS);
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new HBox();
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                _loc_1.setStyle("horizontalGap", 2);
                _loc_2 = new Canvas();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 50;
                _loc_3 = new Canvas();
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 50;
                this.m_UIPlayerOutift = new OutfitTypeSelector();
                this.m_UIPlayerOutift.addons = this.m_PlayerAddons;
                this.m_UIPlayerOutift.colours = this.m_PlayerColours;
                this.m_UIPlayerOutift.noOutfitLabel = resourceManager.getString(BUNDLE, "LABEL_NO_OUTFIT");
                this.m_UIPlayerOutift.outfits = this.m_PlayerOutfits;
                this.m_UIPlayerOutift.percentHeight = NaN;
                this.m_UIPlayerOutift.percentWidth = 50;
                this.m_UIPlayerOutift.type = this.m_PlayerType;
                this.m_UIPlayerOutift.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerTypeChange);
                _loc_2.addChild(this.m_UIPlayerOutift);
                this.m_UIOpenStoreOutfitsCategory = new Button();
                this.m_UIOpenStoreOutfitsCategory.styleName = getStyle("outfitDialogOpenStoreButtonStyle");
                this.m_UIOpenStoreOutfitsCategory.setConstraintValue("right", 2);
                this.m_UIOpenStoreOutfitsCategory.setConstraintValue("top", 2);
                this.m_UIOpenStoreOutfitsCategory.addEventListener(MouseEvent.CLICK, this.onOpenStoreOutfitsCategoryClick);
                this.m_UIOpenStoreOutfitsCategory.toolTip = resourceManager.getString(BUNDLE, "TOOLTIP_STORE");
                _loc_2.addChild(this.m_UIOpenStoreOutfitsCategory);
                this.m_UIMountOutfit = new OutfitTypeSelector();
                this.m_UIMountOutfit.enabled = this.m_MountOutfits != null && this.m_MountOutfits.length > 0;
                this.m_UIMountOutfit.noOutfitLabel = resourceManager.getString(BUNDLE, "LABEL_NO_MOUNT");
                this.m_UIMountOutfit.outfits = this.m_MountOutfits;
                this.m_UIMountOutfit.percentHeight = NaN;
                this.m_UIMountOutfit.percentWidth = 50;
                this.m_UIMountOutfit.type = this.m_MountType;
                this.m_UIMountOutfit.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onMountTypeChange);
                _loc_3.addChild(this.m_UIMountOutfit);
                this.m_UIOpenStoreMountsCategory = new Button();
                this.m_UIOpenStoreMountsCategory.styleName = getStyle("outfitDialogOpenStoreButtonStyle");
                this.m_UIOpenStoreMountsCategory.setConstraintValue("right", 2);
                this.m_UIOpenStoreMountsCategory.setConstraintValue("top", 2);
                this.m_UIOpenStoreMountsCategory.addEventListener(MouseEvent.CLICK, this.onOpenStoreMountsCategoryClick);
                this.m_UIOpenStoreMountsCategory.toolTip = resourceManager.getString(BUNDLE, "TOOLTIP_STORE");
                _loc_3.addChild(this.m_UIOpenStoreMountsCategory);
                _loc_1.addChild(_loc_2);
                _loc_1.addChild(_loc_3);
                addChild(_loc_1);
                _loc_1 = new HBox();
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                _loc_4 = 0;
                while (_loc_4 < this.m_UIPlayerAddons.length)
                {
                    
                    this.m_UIPlayerAddons[_loc_4] = new CheckBox();
                    this.m_UIPlayerAddons[_loc_4].data = 1 << _loc_4;
                    this.m_UIPlayerAddons[_loc_4].label = resourceManager.getString(BUNDLE, "CHECK_OUTFIT_ADDON", [(_loc_4 + 1)]);
                    this.m_UIPlayerAddons[_loc_4].percentHeight = NaN;
                    this.m_UIPlayerAddons[_loc_4].percentWidth = 33;
                    this.m_UIPlayerAddons[_loc_4].styleName = this;
                    this.m_UIPlayerAddons[_loc_4].addEventListener(Event.CHANGE, this.onPlayerAddonsChange);
                    _loc_1.addChild(this.m_UIPlayerAddons[_loc_4]);
                    _loc_4++;
                }
                addChild(_loc_1);
                this.m_UIPlayerBody = new SimpleTabNavigator();
                this.m_UIPlayerBody.percentHeight = NaN;
                this.m_UIPlayerBody.percentWidth = 100;
                this.m_UIPlayerBody.styleName = "selectOutfitTabNavigator";
                _loc_4 = 0;
                while (_loc_4 < this.m_UIPlayerColours.length)
                {
                    
                    _loc_1 = new HBox();
                    _loc_1.label = resourceManager.getString(BUNDLE, BODY_PARTS[_loc_4]);
                    _loc_1.percentHeight = 100;
                    _loc_1.percentWidth = 100;
                    _loc_1.styleName = "selectOutfitTabContainer";
                    this.m_UIPlayerColours[_loc_4] = new OutfitColourSelector();
                    this.m_UIPlayerColours[_loc_4].HSI = this.m_PlayerColours[_loc_4];
                    this.m_UIPlayerColours[_loc_4].addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerColoursChange);
                    _loc_1.addChild(this.m_UIPlayerColours[_loc_4]);
                    this.m_UIPlayerBody.addChild(_loc_1);
                    _loc_4++;
                }
                addChild(this.m_UIPlayerBody);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function onMountTypeChange(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                switch(event.property)
                {
                    case "type":
                    {
                        this.mountType = this.m_UIMountOutfit.type;
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

        public function get playerOutfits() : IList
        {
            return this.m_PlayerOutfits;
        }// end function

        public function get playerType() : int
        {
            return this.m_PlayerType;
        }// end function

        protected function updateCheckboxAddonsPlayer() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = this.getOutfitIndex(this.m_PlayerOutfits, this.m_PlayerType);
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (_loc_1 > -1)
            {
                _loc_5 = this.m_PlayerOutfits.getItemAt(_loc_1);
                _loc_2 = _loc_5.addons;
                _loc_3 = this.m_PlayerAddons & _loc_5.addons;
            }
            var _loc_4:* = this.m_UIPlayerAddons.length - 1;
            while (_loc_4 >= 0)
            {
                
                this.m_UIPlayerAddons[_loc_4].enabled = (int(this.m_UIPlayerAddons[_loc_4].data) & _loc_2) != 0;
                this.m_UIPlayerAddons[_loc_4].selected = (int(this.m_UIPlayerAddons[_loc_4].data) & _loc_3) != 0;
                _loc_4 = _loc_4 - 1;
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = Tibia.s_GetCommunication();
            _loc_2 = Tibia.s_GetCommunication();
            if (param1 && _loc_3 != null)
            {
                _loc_2.sendCSETOUTFIT(this.m_PlayerType, this.m_PlayerColours[0], this.m_PlayerColours[1], this.m_PlayerColours[2], this.m_PlayerColours[3], this.m_PlayerAddons, this.m_MountType);
            }
            super.hide(param1);
            return;
        }// end function

        protected function onPlayerTypeChange(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                switch(event.property)
                {
                    case "type":
                    {
                        this.playerType = this.m_UIPlayerOutift.type;
                        break;
                    }
                    case "addons":
                    {
                        this.playerAddons = this.m_UIPlayerOutift.addons;
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

        public function set playerOutfits(param1:IList) : void
        {
            if (this.m_PlayerOutfits != param1)
            {
                this.m_PlayerOutfits = param1;
                this.m_UncommittedPlayerOutfits = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set mountType(param1:int) : void
        {
            if (this.m_MountType != param1)
            {
                this.m_MountType = param1;
                this.m_UncommittedMountType = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set playerAddons(param1:int) : void
        {
            if (this.m_PlayerAddons != param1)
            {
                this.m_PlayerAddons = param1;
                this.m_UncommittedPlayerAddons = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set mountOutfits(param1:IList) : void
        {
            if (this.m_MountOutfits != param1)
            {
                this.m_MountOutfits = param1;
                this.m_UncommittedMountOutfits = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function getOutfitIndex(param1:IList, param2:int) : int
        {
            var _loc_3:* = 0;
            if (param1 != null)
            {
                _loc_3 = param1.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    if (param1.getItemAt(_loc_3).ID == param2)
                    {
                        return _loc_3;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return -1;
        }// end function

        protected function onOpenStoreOutfitsCategoryClick(event:MouseEvent) : void
        {
            IngameShopManager.getInstance().openShopWindow(true, IngameShopProduct.SERVICE_TYPE_OUTFITS);
            return;
        }// end function

        public function get mountType() : int
        {
            return this.m_MountType;
        }// end function

        public function get playerAddons() : int
        {
            return this.m_PlayerAddons;
        }// end function

        public function set playerType(param1:int) : void
        {
            if (this.m_PlayerType != param1)
            {
                this.m_PlayerType = param1;
                this.m_UncommittedPlayerType = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get mountOutfits() : IList
        {
            return this.m_MountOutfits;
        }// end function

        protected function onPlayerColoursChange(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = 0;
            if (event != null)
            {
                switch(event.property)
                {
                    case "HSI":
                    {
                        _loc_2 = this.m_UIPlayerBody.selectedIndex;
                        this.m_PlayerColours[_loc_2] = this.m_UIPlayerColours[_loc_2].HSI;
                        this.m_UncommittedPlayerColours = true;
                        invalidateProperties();
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

    }
}
