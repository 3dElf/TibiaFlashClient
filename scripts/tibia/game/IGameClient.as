package tibia.game
{
   import flash.events.IEventDispatcher;
   import loader.asset.IAssetProvider;
   import tibia.network.IConnectionData;
   
   public interface IGameClient extends IEventDispatcher
   {
       
      function get isActive() : Boolean;
      
      function saveOptions() : void;
      
      function get isRunning() : Boolean;
      
      function setAssetProvider(param1:IAssetProvider) : void;
      
      function get currentConnection() : Object;
      
      function saveLocalData() : void;
      
      function setConnectionDataList(param1:Vector.<IConnectionData>, param2:uint) : void;
      
      function setClientSize(param1:uint, param2:uint) : void;
      
      function unload() : void;
      
      function set isActive(param1:Boolean) : void;
   }
}
