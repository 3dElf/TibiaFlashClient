package tibia.creatures.battlelistWidgetClasses
{
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   import tibia.game.IUseWidget;
   import tibia.creatures.CreatureStorage;
   import mx.controls.Button;
   import flash.events.MouseEvent;
   import mx.events.ListEvent;
   import mx.collections.IList;
   import mx.events.PropertyChangeEvent;
   import tibia.§sidebar:ns_sidebar_internal§.widgetCollapsed;
   import flash.geom.Point;
   import shared.controls.SmoothList;
   import mx.containers.HBox;
   import shared.controls.CustomButton;
   import mx.controls.listClasses.IListItemRenderer;
   import tibia.creatures.Creature;
   import tibia.network.Communication;
   import tibia.appearances.AppearanceStorage;
   import tibia.appearances.ObjectInstance;
   import tibia.appearances.AppearanceInstance;
   import mx.core.ScrollPolicy;
   
   public class BattlelistWidgetView extends WidgetView implements IUseWidget
   {
      
      private static const ACTION_UNSET:int = -1;
      
      private static const ACTION_NONE:int = 0;
      
      private static const BUNDLE:String = "BattlelistWidget";
      
      private static const ACTION_LOOK:int = 2;
      
      private static const OPPONENT_FILTER_MODES:Array = [{
         "value":CreatureStorage.FILTER_PLAYER,
         "style":"hidePlayerButtonStyle",
         "tip":"TIP_HIDE_PLAYER"
      },{
         "value":CreatureStorage.FILTER_NPC,
         "style":"hideNPCButtonStyle",
         "tip":"TIP_HIDE_NPC"
      },{
         "value":CreatureStorage.FILTER_MONSTER,
         "style":"hideMonsterButtonStyle",
         "tip":"TIP_HIDE_MONSTER"
      },{
         "value":CreatureStorage.FILTER_NON_SKULLED,
         "style":"hideNonSkulledButtonStyle",
         "tip":"TIP_HIDE_NON_SKULLED"
      },{
         "value":CreatureStorage.FILTER_PARTY,
         "style":"hidePartyButtonStyle",
         "tip":"TIP_HIDE_PARTY"
      }];
      
      private static const ACTION_CONTEX_MENU:int = 3;
      
      private static const ACTION_ATTACK:int = 1;
       
      protected var m_Opponents:IList = null;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var m_InvalidFilter:Boolean = false;
      
      protected var m_UIFilterButtons:Vector.<Button>;
      
      protected var m_UIList:SmoothList = null;
      
      private var m_UncommittedOpponents:Boolean = false;
      
      private var m_UncommittedCreatureStorage:Boolean = false;
      
      private var m_UIConstructed:Boolean = false;
      
      public function BattlelistWidgetView()
      {
         this.m_UIFilterButtons = new Vector.<Button>();
         super();
         titleText = resourceManager.getString(BUNDLE,"TITLE");
         verticalScrollPolicy = ScrollPolicy.OFF;
         horizontalScrollPolicy = ScrollPolicy.OFF;
         maxHeight = int.MAX_VALUE;
         addEventListener(MouseEvent.CLICK,this.onItemClick);
         addEventListener(MouseEvent.RIGHT_CLICK,this.onItemClick);
      }
      
      public static function s_ClearCreatureCache(param1:String) : void
      {
         if(BattlelistItemRenderer.s_NameCache != null)
         {
            BattlelistItemRenderer.s_NameCache.removeItem(param1);
         }
      }
      
      override function releaseInstance() : void
      {
         var _loc1_:Button = null;
         super.releaseInstance();
         removeEventListener(MouseEvent.CLICK,this.onItemClick);
         removeEventListener(MouseEvent.RIGHT_CLICK,this.onItemClick);
         for each(_loc1_ in this.m_UIFilterButtons)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onFilterModeChange);
         }
         this.m_UIList.removeEventListener(ListEvent.ITEM_ROLL_OVER,this.onItemRollOver);
         this.m_UIList.removeEventListener(ListEvent.ITEM_ROLL_OUT,this.onItemRollOut);
      }
      
      protected function invalidateFilter() : void
      {
         this.m_InvalidFilter = true;
         invalidateProperties();
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:Button = null;
         super.commitProperties();
         if(this.m_UncommittedCreatureStorage)
         {
            this.m_UncommittedCreatureStorage = false;
         }
         if(this.m_UncommittedOpponents)
         {
            this.m_UIList.dataProvider = this.m_Opponents;
            this.m_UncommittedOpponents = false;
         }
         if(this.m_InvalidFilter)
         {
            for each(_loc1_ in this.m_UIFilterButtons)
            {
               _loc1_.selected = m_Options != null && (m_Options.opponentFilter & int(_loc1_.data)) > 0;
            }
            this.m_InvalidFilter = false;
         }
      }
      
      override protected function onOptionsChange(param1:PropertyChangeEvent) : void
      {
         super.onOptionsChange(param1);
         if(param1 != null)
         {
            switch(param1.property)
            {
               case "opponentFilter":
               case "*":
                  this.invalidateFilter();
            }
         }
      }
      
      protected function onItemRollOut(param1:ListEvent) : void
      {
         if(param1 != null && !widgetCollapsed && this.m_CreatureStorage != null)
         {
            this.m_CreatureStorage.setAim(null);
         }
      }
      
      public function getMultiUseObjectUnderPoint(param1:Point) : Object
      {
         return this.getUseObjectUnderPoint(param1);
      }
      
      override protected function commitOptions() : void
      {
         super.commitOptions();
         this.invalidateFilter();
      }
      
      override protected function createChildren() : void
      {
         var _loc1_:HBox = null;
         var _loc2_:int = 0;
         var _loc3_:Button = null;
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            _loc1_ = new HBox();
            _loc1_.height = 27;
            _loc1_.minHeight = 27;
            _loc1_.minWidth = NaN;
            _loc1_.percentHeight = NaN;
            _loc1_.percentWidth = 100;
            _loc1_.width = NaN;
            _loc1_.styleName = getStyle("headerBoxStyle");
            _loc2_ = 0;
            while(_loc2_ < OPPONENT_FILTER_MODES.length)
            {
               _loc3_ = new CustomButton();
               _loc3_.data = OPPONENT_FILTER_MODES[_loc2_].value;
               _loc3_.selected = m_Options != null && (m_Options.opponentFilter & OPPONENT_FILTER_MODES[_loc2_].value) > 0;
               _loc3_.styleName = getStyle(OPPONENT_FILTER_MODES[_loc2_].style);
               _loc3_.toggle = true;
               _loc3_.toolTip = resourceManager.getString(BUNDLE,OPPONENT_FILTER_MODES[_loc2_].tip);
               _loc3_.addEventListener(MouseEvent.CLICK,this.onFilterModeChange);
               this.m_UIFilterButtons.push(_loc3_);
               _loc1_.addChild(_loc3_);
               _loc2_++;
            }
            addChild(_loc1_);
            _loc1_ = new HBox();
            _loc1_.percentHeight = 100;
            _loc1_.percentWidth = 100;
            _loc1_.styleName = getStyle("listBoxStyle");
            this.m_UIList = new SmoothList(BattlelistItemRenderer,BattlelistItemRenderer.HEIGHT_HINT);
            this.m_UIList.name = "Battlelist";
            this.m_UIList.defaultItemCount = 3;
            this.m_UIList.followTailPolicy = SmoothList.FOLLOW_TAIL_OFF;
            this.m_UIList.minItemCount = 3;
            this.m_UIList.percentWidth = 100;
            this.m_UIList.percentHeight = 100;
            this.m_UIList.selectable = false;
            this.m_UIList.styleName = getStyle("listStyle");
            this.m_UIList.addEventListener(ListEvent.ITEM_ROLL_OVER,this.onItemRollOver);
            this.m_UIList.addEventListener(ListEvent.ITEM_ROLL_OUT,this.onItemRollOut);
            _loc1_.addChild(this.m_UIList);
            addChild(_loc1_);
            this.m_UIConstructed = true;
         }
      }
      
      protected function onFilterModeChange(param1:MouseEvent) : void
      {
         var _loc2_:Button = null;
         var _loc3_:int = 0;
         if(param1 != null && !widgetCollapsed && param1.currentTarget is Button && m_Options != null)
         {
            _loc2_ = Button(param1.currentTarget);
            _loc3_ = int(_loc2_.data);
            if(_loc2_.selected)
            {
               m_Options.opponentFilter = m_Options.opponentFilter | _loc3_;
            }
            else
            {
               m_Options.opponentFilter = m_Options.opponentFilter & ~_loc3_;
            }
         }
      }
      
      protected function onItemClick(param1:MouseEvent) : void
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:Creature = null;
         var _loc4_:int = 0;
         var _loc5_:Communication = null;
         if(param1 != null && !widgetCollapsed && this.m_CreatureStorage != null)
         {
            _loc2_ = this.m_UIList.mouseEventToItemRenderer(param1);
            _loc3_ = _loc2_ != null?Creature(_loc2_.data):null;
            _loc4_ = ACTION_UNSET;
            if(param1.type == MouseEvent.CLICK && !param1.altKey && !param1.ctrlKey && !param1.shiftKey)
            {
               _loc4_ = ACTION_ATTACK;
            }
            else if(param1.altKey)
            {
               _loc4_ = ACTION_ATTACK;
            }
            else if(param1.ctrlKey)
            {
               _loc4_ = ACTION_CONTEX_MENU;
            }
            else if(param1.shiftKey)
            {
               _loc4_ = ACTION_LOOK;
            }
            else
            {
               _loc4_ = ACTION_CONTEX_MENU;
            }
            switch(_loc4_)
            {
               case ACTION_NONE:
                  break;
               case ACTION_ATTACK:
                  if(_loc3_ != null)
                  {
                     this.m_CreatureStorage.toggleAttackTarget(_loc3_,true);
                  }
                  break;
               case ACTION_LOOK:
                  _loc5_ = null;
                  if(_loc3_ != null && (_loc5_ = Tibia.s_GetCommunication()) != null && Boolean(_loc5_.isGameRunning))
                  {
                     _loc5_.sendCLOOKATCREATURE(_loc3_.ID);
                  }
                  break;
               case ACTION_CONTEX_MENU:
                  new BattlelistItemContextMenu(m_Options,this.m_CreatureStorage,_loc3_).display(this,param1.stageX,param1.stageY);
            }
         }
      }
      
      public function getUseObjectUnderPoint(param1:Point) : Object
      {
         var _loc2_:IList = null;
         var _loc3_:int = 0;
         var _loc4_:AppearanceStorage = null;
         var _loc5_:Creature = null;
         var _loc6_:ObjectInstance = null;
         if(this.m_CreatureStorage != null)
         {
            _loc2_ = this.m_CreatureStorage.opponents;
            _loc3_ = this.m_UIList.pointToItemIndex(param1.x,param1.y);
            _loc4_ = Tibia.s_GetAppearanceStorage();
            if(_loc3_ > -1 && _loc3_ < _loc2_.length)
            {
               _loc5_ = Creature(_loc2_.getItemAt(_loc3_));
               _loc6_ = _loc4_.createObjectInstance(AppearanceInstance.CREATURE,_loc5_.ID);
               return {
                  "object":_loc6_,
                  "absolute":null,
                  "position":-1
               };
            }
         }
         return null;
      }
      
      protected function onItemRollOver(param1:ListEvent) : void
      {
         var _loc2_:BattlelistItemRenderer = null;
         if(param1 != null && !widgetCollapsed && this.m_CreatureStorage != null)
         {
            _loc2_ = BattlelistItemRenderer(param1.itemRenderer);
            this.m_CreatureStorage.setAim(Creature(_loc2_.data));
         }
      }
      
      function set creatureStorage(param1:CreatureStorage) : void
      {
         if(this.m_CreatureStorage != param1)
         {
            this.m_CreatureStorage = param1;
            this.m_UncommittedCreatureStorage = true;
            if(this.m_CreatureStorage != null)
            {
               this.m_Opponents = this.m_CreatureStorage.opponents;
            }
            else
            {
               this.m_Opponents = null;
            }
            this.m_UncommittedOpponents = true;
            invalidateProperties();
         }
      }
      
      function get creatureStorage() : CreatureStorage
      {
         return this.m_CreatureStorage;
      }
   }
}
