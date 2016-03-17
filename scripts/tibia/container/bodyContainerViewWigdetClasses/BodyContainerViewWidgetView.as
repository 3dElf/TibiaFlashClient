package tibia.container.bodyContainerViewWigdetClasses
{
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   import tibia.game.IUseWidget;
   import tibia.game.IMoveWidget;
   import tibia.container.BodyContainerView;
   import flash.text.TextField;
   import tibia.game.ObjectDragImpl;
   import flash.events.MouseEvent;
   import tibia.creatures.Player;
   import mx.controls.Button;
   import flash.text.TextFieldAutoSize;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   import shared.controls.CustomButton;
   import flash.geom.Point;
   import tibia.container.containerViewWidgetClasses.ContainerSlot;
   import shared.utility.getClassInstanceUnderPoint;
   import shared.utility.Vector3D;
   import mx.events.PropertyChangeEvent;
   import tibia.input.ModifierKeyEvent;
   import flash.text.TextFormat;
   import tibia.cursors.CursorHelper;
   import mx.core.EdgeMetrics;
   import tibia.appearances.AppearanceInstance;
   import tibia.input.mapping.MouseBinding;
   import tibia.input.MouseActionHelper;
   import tibia.input.gameaction.UseActionImpl;
   import tibia.input.gameaction.LookActionImpl;
   import tibia.game.ObjectContextMenu;
   import tibia.§sidebar:ns_sidebar_internal§.widgetClosed;
   import tibia.§sidebar:ns_sidebar_internal§.widgetCollapsed;
   import mx.managers.CursorManagerPriority;
   import mx.core.ScrollPolicy;
   
   public class BodyContainerViewWidgetView extends WidgetView implements IUseWidget, IMoveWidget
   {
      
      protected static const PARTY_MAX_FLASHING_TIME:uint = 5000;
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const SKILL_FIGHTCLUB:int = 10;
      
      protected static const RISKINESS_DANGEROUS:int = 1;
      
      protected static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
      
      protected static const GUILD_NONE:int = 0;
      
      protected static const PK_PARTYMODE:int = 2;
      
      protected static const RISKINESS_NONE:int = 0;
      
      private static const MOUSE_BUTTON_RIGHT:int = 2;
      
      protected static const PARTY_MEMBER:int = 2;
      
      protected static const STATE_DRUNK:int = 3;
      
      protected static const PARTY_OTHER:int = 11;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      private static const MOUSE_BUTTON_LEFT:int = 1;
      
      protected static const TYPE_SUMMON_OTHERS:int = 4;
      
      protected static const SKILL_STAMINA:int = 17;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const SKILL_FIGHTSHIELD:int = 8;
      
      protected static const SKILL_FIGHTDISTANCE:int = 9;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SKILL_FED:int = 15;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const SKILL_FISHING:int = 14;
      
      private static const WIDGET_VIEW_WIDTH:Number = 176;
      
      protected static const SKILL_HITPOINTS_PERCENT:int = 3;
      
      private static const ACTION_ATTACK:int = 1;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const SUMMON_OTHERS:int = 2;
      
      protected static const SKILL_NONE:int = -1;
      
      protected static const GUILD_MEMBER:int = 4;
      
      private static const BUNDLE:String = "BodyContainerViewWidget";
      
      private static const WIDGET_VIEW_HEIGHT:Number = 154;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      private static const ACTION_OPEN:int = 8;
      
      protected static const SKILL_CARRYSTRENGTH:int = 7;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 11;
      
      protected static const GUILD_WAR_NEUTRAL:int = 3;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const GUILD_WAR_ALLY:int = 1;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      private static const ACTION_TALK:int = 9;
      
      protected static const SUMMON_OWN:int = 1;
      
      private static const ACTION_LOOK:int = 6;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      protected static const TYPE_SUMMON_OWN:int = 3;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      private static const ACTION_SMARTCLICK:int = 100;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const SKILL_FIGHTAXE:int = 12;
      
      private static const MOUSE_BUTTON_MIDDLE:int = 3;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const SKILL_SOULPOINTS:int = 16;
      
      private static const ACTION_CONTEXT_MENU:int = 5;
      
      protected static const STATE_FAST:int = 6;
      
      private static const VALID_ACTIONS:Vector.<uint> = Vector.<uint>([ACTION_USE,ACTION_OPEN,ACTION_LOOK,ACTION_CONTEXT_MENU]);
      
      protected static const GUILD_OTHER:int = 5;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_HITPOINTS:int = 4;
      
      protected static const SKILL_OFFLINETRAINING:int = 18;
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      protected static const SKILL_MANA:int = 5;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const STATE_CURSED:int = 11;
      
      private static const ACTION_NONE:int = 0;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      private static const MOUSE_BUTTON_BOTH:int = 4;
      
      protected static const TYPE_MONSTER:int = 1;
      
      private static const ACTION_ATTACK_OR_TALK:int = 102;
      
      protected static const STATE_POISONED:int = 0;
      
      private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
      
      private static const ACTION_USE_OR_OPEN:int = 101;
      
      protected static const SKILL_FIGHTFIST:int = 13;
      
      private static const ACTION_UNSET:int = -1;
      
      protected static const STATE_BURNING:int = 1;
      
      protected static const GUILD_WAR_ENEMY:int = 2;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      protected static const SUMMON_NONE:int = 0;
      
      private static const ACTION_USE:int = 7;
      
      protected static const PROFESSION_DRUID:int = 4;
      
      protected static const STATE_FIGHTING:int = 7;
      
      private static const ACTION_AUTOWALK:int = 3;
      
      private static const WIDGET_COMPONENTS:Array = [{
         "slot":-1,
         "left":123,
         "top":140,
         "width":28,
         "height":11,
         "style":null,
         "tooltip":null
      },{
         "slot":BodyContainerView.HEAD,
         "left":70,
         "top":2,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotHeadStyle",
         "tooltip":null
      },{
         "slot":BodyContainerView.NECK,
         "left":26,
         "top":8,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotNeckStyle",
         "tooltip":null
      },{
         "slot":BodyContainerView.BACK,
         "left":114,
         "top":8,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotBackStyle",
         "tooltip":null
      },{
         "slot":BodyContainerView.TORSO,
         "left":70,
         "top":39,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotTorsoStyle",
         "tooltip":null
      },{
         "slot":BodyContainerView.RIGHT_HAND,
         "left":120,
         "top":53,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotRightHandStyle",
         "tooltip":null
      },{
         "slot":BodyContainerView.LEFT_HAND,
         "left":19,
         "top":54,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotLeftHandStyle",
         "tooltip":null
      },{
         "slot":BodyContainerView.LEGS,
         "left":70,
         "top":77,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotLegsStyle",
         "tooltip":null
      },{
         "slot":BodyContainerView.FEET,
         "left":70,
         "top":115,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotFeetStyle",
         "tooltip":null
      },{
         "slot":BodyContainerView.FINGER,
         "left":26,
         "top":99,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotFingerStyle",
         "tooltip":null
      },{
         "slot":BodyContainerView.HIP,
         "left":114,
         "top":98,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotHipStyle",
         "tooltip":null
      },{
         "slot":BodyContainerView.PURSE,
         "left":2,
         "top":1,
         "width":NaN,
         "height":NaN,
         "style":"bodySlotPurseStyle",
         "tooltip":"TOOLTIP_PURSE"
      }];
      
      protected static const SKILL_GOSTRENGTH:int = 6;
      
      protected static const PK_MAX_FLASHING_TIME:uint = 5000;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
       
      private var m_UICapacity:TextField = null;
      
      private const m_DragHandler:ObjectDragImpl = new ObjectDragImpl();
      
      private var m_BodyContainer:BodyContainerView = null;
      
      private var m_Player:Player = null;
      
      private var m_UIPurse:Button = null;
      
      private var m_RolloverSlot:ContainerSlot = null;
      
      private var m_UncommittedPlayer:Boolean = false;
      
      private var m_CursorHelper:CursorHelper;
      
      private var m_TempPurseSlot:ContainerSlot;
      
      private var m_UncommittedBodyContainer:Boolean = false;
      
      public function BodyContainerViewWidgetView()
      {
         this.m_CursorHelper = new CursorHelper(CursorManagerPriority.MEDIUM);
         this.m_TempPurseSlot = new ContainerSlot();
         super();
         this.m_TempPurseSlot.position = BodyContainerView.PURSE;
         horizontalScrollPolicy = ScrollPolicy.OFF;
         verticalScrollPolicy = ScrollPolicy.OFF;
         titleText = resourceManager.getString(BUNDLE,"TITLE");
         Tibia.s_GetInputHandler().addEventListener(ModifierKeyEvent.MODIFIER_KEYS_CHANGED,this.onModifierKeyEvent);
      }
      
      private function onSlotClick(param1:MouseEvent) : void
      {
         this.determineAction(param1,true,false);
      }
      
      protected function onSlotRollOver(param1:MouseEvent) : void
      {
         if(param1.target == this.m_UIPurse)
         {
            this.m_RolloverSlot = this.m_TempPurseSlot;
         }
         else
         {
            this.m_RolloverSlot = param1.target as BodySlot;
         }
         this.determineAction(param1,false,true);
      }
      
      override protected function createChildren() : void
      {
         var _loc2_:BodySlot = null;
         super.createChildren();
         this.m_UICapacity = createInFontContext(TextField) as TextField;
         this.m_UICapacity.autoSize = TextFieldAutoSize.CENTER;
         this.m_UICapacity.defaultTextFormat = this.getCapacityTextFormat();
         this.m_UICapacity.filters = [new GlowFilter(0,1,2,2,4,BitmapFilterQuality.LOW,false,false)];
         this.m_UICapacity.selectable = false;
         this.m_UICapacity.text = this.getCapacityLabel();
         rawChildren.addChild(this.m_UICapacity);
         this.m_UIPurse = new CustomButton();
         if(WIDGET_COMPONENTS[BodyContainerView.PURSE].style != null)
         {
            this.m_UIPurse.styleName = getStyle(WIDGET_COMPONENTS[BodyContainerView.PURSE].style);
         }
         if(WIDGET_COMPONENTS[BodyContainerView.PURSE].tooltip != null)
         {
            this.m_UIPurse.toolTip = resourceManager.getString(BUNDLE,WIDGET_COMPONENTS[BodyContainerView.PURSE].tooltip);
         }
         this.m_UIPurse.addEventListener(MouseEvent.CLICK,this.onPurseClick);
         this.m_UIPurse.addEventListener(MouseEvent.MIDDLE_CLICK,this.onPurseClick);
         this.m_UIPurse.addEventListener(MouseEvent.RIGHT_CLICK,this.onPurseClick);
         this.m_UIPurse.addEventListener(MouseEvent.ROLL_OVER,this.onSlotRollOver);
         this.m_UIPurse.addEventListener(MouseEvent.ROLL_OUT,this.onSlotRollOut);
         rawChildren.addChild(this.m_UIPurse);
         var _loc1_:int = BodyContainerView.FIRST_SLOT;
         while(_loc1_ <= BodyContainerView.LAST_SLOT)
         {
            if(_loc1_ != BodyContainerView.PURSE)
            {
               _loc2_ = new BodySlot();
               _loc2_.appearance = null;
               _loc2_.position = _loc1_;
               if(WIDGET_COMPONENTS[_loc1_].style != null)
               {
                  _loc2_.styleName = getStyle(WIDGET_COMPONENTS[_loc1_].style);
               }
               if(WIDGET_COMPONENTS[_loc1_].tooltip != null)
               {
                  _loc2_.toolTip = resourceManager.getString(BUNDLE,WIDGET_COMPONENTS[_loc1_].tooltip);
               }
               _loc2_.addEventListener(MouseEvent.CLICK,this.onSlotClick);
               _loc2_.addEventListener(MouseEvent.RIGHT_CLICK,this.onSlotClick);
               _loc2_.addEventListener(MouseEvent.MIDDLE_CLICK,this.onSlotClick);
               _loc2_.addEventListener(MouseEvent.ROLL_OVER,this.onSlotRollOver);
               _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.onSlotRollOut);
               this.m_DragHandler.addDragComponent(_loc2_);
               addChild(_loc2_);
            }
            _loc1_++;
         }
      }
      
      public function getMoveObjectUnderPoint(param1:Point) : Object
      {
         return this.getUseObjectUnderPoint(param1);
      }
      
      private function getCapacityLabel() : String
      {
         var _loc1_:Number = NaN;
         if(this.m_Player != null)
         {
            _loc1_ = this.m_Player.getSkillValue(SKILL_CARRYSTRENGTH);
            return resourceManager.getString(BUNDLE,"LBL_CAPACITY_FORMAT",[Math.round(_loc1_ / 100)]);
         }
         return null;
      }
      
      public function getUseObjectUnderPoint(param1:Point) : Object
      {
         var _loc2_:BodySlot = null;
         if(this.bodyContainer != null && (_loc2_ = getClassInstanceUnderPoint(stage,param1,BodySlot)) != null)
         {
            return {
               "object":_loc2_.appearance,
               "absolute":new Vector3D(65535,_loc2_.position,0),
               "position":0
            };
         }
         return null;
      }
      
      private function onBodyContainerChange(param1:PropertyChangeEvent) : void
      {
         if(param1.property == "objects")
         {
            this.updateSlots();
         }
      }
      
      public function pointToMap(param1:Point) : Vector3D
      {
         return null;
      }
      
      override function releaseInstance() : void
      {
         var _loc2_:BodySlot = null;
         super.releaseInstance();
         var _loc1_:int = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = BodySlot(removeChildAt(_loc1_));
            _loc2_.appearance = null;
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onSlotClick);
            _loc2_.removeEventListener(MouseEvent.RIGHT_CLICK,this.onSlotClick);
            _loc2_.removeEventListener(MouseEvent.MIDDLE_CLICK,this.onSlotClick);
            this.m_DragHandler.removeDragComponent(_loc2_);
            _loc1_++;
         }
         this.m_UIPurse.removeEventListener(MouseEvent.CLICK,this.onPurseClick);
         this.m_UIPurse.removeEventListener(MouseEvent.MIDDLE_CLICK,this.onPurseClick);
         this.m_UIPurse.removeEventListener(MouseEvent.RIGHT_CLICK,this.onPurseClick);
         Tibia.s_GetInputHandler().removeEventListener(ModifierKeyEvent.MODIFIER_KEYS_CHANGED,this.onModifierKeyEvent);
      }
      
      override public function styleChanged(param1:String) : void
      {
         switch(param1)
         {
            case "capacityFontColor":
            case "capacityFontFamily":
            case "capacityFontSize":
            case "capacityFontStyle":
            case "capacityFontWeight":
               this.m_UICapacity.defaultTextFormat = this.getCapacityTextFormat();
               invalidateDisplayList();
               break;
            default:
               super.styleChanged(param1);
         }
      }
      
      public function pointToAbsolute(param1:Point) : Vector3D
      {
         var _loc2_:BodySlot = null;
         if(this.bodyContainer != null && (_loc2_ = getClassInstanceUnderPoint(stage,param1,BodySlot)) != null)
         {
            return new Vector3D(65535,_loc2_.position,0);
         }
         return null;
      }
      
      private function getCapacityTextFormat() : TextFormat
      {
         var _loc1_:String = getStyle("capacityFontFamily");
         var _loc2_:Number = getStyle("capacityFontSize");
         var _loc3_:uint = getStyle("capacityFontColor");
         var _loc4_:* = getStyle("capacityFontWeight") === "bold";
         var _loc5_:* = getStyle("capacityFontStyle") === "italic";
         return new TextFormat(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      override protected function commitProperties() : void
      {
         if(this.m_UncommittedBodyContainer)
         {
            this.updateSlots();
            this.m_UncommittedBodyContainer = false;
         }
         super.commitProperties();
      }
      
      function set player(param1:Player) : void
      {
         if(this.m_Player != param1)
         {
            if(this.m_Player != null)
            {
               this.m_Player.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onPlayerChange);
            }
            this.m_Player = param1;
            this.m_UncommittedPlayer = true;
            invalidateProperties();
            if(this.m_Player != null)
            {
               this.m_Player.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onPlayerChange);
            }
         }
      }
      
      public function getMultiUseObjectUnderPoint(param1:Point) : Object
      {
         return this.getUseObjectUnderPoint(param1);
      }
      
      override protected function measure() : void
      {
         super.measure();
         var _loc1_:EdgeMetrics = viewMetricsAndPadding;
         measuredMinWidth = measuredWidth = _loc1_.left + WIDGET_VIEW_WIDTH + _loc1_.right;
         measuredMinHeight = measuredHeight = _loc1_.top + WIDGET_VIEW_HEIGHT + _loc1_.bottom;
      }
      
      function get player() : Player
      {
         return this.m_Player;
      }
      
      protected function onSlotRollOut(param1:MouseEvent) : void
      {
         this.m_RolloverSlot = null;
         this.m_CursorHelper.resetCursor();
      }
      
      private function onPurseClick(param1:MouseEvent) : void
      {
         this.determineAction(param1,true,false);
      }
      
      protected function determineAction(param1:MouseEvent, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc10_:Object = null;
         var _loc4_:ContainerSlot = null;
         var _loc5_:AppearanceInstance = null;
         var _loc6_:Vector3D = new Vector3D(0,0,0);
         var _loc7_:AppearanceInstance = null;
         var _loc8_:MouseBinding = null;
         var _loc9_:uint = ACTION_NONE;
         if(m_Options == null)
         {
            return;
         }
         if(param1 != null)
         {
            _loc8_ = m_Options.mouseMapping.findBindingByMouseEvent(param1);
            if(param1.target == this.m_UIPurse)
            {
               _loc4_ = this.m_TempPurseSlot;
            }
            else
            {
               _loc4_ = param1.target as BodySlot;
            }
         }
         else
         {
            _loc8_ = m_Options.mouseMapping.findBindingForLeftMouseButtonAndPressedModifierKey();
            _loc4_ = this.m_RolloverSlot;
         }
         if(_loc8_ != null)
         {
            _loc9_ = _loc8_.action;
         }
         if(_loc4_ == null)
         {
            return;
         }
         _loc7_ = _loc4_.appearance;
         _loc6_ = new Vector3D(65535,_loc4_.position,0);
         if(_loc7_ != null)
         {
            _loc9_ = MouseActionHelper.resolveActionForAppearanceOrCreature(_loc9_,_loc7_,VALID_ACTIONS);
         }
         else
         {
            _loc9_ = ACTION_NONE;
         }
         if(Boolean(param3) && m_Options != null && m_Options.mouseMapping != null && Boolean(m_Options.mouseMapping.showMouseCursorForAction))
         {
            this.m_CursorHelper.setCursor(MouseActionHelper.actionToMouseCursor(_loc9_));
         }
         if(param2)
         {
            switch(_loc9_)
            {
               case ACTION_USE:
               case ACTION_OPEN:
                  new UseActionImpl(_loc6_,_loc7_.type,_loc6_.z,UseActionImpl.TARGET_AUTO).perform();
                  break;
               case ACTION_LOOK:
                  new LookActionImpl(_loc6_,_loc7_.type,_loc6_.z).perform();
                  break;
               case ACTION_CONTEXT_MENU:
                  if(_loc4_.appearance != null)
                  {
                     _loc10_ = {
                        "position":_loc6_.z,
                        "object":_loc7_
                     };
                     new ObjectContextMenu(_loc6_,_loc10_,_loc10_,null).display(this,param1.stageX,param1.stageY);
                  }
                  break;
               case ACTION_NONE:
            }
         }
      }
      
      private function updateSlots() : void
      {
         var _loc2_:BodySlot = null;
         var _loc1_:int = numChildren - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = BodySlot(getChildAt(_loc1_));
            if(this.bodyContainer != null)
            {
               _loc2_.appearance = this.bodyContainer.getObject(_loc2_.position);
            }
            else
            {
               _loc2_.appearance = null;
            }
            _loc1_--;
         }
         if(this.bodyContainer != null)
         {
            this.m_TempPurseSlot.appearance = this.bodyContainer.getObject(BodyContainerView.PURSE);
         }
         else
         {
            this.m_TempPurseSlot.appearance = null;
         }
      }
      
      private function onPlayerChange(param1:PropertyChangeEvent) : void
      {
         if(param1.property == "skill" || param1.property == "*")
         {
            this.m_UICapacity.text = this.getCapacityLabel();
            invalidateDisplayList();
         }
      }
      
      private function onModifierKeyEvent(param1:ModifierKeyEvent) : void
      {
         this.determineAction(null,false,true);
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc6_:BodySlot = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         super.updateDisplayList(param1,param2);
         var _loc3_:* = !(Boolean(widgetClosed) || Boolean(widgetCollapsed));
         var _loc4_:EdgeMetrics = viewMetricsAndPadding;
         this.m_UICapacity.visible = _loc3_;
         this.m_UICapacity.x = _loc4_.left + WIDGET_COMPONENTS[0].left;
         this.m_UICapacity.y = _loc4_.top + WIDGET_COMPONENTS[0].top - 2;
         this.m_UICapacity.width = WIDGET_COMPONENTS[0].width;
         this.m_UICapacity.height = WIDGET_COMPONENTS[0].height;
         this.m_UIPurse.visible = _loc3_;
         this.m_UIPurse.move(_loc4_.left + WIDGET_COMPONENTS[BodyContainerView.PURSE].left,_loc4_.top + WIDGET_COMPONENTS[BodyContainerView.PURSE].top);
         this.m_UIPurse.setActualSize(this.m_UIPurse.getExplicitOrMeasuredWidth(),this.m_UIPurse.getExplicitOrMeasuredHeight());
         var _loc5_:int = numChildren - 1;
         while(_loc5_ >= 0)
         {
            _loc6_ = BodySlot(getChildAt(_loc5_));
            _loc7_ = WIDGET_COMPONENTS[_loc6_.position].width;
            if(isNaN(_loc7_))
            {
               _loc7_ = _loc6_.getExplicitOrMeasuredWidth();
            }
            _loc8_ = WIDGET_COMPONENTS[_loc6_.position].height;
            if(isNaN(_loc8_))
            {
               _loc8_ = _loc6_.getExplicitOrMeasuredHeight();
            }
            _loc6_.visible = _loc3_;
            _loc6_.move(WIDGET_COMPONENTS[_loc6_.position].left,WIDGET_COMPONENTS[_loc6_.position].top);
            _loc6_.setActualSize(_loc7_,_loc8_);
            _loc5_--;
         }
      }
      
      function set bodyContainer(param1:BodyContainerView) : void
      {
         if(param1 != this.m_BodyContainer)
         {
            if(this.m_BodyContainer != null)
            {
               this.m_BodyContainer.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onBodyContainerChange);
            }
            this.m_BodyContainer = param1;
            if(this.m_BodyContainer != null)
            {
               this.m_BodyContainer.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onBodyContainerChange);
            }
            this.m_UncommittedBodyContainer = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
         }
      }
      
      function get bodyContainer() : BodyContainerView
      {
         return this.m_BodyContainer;
      }
   }
}
