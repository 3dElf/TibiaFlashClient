package tibia.magic.spellListWidgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import tibia.creatures.*;
    import tibia.magic.*;

    public class SpellTileRenderer extends HBox
    {
        private var m_UncommittedSelected:Boolean = false;
        private var m_Selected:Boolean = false;
        private var m_UncommittedPlayer:Boolean = false;
        private var m_Player:Player = null;
        private var m_Available:Boolean = true;
        private var m_UncommittedSpell:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        private var m_Spell:Spell = null;
        private var m_UncommittedAvailable:Boolean = false;
        private var m_UISpellIcon:SpellIconRenderer = null;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        static const DRAG_TYPE_CHANNEL:String = "channel";
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const PK_REVENGE:int = 6;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const RISKINESS_DANGEROUS:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        static const GUILD_NONE:int = 0;
        static const PK_PARTYMODE:int = 2;
        static const RISKINESS_NONE:int = 0;
        static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
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
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        static const DRAG_TYPE_ACTION:String = "action";
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
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
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        static const PROFESSION_SORCERER:int = 3;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const SUMMON_OWN:int = 1;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const TYPE_SUMMON_OWN:int = 3;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        static const PROFESSION_PALADIN:int = 2;
        static const SKILL_FIGHTAXE:int = 12;
        static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const DRAG_TYPE_OBJECT:String = "object";
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const BLESSING_NONE:int = 0;
        static const STATE_FAST:int = 6;
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
        static const TYPE_MONSTER:int = 1;
        static const STATE_POISONED:int = 0;
        static const DRAG_TYPE_SPELL:String = "spell";
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
        static const DRAG_OPACITY:Number = 0.75;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function SpellTileRenderer()
        {
            addEventListener(MouseEvent.MOUSE_DOWN, this.onDragControl);
            return;
        }// end function

        public function set player(param1:Player) : void
        {
            if (this.m_Player != param1)
            {
                if (this.m_Player != null)
                {
                    this.m_Player.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerPropertyChange);
                }
                this.m_Player = param1;
                if (this.m_Player != null)
                {
                    this.m_Player.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerPropertyChange, false, EventPriority.DEFAULT, true);
                }
                this.m_UncommittedPlayer = true;
                invalidateProperties();
                this.available = this.m_Player != null && this.spell != null && this.m_Player.getSpellCasts(this.spell) > -1;
            }
            return;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            if (this.m_Selected != param1)
            {
                this.m_Selected = param1;
                this.m_UncommittedSelected = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function get available() : Boolean
        {
            return this.m_Available;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedAvailable)
            {
                this.m_UISpellIcon.available = this.available;
                this.m_UncommittedAvailable = false;
            }
            if (this.m_UncommittedPlayer)
            {
                this.m_UncommittedPlayer = false;
            }
            if (this.m_UncommittedSelected)
            {
                this.m_UISpellIcon.selected = this.selected;
                this.m_UncommittedSelected = false;
            }
            if (this.m_UncommittedSpell)
            {
                this.m_UISpellIcon.spell = this.spell;
                this.m_UncommittedSpell = false;
            }
            return;
        }// end function

        protected function set spell(param1:Spell) : void
        {
            if (this.m_Spell != param1)
            {
                this.m_Spell = param1;
                this.m_UncommittedSpell = true;
                invalidateProperties();
                this.available = this.player != null && this.spell != null && this.player.getSpellCasts(this.spell) > -1;
                this.selected = owner is ListBase && ListBase(owner).selectedItem == data;
            }
            return;
        }// end function

        protected function set available(param1:Boolean) : void
        {
            if (this.m_Available != param1)
            {
                this.m_Available = param1;
                this.m_UncommittedAvailable = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            if (super.data != param1)
            {
                super.data = param1;
                this.spell = param1 as Spell;
            }
            return;
        }// end function

        public function get player() : Player
        {
            return this.m_Player;
        }// end function

        public function get selected() : Boolean
        {
            return this.m_Selected;
        }// end function

        private function onPlayerPropertyChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "knownSpells" || event.property == "premium" || event.property == "profession" || event.property == "skill" || event.property == "*")
            {
                this.available = this.player != null && this.spell != null && this.player.getSpellCasts(this.spell) > -1;
            }
            return;
        }// end function

        protected function get spell() : Spell
        {
            return this.m_Spell;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UISpellIcon = new SpellIconRenderer();
                this.m_UISpellIcon.styleName = "spellListWidgetSpellIconRenderer";
                addChild(this.m_UISpellIcon);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        override public function set owner(param1:DisplayObjectContainer) : void
        {
            if (owner != param1)
            {
                if (owner is ListBase)
                {
                    owner.removeEventListener(ListEvent.CHANGE, this.onListSelectionChange);
                }
                super.owner = param1;
                if (owner is ListBase)
                {
                    owner.addEventListener(ListEvent.CHANGE, this.onListSelectionChange, false, EventPriority.DEFAULT, true);
                }
            }
            return;
        }// end function

        private function onDragControl(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.spell == null)
            {
                return;
            }
            switch(event.type)
            {
                case MouseEvent.MOUSE_DOWN:
                {
                    addEventListener(MouseEvent.MOUSE_MOVE, this.onDragControl);
                    addEventListener(MouseEvent.MOUSE_UP, this.onDragControl);
                    systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onDragControl);
                    break;
                }
                case MouseEvent.MOUSE_MOVE:
                {
                    _loc_2 = new DragSource();
                    _loc_2.addData(DRAG_TYPE_SPELL, "dragType");
                    _loc_2.addData(this.spell, "dragSpell");
                    _loc_3 = new SpellIconRenderer();
                    _loc_3.spell = this.spell;
                    _loc_3.available = true;
                    _loc_3.selected = false;
                    DragManager.doDrag(this, _loc_2, MouseEvent(event), _loc_3, -this.m_UISpellIcon.mouseX, -this.m_UISpellIcon.mouseY, DRAG_OPACITY);
                }
                case MouseEvent.MOUSE_UP:
                case SandboxMouseEvent.MOUSE_UP_SOMEWHERE:
                {
                }
                default:
                {
                    removeEventListener(MouseEvent.MOUSE_MOVE, this.onDragControl);
                    removeEventListener(MouseEvent.MOUSE_UP, this.onDragControl);
                    systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onDragControl);
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function onListSelectionChange(event:ListEvent) : void
        {
            this.selected = event.itemRenderer != null && event.itemRenderer.data == data;
            return;
        }// end function

    }
}
