package tibia.container.containerWidgetClasses
{
   import mx.core.IFlexDisplayObject;
   import mx.styles.ISimpleStyleClient;
   import mx.core.IUIComponent;
   import tibia.appearances.AppearanceInstance;
   
   public interface IContainerSlot extends IFlexDisplayObject, ISimpleStyleClient, IUIComponent
   {
       
      function set appearance(param1:AppearanceInstance) : void;
      
      function get position() : int;
      
      function set position(param1:int) : void;
      
      function get appearance() : AppearanceInstance;
   }
}
