package tibia.input.gameaction
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.resources.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.chat.*;
    import tibia.creatures.*;
    import tibia.cursors.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.network.*;
    import tibia.worldmap.*;

    public class SafeTradeActionImpl extends Object implements IActionImpl
    {
        protected var m_Absolute:Vector3D = null;
        private var m_ListenersRegistered:Boolean = false;
        protected var m_Object:ObjectInstance = null;
        protected var m_Position:int = -1;
        private var m_CursorHelper:CursorHelper;
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
        static const TYPE_SUMMON_OTHERS:int = 4;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const SKILL_STAMINA:int = 17;
        static const TYPE_NPC:int = 2;
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
        private static const BUNDLE:String = "SafeTradeWidget";
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        static const STATE_PZ_ENTERED:int = 14;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
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
        static const TYPE_SUMMON_OWN:int = 3;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        static const PROFESSION_PALADIN:int = 2;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const STATE_FAST:int = 6;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
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
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function SafeTradeActionImpl(param1:Vector3D, param2:ObjectInstance, param3:int)
        {
            this.m_CursorHelper = new CursorHelper(CursorManagerPriority.HIGH);
            if (param1 == null || param1.x == 65535 && param1.y == 0)
            {
                throw new ArgumentError("SafeTradeActionImpl.SafeTradeActionImpl: Invalid co-ordinate.");
            }
            this.m_Absolute = param1;
            this.m_Position = param3;
            if (param2 == null)
            {
                throw new ArgumentError("SafeTradeActionImpl.SafeTradeActionImpl: Invalid object.");
            }
            this.m_Object = param2;
            return;
        }// end function

        private function cancelEvent(event:Event) : void
        {
            if (event != null)
            {
                if (event.cancelable)
                {
                    event.preventDefault();
                }
                event.stopImmediatePropagation();
                event.stopPropagation();
            }
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            this.registerListeners(true);
            this.registerCursor(true);
            return;
        }// end function

        private function onAbort(event:Event) : void
        {
            if (event != null)
            {
                this.cancelEvent(event);
                this.registerCursor(false);
                this.registerListeners(false);
            }
            return;
        }// end function

        private function registerCursor(param1:Boolean) : void
        {
            if (param1)
            {
                this.m_CursorHelper.setCursor(CrosshairCursor);
            }
            else
            {
                this.m_CursorHelper.setCursor(null);
            }
            return;
        }// end function

        private function onPerform(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (event != null)
            {
                this.cancelEvent(event);
                this.registerCursor(false);
                this.registerListeners(false);
                _loc_2 = null;
                _loc_3 = event.target as InteractiveObject;
                do
                {
                    
                    _loc_3 = _loc_3.parent;
                    var _loc_10:* = _loc_3 as IUseWidget;
                    _loc_2 = _loc_3 as IUseWidget;
                }while (_loc_3 != null && _loc_10 == null)
                if (_loc_2 == null)
                {
                    return;
                }
                _loc_4 = Tibia.s_GetCreatureStorage();
                if (_loc_4 == null)
                {
                    return;
                }
                _loc_5 = Tibia.s_GetPlayer();
                if (_loc_5 == null)
                {
                    return;
                }
                _loc_6 = null;
                _loc_7 = _loc_2.getMultiUseObjectUnderPoint(new Point(event.stageX, event.stageY));
                var _loc_10:* = _loc_4.getCreature(_loc_7.object.data);
                _loc_6 = _loc_4.getCreature(_loc_7.object.data);
                if (_loc_7 == null || !(_loc_7.object is ObjectInstance) || _loc_7.object.ID != AppearanceInstance.CREATURE || _loc_10 == null || _loc_6.type != TYPE_PLAYER || _loc_6.ID == _loc_5.ID)
                {
                    _loc_9 = Tibia.s_GetWorldMapStorage();
                    if (_loc_9 != null)
                    {
                        _loc_9.addOnscreenMessage(MessageMode.MESSAGE_FAILURE, ResourceManager.getInstance().getString(BUNDLE, "MSG_INVALID_PARTNER"));
                    }
                    return;
                }
                _loc_8 = Tibia.s_GetCommunication();
                if (_loc_8 != null && _loc_8.isGameRunning)
                {
                    _loc_8.sendCTRADEOBJECT(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z, this.m_Object.type.ID, this.m_Position, _loc_6.ID);
                }
            }
            return;
        }// end function

        private function registerListeners(param1:Boolean) : void
        {
            var _loc_2:* = Tibia.s_GetInstance().systemManager.getSandboxRoot();
            if (param1 && !this.m_ListenersRegistered)
            {
                _loc_2.addEventListener(MouseEvent.MOUSE_UP, this.onPerform, true, EventPriority.DEFAULT, false);
                _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, this.cancelEvent, true, EventPriority.DEFAULT, false);
                _loc_2.addEventListener(MouseEvent.CLICK, this.cancelEvent, true, EventPriority.DEFAULT, false);
                _loc_2.addEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onAbort, true, EventPriority.DEFAULT, false);
                _loc_2.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.cancelEvent, true, EventPriority.DEFAULT, false);
                _loc_2.addEventListener(MouseEvent.RIGHT_CLICK, this.cancelEvent, true, EventPriority.DEFAULT, false);
                _loc_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onAbort);
                _loc_2.addEventListener(Event.DEACTIVATE, this.onAbort);
            }
            else if (!param1 && this.m_ListenersRegistered)
            {
                _loc_2.removeEventListener(MouseEvent.MOUSE_UP, this.onPerform, true);
                _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.cancelEvent, true);
                _loc_2.removeEventListener(MouseEvent.CLICK, this.cancelEvent, true);
                _loc_2.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onAbort, true);
                _loc_2.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.cancelEvent, true);
                _loc_2.removeEventListener(MouseEvent.RIGHT_CLICK, this.cancelEvent, true);
                _loc_2.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onAbort);
                _loc_2.removeEventListener(Event.DEACTIVATE, this.onAbort);
            }
            this.m_ListenersRegistered = param1;
            return;
        }// end function

    }
}
