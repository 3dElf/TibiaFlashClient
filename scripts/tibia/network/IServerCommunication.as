package tibia.network
{
   public interface IServerCommunication
   {
       
      function readMessage(param1:IMessageReader) : void;
      
      function messageProcessingFinished() : void;
   }
}
