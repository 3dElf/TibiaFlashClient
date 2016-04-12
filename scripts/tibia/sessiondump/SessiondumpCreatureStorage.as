package tibia.sessiondump
{
    import flash.utils.*;
    import tibia.appearances.*;
    import tibia.creatures.*;

    public class SessiondumpCreatureStorage extends CreatureStorage
    {
        protected var m_KeyframeCreatures:Dictionary = null;
        private var m_KeyframeCreaturesGot:uint = 0;

        public function SessiondumpCreatureStorage()
        {
            m_MaxCreaturesCount = uint.MAX_VALUE;
            this.resetKeyframeCreatures();
            return;
        }// end function

        override public function replaceCreature(param1:Creature, param2:int = 0) : Creature
        {
            var _loc_3:* = null;
            if (param2 != 0)
            {
                _loc_3 = super.getCreature(param2);
                if (_loc_3 == null)
                {
                    param2 = 0;
                }
            }
            else if (param1.ID != 0 && param1.ID != m_Player.ID)
            {
                _loc_3 = super.getCreature(param1.ID);
                if (_loc_3 != null)
                {
                    param2 = param1.ID;
                }
            }
            return super.replaceCreature(param1, param2);
        }// end function

        override public function getCreature(param1:int) : Creature
        {
            var _loc_3:* = null;
            var _loc_2:* = super.getCreature(param1);
            if (_loc_2 == null)
            {
                if (param1 in this.m_KeyframeCreatures)
                {
                    _loc_2 = this.m_KeyframeCreatures[param1] as Creature;
                    var _loc_4:* = this;
                    var _loc_5:* = this.m_KeyframeCreaturesGot + 1;
                    _loc_4.m_KeyframeCreaturesGot = _loc_5;
                    super.replaceCreature(_loc_2, 0);
                    this.m_KeyframeCreatures[param1] = null;
                }
            }
            if (_loc_2 == null)
            {
                _loc_3 = Tibia.s_GetAppearanceStorage();
                _loc_2 = new Creature(param1);
                _loc_2.type = TYPE_MONSTER;
                _loc_2.name = "Unknown";
                _loc_2.outfit = _loc_3.createOutfitInstance(1, 0, 0, 0, 0, 0);
                _loc_2.setSkillValue(SKILL_HITPOINTS_PERCENT, 100);
                _loc_2.setSkillValue(SKILL_GOSTRENGTH, 100);
                this.addKeyframeCreature(_loc_2);
            }
            return _loc_2;
        }// end function

        public function resetKeyframeCreatures() : void
        {
            this.m_KeyframeCreatures = new Dictionary();
            return;
        }// end function

        override public function removeCreature(param1:int) : void
        {
            var _loc_2:* = super.getCreature(param1);
            if (_loc_2 != null)
            {
                super.removeCreature(param1);
            }
            return;
        }// end function

        public function getKeyframeCreature(param1:int) : Creature
        {
            return this.m_KeyframeCreatures[param1] as Creature;
        }// end function

        public function addKeyframeCreature(param1:Creature) : void
        {
            if (param1 != null)
            {
                this.m_KeyframeCreatures[param1.ID] = param1;
            }
            return;
        }// end function

    }
}
