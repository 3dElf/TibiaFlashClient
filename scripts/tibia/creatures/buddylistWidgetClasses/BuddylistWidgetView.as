package tibia.creatures.buddylistWidgetClasses
{
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   import tibia.creatures.BuddySet;
   import shared.controls.SmoothList;
   import flash.events.MouseEvent;
   import mx.controls.listClasses.IListItemRenderer;
   import tibia.creatures.buddylistClasses.Buddy;
   import tibia.input.gameaction.PrivateChatActionImpl;
   import mx.collections.IList;
   import mx.containers.HBox;
   import mx.core.ScrollPolicy;
   
   public class BuddylistWidgetView extends WidgetView
   {
      
      private static const ACTION_NONE:int = 1;
      
      private static const BUNDLE:String = "BuddylistWidget";
      
      private static const ACTION_UNDEF:int = 0;
      
      private static const ACTION_CONTEXT_MENU:int = 3;
      
      private static const ACTION_OPEN_MESSAGE_CHANNEL:int = 2;
       
      protected var m_UIList:SmoothList = null;
      
      private var m_UncommittedBuddySet:Boolean = false;
      
      protected var m_BuddySet:BuddySet = null;
      
      private var m_UIConstructed:Boolean = false;
      
      public function BuddylistWidgetView()
      {
         super();
         titleText = resourceManager.getString(BUNDLE,"TITLE");
         verticalScrollPolicy = ScrollPolicy.OFF;
         horizontalScrollPolicy = ScrollPolicy.OFF;
         maxHeight = int.MAX_VALUE;
         addEventListener(MouseEvent.CLICK,this.onBuddiesClick);
         addEventListener(MouseEvent.RIGHT_CLICK,this.onBuddiesClick);
         addEventListener(MouseEvent.DOUBLE_CLICK,this.onBuddiesClick);
      }
      
      function get buddySet() : BuddySet
      {
         return this.m_BuddySet;
      }
      
      protected function onBuddiesClick(param1:MouseEvent) : void
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:Buddy = null;
         var _loc4_:int = 0;
         if(this.m_BuddySet != null && param1 != null)
         {
            _loc2_ = this.m_UIList.mouseEventToItemRenderer(param1);
            _loc3_ = null;
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.data as Buddy;
            }
            _loc4_ = ACTION_UNDEF;
            if(param1.type == MouseEvent.DOUBLE_CLICK)
            {
               _loc4_ = ACTION_OPEN_MESSAGE_CHANNEL;
            }
            else if(param1.type == MouseEvent.RIGHT_CLICK)
            {
               _loc4_ = ACTION_CONTEXT_MENU;
            }
            else
            {
               _loc4_ = ACTION_NONE;
            }
            switch(_loc4_)
            {
               case ACTION_NONE:
                  break;
               case ACTION_OPEN_MESSAGE_CHANNEL:
                  if(_loc3_ != null)
                  {
                     new PrivateChatActionImpl(PrivateChatActionImpl.OPEN_MESSAGE_CHANNEL,_loc3_.name).perform();
                  }
                  break;
               case ACTION_CONTEXT_MENU:
                  new BuddylistItemContextMenu(this.m_BuddySet,_loc3_).display(this,stage.mouseX,stage.mouseY);
            }
         }
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedBuddySet)
         {
            this.m_UIList.dataProvider = this.m_BuddySet != null?this.m_BuddySet.buddies:null;
            this.m_UncommittedBuddySet = false;
         }
      }
      
      function set buddySet(param1:BuddySet) : void
      {
         if(this.m_BuddySet != param1)
         {
            this.m_BuddySet = param1;
            this.m_UncommittedBuddySet = true;
            invalidateProperties();
         }
      }
      
      override protected function createChildren() : void
      {
         var _loc1_:HBox = null;
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            _loc1_ = new HBox();
            _loc1_.percentHeight = 100;
            _loc1_.percentWidth = 100;
            _loc1_.styleName = getStyle("listBoxStyle");
            this.m_UIList = new SmoothList(BuddylistItemRenderer,BuddylistItemRenderer.HEIGHT_HINT);
            this.m_UIList.dataProvider = this.m_BuddySet != null?this.m_BuddySet.buddies:null;
            this.m_UIList.defaultItemCount = 3;
            this.m_UIList.doubleClickEnabled = true;
            this.m_UIList.followTailPolicy = SmoothList.FOLLOW_TAIL_OFF;
            this.m_UIList.minItemCount = 3;
            this.m_UIList.percentWidth = 100;
            this.m_UIList.percentHeight = 100;
            this.m_UIList.selectable = false;
            this.m_UIList.styleName = getStyle("listStyle");
            _loc1_.addChild(this.m_UIList);
            addChild(_loc1_);
            this.m_UIConstructed = true;
         }
      }
      
      override function releaseInstance() : void
      {
         super.releaseInstance();
         removeEventListener(MouseEvent.CLICK,this.onBuddiesClick);
         removeEventListener(MouseEvent.DOUBLE_CLICK,this.onBuddiesClick);
         removeEventListener(MouseEvent.RIGHT_CLICK,this.onBuddiesClick);
      }
   }
}
