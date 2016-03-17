package tibia.game
{
   public class AccountCharacter
   {
       
      private var m_World:String = null;
      
      private var m_Address:String = null;
      
      private var m_Port:int = 0;
      
      private var m_Name:String = null;
      
      public function AccountCharacter(param1:String, param2:String, param3:String, param4:int)
      {
         super();
         this.m_Name = param1;
         this.m_World = param2;
         this.m_Address = param3;
         this.m_Port = param4;
      }
      
      public function get port() : int
      {
         return this.m_Port;
      }
      
      public function get name() : String
      {
         return this.m_Name;
      }
      
      public function get world() : String
      {
         return this.m_World;
      }
      
      public function get address() : String
      {
         return this.m_Address;
      }
   }
}
