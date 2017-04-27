package tibia.creatures
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import tibia.game.*;

    public class CharacterProfileWidget extends PopUpBase
    {
        private var m_UISkills:Array;
        private var m_UIProfession:Label = null;
        private var m_UIName:Label = null;
        private var m_UncommittedPlayer:Boolean = false;
        private var m_Player:Player = null;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const PK_REVENGE:int = 6;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const RISKINESS_DANGEROUS:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        static const PK_PARTYMODE:int = 2;
        static const RISKINESS_NONE:int = 0;
        static const GUILD_NONE:int = 0;
        static const PARTY_MEMBER:int = 2;
        static const STATE_DRUNK:int = 3;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        static const TYPE_NPC:int = 2;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const SKILL_STAMINA:int = 17;
        static const STATE_NONE:int = -1;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
        public static const BUNDLE:String = "CharacterProfileWidget";
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        static const BLESSING_BLOOD_OF_THE_MOUNTAIN:int = BLESSING_HEART_OF_THE_MOUNTAIN << 1;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const STATE_PZ_ENTERED:int = 14;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        static const BLESSING_HEART_OF_THE_MOUNTAIN:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const SKILL_LIFE_LEECH_AMOUNT:int = 22;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        static const PROFESSION_SORCERER:int = 3;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const SKILL_CRITICAL_HIT_CHANCE:int = 19;
        static const SUMMON_OWN:int = 1;
        static const SKILL_EXPERIENCE_GAIN:int = -2;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_TWIST_OF_FATE << 1;
        static const PROFESSION_PALADIN:int = 2;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const STATE_FAST:int = 6;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_ADVENTURER << 1;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        static const BLESSING_NONE:int = 0;
        static const GUILD_OTHER:int = 5;
        static const TYPE_PLAYER:int = 0;
        static const SKILL_HITPOINTS:int = 4;
        static const SKILL_OFFLINETRAINING:int = 18;
        static const STATE_MANA_SHIELD:int = 4;
        static const SKILL_MANA:int = 5;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const STATE_CURSED:int = 11;
        static const BLESSING_ADVENTURER:int = 1;
        static const STATE_FREEZING:int = 9;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const STATE_POISONED:int = 0;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        static const TYPE_MONSTER:int = 1;
        static const STATE_BURNING:int = 1;
        static const SKILL_FIGHTFIST:int = 13;
        static const PK_AGGRESSOR:int = 3;
        static const GUILD_WAR_ENEMY:int = 2;
        static const SKILL_LEVEL:int = 1;
        static const STATE_STRENGTHENED:int = 12;
        static const STATE_HUNGRY:int = 31;
        static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
        static const SUMMON_NONE:int = 0;
        static const PROFESSION_DRUID:int = 4;
        static const STATE_FIGHTING:int = 7;
        static const NPC_SPEECH_QUEST:uint = 3;
        static const NPC_SPEECH_NORMAL:uint = 1;
        static const TYPE_PLAYERSUMMON:int = 3;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_FIRE_OF_SUNS << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function CharacterProfileWidget()
        {
            this.m_UISkills = [{skill:SKILL_LEVEL, label:"FORM_ITEM_LEVEL", renderer:null, leftSide:true}, {skill:SKILL_EXPERIENCE, label:"FORM_ITEM_EXPERIENCE", renderer:null, leftSide:true}, {skill:SKILL_EXPERIENCE_GAIN, label:"FORM_ITEM_EXPERIENCEGAIN", renderer:null, leftSide:true}, {skill:SKILL_HITPOINTS, label:"FORM_ITEM_HITPOINTS", renderer:null, leftSide:true}, {skill:SKILL_MANA, label:"FORM_ITEM_MANA", renderer:null, leftSide:true}, {skill:SKILL_CARRYSTRENGTH, label:"FORM_ITEM_CARRYSTRENGTH", renderer:null, leftSide:true}, {skill:SKILL_SOULPOINTS, label:"FORM_ITEM_SOULPOINTS", renderer:null, leftSide:true}, {skill:SKILL_STAMINA, label:"FORM_ITEM_STAMINA", renderer:null, leftSide:true}, {skill:SKILL_OFFLINETRAINING, label:"FORM_ITEM_OFFLINETRAINING", renderer:null, leftSide:true}, {skill:SKILL_GOSTRENGTH, label:"FORM_ITEM_GOSTRENGTH", renderer:null, leftSide:true}, {skill:SKILL_FED, label:"FORM_ITEM_FED", renderer:null, leftSide:true}, {skill:SKILL_MAGLEVEL, label:"FORM_ITEM_MAGLEVEL", renderer:null, leftSide:false}, {skill:SKILL_FIGHTFIST, label:"FORM_ITEM_FIGHTFIST", renderer:null, leftSide:false}, {skill:SKILL_FIGHTAXE, label:"FORM_ITEM_FIGHTAXE", renderer:null, leftSide:false}, {skill:SKILL_FIGHTCLUB, label:"FORM_ITEM_FIGHTCLUB", renderer:null, leftSide:false}, {skill:SKILL_FIGHTSWORD, label:"FORM_ITEM_FIGHTSWORD", renderer:null, leftSide:false}, {skill:SKILL_FIGHTDISTANCE, label:"FORM_ITEM_FIGHTDISTANCE", renderer:null, leftSide:false}, {skill:SKILL_FIGHTSHIELD, label:"FORM_ITEM_FIGHTSHIELD", renderer:null, leftSide:false}, {skill:SKILL_FISHING, label:"FORM_ITEM_FISHING", renderer:null, leftSide:false}, {skill:SKILL_CRITICAL_HIT_CHANCE, label:"FORM_ITEM_CRITICAL_HIT_CHANCE", renderer:null, leftSide:false}, {skill:SKILL_CRITICAL_HIT_DAMAGE, label:"FORM_ITEM_CRITICAL_HIT_DAMAGE", renderer:null, leftSide:false}, {skill:SKILL_LIFE_LEECH_CHANCE, label:"FORM_ITEM_LIFE_LEECH_CHANCE", renderer:null, leftSide:false}, {skill:SKILL_LIFE_LEECH_AMOUNT, label:"FORM_ITEM_LIFE_LEECH_AMOUNT", renderer:null, leftSide:false}, {skill:SKILL_MANA_LEECH_CHANCE, label:"FORM_ITEM_MANA_LEECH_CHANCE", renderer:null, leftSide:false}, {skill:SKILL_MANA_LEECH_AMOUNT, label:"FORM_ITEM_MANA_LEECH_AMOUNT", renderer:null, leftSide:false}];
            buttonFlags = PopUpBase.BUTTON_CLOSE;
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            title = resourceManager.getString(BUNDLE, "TITLE");
            width = 570;
            this.player = Tibia.s_GetPlayer();
            return;
        }// end function

        public function get player() : Player
        {
            return this.m_Player;
        }// end function

        private function updateSkills() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = null;
            for each (_loc_2 in this.m_UISkills)
            {
                
                var _loc_5:* = _loc_2.renderer as Label;
                _loc_1 = _loc_2.renderer as Label;
                if (_loc_5 != null)
                {
                    if (_loc_2.skill != SKILL_EXPERIENCE_GAIN)
                    {
                        _loc_1.htmlText = this.formatSkill(this.m_Player, _loc_2.skill);
                        continue;
                    }
                    _loc_1.htmlText = (this.m_Player.experienceGainInfo.computeXpGainModifier() * 100).toFixed(0) + "%";
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedPlayer)
            {
                if (this.player != null)
                {
                    this.m_UIName.htmlText = this.player.name;
                    this.m_UIProfession.htmlText = this.formatProfession(this.player.profession);
                }
                else
                {
                    this.m_UIName.htmlText = null;
                    this.m_UIProfession.htmlText = null;
                }
                this.updateSkills();
                this.m_UncommittedPlayer = false;
            }
            return;
        }// end function

        public function set player(param1:Player) : void
        {
            if (this.m_Player != param1)
            {
                if (this.m_Player != null)
                {
                    this.m_Player.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerChange);
                }
                this.m_Player = param1;
                this.m_UncommittedPlayer = true;
                invalidateProperties();
                if (this.m_Player != null)
                {
                    this.m_Player.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerChange);
                }
            }
            return;
        }// end function

        private function formatProfession(param1:int) : String
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case PROFESSION_DRUID:
                {
                    _loc_2 = "FORM_LABEL_PROFESSION_DRUID";
                    break;
                }
                case PROFESSION_KNIGHT:
                {
                    _loc_2 = "FORM_LABEL_PROFESSION_KNIGHT";
                    break;
                }
                case PROFESSION_PALADIN:
                {
                    _loc_2 = "FORM_LABEL_PROFESSION_PALADIN";
                    break;
                }
                case PROFESSION_SORCERER:
                {
                    _loc_2 = "FORM_LABEL_PROFESSION_SORCERER";
                    break;
                }
                case PROFESSION_NONE:
                {
                    _loc_2 = "FORM_LABEL_PROFESSION_NONE";
                    break;
                }
                default:
                {
                    return null;
                    break;
                }
            }
            return resourceManager.getString(BUNDLE, _loc_2);
        }// end function

        private function onPlayerChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "name")
            {
                this.m_UIName.htmlText = this.player.name;
            }
            else if (event.property == "skill" || event.property == "xpGain")
            {
                this.updateSkills();
            }
            else if (event.property == "profession")
            {
                this.m_UIProfession.htmlText = this.formatProfession(this.player.profession);
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_5:* = null;
            super.createChildren();
            var _loc_1:* = new HBox();
            _loc_1.percentHeight = 100;
            _loc_1.percentWidth = 100;
            _loc_1.setStyle("horizontalGap", 2);
            addChild(_loc_1);
            var _loc_2:* = new Form();
            _loc_2.percentHeight = 100;
            _loc_2.percentWidth = 50;
            var _loc_3:* = new Form();
            _loc_3.percentHeight = 100;
            _loc_3.percentWidth = 50;
            this.m_UIName = new Label();
            this.m_UIName.setStyle("fontWeight", "bold");
            var _loc_4:* = new FormItem();
            _loc_4.label = resourceManager.getString(BUNDLE, "FORM_ITEM_NAME");
            _loc_4.addChild(this.m_UIName);
            _loc_2.addChild(_loc_4);
            this.m_UIProfession = new Label();
            this.m_UIProfession.setStyle("fontWeight", "bold");
            _loc_4 = new FormItem();
            _loc_4.label = resourceManager.getString(BUNDLE, "FORM_ITEM_PROFESSION");
            _loc_4.addChild(this.m_UIProfession);
            _loc_2.addChild(_loc_4);
            for each (_loc_5 in this.m_UISkills)
            {
                
                if (_loc_5.renderer == null)
                {
                    _loc_5.renderer = new Label();
                    _loc_5.renderer.data = _loc_5.skill;
                    _loc_5.renderer.setStyle("fontWeight", "bold");
                    _loc_4 = new FormItem();
                    _loc_4.label = resourceManager.getString(BUNDLE, _loc_5.label);
                    _loc_4.addChild(_loc_5.renderer);
                    if (_loc_5.leftSide)
                    {
                        _loc_2.addChild(_loc_4);
                        continue;
                    }
                    _loc_3.addChild(_loc_4);
                }
            }
            _loc_1.addChild(_loc_2);
            _loc_1.addChild(_loc_3);
            return;
        }// end function

        private function formatSkill(param1:Player, param2:int) : String
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            if (param1 != null)
            {
                _loc_3 = param1.getSkillValue(param2);
                _loc_4 = param1.getSkillBase(param2);
                _loc_5 = 0;
                _loc_6 = param1.getSkillProgress(param2);
                if (param2 == SKILL_STAMINA || param2 == SKILL_OFFLINETRAINING)
                {
                    _loc_3 = Math.round(Math.max(0, _loc_3 - _loc_4) / (60 * 1000));
                    return String("0" + Math.floor(_loc_3 / 60)).substr(-2) + ":" + String("0" + Math.floor(_loc_3 % 60)).substr(-2) + ":00";
                }
                if (param2 == SKILL_FED)
                {
                    _loc_3 = Math.round(Math.max(0, _loc_3 - _loc_4) / 1000);
                    return "00:" + String("0" + Math.floor(_loc_3 / 60)).substr(-2) + ":" + String("0" + Math.floor(_loc_3 % 60)).substr(-2);
                }
                if (param2 == SKILL_HITPOINTS || param2 == SKILL_MANA)
                {
                    return String(_loc_3) + "/" + String(_loc_4);
                }
                if (param2 == SKILL_CARRYSTRENGTH)
                {
                    return (_loc_3 / 100).toFixed(2) + "/" + (_loc_4 / 100).toFixed(2);
                }
                if (param2 == SKILL_EXPERIENCE || param2 == SKILL_LEVEL || param2 == SKILL_SOULPOINTS)
                {
                    return String(_loc_3);
                }
                if (param2 == SKILL_CRITICAL_HIT_CHANCE || param2 == SKILL_CRITICAL_HIT_DAMAGE || param2 == SKILL_LIFE_LEECH_CHANCE || param2 == SKILL_LIFE_LEECH_AMOUNT || param2 == SKILL_MANA_LEECH_CHANCE || param2 == SKILL_MANA_LEECH_AMOUNT)
                {
                    _loc_5 = _loc_3 - _loc_4;
                    return String(_loc_5) + "%";
                }
                _loc_5 = _loc_3 - _loc_4;
                return String(_loc_4) + (_loc_5 >= 0 ? (" +") : (" ")) + String(_loc_5);
            }
            else
            {
                return null;
            }
        }// end function

    }
}
