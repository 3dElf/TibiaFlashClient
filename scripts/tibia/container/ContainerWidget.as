package tibia.container
{
   import tibia.sidebar.Widget;
   import tibia.container.containerWidgetClasses.ContainerWidgetViewBase;
   import tibia.creatures.Player;
   import tibia.container.containerWidgetClasses.BodyWidgetView;
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   
   public class ContainerWidget extends Widget
   {
       
      protected var m_Container:tibia.container.Container = null;
      
      protected var m_Player:Player = null;
      
      public function ContainerWidget()
      {
         super();
      }
      
      public function get container() : tibia.container.Container
      {
         return this.m_Container;
      }
      
      public function set container(param1:tibia.container.Container) : void
      {
         if(this.m_Container != param1)
         {
            this.m_Container = param1;
            if(m_ViewInstance is ContainerWidgetViewBase)
            {
               ContainerWidgetViewBase(m_ViewInstance).container = this.m_Container;
            }
         }
      }
      
      public function get player() : Player
      {
         return this.m_Player;
      }
      
      public function set player(param1:Player) : void
      {
         if(this.m_Player != param1)
         {
            this.m_Player = param1;
            if(m_ViewInstance is BodyWidgetView)
            {
               BodyWidgetView(m_ViewInstance).player = this.m_Player;
            }
         }
      }
      
      override public function acquireViewInstance(param1:Boolean = true) : WidgetView
      {
         if(type == Widget.TYPE_BODY)
         {
            this.container = Tibia.s_GetContainerStorage().getBodyContainer();
            this.player = Tibia.s_GetPlayer();
         }
         var _loc2_:WidgetView = super.acquireViewInstance(param1);
         if(_loc2_ is ContainerWidgetViewBase)
         {
            ContainerWidgetViewBase(_loc2_).container = this.m_Container;
         }
         if(_loc2_ is BodyWidgetView)
         {
            BodyWidgetView(_loc2_).player = this.m_Player;
         }
         return _loc2_;
      }
      
      override public function close(param1:Boolean = false) : void
      {
         var _loc2_:ContainerStorage = null;
         if(Boolean(param1) || Boolean(closable) && !closed)
         {
            _loc2_ = null;
            if(type == Widget.TYPE_CONTAINER && this.m_Container != null && (_loc2_ = Tibia.s_GetContainerStorage()) != null)
            {
               m_Closed = true;
               if(m_ViewInstance != null)
               {
                  m_ViewInstance.widgetClosed = m_Closed;
               }
               _loc2_.sendCloseContainer(this.m_Container);
            }
            else
            {
               super.close(param1);
            }
         }
      }
      
      override public function releaseViewInstance() : void
      {
         this.container = null;
         this.player = null;
         super.releaseViewInstance();
      }
   }
}
