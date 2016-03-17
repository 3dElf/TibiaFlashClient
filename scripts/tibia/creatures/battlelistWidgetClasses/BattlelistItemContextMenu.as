package tibia.creatures.battlelistWidgetClasses
{
   import tibia.game.ContextMenuBase;
   import tibia.creatures.CreatureStorage;
   import tibia.creatures.Creature;
   import mx.core.IUIComponent;
   import tibia.input.gameaction.PrivateChatActionImpl;
   import tibia.input.gameaction.BuddylistActionImpl;
   import tibia.input.gameaction.NameFilterActionImpl;
   import tibia.input.gameaction.PartyActionImpl;
   import tibia.reporting.reportType.Type;
   import tibia.reporting.ReportWidget;
   import flash.system.System;
   import shared.utility.closure;
   import tibia.options.OptionsStorage;
   
   public class BattlelistItemContextMenu extends ContextMenuBase
   {
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const SKILL_FIGHTCLUB:int = 9;
      
      protected static const WAR_ALLY:int = 1;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      protected static const PK_PARTYMODE:int = 2;
      
      protected static const WAR_ENEMY:int = 2;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      protected static const PARTY_MEMBER:int = 2;
      
      protected static const STATE_DRUNK:int = 3;
      
      protected static const WAR_NEUTRAL:int = 3;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const SKILL_STAMINA:int = 16;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const SKILL_FIGHTSHIELD:int = 7;
      
      protected static const SKILL_FIGHTAXE:int = 11;
      
      protected static const WAR_NONE:int = 0;
      
      protected static const SKILL_FIGHTDISTANCE:int = 8;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SKILL_FED:int = 14;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const SKILL_SOULPOINTS:int = 15;
      
      protected static const SKILL_FISHING:int = 13;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const STATE_FAST:int = 6;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_HITPOINTS:int = 3;
      
      protected static const SKILL_NONE:int = -1;
      
      protected static const SKILL_OFFLINETRAINING:int = 17;
      
      private static const BUNDLE:String = "BattlelistWidget";
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      protected static const SKILL_MANA:int = 4;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 10;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const SKILL_CARRYSTRENGTH:int = 6;
      
      protected static const STATE_POISONED:int = 0;
      
      protected static const STATE_BURNING:int = 1;
      
      protected static const SKILL_FIGHTFIST:int = 12;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      private static const SORT_OPTIONS:Array = [{
         "value":CreatureStorage.SORT_KNOWN_SINCE_ASC,
         "label":"CTX_SORT_KNOWN_SINCE_ASC"
      },{
         "value":CreatureStorage.SORT_KNOWN_SINCE_DESC,
         "label":"CTX_SORT_KNOWN_SINCE_DESC"
      },{
         "value":CreatureStorage.SORT_DISTANCE_ASC,
         "label":"CTX_SORT_DISTANCE_ASC"
      },{
         "value":CreatureStorage.SORT_DISTANCE_DESC,
         "label":"CTX_SORT_DISTANCE_DESC"
      },{
         "value":CreatureStorage.SORT_HITPOINTS_ASC,
         "label":"CTX_SORT_HITPOINTS_ASC"
      },{
         "value":CreatureStorage.SORT_HITPOINTS_DESC,
         "label":"CTX_SORT_HITPOINTS_DESC"
      },{
         "value":CreatureStorage.SORT_NAME_ASC,
         "label":"CTX_SORT_NAME_ASC"
      },{
         "value":CreatureStorage.SORT_NAME_DESC,
         "label":"CTX_SORT_NAME_DESC"
      }];
      
      protected static const PROFESSION_DRUID:int = 4;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      protected static const STATE_FIGHTING:int = 7;
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
       
      protected var m_Creature:Creature = null;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      protected var m_Options:OptionsStorage = null;
      
      public function BattlelistItemContextMenu(param1:OptionsStorage, param2:CreatureStorage, param3:Creature)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("BattlelistItemContextMenu.BattlelistItemContextMenu: Invalid options reference.");
         }
         if(param2 == null)
         {
            throw new ArgumentError("BattlelistItemContextMenu.BattlelistItemContextMenu: Invalid creature storage.");
         }
         this.m_Options = param1;
         this.m_CreatureStorage = param2;
         this.m_Creature = param3;
      }
      
      override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
      {
         var a_Owner:IUIComponent = param1;
         var a_StageX:Number = param2;
         var a_StageY:Number = param3;
         if(this.m_Creature != null)
         {
            createTextItem(resourceManager.getString(BUNDLE,this.m_CreatureStorage.getAttackTarget() == this.m_Creature?"CTX_STOP_ATTACK":"CTX_START_ATTACK"),function(param1:*):void
            {
               m_CreatureStorage.toggleAttackTarget(m_Creature,true);
            });
            createTextItem(resourceManager.getString(BUNDLE,this.m_CreatureStorage.getFollowTarget() == this.m_Creature?"CTX_STOP_FOLLOW":"CTX_START_FOLLOW"),function(param1:*):void
            {
               m_CreatureStorage.toggleFollowTarget(m_Creature,true);
            });
            createSeparatorItem();
         }
         if(this.m_Creature != null && Boolean(this.m_Creature.isHuman))
         {
            createTextItem(resourceManager.getString(BUNDLE,"CTX_PRIVATE_MESSAGE",[this.m_Creature.name]),function(param1:*):void
            {
               new PrivateChatActionImpl(PrivateChatActionImpl.OPEN_MESSAGE_CHANNEL,m_Creature.name).perform();
            });
            if(Tibia.s_GetChatStorage().hasOwnPrivateChannel)
            {
               createTextItem(resourceManager.getString(BUNDLE,"CTX_PRIVATE_CHAT"),function(param1:*):void
               {
                  new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_INVITE,m_Creature.name).perform();
               });
            }
            if(!BuddylistActionImpl.s_IsBuddy(this.m_Creature.ID))
            {
               createTextItem(resourceManager.getString(BUNDLE,"CTX_BUDDY"),function(param1:*):void
               {
                  new BuddylistActionImpl(BuddylistActionImpl.ADD_BY_NAME,m_Creature.name).perform();
               });
            }
            if(NameFilterActionImpl.s_IsBlacklisted(this.m_Creature.name))
            {
               createTextItem(resourceManager.getString(BUNDLE,"CTX_UNIGNORE",[this.m_Creature.name]),function(param1:*):void
               {
                  new NameFilterActionImpl(NameFilterActionImpl.UNIGNORE,m_Creature.name).perform();
               });
            }
            else
            {
               createTextItem(resourceManager.getString(BUNDLE,"CTX_IGNORE",[this.m_Creature.name]),function(param1:*):void
               {
                  new NameFilterActionImpl(NameFilterActionImpl.IGNORE,m_Creature.name).perform();
               });
            }
            if(this.m_CreatureStorage.player != null)
            {
               switch(this.m_CreatureStorage.player.partyFlag)
               {
                  case PARTY_LEADER:
                     if(this.m_Creature.partyFlag == PARTY_MEMBER)
                     {
                        createTextItem(resourceManager.getString(BUNDLE,"CTX_PARTY_EXCLUDE",[this.m_Creature.name]),function(param1:*):void
                        {
                           new PartyActionImpl(PartyActionImpl.EXCLUDE,m_Creature).perform();
                        });
                     }
                     break;
                  case PARTY_LEADER_SEXP_ACTIVE:
                  case PARTY_LEADER_SEXP_INACTIVE_GUILTY:
                  case PARTY_LEADER_SEXP_INACTIVE_INNOCENT:
                  case PARTY_LEADER_SEXP_OFF:
                     if(this.m_Creature.partyFlag == PARTY_MEMBER)
                     {
                        createTextItem(resourceManager.getString(BUNDLE,"CTX_PARTY_EXCLUDE",[this.m_Creature.name]),function(param1:*):void
                        {
                           new PartyActionImpl(PartyActionImpl.EXCLUDE,m_Creature).perform();
                        });
                     }
                     else if(this.m_Creature.partyFlag == PARTY_MEMBER_SEXP_ACTIVE || this.m_Creature.partyFlag == PARTY_MEMBER_SEXP_INACTIVE_GUILTY || this.m_Creature.partyFlag == PARTY_MEMBER_SEXP_INACTIVE_INNOCENT || this.m_Creature.partyFlag == PARTY_MEMBER_SEXP_OFF)
                     {
                        createTextItem(resourceManager.getString(BUNDLE,"CTX_PARTY_PASS_LEADERSHIP",[this.m_Creature.name]),function(param1:*):void
                        {
                           new PartyActionImpl(PartyActionImpl.PASS_LEADERSHIP,m_Creature).perform();
                        });
                     }
                     else
                     {
                        createTextItem(resourceManager.getString(BUNDLE,"CTX_PARTY_INVITE"),function(param1:*):void
                        {
                           new PartyActionImpl(PartyActionImpl.INVITE,m_Creature).perform();
                        });
                     }
                     break;
                  case PARTY_MEMBER:
                  case PARTY_NONE:
                     if(this.m_Creature.partyFlag == PARTY_LEADER)
                     {
                        createTextItem(resourceManager.getString(BUNDLE,"CTX_PARTY_JOIN",[this.m_Creature.name]),function(param1:*):void
                        {
                           new PartyActionImpl(PartyActionImpl.JOIN,m_Creature).perform();
                        });
                     }
                     else
                     {
                        createTextItem(resourceManager.getString(BUNDLE,"CTX_PARTY_INVITE"),function(param1:*):void
                        {
                           new PartyActionImpl(PartyActionImpl.INVITE,m_Creature).perform();
                        });
                     }
                     break;
                  case PARTY_MEMBER_SEXP_ACTIVE:
                  case PARTY_MEMBER_SEXP_INACTIVE_GUILTY:
                  case PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:
                  case PARTY_MEMBER_SEXP_OFF:
               }
            }
            createSeparatorItem();
         }
         if(this.m_Creature != null)
         {
            if(this.m_Creature.isReportTypeAllowed(Type.REPORT_NAME))
            {
               createTextItem(resourceManager.getString(BUNDLE,"CTX_REPORT_NAME"),function(param1:*):void
               {
                  new ReportWidget(Type.REPORT_NAME,m_Creature).show();
               });
            }
            if(this.m_Creature.isReportTypeAllowed(Type.REPORT_BOT))
            {
               createTextItem(resourceManager.getString(BUNDLE,"CTX_REPORT_BOT"),function(param1:*):void
               {
                  new ReportWidget(Type.REPORT_BOT,m_Creature).show();
               });
            }
            createSeparatorItem();
         }
         if(this.m_Creature != null)
         {
            createTextItem(resourceManager.getString(BUNDLE,"CTX_COPY_NAME"),function(param1:*):void
            {
               System.setClipboard(m_Creature.name);
            });
            createSeparatorItem();
         }
         var i:int = 0;
         while(i < SORT_OPTIONS.length)
         {
            if(this.m_Options.opponentSort != SORT_OPTIONS[i].value)
            {
               createTextItem(resourceManager.getString(BUNDLE,SORT_OPTIONS[i].label),closure(null,function(param1:OptionsStorage, param2:int, param3:*):void
               {
                  param1.opponentSort = param2;
               },this.m_Options,SORT_OPTIONS[i].value));
            }
            i++;
         }
         super.display(a_Owner,a_StageX,a_StageY);
      }
   }
}
