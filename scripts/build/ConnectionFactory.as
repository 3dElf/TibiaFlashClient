package build
{
   import tibia.network.IServerConnection;
   import tibia.network.Connection;
   
   public class ConnectionFactory
   {
       
      public function ConnectionFactory()
      {
         super();
         throw new Error("ConnectionFactory must not be instantiated");
      }
      
      public static function s_CreateServerConnection() : IServerConnection
      {
         var _loc1_:IServerConnection = null;
         _loc1_ = new Connection();
         return _loc1_;
      }
   }
}
