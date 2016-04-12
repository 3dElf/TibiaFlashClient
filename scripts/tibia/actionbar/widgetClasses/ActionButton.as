package tibia.actionbar.widgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import shared.utility.*;
    import tibia.actionbar.*;
    import tibia.actionbar.widgetClasses.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.container.*;
    import tibia.creatures.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.magic.*;

    public class ActionButton extends UIComponent implements IActionButton
    {
        private var m_ActionBar:ActionBar = null;
        private var m_UIActionIcon:FlexShape = null;
        private var m_ActionIconCacheMiss:Boolean = false;
        private var m_ActionSpell:Spell = null;
        private var m_LocalAppearanceBitmapCache:BitmapData = null;
        private var m_UncommittedAction:Boolean = false;
        private var m_OverlayText:String = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UISkinHighlight:IFlexDisplayObject = null;
        private var m_OverlayPosition:int = 1;
        private var m_UICooldownMask:FlexShape = null;
        private var m_ActionRune:Rune = null;
        private var m_ActionObject:ObjectInstance = null;
        private var m_Highlight:Boolean = false;
        private var m_UIOverlay:FlexShape = null;
        private var m_UncommittedCooldownDelay:Boolean = true;
        private var m_UISkinBackground:IFlexDisplayObject = null;
        private var m_UncommittedOverlayText:Boolean = true;
        private var m_Available:Boolean = true;
        private var m_UncommittedPosition:Boolean = true;
        private var m_Position:int = 0;
        private var m_UISkinCooldown:IFlexDisplayObject = null;
        private var m_CooldownPhase:int = -1;
        private var m_UISkinDisabled:IFlexDisplayObject = null;
        private var m_CooldownDelay:Delay = null;
        private var m_Action:IAction = null;
        private var m_UncommittedActionBar:Boolean = false;
        private var m_UILabel:FlexShape = null;
        private static const BUNDLE:String = "ActionBarWidget";
        private static var s_ZeroPoint:Point = new Point(0, 0);
        private static const OVERLAY_TOP:int = 1;
        private static const ICON_SIZE:int = 32;
        static var s_LabelTextCache:TextFieldCache = null;
        static var s_Rect:Rectangle = new Rectangle();
        static var s_OverlayTextCache:TextFieldCache = null;
        private static const OVERLAY_BOTTOM:int = 0;
        static var s_Trans:Matrix = new Matrix();
        static var s_TalkTextCache:TalkActionIconCache = null;

        public function ActionButton()
        {
            return;
        }// end function

        private function set actionBar(param1:ActionBar) : void
        {
            if (this.m_ActionBar != param1)
            {
                this.m_ActionBar = param1;
                this.m_UncommittedActionBar = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = 0;
            super.commitProperties();
            if (this.m_UncommittedAction)
            {
                this.m_ActionObject = null;
                this.m_ActionRune = null;
                this.m_ActionSpell = null;
                _loc_1 = Tibia.s_GetSecondaryTimer();
                _loc_1.removeEventListener(TimerEvent.TIMER, this.onTimer);
                _loc_2 = Tibia.s_GetAppearanceStorage();
                if (this.action is UseAction)
                {
                    this.m_ActionObject = new ObjectInstance(UseAction(this.action).type.ID, UseAction(this.action).type, UseAction(this.action).data);
                    this.m_ActionRune = SpellStorage.getRune(UseAction(this.action).type.ID);
                }
                else if (this.action is EquipAction)
                {
                    this.m_ActionObject = new ObjectInstance(EquipAction(this.action).type.ID, EquipAction(this.action).type, EquipAction(this.action).data);
                }
                else if (this.action is SpellAction)
                {
                    this.m_ActionSpell = SpellAction(this.action).spell;
                }
                if (this.m_ActionIconCacheMiss || this.m_ActionObject != null || this.m_ActionRune != null || this.m_ActionSpell != null)
                {
                    _loc_1.addEventListener(TimerEvent.TIMER, this.onTimer, false, EventPriority.DEFAULT, true);
                }
                this.drawActionIcon();
                this.updateActionProperties();
                this.m_UncommittedAction = false;
            }
            if (this.m_UncommittedActionBar || this.m_UncommittedPosition)
            {
                this.drawLabel();
                this.m_UncommittedActionBar = false;
                this.m_UncommittedPosition = false;
            }
            if (this.m_UncommittedCooldownDelay)
            {
                if (this.cooldownDelay != null && this.cooldownDelay.contains(Tibia.s_FrameTibiaTimestamp))
                {
                    _loc_3 = this.cooldownDelay.end - Tibia.s_FrameTibiaTimestamp;
                    if (this.cooldownDelay.duration > 3000 && _loc_3 > 1000)
                    {
                        _loc_4 = int(_loc_3 / 1000);
                        if (_loc_4 > 60)
                        {
                            this.overlayText = String(int(_loc_4 / 60)) + ":" + String("0" + _loc_4 % 60).substr(-2);
                        }
                        else
                        {
                            this.overlayText = String(_loc_4);
                        }
                        this.m_OverlayPosition = OVERLAY_TOP;
                    }
                    this.m_CooldownPhase = int((1 - _loc_3 / this.cooldownDelay.duration) * 60);
                }
                else
                {
                    this.m_CooldownPhase = -1;
                }
                this.m_UncommittedCooldownDelay = false;
            }
            if (this.m_UncommittedOverlayText)
            {
                this.drawOverlayText();
                this.m_UncommittedOverlayText = false;
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

        private function drawLabel() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = this.m_UILabel.graphics;
            _loc_1.clear();
            s_Trans.a = 1;
            s_Trans.d = 1;
            if (this.actionBar != null)
            {
                _loc_2 = getStyle("backgroundLabelColor") ? (getStyle("backgroundLabelColor")) : (65280);
                _loc_3 = this.actionBar.location << 24 | this.position;
                _loc_4 = this.actionBar.getLabel(this.position);
                _loc_5 = s_LabelTextCache.getItem(_loc_3, _loc_4, _loc_2);
                s_Trans.tx = -_loc_5.x;
                s_Trans.ty = -_loc_5.y;
                _loc_1.beginBitmapFill(s_LabelTextCache, s_Trans, false);
                _loc_1.drawRect(0, 0, _loc_5.width, _loc_5.height);
                _loc_1.endFill();
            }
            return;
        }// end function

        private function set available(param1:Boolean) : void
        {
            if (this.m_Available != param1)
            {
                this.m_Available = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UISkinBackground = this.updateSkin("backgroundImage");
                this.m_UISkinCooldown = this.updateSkin("overlayCooldownImage");
                this.m_UISkinDisabled = this.updateSkin("overlayDisabledImage");
                this.m_UISkinHighlight = this.updateSkin("overlayHighlightImage");
                this.m_UILabel = new FlexShape();
                this.m_UILabel.cacheAsBitmap = true;
                this.m_UILabel.name = "label";
                addChild(this.m_UILabel);
                this.m_UIActionIcon = new FlexShape();
                this.m_UIActionIcon.cacheAsBitmap = true;
                this.m_UIActionIcon.name = "action";
                addChild(this.m_UIActionIcon);
                this.m_UICooldownMask = new FlexShape();
                this.m_UICooldownMask.cacheAsBitmap = false;
                this.m_UICooldownMask.name = "cooldownMask";
                addChild(this.m_UICooldownMask);
                this.drawCooldownMask();
                this.m_UIOverlay = new FlexShape();
                this.m_UIOverlay.cacheAsBitmap = true;
                this.m_UIOverlay.name = "overlay";
                addChild(this.m_UIOverlay);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        private function get overlayText() : String
        {
            return this.m_OverlayText;
        }// end function

        public function get position() : int
        {
            return this.m_Position;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            this.updateActionProperties();
            return;
        }// end function

        private function drawActionIcon() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = this.m_UIActionIcon.graphics;
            _loc_1.clear();
            s_Trans.a = 1;
            s_Trans.d = 1;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_8:* = this.m_ActionObject.type;
            _loc_3 = this.m_ActionObject.type;
            if (this.m_ActionObject != null && _loc_8 != null)
            {
                _loc_4 = this.m_ActionObject.getSprite(-1, -1, -1, -1);
                this.m_ActionIconCacheMiss = _loc_4.cacheMiss;
                if (this.m_LocalAppearanceBitmapCache == null || this.m_LocalAppearanceBitmapCache.width < _loc_4.rectangle.width || this.m_LocalAppearanceBitmapCache.height < _loc_4.rectangle.height)
                {
                    this.m_LocalAppearanceBitmapCache = new BitmapData(_loc_4.rectangle.width, _loc_4.rectangle.height);
                }
                this.m_LocalAppearanceBitmapCache.copyPixels(_loc_4.bitmapData, _loc_4.rectangle, s_ZeroPoint);
                s_Rect.setTo(0, 0, _loc_4.rectangle.width, _loc_4.rectangle.height);
                var _loc_8:* = ICON_SIZE / _loc_3.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize;
                s_Trans.d = ICON_SIZE / _loc_3.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize;
                s_Trans.a = _loc_8;
                _loc_2 = this.m_LocalAppearanceBitmapCache;
            }
            else if (this.m_ActionSpell != null)
            {
                _loc_2 = this.m_ActionSpell.getIcon(s_Rect);
            }
            else if (this.action is TalkAction)
            {
                _loc_5 = getStyle("overlayLabelColor") ? (getStyle("overlayLabelColor")) : (65280);
                _loc_6 = TalkAction(this.action).text;
                _loc_7 = s_TalkTextCache.getItem(_loc_6, _loc_6, _loc_5);
                _loc_2 = s_TalkTextCache;
                s_Rect.x = _loc_7.x;
                s_Rect.y = _loc_7.y;
                s_Rect.width = _loc_7.width;
                s_Rect.height = _loc_7.height;
            }
            if (_loc_2 != null)
            {
                s_Trans.tx = (-s_Rect.x) * s_Trans.a;
                s_Trans.ty = (-s_Rect.y) * s_Trans.d;
                s_Rect.width = s_Rect.width * s_Trans.a;
                s_Rect.height = s_Rect.height * s_Trans.d;
                _loc_1.beginBitmapFill(_loc_2, s_Trans, false, false);
                _loc_1.drawRect(0, 0, s_Rect.width, s_Rect.height);
                _loc_1.endFill();
            }
            return;
        }// end function

        private function onActionBarChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "actionBar")
            {
                this.actionBar = ActionBarWidget(owner).actionBar;
                this.drawLabel();
            }
            return;
        }// end function

        private function set cooldownDelay(param1:Delay) : void
        {
            if (param1 != null && param1.duration == 0)
            {
                param1 = null;
            }
            if (this.m_CooldownDelay != param1)
            {
                this.m_CooldownDelay = param1;
                this.m_UncommittedCooldownDelay = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        private function drawOverlayText() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = this.m_UIOverlay.graphics;
            _loc_1.clear();
            if (this.overlayText != null)
            {
                _loc_2 = getStyle("overlayLabelColor") ? (getStyle("overlayLabelColor")) : (65280);
                _loc_3 = s_OverlayTextCache.getItem(this.overlayText, this.overlayText, _loc_2);
                s_Trans.tx = -_loc_3.x;
                s_Trans.ty = -_loc_3.y;
                _loc_1.beginBitmapFill(s_OverlayTextCache, s_Trans, false);
                _loc_1.drawRect(0, 0, _loc_3.width, _loc_3.height);
                _loc_1.endFill();
            }
            return;
        }// end function

        private function get highlight() : Boolean
        {
            return this.m_Highlight;
        }// end function

        private function set overlayText(param1:String) : void
        {
            if (this.m_OverlayText != param1)
            {
                this.m_OverlayText = param1;
                this.m_OverlayPosition = OVERLAY_BOTTOM;
                this.m_UncommittedOverlayText = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "backgroundImage":
                {
                    this.m_UISkinBackground = this.updateSkin(param1);
                    invalidateDisplayList();
                    invalidateSize();
                    break;
                }
                case "overlayCooldownImage":
                {
                    this.m_UISkinCooldown = this.updateSkin(param1);
                    this.drawCooldownMask();
                    invalidateDisplayList();
                    break;
                }
                case "overlayDisabledImage":
                {
                    this.m_UISkinDisabled = this.updateSkin(param1);
                    invalidateDisplayList();
                    break;
                }
                case "overlayHighlightImage":
                {
                    this.m_UISkinHighlight = this.updateSkin(param1);
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

        public function set position(param1:int) : void
        {
            if (this.m_Position != param1)
            {
                this.m_Position = param1;
                this.m_UncommittedPosition = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        private function get available() : Boolean
        {
            return this.m_Available;
        }// end function

        public function get action() : IAction
        {
            return this.m_Action;
        }// end function

        private function get cooldownDelay() : Delay
        {
            return this.m_CooldownDelay;
        }// end function

        private function drawCooldownMask() : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_1:* = this.m_UICooldownMask.graphics;
            _loc_1.clear();
            if (this.m_UISkinCooldown != null)
            {
                _loc_2 = this.m_UISkinCooldown.width / 60;
                _loc_3 = this.m_UISkinCooldown.height;
                _loc_1.beginFill(65280, 1);
                _loc_1.drawRect(0, 0, _loc_2, _loc_3);
                _loc_1.endFill();
            }
            return;
        }// end function

        override public function set owner(param1:DisplayObjectContainer) : void
        {
            if (owner != param1)
            {
                if (owner is ActionBarWidget)
                {
                    owner.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onActionBarChange);
                }
                super.owner = param1;
                if (owner is ActionBarWidget)
                {
                    owner.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onActionBarChange, false, EventPriority.DEFAULT, true);
                }
            }
            return;
        }// end function

        private function updateActionProperties() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = Tibia.s_GetContainerStorage();
            var _loc_2:* = Tibia.s_GetPlayer();
            var _loc_3:* = Tibia.s_GetSpellStorage();
            if (_loc_1 == null || _loc_2 == null || _loc_3 == null)
            {
                return;
            }
            if (this.m_ActionObject != null)
            {
                _loc_4 = this.m_ActionObject.type;
                if (this.m_ActionIconCacheMiss || _loc_4 != null && (_loc_4.isAnimateAlways || _loc_4.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].isAnimation))
                {
                    this.m_ActionObject.animate(Tibia.s_FrameTibiaTimestamp);
                    this.drawActionIcon();
                }
                _loc_5 = _loc_1.getAvailableInventory(this.m_ActionObject.ID, this.m_ActionObject.data);
                _loc_6 = _loc_1.getBodyContainerView();
                this.available = (_loc_5 == -1 || _loc_5 > 0) && (this.m_ActionRune == null || _loc_2.getRuneUses(this.m_ActionRune) > 0);
                this.highlight = this.action is EquipAction && _loc_6 != null && _loc_6.isEquipped(this.m_ActionObject.ID);
                _loc_7 = null;
                if (this.action is UseAction && _loc_4.isMultiUse)
                {
                    _loc_7 = Delay.merge(_loc_1.getMultiUseDelay(), this.m_ActionRune != null ? (_loc_3.getRuneDelay(this.m_ActionRune.ID)) : (null));
                }
                this.cooldownDelay = _loc_7;
                if (_loc_5 >= 10000)
                {
                    this.overlayText = String(int(_loc_5 / 1000)) + "k+";
                }
                else if (_loc_5 > 0)
                {
                    this.overlayText = String(_loc_5);
                }
                else
                {
                    this.overlayText = null;
                }
            }
            else if (this.m_ActionSpell != null)
            {
                this.available = _loc_2.getSpellCasts(this.m_ActionSpell) > 0;
                this.highlight = false;
                this.cooldownDelay = _loc_3.getSpellDelay(this.m_ActionSpell.ID);
                this.overlayText = null;
            }
            else
            {
                this.available = true;
                this.cooldownDelay = null;
                this.highlight = false;
                this.overlayText = null;
            }
            return;
        }// end function

        public function set action(param1:IAction) : void
        {
            if (this.m_Action != param1)
            {
                this.m_Action = param1;
                this.m_UncommittedAction = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            if (this.m_UISkinBackground != null)
            {
                var _loc_1:* = this.m_UISkinBackground.width;
                measuredWidth = this.m_UISkinBackground.width;
                measuredMinWidth = _loc_1;
                var _loc_1:* = this.m_UISkinBackground.height;
                measuredHeight = this.m_UISkinBackground.height;
                measuredMinHeight = _loc_1;
            }
            else
            {
                var _loc_1:* = ICON_SIZE + getStyle("paddingLeft") + getStyle("paddingRight");
                measuredWidth = ICON_SIZE + getStyle("paddingLeft") + getStyle("paddingRight");
                measuredMinWidth = _loc_1;
                var _loc_1:* = ICON_SIZE + getStyle("paddingTop") + getStyle("paddingBottom");
                measuredHeight = ICON_SIZE + getStyle("paddingTop") + getStyle("paddingBottom");
                measuredMinHeight = _loc_1;
            }
            return;
        }// end function

        private function set highlight(param1:Boolean) : void
        {
            if (this.m_Highlight != param1)
            {
                this.m_Highlight = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        private function get actionBar() : ActionBar
        {
            return this.m_ActionBar;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_8:* = false;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = 0;
            if (this.m_UISkinBackground != null)
            {
                this.m_UISkinBackground.x = (param1 - this.m_UISkinBackground.width) / 2;
                this.m_UISkinBackground.y = (param2 - this.m_UISkinBackground.height) / 2;
                this.m_UISkinBackground.visible = true;
                setChildIndex(DisplayObject(this.m_UISkinBackground), _loc_3++);
            }
            var _loc_4:* = param2 - getStyle("paddingBottom");
            var _loc_5:* = getStyle("paddingLeft");
            var _loc_6:* = param1 - getStyle("paddingRight");
            var _loc_7:* = getStyle("paddingTop");
            if (this.m_UILabel != null)
            {
                this.m_UILabel.x = _loc_5;
                this.m_UILabel.y = _loc_4 - this.m_UILabel.height;
                this.m_UILabel.visible = this.action == null;
                setChildIndex(DisplayObject(this.m_UILabel), _loc_3++);
            }
            if (this.m_UIActionIcon != null)
            {
                this.m_UIActionIcon.x = _loc_6 - this.m_UIActionIcon.width;
                this.m_UIActionIcon.y = _loc_4 - this.m_UIActionIcon.height;
                this.m_UIActionIcon.visible = this.action != null;
                setChildIndex(DisplayObject(this.m_UIActionIcon), _loc_3++);
            }
            if (this.m_UISkinDisabled != null)
            {
                this.m_UISkinDisabled.x = (param1 - this.m_UISkinDisabled.width) / 2;
                this.m_UISkinDisabled.y = (param2 - this.m_UISkinDisabled.height) / 2;
                this.m_UISkinDisabled.visible = !this.available;
                setChildIndex(DisplayObject(this.m_UISkinDisabled), _loc_3++);
            }
            if (this.m_UICooldownMask != null && this.m_UISkinCooldown != null)
            {
                _loc_8 = this.m_CooldownPhase > -1;
                this.m_UICooldownMask.x = (param1 - this.m_UICooldownMask.width) / 2;
                this.m_UICooldownMask.y = (param2 - this.m_UICooldownMask.height) / 2;
                this.m_UICooldownMask.visible = _loc_8;
                setChildIndex(DisplayObject(this.m_UICooldownMask), _loc_3++);
                this.m_UISkinCooldown.mask = this.m_UICooldownMask;
                this.m_UISkinCooldown.x = this.m_UICooldownMask.x - this.m_CooldownPhase * this.m_UICooldownMask.width;
                this.m_UISkinCooldown.y = this.m_UICooldownMask.y;
                this.m_UISkinCooldown.visible = _loc_8;
                setChildIndex(DisplayObject(this.m_UISkinCooldown), _loc_3++);
            }
            if (this.m_UISkinHighlight != null)
            {
                this.m_UISkinHighlight.x = (param1 - this.m_UISkinDisabled.width) / 2;
                this.m_UISkinHighlight.y = (param2 - this.m_UISkinDisabled.height) / 2;
                this.m_UISkinHighlight.visible = this.highlight;
                setChildIndex(DisplayObject(this.m_UISkinHighlight), _loc_3++);
            }
            if (this.m_UIOverlay != null)
            {
                this.m_UIOverlay.x = _loc_6 - this.m_UIOverlay.width;
                this.m_UIOverlay.y = this.m_OverlayPosition == OVERLAY_BOTTOM ? (_loc_4 - this.m_UIOverlay.height) : (_loc_7);
                this.m_UIOverlay.visible = this.overlayText != null;
                setChildIndex(DisplayObject(this.m_UIOverlay), _loc_3++);
            }
            return;
        }// end function

        private static function initialiseStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration(Selector);
            }
            Decl.defaultFactory = function () : void
            {
                this.backgroundImage = undefined;
                this.backgroundColor = 0;
                this.backgroundAlpha = 1;
                this.backgroundLabelColor = 16777215;
                this.overlayCooldownImage = undefined;
                this.overlayDisabledImage = undefined;
                this.overlayHighlightImage = undefined;
                this.paddingBottom = 2;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        private static function initializeStatic() : void
        {
            var _loc_1:* = ActionBarSet.NUM_LOCATIONS * ActionBar.NUM_ACTIONS;
            var _loc_2:* = new TextFormat("Verdana", 10, 16777215);
            _loc_2.kerning = true;
            _loc_2.letterSpacing = -1;
            s_OverlayTextCache = new TextFieldCache(ICON_SIZE, TextFieldCache.DEFAULT_HEIGHT, 4 * _loc_1, false);
            s_OverlayTextCache.textFormat = _loc_2;
            s_LabelTextCache = new TextFieldCache(ICON_SIZE, TextFieldCache.DEFAULT_HEIGHT, _loc_1, false);
            s_LabelTextCache.textFormat = new TextFormat("Verdana", 8, 16777215);
            s_LabelTextCache.textFilters = null;
            s_TalkTextCache = new TalkActionIconCache(ICON_SIZE, ICON_SIZE, _loc_1, false);
            s_TalkTextCache.textFormat = new TextFormat("Verdana", 8, 16777215);
            s_TalkTextCache.textFilters = null;
            return;
        }// end function

        initializeStatic();
        initialiseStyle();
    }
}
