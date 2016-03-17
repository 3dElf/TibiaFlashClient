package tibia.creatures
{
   import tibia.sidebar.Widget;
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   import tibia.creatures.buddylistWidgetClasses.BuddylistWidgetView;
   import mx.events.PropertyChangeEvent;
   
   public class BuddylistWidget extends Widget
   {
       
      protected var m_BuddySet:tibia.creatures.BuddySet = null;
      
      public function BuddylistWidget()
      {
         super();
      }
      
      override public function acquireViewInstance(param1:Boolean = true) : WidgetView
      {
         options = Tibia.s_GetOptions();
         var _loc2_:BuddylistWidgetView = super.acquireViewInstance(param1) as BuddylistWidgetView;
         if(_loc2_ != null)
         {
            _loc2_.buddySet = this.buddySet;
         }
         return _loc2_;
      }
      
      override public function releaseViewInstance() : void
      {
         options = null;
         super.releaseViewInstance();
      }
      
      private function updateBuddySet() : void
      {
         if(m_Options != null)
         {
            this.buddySet = m_Options.getBuddySet(tibia.creatures.BuddySet.DEFAULT_SET);
         }
      }
      
      override protected function commitOptions() : void
      {
         super.commitOptions();
         this.updateBuddySet();
      }
      
      public function set buddySet(param1:tibia.creatures.BuddySet) : void
      {
         if(this.m_BuddySet != param1)
         {
            this.m_BuddySet = param1;
            if(m_ViewInstance is BuddylistWidgetView)
            {
               BuddylistWidgetView(m_ViewInstance).buddySet = this.m_BuddySet;
            }
         }
      }
      
      public function get buddySet() : tibia.creatures.BuddySet
      {
         return this.m_BuddySet;
      }
      
      override protected function onOptionsChange(param1:PropertyChangeEvent) : void
      {
         super.onOptionsChange(param1);
         if(param1 != null)
         {
            switch(param1.property)
            {
               case "buddySet":
               case "*":
                  this.updateBuddySet();
            }
         }
      }
   }
}
