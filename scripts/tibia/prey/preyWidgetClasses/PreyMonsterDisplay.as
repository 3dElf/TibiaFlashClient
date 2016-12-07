package tibia.prey.preyWidgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import mx.containers.*;
    import mx.controls.*;
    import shared.controls.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.prey.*;

    public class PreyMonsterDisplay extends HBox
    {
        private var m_UIBonusImage:Image = null;
        private var m_UICompleted:Boolean = false;
        private var m_BonusType:uint = 4;
        private var m_UncommittedMonster:Boolean = false;
        private var m_BonusValue:uint = 0;
        private var m_UIMonsterDisplay:SimpleAppearanceRenderer = null;
        private var m_UIBonusStars:Vector.<Image>;
        private var m_PreyMonster:AppearanceInstance = null;
        private var m_UINoMonster:Image = null;
        private var m_BonusGrade:uint = 0;
        private var m_UncommittedBonus:Boolean = false;
        private static const PREY_NO_BONUS_CLASS:Class = PreyMonsterDisplay_PREY_NO_BONUS_CLASS;
        private static const PREY_NO_PREY_CLASS:Class = PreyMonsterDisplay_PREY_NO_PREY_CLASS;
        private static const PREY_DAMAGE_REDUCTION_CLASS:Class = PreyMonsterDisplay_PREY_DAMAGE_REDUCTION_CLASS;
        private static const PREY_STAR_INACTIVE_CLASS:Class = PreyMonsterDisplay_PREY_STAR_INACTIVE_CLASS;
        public static const PREY_STAR_ACTIVE:BitmapData = Bitmap(new PREY_STAR_ACTIVE_CLASS()).bitmapData;
        public static const PREY_IMPROVED_LOOT:BitmapData = Bitmap(new PREY_IMPROVED_LOOT_CLASS()).bitmapData;
        public static const PREY_DAMAGE_BOOST:BitmapData = Bitmap(new PREY_DAMAGE_BOOST_CLASS()).bitmapData;
        private static const PREY_STAR_ACTIVE_CLASS:Class = PreyMonsterDisplay_PREY_STAR_ACTIVE_CLASS;
        public static const PREY_IMPROVED_XP:BitmapData = Bitmap(new PREY_IMPROVED_XP_CLASS()).bitmapData;
        private static const PREY_IMPROVED_LOOT_CLASS:Class = PreyMonsterDisplay_PREY_IMPROVED_LOOT_CLASS;
        public static const PREY_DAMAGE_REDUCTION:BitmapData = Bitmap(new PREY_DAMAGE_REDUCTION_CLASS()).bitmapData;
        public static const PREY_STAR_INACTIVE:BitmapData = Bitmap(new PREY_STAR_INACTIVE_CLASS()).bitmapData;
        public static const PREY_NO_BONUS:BitmapData = Bitmap(new PREY_NO_BONUS_CLASS()).bitmapData;
        public static const PREY_NO_PREY:BitmapData = Bitmap(new PREY_NO_PREY_CLASS()).bitmapData;
        private static const PREY_DAMAGE_BOOST_CLASS:Class = PreyMonsterDisplay_PREY_DAMAGE_BOOST_CLASS;
        private static const PREY_IMPROVED_XP_CLASS:Class = PreyMonsterDisplay_PREY_IMPROVED_XP_CLASS;

        public function PreyMonsterDisplay()
        {
            this.m_UIBonusStars = new Vector.<Image>;
            setStyle("verticalGap", 4);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            super.commitProperties();
            if (this.m_UncommittedMonster)
            {
                this.m_UIMonsterDisplay.appearance = this.m_PreyMonster;
                this.m_UIMonsterDisplay.patternX = 2;
                this.m_UIMonsterDisplay.patternY = 0;
                this.m_UIMonsterDisplay.patternZ = 0;
                (this.m_UIMonsterDisplay.parent as ShapeWrapper).visible = this.m_PreyMonster != null;
                (this.m_UIMonsterDisplay.parent as ShapeWrapper).includeInLayout = this.m_PreyMonster != null;
                (this.m_UIMonsterDisplay.parent as ShapeWrapper).invalidateSize();
                (this.m_UIMonsterDisplay.parent as ShapeWrapper).invalidateDisplayList();
                if (this.m_PreyMonster != null)
                {
                    if (contains(this.m_UINoMonster))
                    {
                        removeChild(this.m_UINoMonster);
                    }
                }
                else
                {
                    addChildAt(this.m_UINoMonster, 0);
                }
                this.m_UncommittedMonster = false;
            }
            if (this.m_UncommittedBonus)
            {
                this.m_UIBonusImage.removeChildren();
                _loc_1 = this.getBonusTypeBitmapData();
                this.m_UIBonusImage.addChild(new Bitmap(_loc_1));
                this.m_UIBonusImage.width = _loc_1.width;
                this.m_UIBonusImage.height = _loc_1.height;
                _loc_2 = 0;
                while (_loc_2 < this.m_UIBonusStars.length)
                {
                    
                    this.m_UIBonusStars[_loc_2].removeChildren();
                    this.m_UIBonusStars[_loc_2].addChild(new Bitmap(_loc_2 < this.m_BonusGrade ? (PREY_STAR_ACTIVE) : (PREY_STAR_INACTIVE)));
                    _loc_2++;
                }
                this.m_UncommittedBonus = false;
            }
            return;
        }// end function

        public function setMonster(param1:AppearanceInstance) : void
        {
            this.m_PreyMonster = param1;
            this.m_UncommittedMonster = true;
            invalidateProperties();
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            super.createChildren();
            if (!this.m_UICompleted)
            {
                _loc_1 = 128;
                this.m_UIMonsterDisplay = new SimpleAppearanceRenderer();
                this.m_UIMonsterDisplay.scale = 2;
                _loc_2 = new ShapeWrapper();
                _loc_2.explicitWidth = _loc_1;
                _loc_2.explicitHeight = _loc_1;
                _loc_2.setStyle("horizontalAlign", "right");
                _loc_2.setStyle("verticalAlign", "bottom");
                _loc_2.addChild(this.m_UIMonsterDisplay);
                addChild(_loc_2);
                this.m_UINoMonster = new Image();
                this.m_UINoMonster.addChild(new Bitmap(PREY_NO_PREY));
                this.m_UINoMonster.explicitWidth = _loc_1;
                this.m_UINoMonster.explicitHeight = _loc_1;
                this.m_UINoMonster.setStyle("horizontalAlign", "center");
                this.m_UINoMonster.setStyle("verticalAlign", "middle");
                _loc_3 = new VBox();
                _loc_3.percentWidth = 100;
                _loc_3.setStyle("horizontalAlign", "center");
                _loc_3.setStyle("paddingLeft", 15);
                addChild(_loc_3);
                this.m_UIBonusImage = new Image();
                _loc_3.addChild(this.m_UIBonusImage);
                _loc_4 = new HBox();
                _loc_4.percentWidth = 100;
                _loc_4.setStyle("horizontalGap", 2);
                _loc_3.addChild(_loc_4);
                _loc_5 = new HBox();
                _loc_5.percentWidth = 100;
                _loc_5.setStyle("horizontalGap", 2);
                _loc_3.addChild(_loc_5);
                _loc_6 = 0;
                while (_loc_6 < PreyData.PREY_MAXIMUM_GRADE)
                {
                    
                    _loc_7 = new Image();
                    _loc_7.width = PREY_STAR_ACTIVE.width;
                    _loc_7.height = PREY_STAR_ACTIVE.width;
                    if (_loc_6 < PreyData.PREY_MAXIMUM_GRADE / 2)
                    {
                        _loc_4.addChild(_loc_7);
                    }
                    else
                    {
                        _loc_5.addChild(_loc_7);
                    }
                    this.m_UIBonusStars.push(_loc_7);
                    _loc_6 = _loc_6 + 1;
                }
                this.m_UICompleted = true;
            }
            return;
        }// end function

        public function setBonus(param1:uint, param2:uint, param3:uint) : void
        {
            this.m_BonusType = param1;
            this.m_BonusValue = param2;
            this.m_BonusGrade = param3;
            this.m_UncommittedBonus = true;
            invalidateProperties();
            return;
        }// end function

        private function getBonusTypeBitmapData() : BitmapData
        {
            if (this.m_BonusType == PreyData.BONUS_DAMAGE_BOOST)
            {
                return PREY_DAMAGE_BOOST;
            }
            if (this.m_BonusType == PreyData.BONUS_DAMAGE_REDUCTION)
            {
                return PREY_DAMAGE_REDUCTION;
            }
            if (this.m_BonusType == PreyData.BONUS_IMPROVED_LOOT)
            {
                return PREY_IMPROVED_LOOT;
            }
            if (this.m_BonusType == PreyData.BONUS_XP_BONUS)
            {
                return PREY_IMPROVED_XP;
            }
            return PREY_NO_BONUS;
        }// end function

    }
}
