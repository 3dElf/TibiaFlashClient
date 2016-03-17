package tibia.input.staticaction
{
   import tibia.container.ContainerStorage;
   import tibia.container.Container;
   import tibia.appearances.AppearanceInstance;
   import tibia.input.gameaction.UseActionImpl;
   import shared.utility.Vector3D;
   
   public class OpenRootContainer extends StaticAction
   {
       
      public function OpenRootContainer(param1:int, param2:String, param3:uint)
      {
         super(param1,param2,param3,false);
      }
      
      override public function perform(param1:Boolean = false) : void
      {
         var _loc2_:ContainerStorage = Tibia.s_GetContainerStorage();
         var _loc3_:Container = null;
         var _loc4_:AppearanceInstance = null;
         if(_loc2_ != null && (_loc3_ = _loc2_.getBodyContainer()) != null && (_loc4_ = _loc3_.getItemAt(ContainerStorage.BODY_BACK - ContainerStorage.BODY_HEAD)) != null && _loc4_.type != null && Boolean(_loc4_.type.isContainer))
         {
            new UseActionImpl(new Vector3D(65535,ContainerStorage.BODY_BACK,0),_loc4_,ContainerStorage.BODY_BACK,UseActionImpl.TARGET_NEW_WINDOW).perform();
         }
      }
   }
}
