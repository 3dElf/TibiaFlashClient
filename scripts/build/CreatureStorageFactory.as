package build
{
   import tibia.creatures.CreatureStorage;
   
   public class CreatureStorageFactory
   {
       
      public function CreatureStorageFactory()
      {
         super();
         throw new Error("CreatureStorageFactory must not be instantiated");
      }
      
      public static function s_CreateCreatureStorage() : CreatureStorage
      {
         var _loc1_:CreatureStorage = null;
         _loc1_ = new CreatureStorage();
         return _loc1_;
      }
   }
}
