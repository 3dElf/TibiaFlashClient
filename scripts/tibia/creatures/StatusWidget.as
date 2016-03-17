package tibia.creatures
{
   import mx.containers.Box;
   import mx.resources.ResourceManager;
   import tibia.creatures.statusWidgetClasses.StateRenderer;
   import tibia.creatures.statusWidgetClasses.BitmapProgressBar;
   import mx.core.EdgeMetrics;
   import mx.core.mx_internal;
   import mx.core.IBorder;
   import mx.events.ToolTipEvent;
   import mx.core.IToolTip;
   import mx.core.IInvalidating;
   import flash.geom.Matrix;
   import tibia.options.OptionsStorage;
   import mx.events.DragEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.managers.dragClasses.DragProxy;
   import mx.core.IFlexDisplayObject;
   import mx.core.DragSource;
   import mx.core.IUIComponent;
   import mx.managers.DragManager;
   import mx.events.PropertyChangeEvent;
   import flash.events.MouseEvent;
   import tibia.creatures.statusWidgetClasses.StatusWidgetContextMenu;
   import tibia.controls.GridContainer;
   import tibia.creatures.statusWidgetClasses.DefaultStatusWidgetStyle;
   import tibia.creatures.statusWidgetClasses.CompactStatusWidgetStyle;
   import tibia.creatures.statusWidgetClasses.ParallelStatusWidgetStyle;
   import flash.events.Event;
   import mx.events.SandboxMouseEvent;
   import mx.core.ScrollPolicy;
   
   public class StatusWidget extends Box
   {
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      protected static const DRAG_TYPE_SPELL:String = "spell";
      
      public static const DIRECTION_TOP_TO_BOTTOM:String = "tb";
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      protected static const DRAG_TYPE_CHANNEL:String = "channel";
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const SKILL_FIGHTCLUB:int = 9;
      
      public static const LOCATION_RIGHT:int = 3;
      
      protected static const WAR_ALLY:int = 1;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      protected static const PK_PARTYMODE:int = 2;
      
      public static const DIRECTION_RIGHT_TO_LEFT:String = "rl";
      
      protected static const WAR_ENEMY:int = 2;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      protected static const PARTY_MEMBER:int = 2;
      
      public static const DIRECTION_BOTTOM_TO_TOP:String = "bt";
      
      protected static const STATE_DRUNK:int = 3;
      
      protected static const WAR_NEUTRAL:int = 3;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const SKILL_STAMINA:int = 16;
      
      public static const STATUS_STYLE_FAT:int = 4;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const SKILL_FIGHTSHIELD:int = 7;
      
      protected static const SKILL_FIGHTAXE:int = 11;
      
      protected static const WAR_NONE:int = 0;
      
      protected static const SKILL_FIGHTDISTANCE:int = 8;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const DRAG_TYPE_OBJECT:String = "object";
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SKILL_FED:int = 14;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const SKILL_SOULPOINTS:int = 15;
      
      public static const LOCATION_LEFT:int = 2;
      
      protected static const SKILL_FISHING:int = 13;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
      
      protected static const STATE_FAST:int = 6;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_HITPOINTS:int = 3;
      
      protected static const SKILL_NONE:int = -1;
      
      protected static const SKILL_OFFLINETRAINING:int = 17;
      
      public static const DIRECTION_LEFT_TO_RIGHT:String = "lr";
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      public static const STATUS_STYLE_OFF:int = 0;
      
      protected static const SKILL_MANA:int = 4;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const DRAG_TYPE_ACTION:String = "action";
      
      public static const DIRECTION_AUTO:String = "a";
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      public static const LOCATION_TOP:int = 0;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 10;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const SKILL_CARRYSTRENGTH:int = 6;
      
      protected static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
      
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
      
      public static const STATUS_STYLE_PARALLEL:int = 3;
      
      private static const BUNDLE:String = "StatusWidget";
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      protected static const STATE_FIGHTING:int = 7;
      
      public static const STATUS_STYLE_COMPACT:int = 2;
      
      public static const STATUS_STYLE_DEFAULT:int = 1;
      
      protected static const DRAG_OPACITY:Number = 0.75;
      
      public static const LOCATION_BOTTOM:int = 1;
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
       
      protected var DRAG_SNAP_DISTANCE:int = 100;
      
      private var m_RealX:Number = 0;
      
      private var m_RealY:Number = 0;
      
      protected var m_UIState:StateRenderer = null;
      
      protected var m_UIMana:BitmapProgressBar = null;
      
      protected var m_Player:tibia.creatures.Player = null;
      
      private var m_UncommittedStyle:Boolean = true;
      
      private var m_UncommittedVisible:Boolean = true;
      
      protected var m_Options:OptionsStorage = null;
      
      protected var m_UIHitpoints:BitmapProgressBar = null;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_Style:int = 1;
      
      private var m_UncommittedSkill:Boolean = false;
      
      protected var m_UISkill:BitmapProgressBar = null;
      
      private var m_UncommittedOptions:Boolean = false;
      
      private var m_UncommittedPlayer:Boolean = false;
      
      protected var m_Skill:int = 1;
      
      private var m_UncommittedLocation:Boolean = true;
      
      protected var m_Location:int = 0;
      
      public function StatusWidget()
      {
         super();
         mx_internal::layoutObject = new DefaultStatusWidgetStyle();
         clipContent = false;
         horizontalScrollPolicy = ScrollPolicy.OFF;
         verticalScrollPolicy = ScrollPolicy.OFF;
         addEventListener(MouseEvent.MOUSE_DOWN,this.onDragInit);
         addEventListener(MouseEvent.RIGHT_CLICK,this.onMouseClick);
      }
      
      public static function s_GetSkillName(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case SKILL_NONE:
               _loc2_ = "SKILL_NONE";
               break;
            case SKILL_LEVEL:
               _loc2_ = "SKILL_LEVEL";
               break;
            case SKILL_MAGLEVEL:
               _loc2_ = "SKILL_MAGLEVEL";
               break;
            case SKILL_FIGHTAXE:
               _loc2_ = "SKILL_FIGHTAXE";
               break;
            case SKILL_FIGHTCLUB:
               _loc2_ = "SKILL_FIGHTCLUB";
               break;
            case SKILL_FIGHTDISTANCE:
               _loc2_ = "SKILL_FIGHTDISTANCE";
               break;
            case SKILL_FIGHTFIST:
               _loc2_ = "SKILL_FIGHTFIST";
               break;
            case SKILL_FIGHTSHIELD:
               _loc2_ = "SKILL_FIGHTSHIELD";
               break;
            case SKILL_FIGHTSWORD:
               _loc2_ = "SKILL_FIGHTSWORD";
               break;
            case SKILL_FISHING:
               _loc2_ = "SKILL_FISHING";
               break;
            default:
               _loc2_ = null;
         }
         return ResourceManager.getInstance().getString(BUNDLE,_loc2_);
      }
      
      public static function s_GetStyleName(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case STATUS_STYLE_COMPACT:
               _loc2_ = "STYLE_COMPACT";
               break;
            case STATUS_STYLE_DEFAULT:
               _loc2_ = "STYLE_DEFAULT";
               break;
            case STATUS_STYLE_FAT:
               _loc2_ = "STYLE_FAT";
               break;
            case STATUS_STYLE_OFF:
               _loc2_ = "STYLE_OFF";
               break;
            case STATUS_STYLE_PARALLEL:
               _loc2_ = "STYLE_PARALLEL";
               break;
            default:
               _loc2_ = null;
         }
         return ResourceManager.getInstance().getString(BUNDLE,_loc2_);
      }
      
      override public function set explicitMinHeight(param1:Number) : void
      {
      }
      
      override public function set width(param1:Number) : void
      {
         if(this.isHorizontal())
         {
            super.width = param1;
         }
         else
         {
            super.height = param1;
         }
      }
      
      override public function get borderMetrics() : EdgeMetrics
      {
         if(mx_internal::border is IBorder)
         {
            return IBorder(mx_internal::border).borderMetrics;
         }
         return super.borderMetrics;
      }
      
      protected function onSkillToolTip(param1:ToolTipEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:IToolTip = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(param1 != null && param1.toolTip != null)
         {
            if(this.m_Player != null && this.m_Skill != SKILL_NONE)
            {
               _loc2_ = NaN;
               _loc3_ = NaN;
               _loc4_ = null;
               _loc5_ = StatusWidget.s_GetSkillName(this.m_Skill);
               if(this.m_Skill == SKILL_LEVEL)
               {
                  _loc2_ = this.m_Player.getSkillGain(SKILL_EXPERIENCE);
                  _loc3_ = tibia.creatures.Player.s_GetExperienceForLevel(this.m_Player.level + 1) - this.m_Player.getSkillValue(SKILL_EXPERIENCE);
                  _loc4_ = resourceManager.getString(BUNDLE,"TIP_SKILL_UNIT_EXPERIENCE");
               }
               else
               {
                  _loc2_ = this.m_Player.getSkillGain(this.m_Skill);
                  _loc3_ = 100 - this.m_Player.getSkillProgress(this.m_Skill);
                  _loc4_ = resourceManager.getString(BUNDLE,"TIP_SKILL_UNIT_DEFAULT");
               }
               _loc3_ = Math.max(0,_loc3_);
               _loc6_ = param1.toolTip;
               if(_loc2_ > 0)
               {
                  _loc7_ = Math.floor(_loc3_ * 60 / _loc2_);
                  _loc8_ = Math.floor(_loc7_ / 60);
                  _loc7_ = _loc7_ - _loc8_ * 60;
                  _loc6_.text = resourceManager.getString(BUNDLE,"TIP_SKILL_EXTENDED",[_loc5_,_loc3_,_loc4_,_loc2_,_loc8_,_loc7_]);
               }
               else
               {
                  _loc6_.text = resourceManager.getString(BUNDLE,"TIP_SKILL_SIMPLE",[_loc5_,_loc3_,_loc4_]);
               }
               if(_loc6_ is IInvalidating)
               {
                  IInvalidating(_loc6_).validateNow();
                  _loc9_ = _loc6_.getExplicitOrMeasuredWidth();
                  _loc10_ = _loc6_.getExplicitOrMeasuredHeight();
                  _loc11_ = Math.max(0,Math.min(_loc6_.x,stage.stageWidth - _loc9_));
                  _loc12_ = Math.max(0,Math.min(_loc6_.y,stage.stageHeight - _loc10_));
                  _loc6_.move(_loc11_,_loc12_);
                  _loc6_.setActualSize(_loc9_,_loc10_);
               }
            }
            else
            {
               param1.preventDefault();
               param1.stopImmediatePropagation();
            }
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc3_:Matrix = null;
         if(direction == DIRECTION_BOTTOM_TO_TOP)
         {
            transform.matrix = new Matrix(0,-1,1,0,this.m_RealX,this.m_RealY + param1);
         }
         else if(direction == DIRECTION_TOP_TO_BOTTOM)
         {
            transform.matrix = new Matrix(0,1,-1,0,this.m_RealX + param2,this.m_RealY);
         }
         else
         {
            transform.matrix = new Matrix(1,0,0,1,this.m_RealX,this.m_RealY);
         }
         this.m_UIState.transform.matrix = new Matrix();
         super.updateDisplayList(param1,param2);
         if(direction == DIRECTION_BOTTOM_TO_TOP)
         {
            _loc3_ = this.m_UIState.transform.matrix;
            this.m_UIState.transform.matrix = new Matrix(-1,0,0,-1,this.m_UIState.getExplicitOrMeasuredWidth() + _loc3_.tx,this.m_UIState.getExplicitOrMeasuredHeight() + _loc3_.ty);
         }
      }
      
      public function get options() : OptionsStorage
      {
         return this.m_Options;
      }
      
      public function set skill(param1:int) : void
      {
         if(this.m_Skill != param1)
         {
            this.m_Skill = param1;
            this.m_UncommittedSkill = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
         }
      }
      
      protected function onDragEvent(param1:DragEvent) : void
      {
         var _loc4_:Point = null;
         var _loc5_:Rectangle = null;
         var _loc6_:int = 0;
         var _loc7_:DragProxy = null;
         var _loc8_:IFlexDisplayObject = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc2_:DragSource = null;
         var _loc3_:IUIComponent = null;
         if(param1 != null && (_loc2_ = param1.dragSource) != null && Boolean(_loc2_.hasFormat("dragType")) && _loc2_.dataForFormat("dragType") == DRAG_TYPE_STATUSWIDGET && (_loc3_ = param1.currentTarget as IUIComponent) != null)
         {
            _loc4_ = _loc3_.localToGlobal(new Point(0,0));
            _loc5_ = new Rectangle(_loc4_.x,_loc4_.y,_loc3_.width / _loc3_.scaleX,_loc3_.height / _loc3_.scaleY);
            _loc6_ = -1;
            if(_loc5_.contains(stage.mouseX,stage.mouseY))
            {
               if(stage.mouseY < _loc5_.top + this.DRAG_SNAP_DISTANCE)
               {
                  _loc6_ = LOCATION_TOP;
               }
               else if(stage.mouseY > _loc5_.bottom - this.DRAG_SNAP_DISTANCE)
               {
                  _loc6_ = LOCATION_BOTTOM;
               }
               else if(stage.mouseX < _loc5_.left + this.DRAG_SNAP_DISTANCE)
               {
                  _loc6_ = LOCATION_LEFT;
               }
               else if(stage.mouseX > _loc5_.right - this.DRAG_SNAP_DISTANCE)
               {
                  _loc6_ = LOCATION_RIGHT;
               }
            }
            switch(param1.type)
            {
               case DragEvent.DRAG_DROP:
                  if(_loc6_ > -1 && this.m_Location != _loc6_)
                  {
                     this.m_Location = _loc6_;
                     this.m_UncommittedLocation = true;
                     invalidateProperties();
                  }
                  _loc3_.removeEventListener(DragEvent.DRAG_DROP,this.onDragEvent);
                  _loc3_.removeEventListener(DragEvent.DRAG_ENTER,this.onDragEvent);
                  _loc3_.removeEventListener(DragEvent.DRAG_EXIT,this.onDragEvent);
                  _loc3_.removeEventListener(DragEvent.DRAG_OVER,this.onDragEvent);
                  break;
               case DragEvent.DRAG_ENTER:
                  DragManager.acceptDragDrop(_loc3_);
               case DragEvent.DRAG_EXIT:
               case DragEvent.DRAG_OVER:
                  _loc7_ = DragManager.mx_internal::dragProxy;
                  _loc8_ = null;
                  if(_loc7_ != null && (_loc8_ = _loc7_.getChildAt(0) as IFlexDisplayObject) != null)
                  {
                     _loc9_ = 0;
                     _loc10_ = 0;
                     if(this.m_Location == LOCATION_TOP || this.m_Location == LOCATION_BOTTOM)
                     {
                        _loc9_ = unscaledWidth;
                        _loc10_ = unscaledHeight;
                     }
                     else
                     {
                        _loc9_ = unscaledHeight;
                        _loc10_ = unscaledWidth;
                     }
                     if(_loc6_ == LOCATION_TOP)
                     {
                        _loc7_.move(_loc5_.left,_loc5_.top);
                        _loc7_.setActualSize(_loc5_.width,_loc10_);
                        _loc8_.setActualSize(_loc5_.width,_loc10_);
                     }
                     else if(_loc6_ == LOCATION_BOTTOM)
                     {
                        _loc7_.move(_loc5_.left,_loc5_.bottom - _loc10_);
                        _loc7_.setActualSize(_loc5_.width,_loc10_);
                        _loc8_.setActualSize(_loc5_.width,_loc10_);
                     }
                     else if(_loc6_ == LOCATION_LEFT)
                     {
                        _loc7_.move(_loc5_.left,_loc5_.top);
                        _loc7_.setActualSize(_loc10_,_loc5_.height);
                        _loc8_.setActualSize(_loc10_,_loc5_.height);
                     }
                     else if(_loc6_ == LOCATION_RIGHT)
                     {
                        _loc7_.move(_loc5_.right - _loc10_,_loc5_.top);
                        _loc7_.setActualSize(_loc10_,_loc5_.height);
                        _loc8_.setActualSize(_loc10_,_loc5_.height);
                     }
                     else
                     {
                        _loc7_.setActualSize(unscaledWidth,unscaledHeight);
                        _loc8_.setActualSize(unscaledWidth,unscaledHeight);
                     }
                  }
                  break;
               default:
                  log("StatusWidget.onDragInit: Unknown event type.");
            }
         }
      }
      
      override public function set explicitMaxHeight(param1:Number) : void
      {
      }
      
      public function get style() : int
      {
         return this.m_Style;
      }
      
      override public function set measuredHeight(param1:Number) : void
      {
         if(this.isHorizontal())
         {
            super.measuredHeight = param1;
         }
         else
         {
            super.measuredWidth = param1;
         }
      }
      
      public function get location() : int
      {
         return this.m_Location;
      }
      
      protected function onPlayerChange(param1:PropertyChangeEvent) : void
      {
         if(param1 != null)
         {
            switch(param1.property)
            {
               case "skill":
                  this.updateHitpoints();
                  this.updateMana();
                  this.updateSkill();
                  break;
               case "stateFlags":
                  this.updateState();
            }
         }
      }
      
      override public function setActualSize(param1:Number, param2:Number) : void
      {
         if(this.isHorizontal())
         {
            super.setActualSize(param1,param2);
         }
         else
         {
            super.setActualSize(param2,param1);
         }
      }
      
      protected function onMouseClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            new StatusWidgetContextMenu(this.m_Options).display(this,param1.stageX,param1.stageY);
         }
      }
      
      override public function set explicitMaxWidth(param1:Number) : void
      {
      }
      
      public function set options(param1:OptionsStorage) : void
      {
         if(this.m_Options != param1)
         {
            if(this.m_Options != null)
            {
               this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onOptionsChange);
            }
            this.m_Options = param1;
            this.m_UncommittedOptions = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
            if(this.m_Options != null)
            {
               this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onOptionsChange);
            }
         }
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIHitpoints = new BitmapProgressBar();
            this.m_UIHitpoints.labelEnabled = true;
            this.m_UIHitpoints.labelFormat = "{1}/{2}";
            this.m_UIHitpoints.name = "hitpoints";
            this.m_UIHitpoints.percentHeight = NaN;
            this.m_UIHitpoints.percentWidth = 100;
            this.updateHitpoints();
            addChild(this.m_UIHitpoints);
            this.m_UIMana = new BitmapProgressBar();
            this.m_UIMana.labelEnabled = true;
            this.m_UIMana.labelFormat = "{1}/{2}";
            this.m_UIMana.name = "mana";
            this.m_UIMana.percentHeight = NaN;
            this.m_UIMana.percentWidth = 100;
            this.updateMana();
            addChild(this.m_UIMana);
            this.m_UISkill = new BitmapProgressBar();
            this.m_UISkill.labelEnabled = false;
            this.m_UISkill.labelFormat = "{1}%";
            this.m_UISkill.name = "skill";
            this.m_UISkill.percentHeight = NaN;
            this.m_UISkill.percentWidth = 100;
            this.m_UISkill.tickValues = [25,50,75];
            this.m_UISkill.toolTip = "toolTip";
            this.m_UISkill.addEventListener(ToolTipEvent.TOOL_TIP_SHOW,this.onSkillToolTip);
            this.updateSkill();
            addChild(this.m_UISkill);
            this.m_UIState = new StateRenderer();
            this.m_UIState.maxColumns = int.MAX_VALUE;
            this.m_UIState.minColumns = 4;
            this.m_UIState.maxRows = this.m_Style == STATUS_STYLE_FAT?2:1;
            this.m_UIState.minRows = 1;
            this.m_UIState.name = "state";
            addChild(this.m_UIState);
            this.m_UIConstructed = true;
         }
      }
      
      private function updateHitpoints() : void
      {
         if(this.m_Player != null)
         {
            this.m_UIHitpoints.maxValue = this.m_Player.hitpointsMax;
            this.m_UIHitpoints.value = this.m_Player.hitpoints;
         }
         else
         {
            this.m_UIHitpoints.maxValue = 100;
            this.m_UIHitpoints.value = 100;
         }
         this.m_UIHitpoints.toolTip = this.m_UIHitpoints.value + "/" + this.m_UIHitpoints.maxValue;
      }
      
      private function updateMana() : void
      {
         if(this.m_Player != null)
         {
            this.m_UIMana.maxValue = this.m_Player.manaMax;
            this.m_UIMana.value = this.m_Player.mana;
         }
         else
         {
            this.m_UIMana.maxValue = 100;
            this.m_UIMana.value = 100;
         }
         this.m_UIMana.toolTip = this.m_UIMana.value + "/" + this.m_UIMana.maxValue;
      }
      
      public function set player(param1:tibia.creatures.Player) : void
      {
         if(this.m_Player != param1)
         {
            if(this.m_Player != null)
            {
               this.m_Player.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onPlayerChange);
            }
            this.m_Player = param1;
            this.m_UncommittedPlayer = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
            if(this.m_Player != null)
            {
               this.m_Player.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onPlayerChange);
            }
         }
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:GridContainer = null;
         if(this.m_UncommittedPlayer)
         {
            this.updateHitpoints();
            this.updateMana();
            this.updateSkill();
            this.updateState();
            this.m_UncommittedPlayer = false;
         }
         if(this.m_UncommittedOptions)
         {
            if(this.m_Options != null)
            {
               this.location = this.m_Options.statusWidgetLocation;
               this.skill = this.m_Options.statusWidgetSkill;
               this.style = this.m_Options.statusWidgetStyle;
               this.visible = this.m_Options.statusWidgetVisible;
            }
            this.m_UncommittedOptions = false;
         }
         if(this.m_UncommittedSkill)
         {
            this.m_UISkill.includeInLayout = this.m_Skill != SKILL_NONE;
            this.m_UISkill.visible = this.m_Skill != SKILL_NONE;
            this.updateSkill();
            this.m_UncommittedSkill = false;
         }
         if(this.m_UncommittedStyle)
         {
            switch(this.m_Style)
            {
               case STATUS_STYLE_DEFAULT:
                  mx_internal::layoutObject = new DefaultStatusWidgetStyle();
                  styleName = "statusWidgetDefault";
                  break;
               case STATUS_STYLE_COMPACT:
                  mx_internal::layoutObject = new CompactStatusWidgetStyle();
                  styleName = "statusWidgetCompact";
                  break;
               case STATUS_STYLE_FAT:
                  mx_internal::layoutObject = new CompactStatusWidgetStyle();
                  styleName = "statusWidgetFat";
                  break;
               case STATUS_STYLE_PARALLEL:
                  mx_internal::layoutObject = new ParallelStatusWidgetStyle();
                  styleName = "statusWidgetParallel";
            }
            mx_internal::layoutObject.direction = this.getDirectionFromLocation(this.m_Location);
            mx_internal::layoutObject.target = this;
            this.m_UIHitpoints.styleName = getStyle("hitpointsStyle");
            this.m_UIMana.styleName = getStyle("manaStyle");
            this.m_UISkill.styleName = getStyle("skillStyle");
            this.m_UIState.styleName = getStyle("stateStyle");
            this.m_UIState.maxRows = this.m_Style == STATUS_STYLE_FAT?2:1;
            if(this.m_Options != null)
            {
               this.m_Options.statusWidgetStyle = this.m_Style;
            }
            this.m_UncommittedStyle = false;
         }
         if(this.m_UncommittedVisible)
         {
            includeInLayout = visible;
            if(this.m_Options != null)
            {
               this.m_Options.statusWidgetVisible = visible;
            }
            this.m_UncommittedVisible = false;
         }
         if(this.m_UncommittedLocation)
         {
            _loc1_ = parent as GridContainer;
            if(_loc1_ != null)
            {
               switch(this.m_Location)
               {
                  case LOCATION_TOP:
                     _loc1_.top = this;
                     break;
                  case LOCATION_BOTTOM:
                     _loc1_.bottom = this;
                     break;
                  case LOCATION_LEFT:
                     _loc1_.left = this;
                     break;
                  case LOCATION_RIGHT:
                     _loc1_.right = this;
               }
            }
            if(mx_internal::layoutObject != null)
            {
               mx_internal::layoutObject.direction = this.getDirectionFromLocation(this.m_Location);
            }
            if(this.m_Options != null)
            {
               this.m_Options.statusWidgetLocation = this.m_Location;
            }
            this.m_UncommittedLocation = false;
         }
         super.commitProperties();
      }
      
      override public function set measuredWidth(param1:Number) : void
      {
         if(this.isHorizontal())
         {
            super.measuredWidth = param1;
         }
         else
         {
            super.measuredHeight = param1;
         }
      }
      
      override public function set explicitMinWidth(param1:Number) : void
      {
      }
      
      public function get skill() : int
      {
         return this.m_Skill;
      }
      
      override public function set height(param1:Number) : void
      {
         if(this.isHorizontal())
         {
            super.height = param1;
         }
         else
         {
            super.width = param1;
         }
      }
      
      protected function onOptionsChange(param1:PropertyChangeEvent) : void
      {
         if(param1 != null)
         {
            switch(param1.property)
            {
               case "statusWidgetLocation":
                  this.location = this.m_Options.statusWidgetLocation;
                  break;
               case "statusWidgetSkill":
                  this.skill = this.m_Options.statusWidgetSkill;
                  break;
               case "statusWidgetStyle":
                  this.style = this.m_Options.statusWidgetStyle;
                  break;
               case "statusWidgetVisible":
                  this.visible = this.m_Options.statusWidgetVisible;
                  break;
               case "*":
                  this.location = this.m_Options.statusWidgetLocation;
                  this.skill = this.m_Options.statusWidgetSkill;
                  this.style = this.m_Options.statusWidgetStyle;
                  this.visible = this.m_Options.statusWidgetVisible;
            }
         }
      }
      
      private function updateState() : void
      {
         if(this.m_Player != null)
         {
            this.m_UIState.bitSet = this.m_Player.stateFlags;
         }
         else
         {
            this.m_UIState.bitSet = 4294967295;
         }
      }
      
      private function updateSkill() : void
      {
         if(this.m_Player != null && this.m_Skill != SKILL_NONE)
         {
            this.m_UISkill.maxValue = 100;
            this.m_UISkill.value = this.m_Player.getSkillProgress(this.m_Skill);
         }
         else
         {
            this.m_UISkill.maxValue = 100;
            this.m_UISkill.value = 100;
         }
         this.m_UISkill.toolTip = "toolTip";
      }
      
      public function get player() : tibia.creatures.Player
      {
         return this.m_Player;
      }
      
      public function set style(param1:int) : void
      {
         if(this.m_Style != param1)
         {
            if(param1 == STATUS_STYLE_COMPACT || param1 == STATUS_STYLE_DEFAULT || param1 == STATUS_STYLE_FAT || param1 == STATUS_STYLE_PARALLEL)
            {
               this.m_Style = param1;
               this.m_UncommittedStyle = true;
               invalidateDisplayList();
               invalidateProperties();
               invalidateSize();
            }
            else
            {
               throw new ArgumentError("StatusWidget.set style: Invalid style: " + param1);
            }
         }
      }
      
      protected function onDragInit(param1:Event) : void
      {
         var _loc2_:DragSource = null;
         if(param1 != null)
         {
            switch(param1.type)
            {
               case MouseEvent.MOUSE_DOWN:
                  addEventListener(MouseEvent.MOUSE_MOVE,this.onDragInit);
                  addEventListener(MouseEvent.MOUSE_UP,this.onDragInit);
                  addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.onDragInit);
                  break;
               case MouseEvent.MOUSE_MOVE:
                  if(parent != null)
                  {
                     parent.addEventListener(DragEvent.DRAG_DROP,this.onDragEvent);
                     parent.addEventListener(DragEvent.DRAG_ENTER,this.onDragEvent);
                     parent.addEventListener(DragEvent.DRAG_EXIT,this.onDragEvent);
                     parent.addEventListener(DragEvent.DRAG_OVER,this.onDragEvent);
                     _loc2_ = new DragSource();
                     _loc2_.addData(DRAG_TYPE_STATUSWIDGET,"dragType");
                     DragManager.doDrag(this,_loc2_,param1 as MouseEvent);
                  }
               case MouseEvent.MOUSE_UP:
               case SandboxMouseEvent.MOUSE_UP_SOMEWHERE:
                  removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragInit);
                  removeEventListener(MouseEvent.MOUSE_UP,this.onDragInit);
                  removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.onDragInit);
                  break;
               default:
                  log("StatusWidget.onDragInit: Unknown event type.");
            }
         }
      }
      
      override public function set explicitWidth(param1:Number) : void
      {
      }
      
      private function getDirectionFromLocation(param1:int) : String
      {
         switch(param1)
         {
            case LOCATION_BOTTOM:
               return DIRECTION_LEFT_TO_RIGHT;
            case LOCATION_LEFT:
               return DIRECTION_BOTTOM_TO_TOP;
            case LOCATION_RIGHT:
               return DIRECTION_TOP_TO_BOTTOM;
            case LOCATION_TOP:
               return DIRECTION_LEFT_TO_RIGHT;
            default:
               return null;
         }
      }
      
      override public function move(param1:Number, param2:Number) : void
      {
         if(this.m_RealX != param1 || this.m_RealY != param2)
         {
            this.m_RealX = param1;
            this.m_RealY = param2;
            invalidateDisplayList();
         }
      }
      
      public function set location(param1:int) : void
      {
         if(param1 != LOCATION_TOP && param1 != LOCATION_BOTTOM && param1 != LOCATION_LEFT && param1 != LOCATION_RIGHT)
         {
            throw new ArgumentError("StatusWidget.set location: Invalid location.");
         }
         if(this.m_Location != param1)
         {
            this.m_Location = param1;
            this.m_UncommittedLocation = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
         }
      }
      
      override public function set measuredMinHeight(param1:Number) : void
      {
         if(this.isHorizontal())
         {
            super.measuredMinHeight = param1;
         }
         else
         {
            super.measuredMinWidth = param1;
         }
      }
      
      private function isHorizontal() : Boolean
      {
         return direction == DIRECTION_LEFT_TO_RIGHT || direction == DIRECTION_RIGHT_TO_LEFT;
      }
      
      override public function set x(param1:Number) : void
      {
         if(this.m_RealX != param1)
         {
            this.m_RealX = param1;
            invalidateDisplayList();
         }
      }
      
      override public function set y(param1:Number) : void
      {
         if(this.m_RealY != param1)
         {
            this.m_RealY = param1;
            invalidateDisplayList();
         }
      }
      
      override public function set measuredMinWidth(param1:Number) : void
      {
         if(this.isHorizontal())
         {
            super.measuredMinWidth = param1;
         }
         else
         {
            super.measuredMinHeight = param1;
         }
      }
      
      override public function set explicitHeight(param1:Number) : void
      {
      }
      
      override public function get x() : Number
      {
         return this.m_RealX;
      }
      
      override public function get y() : Number
      {
         return this.m_RealY;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(super.visible != param1)
         {
            super.visible = param1;
            this.m_UncommittedVisible = true;
            invalidateProperties();
         }
      }
   }
}
