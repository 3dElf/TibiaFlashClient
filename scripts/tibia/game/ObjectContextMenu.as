package tibia.game
{
   import flash.events.ContextMenuEvent;
   import tibia.input.gameaction.PrivateChatActionImpl;
   import tibia.input.staticaction.StaticActionList;
   import tibia.input.gameaction.PartyActionImpl;
   import mx.core.IUIComponent;
   import tibia.creatures.Player;
   import tibia.appearances.ObjectInstance;
   import tibia.creatures.CreatureStorage;
   import flash.ui.ContextMenuItem;
   import tibia.appearances.AppearanceInstance;
   import tibia.input.gameaction.BuddylistActionImpl;
   import tibia.input.gameaction.NameFilterActionImpl;
   import tibia.reporting.reportType.Type;
   import tibia.input.gameaction.SafeTradeActionImpl;
   import tibia.input.gameaction.TurnActionImpl;
   import tibia.reporting.ReportWidget;
   import tibia.creatures.Creature;
   import tibia.input.gameaction.UseActionImpl;
   import shared.utility.Vector3D;
   import tibia.input.gameaction.MoveActionImpl;
   import tibia.input.gameaction.LookActionImpl;
   import flash.system.System;
   
   public class ObjectContextMenu extends ContextMenuBase
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
      
      private static const BUNDLE:String = "ObjectContextMenu";
      
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
      
      protected static const PROFESSION_DRUID:int = 4;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      protected static const STATE_FIGHTING:int = 7;
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
       
      protected var m_LookTarget:Object = null;
      
      protected var m_UseTarget:Object = null;
      
      protected var m_CreatureTarget:Creature = null;
      
      protected var m_Absolute:Vector3D = null;
      
      public function ObjectContextMenu(param1:Vector3D, param2:Object, param3:Object, param4:Creature)
      {
         super();
         if(param1 == null || param1.x == 65535 && param1.y == 0)
         {
            throw new ArgumentError("MapContextMenu.MapContextMenu: Invalid co-ordinate " + param1 + ".");
         }
         this.m_Absolute = param1;
         if(param2 == null)
         {
            throw new ArgumentError("MapContextMenu.MapContextMenu: Invalid look target.");
         }
         this.m_LookTarget = param2;
         if(param3 == null)
         {
            throw new ArgumentError("MapContextMenu.MapContextMenu: Invalid use target.");
         }
         this.m_UseTarget = param3;
         this.m_CreatureTarget = param4;
      }
      
      protected function onPlayerChatInvite(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_INVITE,this.m_CreatureTarget.name).perform();
         }
      }
      
      protected function onPlayerSetOutfit(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            StaticActionList.MISC_SHOW_OUTFIT.perform();
         }
      }
      
      protected function onPartyLeave(param1:ContextMenuEvent) : void
      {
         if(param1 != null)
         {
            new PartyActionImpl(PartyActionImpl.LEAVE,null).perform();
         }
      }
      
      override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
      {
         var CrStorage:CreatureStorage = null;
         var a_Owner:IUIComponent = param1;
         var a_StageX:Number = param2;
         var a_StageY:Number = param3;
         var Item:ContextMenuItem = null;
         var LookObj:ObjectInstance = this.m_LookTarget.object as ObjectInstance;
         var UseObj:ObjectInstance = this.m_UseTarget.object as ObjectInstance;
         var Label:String = null;
         if(LookObj != null)
         {
            this.createItem("CTX_OBJECT_LOOK",this.onObjectLook);
         }
         if(UseObj != null && Boolean(UseObj.type.isContainer))
         {
            if(this.m_Absolute.x == 65535 && this.m_Absolute.y >= 64)
            {
               this.createItem("CTX_OBJECT_OPEN",this.onObjectOpen);
               this.createItem("CTX_OBJECT_OPEN_NEW_WINDOW",this.onObjectOpenNewWindow);
            }
            else
            {
               this.createItem("CTX_OBJECT_OPEN",this.onObjectOpenNewWindow);
            }
         }
         if(UseObj != null && !UseObj.type.isContainer)
         {
            this.createItem(!!UseObj.type.isMultiUse?"CTX_OBJECT_MULTIUSE":"CTX_OBJECT_USE",this.onObjectUse);
         }
         if(UseObj != null && Boolean(UseObj.type.isRotateable))
         {
            this.createItem("CTX_OBJECT_TURN",this.onObjectTurn);
         }
         var NeedSeparator:Boolean = true;
         if(LookObj != null && LookObj.ID != AppearanceInstance.CREATURE && !LookObj.type.isUnmoveable && Boolean(LookObj.type.isTakeable))
         {
            this.createItem("CTX_OBJECT_TRADE",this.onObjectTrade,NeedSeparator);
            NeedSeparator = false;
         }
         if(LookObj != null && this.m_Absolute.x == 65535 && this.m_Absolute.y >= 64 && Boolean(Tibia.s_GetContainerStorage().getOpenContainer(this.m_Absolute.y - 64).isSubContainer))
         {
            this.createItem("CTX_OBJECT_MOVE_UP",this.onObjectMoveUp,NeedSeparator);
            NeedSeparator = false;
         }
         var _Player:Player = Tibia.s_GetPlayer();
         if(this.m_CreatureTarget != null && this.m_CreatureTarget.ID != _Player.ID)
         {
            CrStorage = Tibia.s_GetCreatureStorage();
            if(CrStorage.getAttackTarget() != null && CrStorage.getAttackTarget().ID == this.m_CreatureTarget.ID)
            {
               this.createItem("CTX_CREATURE_ATTACK_STOP",this.onCreatureAttack,NeedSeparator);
            }
            else
            {
               this.createItem("CTX_CREATURE_ATTACK_START",this.onCreatureAttack,NeedSeparator);
            }
            NeedSeparator = false;
            if(CrStorage.getFollowTarget() != null && CrStorage.getFollowTarget().ID == this.m_CreatureTarget.ID)
            {
               this.createItem("CTX_CREATURE_FOLLOW_STOP",this.onCreatureFollow);
            }
            else
            {
               this.createItem("CTX_CREATURE_FOLLOW_START",this.onCreatureFollow);
            }
            if(this.m_CreatureTarget.isHuman)
            {
               Label = resourceManager.getString(BUNDLE,"CTX_PLAYER_CHAT_MESSAGE",[this.m_CreatureTarget.name]);
               super.createItem(Label,this.onPlayerChatMessage);
               if(Tibia.s_GetChatStorage().hasOwnPrivateChannel)
               {
                  this.createItem("CTX_PLAYER_CHAT_INVITE",this.onPlayerChatInvite);
               }
               if(!BuddylistActionImpl.s_IsBuddy(this.m_CreatureTarget.ID))
               {
                  this.createItem("CTX_PLAYER_ADD_BUDDY",this.onPlayerAddBuddy);
               }
               if(NameFilterActionImpl.s_IsBlacklisted(this.m_CreatureTarget.name))
               {
                  super.createItem(resourceManager.getString(BUNDLE,"CTX_PLAYER_UNIGNORE",[this.m_CreatureTarget.name]),function(param1:ContextMenuEvent):void
                  {
                     new NameFilterActionImpl(NameFilterActionImpl.UNIGNORE,m_CreatureTarget.name).perform();
                  });
               }
               else
               {
                  super.createItem(resourceManager.getString(BUNDLE,"CTX_PLAYER_IGNORE",[this.m_CreatureTarget.name]),function(param1:ContextMenuEvent):void
                  {
                     new NameFilterActionImpl(NameFilterActionImpl.IGNORE,m_CreatureTarget.name).perform();
                  });
               }
               switch(_Player.partyFlag)
               {
                  case PARTY_LEADER:
                     if(this.m_CreatureTarget.partyFlag == PARTY_MEMBER)
                     {
                        Label = resourceManager.getString(BUNDLE,"CTX_PARTY_EXCLUDE",[this.m_CreatureTarget.name]);
                        super.createItem(Label,this.onPartyExclude);
                     }
                     break;
                  case PARTY_LEADER_SEXP_ACTIVE:
                  case PARTY_LEADER_SEXP_INACTIVE_GUILTY:
                  case PARTY_LEADER_SEXP_INACTIVE_INNOCENT:
                  case PARTY_LEADER_SEXP_OFF:
                     if(this.m_CreatureTarget.partyFlag == PARTY_MEMBER)
                     {
                        Label = resourceManager.getString(BUNDLE,"CTX_PARTY_EXCLUDE",[this.m_CreatureTarget.name]);
                        super.createItem(Label,this.onPartyExclude);
                     }
                     else if(this.m_CreatureTarget.partyFlag == PARTY_MEMBER_SEXP_OFF || this.m_CreatureTarget.partyFlag == PARTY_MEMBER_SEXP_ACTIVE || this.m_CreatureTarget.partyFlag == PARTY_MEMBER_SEXP_INACTIVE_GUILTY || this.m_CreatureTarget.partyFlag == PARTY_MEMBER_SEXP_INACTIVE_INNOCENT)
                     {
                        Label = resourceManager.getString(BUNDLE,"CTX_PARTY_PASS_LEADERSHIP",[this.m_CreatureTarget.name]);
                        super.createItem(Label,this.onPartyPassLeadership);
                     }
                     else
                     {
                        this.createItem("CTX_PARTY_INVITE",this.onPartyInvite);
                     }
                     break;
                  case PARTY_MEMBER_SEXP_ACTIVE:
                  case PARTY_MEMBER_SEXP_INACTIVE_GUILTY:
                  case PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:
                  case PARTY_MEMBER_SEXP_OFF:
                     break;
                  case PARTY_NONE:
                  case PARTY_MEMBER:
                     if(this.m_CreatureTarget.partyFlag == PARTY_LEADER)
                     {
                        Label = resourceManager.getString(BUNDLE,"CTX_PARTY_JOIN",[this.m_CreatureTarget.name]);
                        super.createItem(Label,this.onPartyJoin);
                     }
                     else
                     {
                        this.createItem("CTX_PARTY_INVITE",this.onPartyInvite);
                     }
                     break;
                  default:
                     log("ObjectContextMenu.display: Invalid player party flag: " + _Player.partyFlag);
               }
            }
            NeedSeparator = true;
            if(this.m_CreatureTarget.isReportTypeAllowed(Type.REPORT_NAME))
            {
               this.createItem("CTX_PLAYER_REPORT_NAME",this.onPlayerReportName,NeedSeparator);
               NeedSeparator = false;
            }
            if(this.m_CreatureTarget.isReportTypeAllowed(Type.REPORT_BOT))
            {
               this.createItem("CTX_PLAYER_REPORT_BOT",this.onPlayerReportBot,NeedSeparator);
               NeedSeparator = false;
            }
         }
         if(this.m_CreatureTarget != null && this.m_CreatureTarget.ID == _Player.ID)
         {
            this.createItem("CTX_PLAYER_SET_OUTFIT",this.onPlayerSetOutfit,NeedSeparator);
            NeedSeparator = false;
            this.createItem(_Player.mountOutfit == null?"CTX_PLAYER_MOUNT":"CTX_PLAYER_DISMOUNT",this.onPlayerMount);
            if(Boolean(_Player.isPartyMember) && !_Player.isFighting)
            {
               if(_Player.isPartyLeader)
               {
                  this.createItem(!!_Player.isPartySharedExperienceActive?"CTX_PARTY_DISABLE_SHARED_EXPERIENCE":"CTX_PARTY_ENABLE_SHARED_EXPERIENCE",this.onPartySharedExperience);
               }
               this.createItem("CTX_PARTY_LEAVE",this.onPartyLeave);
            }
         }
         if(this.m_CreatureTarget != null)
         {
            this.createItem("CTX_CREATURE_COPY_NAME",this.onCreatureCopyName,true);
         }
         super.display(a_Owner,a_StageX,a_StageY);
      }
      
      protected function onObjectTrade(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_LookTarget.object != null)
         {
            new SafeTradeActionImpl(this.m_Absolute,this.m_LookTarget.object,this.m_LookTarget.position).perform();
         }
      }
      
      protected function onPlayerChatMessage(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            new PrivateChatActionImpl(PrivateChatActionImpl.OPEN_MESSAGE_CHANNEL,this.m_CreatureTarget.name).perform();
         }
      }
      
      protected function onPartyJoin(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            new PartyActionImpl(PartyActionImpl.JOIN,this.m_CreatureTarget).perform();
         }
      }
      
      protected function onPartyExclude(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            new PartyActionImpl(PartyActionImpl.EXCLUDE,this.m_CreatureTarget).perform();
         }
      }
      
      protected function onCreatureFollow(param1:ContextMenuEvent) : void
      {
         var _loc2_:CreatureStorage = null;
         if(param1 != null && this.m_CreatureTarget != null && (_loc2_ = Tibia.s_GetCreatureStorage()) != null)
         {
            _loc2_.toggleFollowTarget(this.m_CreatureTarget,true);
         }
      }
      
      protected function onPlayerMount(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            StaticActionList.PLAYER_MOUNT.perform();
         }
      }
      
      protected function onObjectTurn(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_UseTarget.object != null)
         {
            new TurnActionImpl(this.m_Absolute,this.m_UseTarget.object,this.m_UseTarget.position).perform();
         }
      }
      
      protected function onPartyPassLeadership(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            new PartyActionImpl(PartyActionImpl.PASS_LEADERSHIP,this.m_CreatureTarget).perform();
         }
      }
      
      protected function onPlayerReportName(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            new ReportWidget(Type.REPORT_NAME,this.m_CreatureTarget).show();
         }
      }
      
      protected function onPlayerAddBuddy(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            new BuddylistActionImpl(BuddylistActionImpl.ADD_BY_NAME,this.m_CreatureTarget.name).perform();
         }
      }
      
      protected function onCreatureAttack(param1:ContextMenuEvent) : void
      {
         var _loc2_:CreatureStorage = null;
         if(param1 != null && this.m_CreatureTarget != null && (_loc2_ = Tibia.s_GetCreatureStorage()) != null)
         {
            _loc2_.toggleAttackTarget(this.m_CreatureTarget,true);
         }
      }
      
      protected function onObjectOpen(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_UseTarget.object != null)
         {
            new UseActionImpl(this.m_Absolute,this.m_UseTarget.object,this.m_UseTarget.position,UseActionImpl.TARGET_AUTO).perform();
         }
      }
      
      protected function onObjectMoveUp(param1:ContextMenuEvent) : void
      {
         var _loc2_:Vector3D = null;
         var _loc3_:int = 0;
         if(param1 != null && this.m_LookTarget.object != null)
         {
            _loc2_ = new Vector3D(this.m_Absolute.x,this.m_Absolute.y,254);
            _loc3_ = MoveActionImpl.MOVE_ALL;
            new MoveActionImpl(this.m_Absolute,this.m_LookTarget.object,this.m_LookTarget.position,_loc2_,_loc3_).perform();
         }
      }
      
      protected function onPartySharedExperience(param1:ContextMenuEvent) : void
      {
         var _loc2_:Player = Tibia.s_GetPlayer();
         if(param1 != null)
         {
            if(_loc2_.isPartySharedExperienceActive)
            {
               new PartyActionImpl(PartyActionImpl.DISABLE_SHARED_EXPERIENCE,null).perform();
            }
            else
            {
               new PartyActionImpl(PartyActionImpl.ENABLE_SHARED_EXPERIENCE,null).perform();
            }
         }
      }
      
      override protected function createItem(param1:String, param2:Function, param3:Boolean = false) : ContextMenuItem
      {
         return super.createItem(resourceManager.getString(BUNDLE,param1),param2,param3);
      }
      
      protected function onObjectUse(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_UseTarget.object != null)
         {
            new UseActionImpl(this.m_Absolute,this.m_UseTarget.object,this.m_UseTarget.position,UseActionImpl.TARGET_AUTO).perform();
         }
      }
      
      protected function onObjectOpenNewWindow(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_UseTarget.object != null)
         {
            new UseActionImpl(this.m_Absolute,this.m_UseTarget.object,this.m_UseTarget.position,UseActionImpl.TARGET_NEW_WINDOW).perform();
         }
      }
      
      protected function onPlayerReportBot(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            new ReportWidget(Type.REPORT_BOT,this.m_CreatureTarget).show();
         }
      }
      
      protected function onObjectLook(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_LookTarget.object != null)
         {
            new LookActionImpl(this.m_Absolute,this.m_LookTarget.object,this.m_LookTarget.position).perform();
         }
      }
      
      protected function onCreatureCopyName(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            System.setClipboard(this.m_CreatureTarget.name);
         }
      }
      
      protected function onPartyInvite(param1:ContextMenuEvent) : void
      {
         if(param1 != null && this.m_CreatureTarget != null)
         {
            new PartyActionImpl(PartyActionImpl.INVITE,this.m_CreatureTarget).perform();
         }
      }
   }
}
