package tibia.creatures.battlelistWidgetClasses
{
    import flash.events.*;
    import flash.system.*;
    import mx.core.*;
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.game.*;
    import tibia.input.gameaction.*;
    import tibia.options.*;
    import tibia.reporting.*;
    import tibia.reporting.reportType.*;

    public class BattlelistItemContextMenu extends ContextMenuBase
    {
        protected var m_Creature:Creature = null;
        protected var m_CreatureStorage:CreatureStorage = null;
        protected var m_Options:OptionsStorage = null;
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
        private static const BUNDLE:String = "BattlelistWidget";
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
        private static const SORT_OPTIONS:Array = [{value:CreatureStorage.SORT_KNOWN_SINCE_ASC, label:"CTX_SORT_KNOWN_SINCE_ASC"}, {value:CreatureStorage.SORT_KNOWN_SINCE_DESC, label:"CTX_SORT_KNOWN_SINCE_DESC"}, {value:CreatureStorage.SORT_DISTANCE_ASC, label:"CTX_SORT_DISTANCE_ASC"}, {value:CreatureStorage.SORT_DISTANCE_DESC, label:"CTX_SORT_DISTANCE_DESC"}, {value:CreatureStorage.SORT_HITPOINTS_ASC, label:"CTX_SORT_HITPOINTS_ASC"}, {value:CreatureStorage.SORT_HITPOINTS_DESC, label:"CTX_SORT_HITPOINTS_DESC"}, {value:CreatureStorage.SORT_NAME_ASC, label:"CTX_SORT_NAME_ASC"}, {value:CreatureStorage.SORT_NAME_DESC, label:"CTX_SORT_NAME_DESC"}];
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

        public function BattlelistItemContextMenu(param1:OptionsStorage, param2:CreatureStorage, param3:Creature)
        {
            if (param1 == null)
            {
                throw new ArgumentError("BattlelistItemContextMenu.BattlelistItemContextMenu: Invalid options reference.");
            }
            if (param2 == null)
            {
                throw new ArgumentError("BattlelistItemContextMenu.BattlelistItemContextMenu: Invalid creature storage.");
            }
            this.m_Options = param1;
            this.m_CreatureStorage = param2;
            this.m_Creature = param3;
            return;
        }// end function

        private function onRollOver(event:MouseEvent) : void
        {
            this.m_CreatureStorage.setAim(this.m_Creature);
            return;
        }// end function

        override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
        {
            var a_Owner:* = param1;
            var a_StageX:* = param2;
            var a_StageY:* = param3;
            addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            this.m_CreatureStorage.setAim(this.m_Creature);
            if (this.m_Creature != null)
            {
                if (this.m_Creature.isNPC)
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_CREATURE_TALK"), function (param1) : void
            {
                Tibia.s_GameActionFactory.createGreetAction(m_Creature).perform();
                return;
            }// end function
            );
                }
                else
                {
                    createTextItem(resourceManager.getString(BUNDLE, this.m_CreatureStorage.getAttackTarget() == this.m_Creature ? ("CTX_STOP_ATTACK") : ("CTX_START_ATTACK")), function (param1) : void
            {
                Tibia.s_GameActionFactory.createToggleAttackTargetAction(m_Creature, true).perform();
                return;
            }// end function
            );
                }
                createTextItem(resourceManager.getString(BUNDLE, this.m_CreatureStorage.getFollowTarget() == this.m_Creature ? ("CTX_STOP_FOLLOW") : ("CTX_START_FOLLOW")), function (param1) : void
            {
                m_CreatureStorage.toggleFollowTarget(m_Creature, true);
                return;
            }// end function
            );
                if (this.m_Creature.isConfirmedPartyMember)
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_PARTY_JOIN_AGGRESSION", [this.m_Creature.name]), function (param1) : void
            {
                new PartyActionImpl(PartyActionImpl.JOIN_AGGRESSION, m_Creature).perform();
                return;
            }// end function
            );
                }
                createSeparatorItem();
            }
            if (this.m_Creature != null && this.m_Creature.isHuman)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_PRIVATE_MESSAGE", [this.m_Creature.name]), function (param1) : void
            {
                new PrivateChatActionImpl(PrivateChatActionImpl.OPEN_MESSAGE_CHANNEL, PrivateChatActionImpl.CHAT_CHANNEL_NO_CHANNEL, m_Creature.name).perform();
                return;
            }// end function
            );
                if (Tibia.s_GetChatStorage().hasOwnPrivateChannel)
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_PRIVATE_CHAT"), function (param1) : void
            {
                new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_INVITE, Tibia.s_GetChatStorage().ownPrivateChannelID, m_Creature.name).perform();
                return;
            }// end function
            );
                }
                if (!BuddylistActionImpl.s_IsBuddy(this.m_Creature.ID))
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_BUDDY"), function (param1) : void
            {
                new BuddylistActionImpl(BuddylistActionImpl.ADD_BY_NAME, m_Creature.name).perform();
                return;
            }// end function
            );
                }
                if (NameFilterActionImpl.s_IsBlacklisted(this.m_Creature.name))
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_UNIGNORE", [this.m_Creature.name]), function (param1) : void
            {
                new NameFilterActionImpl(NameFilterActionImpl.UNIGNORE, m_Creature.name).perform();
                return;
            }// end function
            );
                }
                else
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_IGNORE", [this.m_Creature.name]), function (param1) : void
            {
                new NameFilterActionImpl(NameFilterActionImpl.IGNORE, m_Creature.name).perform();
                return;
            }// end function
            );
                }
                if (this.m_CreatureStorage.player != null)
                {
                    switch(this.m_CreatureStorage.player.partyFlag)
                    {
                        case PARTY_LEADER:
                        {
                            if (this.m_Creature.partyFlag == PARTY_MEMBER)
                            {
                                createTextItem(resourceManager.getString(BUNDLE, "CTX_PARTY_EXCLUDE", [this.m_Creature.name]), function (param1) : void
            {
                new PartyActionImpl(PartyActionImpl.EXCLUDE, m_Creature).perform();
                return;
            }// end function
            );
                            }
                            break;
                        }
                        case PARTY_LEADER_SEXP_ACTIVE:
                        case PARTY_LEADER_SEXP_INACTIVE_GUILTY:
                        case PARTY_LEADER_SEXP_INACTIVE_INNOCENT:
                        case PARTY_LEADER_SEXP_OFF:
                        {
                            if (this.m_Creature.partyFlag == PARTY_MEMBER)
                            {
                                createTextItem(resourceManager.getString(BUNDLE, "CTX_PARTY_EXCLUDE", [this.m_Creature.name]), function (param1) : void
            {
                new PartyActionImpl(PartyActionImpl.EXCLUDE, m_Creature).perform();
                return;
            }// end function
            );
                            }
                            else if (this.m_Creature.partyFlag == PARTY_MEMBER_SEXP_ACTIVE || this.m_Creature.partyFlag == PARTY_MEMBER_SEXP_INACTIVE_GUILTY || this.m_Creature.partyFlag == PARTY_MEMBER_SEXP_INACTIVE_INNOCENT || this.m_Creature.partyFlag == PARTY_MEMBER_SEXP_OFF)
                            {
                                createTextItem(resourceManager.getString(BUNDLE, "CTX_PARTY_PASS_LEADERSHIP", [this.m_Creature.name]), function (param1) : void
            {
                new PartyActionImpl(PartyActionImpl.PASS_LEADERSHIP, m_Creature).perform();
                return;
            }// end function
            );
                            }
                            else
                            {
                                createTextItem(resourceManager.getString(BUNDLE, "CTX_PARTY_INVITE"), function (param1) : void
            {
                new PartyActionImpl(PartyActionImpl.INVITE, m_Creature).perform();
                return;
            }// end function
            );
                            }
                            break;
                        }
                        case PARTY_MEMBER:
                        case PARTY_NONE:
                        {
                            if (this.m_Creature.partyFlag == PARTY_LEADER)
                            {
                                createTextItem(resourceManager.getString(BUNDLE, "CTX_PARTY_JOIN", [this.m_Creature.name]), function (param1) : void
            {
                new PartyActionImpl(PartyActionImpl.JOIN, m_Creature).perform();
                return;
            }// end function
            );
                            }
                            else if (this.m_Creature.partyFlag != PARTY_OTHER)
                            {
                                createTextItem(resourceManager.getString(BUNDLE, "CTX_PARTY_INVITE"), function (param1) : void
            {
                new PartyActionImpl(PartyActionImpl.INVITE, m_Creature).perform();
                return;
            }// end function
            );
                            }
                            break;
                        }
                        case PARTY_MEMBER_SEXP_ACTIVE:
                        case PARTY_MEMBER_SEXP_INACTIVE_GUILTY:
                        case PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:
                        case PARTY_MEMBER_SEXP_OFF:
                        {
                        }
                        default:
                        {
                            break;
                            break;
                        }
                    }
                }
                createTextItem(resourceManager.getString(BUNDLE, "CTX_INSPECT_CHARACTER", [this.m_Creature.name]), function (param1) : void
            {
                var _loc_2:* = new Tibia11NagWidget();
                _loc_2.show();
                return;
            }// end function
            );
                createSeparatorItem();
            }
            if (this.m_Creature != null)
            {
                if (this.m_Creature.isReportTypeAllowed(Type.REPORT_NAME))
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_REPORT_NAME"), function (param1) : void
            {
                new ReportWidget(Type.REPORT_NAME, m_Creature).show();
                return;
            }// end function
            );
                }
                if (this.m_Creature.isReportTypeAllowed(Type.REPORT_BOT))
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_REPORT_BOT"), function (param1) : void
            {
                new ReportWidget(Type.REPORT_BOT, m_Creature).show();
                return;
            }// end function
            );
                }
                createSeparatorItem();
            }
            if (this.m_Creature != null)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_COPY_NAME"), function (param1) : void
            {
                System.setClipboard(m_Creature.name);
                return;
            }// end function
            );
                createSeparatorItem();
            }
            var i:int;
            while (i < SORT_OPTIONS.length)
            {
                
                if (this.m_Options.opponentSort != SORT_OPTIONS[i].value)
                {
                    createTextItem(resourceManager.getString(BUNDLE, SORT_OPTIONS[i].label), closure(null, function (param1:OptionsStorage, param2:int, param3) : void
            {
                param1.opponentSort = param2;
                return;
            }// end function
            , this.m_Options, SORT_OPTIONS[i].value));
                }
                i = (i + 1);
            }
            super.display(a_Owner, a_StageX, a_StageY);
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            this.m_CreatureStorage.setAim(null);
            return;
        }// end function

        override public function hide() : void
        {
            this.m_CreatureStorage.setAim(null);
            removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            super.hide();
            return;
        }// end function

    }
}
