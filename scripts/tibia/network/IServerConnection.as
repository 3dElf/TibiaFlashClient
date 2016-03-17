package tibia.network
{
   import flash.events.IEventDispatcher;
   
   public interface IServerConnection extends IEventDispatcher
   {
       
      function readCommunicationData() : void;
      
      function get isGameRunning() : Boolean;
      
      function connect(param1:IConnectionData) : void;
      
      function set communication(param1:Communication) : void;
      
      function get isPending() : Boolean;
      
      function setConnectionState(param1:uint, param2:Boolean = true) : void;
      
      function get connectionState() : uint;
      
      function get communication() : Communication;
      
      function get messageReader() : IMessageReader;
      
      function get messageWriter() : IMessageWriter;
      
      function disconnect() : void;
      
      function get latency() : uint;
      
      function get isConnected() : Boolean;
   }
}
