package tibia.container.bodyContainerViewWigdetClasses
{
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   import tibia.game.IUseWidget;
   import tibia.game.IMoveWidget;
   import tibia.container.BodyContainerView;
   import flash.text.TextField;
   import shared.utility.Vector3D;
   import flash.geom.Point;
   import shared.utility.getClassInstanceUnderPoint;
   import tibia.game.ObjectDragImpl;
   import flash.events.MouseEvent;
   import tibia.container.containerViewWidgetClasses.containerSlotMouseEventHandler;
   import tibia.creatures.Player;
   import mx.events.PropertyChangeEvent;
   import flash.text.TextFormat;
   import tibia.appearances.AppearanceInstance;
   import tibia.appearances.AppearanceType;
   import tibia.input.gameaction.UseActionImpl;
   import mx.controls.Button;
   import flash.text.TextFieldAutoSize;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   import shared.controls.CustomButton;
   import mx.core.EdgeMetrics;
   import tibia.§sidebar:ns_sidebar_internal§.widgetClosed;
   import tibia.§sidebar:ns_sidebar_internal§.widgetCollapsed;
   import mx.core.ScrollPolicy;
   
   public class BodyContainerViewWidgetView extends WidgetView implements IUseWidget, IMoveWidget
   {
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      protected static const GUILD_WAR_ALLY:int = 1;
      
      protected static const PARTY_MAX_FLASHING_TIME:uint = 5000;
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const SUMMON_OWN:int = 1;
      
      protected static const SKILL_FIGHTCLUB:int = 10;
      
      protected static const RISKINESS_DANGEROUS:int = 1;
      
      protected static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
      
      protected static const RISKINESS_NONE:int = 0;
      
      protected static const GUILD_NONE:int = 0;
      
      protected static const PK_PARTYMODE:int = 2;
      
      protected static const TYPE_SUMMON_OWN:int = 3;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      protected static const PARTY_MEMBER:int = 2;
      
      protected static const PARTY_OTHER:int = 11;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      protected static const TYPE_SUMMON_OTHERS:int = 4;
      
      protected static const STATE_DRUNK:int = 3;
      
      protected static const SKILL_STAMINA:int = 17;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const SKILL_FIGHTSHIELD:int = 8;
      
      protected static const SKILL_FIGHTAXE:int = 12;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const SKILL_FIGHTDISTANCE:int = 9;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const SKILL_FED:int = 15;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const SKILL_SOULPOINTS:int = 16;
      
      protected static const SKILL_FISHING:int = 14;
      
      protected static const SKILL_HITPOINTS_PERCENT:int = 3;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const STATE_FAST:int = 6;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const GUILD_OTHER:int = 5;
      
      protected static const SKILL_NONE:int = -1;
      
      protected static const SKILL_HITPOINTS:int = 4;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_OFFLINETRAINING:int = 18;
      
      protected static const SUMMON_OTHERS:int = 2;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      private static const WIDGET_VIEW_WIDTH:Number = 176;
      
      protected static const SKILL_MANA:int = 5;
      
      protected static const GUILD_MEMBER:int = 4;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const STATE_FREEZING:int = 9;
      
      private static const BUNDLE:String = "BodyContainerViewWidget";
      
      private static const WIDGET_VIEW_HEIGHT:Number = 154;
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      protected static const SKILL_CARRYSTRENGTH:int = 7;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 11;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const STATE_POISONED:int = 0;
      
      protected static const STATE_BURNING:int = 1;
      
      protected static const SKILL_FIGHTFIST:int = 13;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const GUILD_WAR_NEUTRAL:int = 3;
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const GUILD_WAR_ENEMY:int = 2;
      
      protected static const PROFESSION_DRUID:int = 4;
      
      protected static const STATE_FIGHTING:int = 7;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      protected static const SUMMON_NONE:int = 0;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
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
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const PK_MAX_FLASHING_TIME:uint = 5000;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
       
      private var m_UICapacity:TextField = null;
      
      private const m_DragHandler:ObjectDragImpl = new ObjectDragImpl();
      
      private var m_BodyContainer:BodyContainerView = null;
      
      private var m_UncommittedPlayer:Boolean = false;
      
      private var m_Player:Player = null;
      
      private var m_UIPurse:Button = null;
      
      private var m_UncommittedBodyContainer:Boolean = false;
      
      public function BodyContainerViewWidgetView()
      {
         super();
         horizontalScrollPolicy = ScrollPolicy.OFF;
         verticalScrollPolicy = ScrollPolicy.OFF;
         titleText = resourceManager.getString(BUNDLE,"TITLE");
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
      
      private function onSlotClick(param1:MouseEvent) : void
      {
         var _loc2_:BodySlot = null;
         if(this.bodyContainer != null && (_loc2_ = param1.target as BodySlot) != null)
         {
            containerSlotMouseEventHandler(param1,this,new Vector3D(65535,_loc2_.position,0),_loc2_.appearance);
         }
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
      
      private function getCapacityTextFormat() : TextFormat
      {
         var _loc1_:String = getStyle("capacityFontFamily");
         var _loc2_:Number = getStyle("capacityFontSize");
         var _loc3_:uint = getStyle("capacityFontColor");
         var _loc4_:* = getStyle("capacityFontWeight") === "bold";
         var _loc5_:* = getStyle("capacityFontStyle") === "italic";
         return new TextFormat(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      private function onPurseClick(param1:MouseEvent) : void
      {
         var _loc2_:AppearanceInstance = null;
         var _loc3_:AppearanceType = null;
         if(this.bodyContainer != null && (_loc2_ = this.bodyContainer.getObject(BodyContainerView.PURSE)) != null && (_loc3_ = _loc2_.type) != null)
         {
            new UseActionImpl(new Vector3D(65535,BodyContainerView.PURSE,0),_loc3_,0,UseActionImpl.TARGET_NEW_WINDOW).perform();
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
      
      function get player() : Player
      {
         return this.m_Player;
      }
      
      public function getMultiUseObjectUnderPoint(param1:Point) : Object
      {
         return this.getUseObjectUnderPoint(param1);
      }
      
      public function getMoveObjectUnderPoint(param1:Point) : Object
      {
         return this.getUseObjectUnderPoint(param1);
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
               this.m_DragHandler.addDragComponent(_loc2_);
               addChild(_loc2_);
            }
            _loc1_++;
         }
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
      
      override protected function commitProperties() : void
      {
         if(this.m_UncommittedBodyContainer)
         {
            this.updateSlots();
            this.m_UncommittedBodyContainer = false;
         }
         super.commitProperties();
      }
      
      override protected function measure() : void
      {
         super.measure();
         var _loc1_:EdgeMetrics = viewMetricsAndPadding;
         measuredMinWidth = measuredWidth = _loc1_.left + WIDGET_VIEW_WIDTH + _loc1_.right;
         measuredMinHeight = measuredHeight = _loc1_.top + WIDGET_VIEW_HEIGHT + _loc1_.bottom;
      }
      
      private function onBodyContainerChange(param1:PropertyChangeEvent) : void
      {
         if(param1.property == "objects")
         {
            this.updateSlots();
         }
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
      
      public function pointToMap(param1:Point) : Vector3D
      {
         return null;
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
            this.m_DragHandler.removeDragComponent(_loc2_);
            _loc1_++;
         }
         this.m_UIPurse.removeEventListener(MouseEvent.CLICK,this.onPurseClick);
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
