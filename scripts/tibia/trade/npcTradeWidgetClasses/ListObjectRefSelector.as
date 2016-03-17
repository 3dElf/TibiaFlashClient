package tibia.trade.npcTradeWidgetClasses
{
   import mx.controls.List;
   import mx.events.ListEvent;
   import flash.events.MouseEvent;
   import mx.collections.IList;
   import shared.controls.CustomList;
   import mx.core.ClassFactory;
   import mx.core.ScrollPolicy;
   import mx.core.EventPriority;
   
   public class ListObjectRefSelector extends ObjectRefSelectorBase
   {
      
      private static const BUNDLE:String = "NPCTradeWidget";
       
      protected var m_UIList:List = null;
      
      private var m_UncommittedSelectedIndex:Boolean = false;
      
      private var m_UncommittedDataProvider:Boolean = false;
      
      private var m_UIConstructed:Boolean = false;
      
      public function ListObjectRefSelector()
      {
         super();
      }
      
      override public function get layout() : int
      {
         return ObjectRefSelectorBase.LAYOUT_LIST;
      }
      
      protected function onListChange(param1:ListEvent) : void
      {
         if(param1 != null)
         {
            this.selectedIndex = param1.rowIndex;
         }
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         if(selectedIndex != param1)
         {
            super.selectedIndex = param1;
            this.m_UncommittedSelectedIndex = true;
            invalidateProperties();
         }
      }
      
      protected function onListMouseDown(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
         }
      }
      
      override public function set dataProvider(param1:IList) : void
      {
         if(dataProvider != param1)
         {
            super.dataProvider = param1;
            this.m_UncommittedDataProvider = true;
            invalidateProperties();
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         this.m_UIList.setActualSize(param1,param2);
         this.m_UIList.move(0,0);
         this.m_UIList.visible = true;
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedDataProvider)
         {
            this.m_UIList.dataProvider = dataProvider;
            this.m_UIList.verticalScrollPosition = 0;
            this.m_UncommittedDataProvider = false;
         }
         if(this.m_UncommittedSelectedIndex)
         {
            this.m_UIList.selectedIndex = selectedIndex;
            if(selectedIndex < 0)
            {
               this.m_UIList.verticalScrollPosition = 0;
            }
            this.m_UncommittedSelectedIndex = false;
         }
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIList = new CustomList();
            this.m_UIList.dataProvider = m_DataProvider;
            this.m_UIList.itemRenderer = new ClassFactory(ListObjectRefItemRenderer);
            this.m_UIList.percentHeight = 100;
            this.m_UIList.percentWidth = 100;
            this.m_UIList.styleName = this;
            this.m_UIList.verticalScrollPolicy = ScrollPolicy.ON;
            this.m_UIList.addEventListener(ListEvent.CHANGE,this.onListChange);
            this.m_UIList.addEventListener(MouseEvent.MOUSE_DOWN,this.onListMouseDown,false,EventPriority.DEFAULT + 1,false);
            addChild(this.m_UIList);
            this.m_UIConstructed = true;
         }
      }
      
      override protected function measure() : void
      {
         super.measure();
         measuredWidth = this.m_UIList.measuredWidth;
         measuredMinWidth = this.m_UIList.measuredMinWidth;
         measuredHeight = this.m_UIList.measuredHeight;
         measuredMinHeight = this.m_UIList.measuredMinHeight;
      }
   }
}
