package tibia.game
{
   import flash.events.IEventDispatcher;
   
   public interface IGameClient extends IEventDispatcher
   {
       
      function saveOptions() : void;
      
      function setCharacters(param1:String, param2:Array, param3:int) : void;
      
      function get isRunning() : Boolean;
      
      function setContent(param1:Vector.<Asset>) : void;
      
      function saveLocalData() : void;
      
      function setOptions(param1:OptionsAsset, param2:OptionsAsset) : void;
      
      function unload() : void;
   }
}
