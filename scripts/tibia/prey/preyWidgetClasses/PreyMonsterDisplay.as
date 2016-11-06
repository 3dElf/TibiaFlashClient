package tibia.prey.preyWidgetClasses
{
    import flash.display.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.utils.*;
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
        private var m_PreyMonster:AppearanceInstance = null;
        private var m_UINoMonster:Image = null;
        private var m_UncommittedBonus:Boolean = false;
        private var m_UIBonusText:Label = null;
        private static const PREY_NO_BONUS_CLASS:Class = PreyMonsterDisplay_PREY_NO_BONUS_CLASS;
        private static const PREY_DAMAGE_REDUCTION_CLASS:Class = PreyMonsterDisplay_PREY_DAMAGE_REDUCTION_CLASS;
        private static const PREY_NO_PREY_CLASS:Class = PreyMonsterDisplay_PREY_NO_PREY_CLASS;
        public static const PREY_IMPROVED_XP:BitmapData = Bitmap(new PREY_IMPROVED_XP_CLASS()).bitmapData;
        private static const PREY_IMPROVED_LOOT_CLASS:Class = PreyMonsterDisplay_PREY_IMPROVED_LOOT_CLASS;
        public static const PREY_DAMAGE_REDUCTION:BitmapData = Bitmap(new PREY_DAMAGE_REDUCTION_CLASS()).bitmapData;
        public static const PREY_IMPROVED_LOOT:BitmapData = Bitmap(new PREY_IMPROVED_LOOT_CLASS()).bitmapData;
        private static const PREY_DAMAGE_BOOST_CLASS:Class = PreyMonsterDisplay_PREY_DAMAGE_BOOST_CLASS;
        public static const PREY_NO_BONUS:BitmapData = Bitmap(new PREY_NO_BONUS_CLASS()).bitmapData;
        public static const PREY_NO_PREY:BitmapData = Bitmap(new PREY_NO_PREY_CLASS()).bitmapData;
        private static const PREY_IMPROVED_XP_CLASS:Class = PreyMonsterDisplay_PREY_IMPROVED_XP_CLASS;
        public static const PREY_DAMAGE_BOOST:BitmapData = Bitmap(new PREY_DAMAGE_BOOST_CLASS()).bitmapData;

        public function PreyMonsterDisplay()
        {
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
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
                if (this.m_BonusType == PreyData.BONUS_NONE)
                {
                    this.m_UIBonusText.text = "+??%";
                }
                else
                {
                    this.m_UIBonusText.text = StringUtil.substitute("+{0}%", this.m_BonusValue);
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
                addChild(_loc_3);
                this.m_UIBonusImage = new Image();
                _loc_3.addChild(this.m_UIBonusImage);
                this.m_UIBonusText = new Label();
                this.m_UIBonusText.percentWidth = 100;
                this.m_UIBonusText.setStyle("textAlign", "center");
                this.m_UIBonusText.setStyle("fontWeight", "bold");
                _loc_3.addChild(this.m_UIBonusText);
                this.m_UICompleted = true;
            }
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

        public function setBonus(param1:uint, param2:uint) : void
        {
            this.m_BonusType = param1;
            this.m_BonusValue = param2;
            this.m_UncommittedBonus = true;
            invalidateProperties();
            return;
        }// end function

    }
}
