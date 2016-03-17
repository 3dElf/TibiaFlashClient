package tibia.network
{
   public class ConnectionFactory
   {
       
      public function ConnectionFactory()
      {
         super();
      }
      
      public static function s_CreateServerConnection() : IServerConnection
      {
         return new Connection();
      }
   }
}
