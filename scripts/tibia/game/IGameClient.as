package tibia.game
{
   import flash.events.IEventDispatcher;
   
   public interface IGameClient extends IEventDispatcher
   {
       
      function setCharacters(param1:String, param2:Array, param3:int) : void;
      
      function get isRunning() : Boolean;
      
      function unload() : void;
      
      function setContent(param1:Vector.<Asset>) : void;
   }
}
