package tibia.worldmap
{
   import mx.core.Container;
   import tibia.game.IUseWidget;
   import tibia.game.IMoveWidget;
   import flash.display.Bitmap;
   import tibia.game.ObjectDragImpl;
   import tibia.creatures.Player;
   import mx.core.FlexShape;
   import tibia.worldmap.widgetClasses.RendererImpl;
   import flash.events.MouseEvent;
   import mx.controls.Label;
   import tibia.options.OptionsStorage;
   import tibia.creatures.Creature;
   import shared.utility.Vector3D;
   import tibia.network.Connection;
   import tibia.input.gameaction.UseActionImpl;
   import tibia.input.gameaction.LookActionImpl;
   import tibia.game.ObjectContextMenu;
   import flash.geom.Point;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import tibia.creatures.CreatureStorage;
   import flash.geom.Rectangle;
   import mx.events.ResizeEvent;
   
   public class WorldMapWidget extends Container implements IUseWidget, IMoveWidget
   {
      
      private static const EMBED_LATENCY_ICON_HIGH:Class = WorldMapWidget_EMBED_LATENCY_ICON_HIGH;
      
      private static const BUNDLE:String = "WorldMapStorage";
      
      protected static const ACTION_ATTACK_FALLTHROUGH:int = 2;
      
      private static const LATENCY_ICON_HIGH:Bitmap = new EMBED_LATENCY_ICON_HIGH();
      
      protected static const ACTION_LOOK:int = 5;
      
      protected static const NUM_EFFECTS:int = 200;
      
      protected static const MAP_HEIGHT:int = 11;
      
      private static const EMBED_LATENCY_ICON_LOW:Class = WorldMapWidget_EMBED_LATENCY_ICON_LOW;
      
      protected static const DRAG_TYPE_CHANNEL:String = "channel";
      
      protected static const ONSCREEN_MESSAGE_WIDTH:int = 295;
      
      private static const WIDGET_MIN_WIDTH:int = 350;
      
      protected static const ACTION_NONE:int = 0;
      
      private static const LATENCY_ICON_MEDIUM:Bitmap = new EMBED_LATENCY_ICON_MEDIUM();
      
      protected static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
      
      protected static const UNDERGROUND_LAYER:int = 2;
      
      protected static const NUM_FIELDS:int = MAPSIZE_Z * MAPSIZE_Y * MAPSIZE_X;
      
      protected static const FIELD_HEIGHT:int = 24;
      
      protected static const DRAG_TYPE_SPELL:String = "spell";
      
      protected static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
      
      protected static const FIELD_CACHESIZE:int = FIELD_SIZE;
      
      private static const EMBED_LATENCY_ICON_MEDIUM:Class = WorldMapWidget_EMBED_LATENCY_ICON_MEDIUM;
      
      private static const LATENCY_ICON_LOW:Bitmap = new EMBED_LATENCY_ICON_LOW();
      
      protected static const ACTION_UNSET:int = -1;
      
      protected static const MAP_MIN_X:int = 24576;
      
      protected static const MAP_MIN_Y:int = 24576;
      
      protected static const MAP_MIN_Z:int = 0;
      
      protected static const PLAYER_OFFSET_Y:int = 6;
      
      protected static const FIELD_SIZE:int = 32;
      
      protected static const DRAG_TYPE_ACTION:String = "action";
      
      protected static const PLAYER_OFFSET_X:int = 8;
      
      protected static const MAPSIZE_W:int = 10;
      
      protected static const MAPSIZE_X:int = MAP_WIDTH + 3;
      
      protected static const MAPSIZE_Y:int = MAP_HEIGHT + 3;
      
      protected static const MAPSIZE_Z:int = 8;
      
      protected static const DRAG_TYPE_OBJECT:String = "object";
      
      protected static const MAP_MAX_X:int = MAP_MIN_X + (1 << 14 - 1);
      
      protected static const MAP_MAX_Y:int = MAP_MIN_Y + (1 << 14 - 1);
      
      protected static const MAP_MAX_Z:int = 15;
      
      protected static const DRAG_OPACITY:Number = 0.75;
      
      protected static const ACTION_AUTOWALK:int = 3;
      
      protected static const MAP_WIDTH:int = 15;
      
      protected static const ACTION_USE:int = 6;
      
      protected static const NUM_ONSCREEN_MESSAGES:int = 16;
      
      protected static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
      
      protected static const ACTION_ATTACK:int = 1;
      
      private static const WIDGET_MIN_HEIGHT:int = 250;
      
      protected static const GROUND_LAYER:int = 7;
      
      protected static const ACTION_CONTEXT_MENU:int = 4;
       
      private var m_DragHandler:ObjectDragImpl;
      
      private var m_Player:Player = null;
      
      private var m_InfoTimestamp:Number = -Infinity;
      
      private var m_UIBackdrop:FlexShape = null;
      
      private var m_Options:OptionsStorage = null;
      
      private var m_UIConstructed:Boolean = false;
      
      private var m_UIInfoFramerate:Label = null;
      
      private var m_WorldMapStorage:tibia.worldmap.WorldMapStorage = null;
      
      private var m_UIRendererImpl:RendererImpl = null;
      
      private var m_CreatureStorage:CreatureStorage = null;
      
      private var m_UncommittedOptions:Boolean = false;
      
      private var m_UncommittedPlayer:Boolean = false;
      
      private var m_UncommittedWorldMapStorage:Boolean = false;
      
      private var m_UIInfoLatency:UIBitmap = null;
      
      private var m_UncommittedCreatureStorage:Boolean = false;
      
      public function WorldMapWidget()
      {
         super();
         minHeight = WIDGET_MIN_HEIGHT;
         minWidth = WIDGET_MIN_WIDTH;
         addEventListener(ResizeEvent.RESIZE,this.onResize);
         this.m_DragHandler = new ObjectDragImpl();
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIBackdrop = new FlexShape();
            this.m_UIBackdrop.name = "backdrop";
            rawChildren.addChild(this.m_UIBackdrop);
            this.m_UIRendererImpl = new RendererImpl();
            this.m_UIRendererImpl.name = "renderer";
            this.m_UIRendererImpl.addEventListener(MouseEvent.CLICK,this.onMouseClick);
            this.m_UIRendererImpl.addEventListener(MouseEvent.RIGHT_CLICK,this.onMouseClick);
            this.m_DragHandler.addDragComponent(this.m_UIRendererImpl);
            addChild(this.m_UIRendererImpl);
            this.m_UIInfoLatency = new UIBitmap();
            this.m_UIInfoLatency.name = "latency";
            addChild(this.m_UIInfoLatency);
            this.m_UIInfoFramerate = new Label();
            this.m_UIInfoFramerate.name = "framerate";
            this.m_UIInfoFramerate.text = null;
            this.m_UIInfoFramerate.setStyle("color",65280);
            this.m_UIInfoFramerate.setStyle("fontSize",12);
            this.m_UIInfoFramerate.setStyle("fontWeight","bold");
            addChild(this.m_UIInfoFramerate);
            this.m_UIConstructed = true;
         }
      }
      
      public function get options() : OptionsStorage
      {
         return this.m_Options;
      }
      
      protected function onMouseClick(param1:MouseEvent) : void
      {
         var _loc4_:Creature = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:Vector3D = null;
         var _loc8_:int = 0;
         var _loc2_:Connection = null;
         var _loc3_:Vector3D = null;
         if(param1 != null && this.m_WorldMapStorage != null && this.m_Player != null && (_loc2_ = Tibia.s_GetConnection()) != null && Boolean(_loc2_.isGameRunning) && this.m_UIRendererImpl != null && (_loc3_ = this.m_UIRendererImpl.pointToMap(param1.localX,param1.localY,false)) != null)
         {
            _loc4_ = this.m_UIRendererImpl.pointToCreature(param1.localX,param1.localY,false);
            _loc5_ = new Object();
            _loc6_ = new Object();
            this.m_WorldMapStorage.getTopLookObject(_loc3_.x,_loc3_.y,_loc3_.z,_loc5_);
            this.m_WorldMapStorage.getTopUseObject(_loc3_.x,_loc3_.y,_loc3_.z,_loc6_);
            _loc7_ = this.m_WorldMapStorage.toAbsolute(_loc3_);
            _loc8_ = ACTION_UNSET;
            if(param1.type == MouseEvent.CLICK && !param1.shiftKey && !param1.ctrlKey && !param1.altKey)
            {
               _loc8_ = ACTION_AUTOWALK;
            }
            else if(this.m_Options != null && Boolean(this.m_Options.generalInputClassicControls))
            {
               if(param1.altKey)
               {
                  _loc8_ = ACTION_ATTACK_FALLTHROUGH;
               }
               else if(param1.ctrlKey)
               {
                  _loc8_ = ACTION_CONTEXT_MENU;
               }
               else if(param1.shiftKey)
               {
                  _loc8_ = ACTION_LOOK;
               }
               else
               {
                  _loc8_ = ACTION_ATTACK_FALLTHROUGH;
               }
            }
            else if(param1.altKey)
            {
               _loc8_ = ACTION_ATTACK;
            }
            else if(param1.ctrlKey)
            {
               _loc8_ = ACTION_USE;
            }
            else if(param1.shiftKey)
            {
               _loc8_ = ACTION_LOOK;
            }
            else
            {
               _loc8_ = ACTION_CONTEXT_MENU;
            }
            switch(_loc8_)
            {
               case ACTION_NONE:
                  break;
               case ACTION_AUTOWALK:
                  _loc7_ = this.m_UIRendererImpl.pointToAbsolute(param1.localX,param1.localY,true,_loc7_);
                  this.m_Player.startAutowalk(_loc7_.x,_loc7_.y,_loc7_.z,false,true);
                  break;
               case ACTION_ATTACK:
               case ACTION_ATTACK_FALLTHROUGH:
                  if(_loc4_ != null && _loc4_ != this.m_Player)
                  {
                     this.m_CreatureStorage.toggleAttackTarget(_loc4_,true);
                     break;
                  }
                  if(_loc8_ != ACTION_ATTACK_FALLTHROUGH)
                  {
                     break;
                  }
               case ACTION_USE:
                  if(_loc6_.object != null)
                  {
                     new UseActionImpl(_loc7_,_loc6_.object,_loc6_.position,UseActionImpl.TARGET_AUTO).perform();
                  }
                  break;
               case ACTION_LOOK:
                  if(_loc5_.object != null)
                  {
                     new LookActionImpl(_loc7_,_loc5_.object,_loc5_.position).perform();
                  }
                  break;
               case ACTION_CONTEXT_MENU:
                  new ObjectContextMenu(_loc7_,_loc5_,_loc6_,_loc4_).display(this,param1.stageX,param1.stageY);
                  break;
               case ACTION_UNSET:
               default:
                  log("WorldMapWidget.onMouseClick: Unhandled event: " + param1 + ", action: " + _loc8_);
            }
         }
      }
      
      public function getMoveObjectUnderPoint(param1:Point) : Object
      {
         var _loc2_:Point = null;
         var _loc3_:Vector3D = null;
         var _loc4_:Object = null;
         if(this.m_UIRendererImpl != null && this.m_WorldMapStorage != null)
         {
            _loc2_ = this.m_UIRendererImpl.globalToLocal(param1);
            _loc3_ = this.m_UIRendererImpl.pointToMap(_loc2_.x,_loc2_.y,false);
            if(_loc3_ != null)
            {
               _loc4_ = {"absolute":this.m_WorldMapStorage.toAbsolute(_loc3_)};
               this.m_WorldMapStorage.getTopMoveObject(_loc3_.x,_loc3_.y,_loc3_.z,_loc4_);
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getUseObjectUnderPoint(param1:Point) : Object
      {
         var _loc2_:Point = null;
         var _loc3_:Vector3D = null;
         var _loc4_:Object = null;
         if(this.m_UIRendererImpl != null && this.m_WorldMapStorage != null)
         {
            _loc2_ = this.m_UIRendererImpl.globalToLocal(param1);
            _loc3_ = this.m_UIRendererImpl.pointToMap(_loc2_.x,_loc2_.y,false);
            if(_loc3_ != null)
            {
               _loc4_ = {"absolute":this.m_WorldMapStorage.toAbsolute(_loc3_)};
               this.m_WorldMapStorage.getTopUseObject(_loc3_.x,_loc3_.y,_loc3_.z,_loc4_);
               return _loc4_;
            }
         }
         return null;
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Connection = null;
         if(this.m_UIRendererImpl != null && Tibia.s_FrameTimestamp > this.m_InfoTimestamp + 500)
         {
            this.m_InfoTimestamp = Tibia.s_FrameTimestamp;
            _loc2_ = Tibia.s_GetConnection();
            if(_loc2_ != null && Boolean(_loc2_.isGameRunning))
            {
               if(_loc2_.latency < Connection.LATENCY_LOW)
               {
                  this.m_UIInfoLatency.bitmap = LATENCY_ICON_LOW;
                  this.m_UIInfoLatency.toolTip = resourceManager.getString(BUNDLE,"LATENCY_TOOTLIP_LOW");
               }
               else if(_loc2_.latency < Connection.LATENCY_MEDIUM)
               {
                  this.m_UIInfoLatency.bitmap = LATENCY_ICON_MEDIUM;
                  this.m_UIInfoLatency.toolTip = resourceManager.getString(BUNDLE,"LATENCY_TOOTLIP_MEDIUM");
               }
               else
               {
                  this.m_UIInfoLatency.bitmap = LATENCY_ICON_HIGH;
                  this.m_UIInfoLatency.toolTip = resourceManager.getString(BUNDLE,"LATENCY_TOOTLIP_HIGH");
               }
            }
            else
            {
               this.m_UIInfoLatency.bitmap = LATENCY_ICON_HIGH;
               this.m_UIInfoLatency.toolTip = resourceManager.getString(BUNDLE,"LATENCY_TOOTLIP_NO_CONNECTION");
            }
            this.m_UIInfoFramerate.text = this.m_UIRendererImpl.fps + " FPS";
         }
      }
      
      public function get worldMapStorage() : tibia.worldmap.WorldMapStorage
      {
         return this.m_WorldMapStorage;
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
            if(this.m_Options != null)
            {
               this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onOptionsChange);
            }
            this.m_UncommittedOptions = true;
            invalidateDisplayList();
            invalidateProperties();
            this.updateEnterFrameListener();
         }
      }
      
      public function set player(param1:Player) : void
      {
         if(this.m_Player != param1)
         {
            this.m_Player = param1;
            this.m_UncommittedPlayer = true;
            invalidateDisplayList();
            invalidateProperties();
         }
      }
      
      public function get creatureStorage() : CreatureStorage
      {
         return this.m_CreatureStorage;
      }
      
      public function reset() : void
      {
         if(this.m_UIRendererImpl != null)
         {
            this.m_UIRendererImpl.reset();
         }
      }
      
      public function pointToAbsolute(param1:Point) : Vector3D
      {
         var _loc2_:Point = null;
         if(this.m_UIRendererImpl != null)
         {
            _loc2_ = this.m_UIRendererImpl.globalToLocal(param1);
            return this.m_UIRendererImpl.pointToAbsolute(_loc2_.x,_loc2_.y,false);
         }
         return null;
      }
      
      public function pointToMap(param1:Point) : Vector3D
      {
         var _loc2_:Point = null;
         if(this.m_UIRendererImpl != null)
         {
            _loc2_ = this.m_UIRendererImpl.globalToLocal(param1);
            return this.m_UIRendererImpl.pointToMap(_loc2_.x,_loc2_.y,false);
         }
         return null;
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedCreatureStorage)
         {
            this.m_UIRendererImpl.creatureStorage = this.m_CreatureStorage;
            this.m_UncommittedCreatureStorage = false;
         }
         if(this.m_UncommittedOptions)
         {
            this.m_UIRendererImpl.options = this.m_Options;
            this.m_UncommittedOptions = false;
         }
         if(this.m_UncommittedPlayer)
         {
            this.m_UIRendererImpl.player = this.m_Player;
            this.m_UncommittedPlayer = false;
         }
         if(this.m_UncommittedWorldMapStorage)
         {
            this.m_UIRendererImpl.worldMapStorage = this.m_WorldMapStorage;
            this.m_UncommittedWorldMapStorage = false;
         }
      }
      
      public function calculateOptimalSize(param1:Number, param2:Number) : Rectangle
      {
         var _loc3_:Number = NaN;
         if(MAP_WIDTH > MAP_HEIGHT)
         {
            return new Rectangle(0,0,param1,Math.round(param1 * MAP_HEIGHT / MAP_WIDTH));
         }
         if(MAP_HEIGHT < MAP_WIDTH)
         {
            return new Rectangle(0,0,Math.round(param2 * MAP_WIDTH / MAP_HEIGHT),param2);
         }
         _loc3_ = Math.min(param1,param2);
         return new Rectangle(0,0,_loc3_,_loc3_);
      }
      
      protected function onOptionsChange(param1:PropertyChangeEvent) : void
      {
         if(param1 != null)
         {
            invalidateDisplayList();
            switch(param1.property)
            {
               case "rendererShowFrameRate":
               case "*":
                  this.updateEnterFrameListener();
            }
         }
      }
      
      public function get player() : Player
      {
         return this.m_Player;
      }
      
      public function set worldMapStorage(param1:tibia.worldmap.WorldMapStorage) : void
      {
         if(this.m_WorldMapStorage != param1)
         {
            this.m_WorldMapStorage = param1;
            this.m_UncommittedWorldMapStorage = true;
            invalidateDisplayList();
            invalidateProperties();
         }
      }
      
      override protected function measure() : void
      {
         super.measure();
         measuredMinHeight = WIDGET_MIN_HEIGHT;
         measuredMinWidth = WIDGET_MIN_WIDTH;
         measuredHeight = this.m_UIRendererImpl != null?Number(this.m_UIRendererImpl.getExplicitOrMeasuredHeight() + 2):Number(0);
         measuredWidth = this.m_UIRendererImpl != null?Number(this.m_UIRendererImpl.getExplicitOrMeasuredWidth() + 2):Number(0);
      }
      
      public function getMultiUseObjectUnderPoint(param1:Point) : Object
      {
         var _loc2_:Point = null;
         var _loc3_:Vector3D = null;
         var _loc4_:Object = null;
         if(this.m_UIRendererImpl != null && this.m_WorldMapStorage != null)
         {
            _loc2_ = this.m_UIRendererImpl.globalToLocal(param1);
            _loc3_ = this.m_UIRendererImpl.pointToMap(_loc2_.x,_loc2_.y,false);
            if(_loc3_ != null)
            {
               _loc4_ = {"absolute":this.m_WorldMapStorage.toAbsolute(_loc3_)};
               this.m_WorldMapStorage.getTopMultiUseObject(_loc3_.x,_loc3_.y,_loc3_.z,_loc4_);
               return _loc4_;
            }
         }
         return null;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var Height:Number = NaN;
         var RowHeight:Number = NaN;
         var a_UnscaledWidth:Number = param1;
         var a_UnscaledHeight:Number = param2;
         super.updateDisplayList(a_UnscaledWidth,a_UnscaledHeight);
         var AvailHeight:Number = Math.max(0,a_UnscaledHeight - 2);
         Height = MAP_HEIGHT * FIELD_SIZE;
         var AvailWidth:Number = Math.max(0,a_UnscaledWidth - 2);
         var Width:Number = MAP_WIDTH * FIELD_SIZE;
         var Left:Number = 0;
         var Top:Number = 0;
         var Scale:Number = 1;
         if(this.m_Options != null && Boolean(this.m_Options.rendererScaleMap) || AvailHeight < Height || AvailWidth < Width)
         {
            Scale = Math.min(AvailHeight / Height,AvailWidth / Width);
            Height = Math.floor(Height * Scale);
            Width = Math.floor(Width * Scale);
         }
         Left = Math.floor((a_UnscaledWidth - Width) / 2);
         Top = Math.floor((a_UnscaledHeight - Height) / 2);
         this.m_UIBackdrop.x = Left - 1;
         this.m_UIBackdrop.y = Top - 1;
         with(this.m_UIBackdrop.graphics)
         {
            
            clear();
            lineStyle(1,0,1);
            drawRect(0,0,Width + 1,Height + 1);
            endFill();
         }
         this.m_UIRendererImpl.move(Left,Top);
         this.m_UIRendererImpl.setActualSize(Width,Height);
         if(this.m_Options != null && Boolean(this.m_Options.rendererShowFrameRate))
         {
            Width = this.m_UIInfoLatency.getExplicitOrMeasuredWidth();
            Height = this.m_UIInfoLatency.getExplicitOrMeasuredHeight();
            RowHeight = Math.max(Height,this.m_UIInfoFramerate.getExplicitOrMeasuredHeight());
            Left = 5;
            Top = a_UnscaledHeight - RowHeight - 5;
            this.m_UIInfoLatency.visible = true;
            this.m_UIInfoLatency.move(Left,Top + (RowHeight - Height) / 2);
            this.m_UIInfoLatency.setActualSize(Width,Height);
            Left = Left + Width;
            Width = this.m_UIInfoFramerate.getExplicitOrMeasuredWidth();
            Height = this.m_UIInfoFramerate.getExplicitOrMeasuredHeight();
            this.m_UIInfoFramerate.visible = true;
            this.m_UIInfoFramerate.move(Left,Top + (RowHeight - Height) / 2);
            this.m_UIInfoFramerate.setActualSize(Width,Height);
         }
         else
         {
            this.m_UIInfoLatency.visible = false;
            this.m_UIInfoFramerate.visible = false;
         }
      }
      
      public function set creatureStorage(param1:CreatureStorage) : void
      {
         if(this.m_CreatureStorage != param1)
         {
            this.m_CreatureStorage = param1;
            this.m_UncommittedCreatureStorage = true;
            invalidateDisplayList();
            invalidateProperties();
         }
      }
      
      private function updateEnterFrameListener() : void
      {
         if(this.m_Options != null && Boolean(this.m_Options.rendererShowFrameRate))
         {
            if(!hasEventListener(Event.ENTER_FRAME))
            {
               addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            }
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      protected function onResize(param1:ResizeEvent) : void
      {
         if(this.m_WorldMapStorage != null)
         {
            this.m_WorldMapStorage.invalidateOnscreenMessages();
         }
      }
   }
}

import mx.core.UIComponent;
import flash.display.Bitmap;

class UIBitmap extends UIComponent
{
    
   private var m_Bitmap:Bitmap;
   
   function UIBitmap()
   {
      super();
   }
   
   public function set bitmap(param1:Bitmap) : void
   {
      if(this.m_Bitmap != param1)
      {
         this.m_Bitmap = param1;
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         if(this.m_Bitmap != null)
         {
            addChild(this.m_Bitmap);
         }
         invalidateSize();
         invalidateDisplayList();
      }
   }
   
   override protected function updateDisplayList(param1:Number, param2:Number) : void
   {
      super.updateDisplayList(param1,param2);
      if(this.m_Bitmap != null)
      {
         this.m_Bitmap.x = (param1 - this.m_Bitmap.width) / 2;
         this.m_Bitmap.y = (param2 - this.m_Bitmap.height) / 2;
      }
   }
   
   override protected function measure() : void
   {
      super.measure();
      if(this.m_Bitmap != null)
      {
         measuredMinWidth = measuredWidth = this.m_Bitmap.width;
         measuredMinHeight = measuredHeight = this.m_Bitmap.height;
      }
      else
      {
         measuredMinWidth = measuredWidth = 0;
         measuredMinHeight = measuredHeight = 0;
      }
   }
   
   public function get bitmap() : Bitmap
   {
      return this.m_Bitmap;
   }
}
