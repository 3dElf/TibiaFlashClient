package tibia.game
{
   import flash.events.IEventDispatcher;
   import tibia.network.IConnectionData;
   
   public interface IGameClient extends IEventDispatcher
   {
       
      function get isActive() : Boolean;
      
      function saveOptions() : void;
      
      function get isRunning() : Boolean;
      
      function unload() : void;
      
      function set isActive(param1:Boolean) : void;
      
      function saveLocalData() : void;
      
      function setOptions(param1:OptionsAsset, param2:OptionsAsset) : void;
      
      function setClientSize(param1:uint, param2:uint) : void;
      
      function setContent(param1:Vector.<Asset>) : void;
      
      function setConnectionDataList(param1:Vector.<IConnectionData>, param2:uint) : void;
   }
}
