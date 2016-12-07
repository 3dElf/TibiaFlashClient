package tibia.prey.preyWidgetClasses
{
    import flash.display.*;
    import flash.filters.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import shared.utility.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.creatures.statusWidgetClasses.*;
    import tibia.prey.*;

    public class PreyListRenderer extends HBox implements IListItemRenderer, IDataRenderer
    {
        private var m_UIBonusImage:Image = null;
        private var m_UncommittedPrey:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        private var m_UINoMonster:Image = null;
        private var m_UIMonsterDisplay:SimpleAppearanceRenderer = null;
        private var m_UIProgress:BitmapProgressBar = null;
        private var m_UIMonsterName:Label = null;
        private static const BUNDLE:String = "PreyWidget";
        private static const PREY_NO_BONUS_CLASS:Class = PreyListRenderer_PREY_NO_BONUS_CLASS;
        private static const PREY_DAMAGE_REDUCTION_CLASS:Class = PreyListRenderer_PREY_DAMAGE_REDUCTION_CLASS;
        public static const PREY_IMPROVED_LOOT:BitmapData = Bitmap(new PREY_IMPROVED_LOOT_CLASS()).bitmapData;
        private static const PREY_NO_PREY_CLASS:Class = PreyListRenderer_PREY_NO_PREY_CLASS;
        public static const PREY_DAMAGE_BOOST:BitmapData = Bitmap(new PREY_DAMAGE_BOOST_CLASS()).bitmapData;
        public static const HEIGHT_HINT:int = 32;
        public static const MONSTER_SIZE:int = 32;
        public static const PREY_IMPROVED_XP:BitmapData = Bitmap(new PREY_IMPROVED_XP_CLASS()).bitmapData;
        private static const PREY_IMPROVED_LOOT_CLASS:Class = PreyListRenderer_PREY_IMPROVED_LOOT_CLASS;
        public static const PREY_DAMAGE_REDUCTION:BitmapData = Bitmap(new PREY_DAMAGE_REDUCTION_CLASS()).bitmapData;
        public static const PREY_NO_BONUS:BitmapData = Bitmap(new PREY_NO_BONUS_CLASS()).bitmapData;
        public static const PREY_NO_PREY:BitmapData = Bitmap(new PREY_NO_PREY_CLASS()).bitmapData;
        private static const PREY_DAMAGE_BOOST_CLASS:Class = PreyListRenderer_PREY_DAMAGE_BOOST_CLASS;
        private static const PREY_IMPROVED_XP_CLASS:Class = PreyListRenderer_PREY_IMPROVED_XP_CLASS;

        public function PreyListRenderer()
        {
            minHeight = HEIGHT_HINT;
            setStyle("verticalAlign", "middle");
            setStyle("horizontalGap", 2);
            return;
        }// end function

        private function getBonusTypeBitmapData(param1:uint) : BitmapData
        {
            if (param1 == PreyData.BONUS_DAMAGE_BOOST)
            {
                return PREY_DAMAGE_BOOST;
            }
            if (param1 == PreyData.BONUS_DAMAGE_REDUCTION)
            {
                return PREY_DAMAGE_REDUCTION;
            }
            if (param1 == PreyData.BONUS_IMPROVED_LOOT)
            {
                return PREY_IMPROVED_LOOT;
            }
            if (param1 == PreyData.BONUS_XP_BONUS)
            {
                return PREY_IMPROVED_XP;
            }
            return PREY_NO_BONUS;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.createChildren();
            if (!this.m_UIConstructed)
            {
                this.m_UIMonsterDisplay = new SimpleAppearanceRenderer();
                this.m_UIMonsterDisplay.scale = 0.5;
                _loc_1 = new ShapeWrapper();
                _loc_1.explicitWidth = MONSTER_SIZE;
                _loc_1.explicitHeight = MONSTER_SIZE;
                _loc_1.setStyle("horizontalAlign", "right");
                _loc_1.setStyle("verticalAlign", "bottom");
                _loc_1.addChild(this.m_UIMonsterDisplay);
                addChild(_loc_1);
                this.m_UINoMonster = new Image();
                this.m_UINoMonster.addChild(new Bitmap(PREY_NO_PREY));
                this.m_UINoMonster.width = MONSTER_SIZE;
                this.m_UINoMonster.height = PREY_NO_PREY.height;
                this.m_UIBonusImage = new Image();
                addChild(this.m_UIBonusImage);
                _loc_2 = new VBox();
                _loc_2.percentWidth = 100;
                _loc_2.setStyle("verticalGap", 0);
                addChild(_loc_2);
                this.m_UIMonsterName = new Label();
                this.m_UIMonsterName.setStyle("fontSize", 11);
                this.m_UIMonsterName.setStyle("fontWeight", "bold");
                this.m_UIMonsterName.width = 125;
                this.m_UIMonsterName.truncateToFit = true;
                this.m_UIMonsterName.filters = [new GlowFilter(0, 1, 2, 2, 4, BitmapFilterQuality.LOW, false, false)];
                _loc_2.addChild(this.m_UIMonsterName);
                this.m_UIProgress = new BitmapProgressBar();
                this.m_UIProgress.width = this.m_UIMonsterName.width;
                this.m_UIProgress.styleName = "preyDurationProgressSidebar";
                this.m_UIProgress.minValue = 0;
                this.m_UIProgress.maxValue = PreyData.PREY_FULL_DURATION;
                _loc_2.addChild(this.m_UIProgress);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.commitProperties();
            if (this.m_UncommittedPrey)
            {
                _loc_1 = data as PreyData;
                if (_loc_1 != null)
                {
                    var _loc_3:* = _loc_1.state != PreyData.STATE_LOCKED;
                    includeInLayout = _loc_1.state != PreyData.STATE_LOCKED;
                    visible = _loc_3;
                    removeChildAt(0);
                    if (_loc_1.state == PreyData.STATE_ACTIVE)
                    {
                        addChildAt(this.m_UIMonsterDisplay.parent, 0);
                    }
                    else
                    {
                        addChildAt(this.m_UINoMonster, 0);
                    }
                    if (_loc_1.monster != null)
                    {
                        this.m_UIMonsterDisplay.appearance = _loc_1.monster.monsterAppearanceInstance;
                        this.m_UIMonsterDisplay.patternX = 2;
                        this.m_UIMonsterDisplay.patternY = 0;
                        this.m_UIMonsterDisplay.patternZ = 0;
                        (this.m_UIMonsterDisplay.parent as ShapeWrapper).invalidateSize();
                        (this.m_UIMonsterDisplay.parent as ShapeWrapper).invalidateDisplayList();
                        this.m_UIMonsterName.text = _loc_1.monster.monsterName;
                    }
                    else
                    {
                        this.m_UIMonsterName.text = resourceManager.getString(BUNDLE, "PREY_INACTIVE");
                    }
                    this.m_UIBonusImage.removeChildren();
                    _loc_2 = this.getBonusTypeBitmapData(_loc_1.bonusType);
                    this.m_UIBonusImage.addChild(new Bitmap(_loc_2));
                    this.m_UIBonusImage.width = _loc_2.width;
                    this.m_UIBonusImage.height = _loc_2.height;
                    if (_loc_1.state == PreyData.STATE_ACTIVE)
                    {
                        toolTip = resourceManager.getString(BUNDLE, "TOOLTIP_PREY_ACTIVE", [_loc_1.monster.monsterName, StringHelper.s_MillisecondsToTimeString(_loc_1.preyTimeLeft * 60 * 1000, false).slice(0, -3), _loc_1.bonusGrade, PreyData.PREY_MAXIMUM_GRADE, _loc_1.generateBonusString(), _loc_1.generateBonusDescription()]);
                    }
                    else
                    {
                        toolTip = resourceManager.getString(BUNDLE, "TOOLTIP_PREY_INACTIVE");
                    }
                    this.m_UIProgress.value = _loc_1.preyTimeLeft;
                }
                else
                {
                    var _loc_3:* = false;
                    includeInLayout = false;
                    visible = _loc_3;
                }
                (parent as Box).invalidateDisplayList();
                (parent as Box).invalidateSize();
                this.m_UncommittedPrey = false;
            }
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            if (data != null)
            {
                (data as PreyData).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPreyDataChanged);
            }
            super.data = param1;
            this.m_UncommittedPrey = true;
            invalidateProperties();
            if (data != null)
            {
                (data as PreyData).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPreyDataChanged);
            }
            return;
        }// end function

        protected function onPreyDataChanged(event:PropertyChangeEvent) : void
        {
            this.m_UncommittedPrey = true;
            invalidateProperties();
            return;
        }// end function

    }
}
