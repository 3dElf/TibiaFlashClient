package tibia.container.containerViewWidgetClasses
{
   import flash.events.MouseEvent;
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   import shared.utility.Vector3D;
   import tibia.appearances.AppearanceInstance;
   import tibia.options.OptionsStorage;
   import tibia.input.gameaction.UseActionImpl;
   import tibia.input.gameaction.LookActionImpl;
   import tibia.game.ObjectContextMenu;
   
   public function containerSlotMouseEventHandler(param1:MouseEvent, param2:WidgetView, param3:Vector3D, param4:AppearanceInstance) : void
   {
      var _loc9_:OptionsStorage = null;
      var _loc10_:int = 0;
      var _loc11_:Object = null;
      var _loc5_:int = 0;
      var _loc6_:int = 1;
      var _loc7_:int = 2;
      var _loc8_:int = 3;
      if(param1 != null && (param1.type != MouseEvent.CLICK || Boolean(param1.shiftKey) || Boolean(param1.ctrlKey) || Boolean(param1.altKey)) && param2 != null && param3 != null && param4 != null)
      {
         _loc9_ = Tibia.s_GetOptions();
         _loc10_ = _loc5_;
         if(_loc9_ != null && Boolean(_loc9_.generalInputClassicControls))
         {
            if(param1.altKey)
            {
               _loc10_ = _loc8_;
            }
            else if(param1.ctrlKey)
            {
               _loc10_ = _loc6_;
            }
            else if(param1.shiftKey)
            {
               _loc10_ = _loc7_;
            }
            else
            {
               _loc10_ = _loc8_;
            }
         }
         else if(param1.altKey)
         {
            _loc10_ = _loc6_;
         }
         else if(param1.ctrlKey)
         {
            _loc10_ = _loc8_;
         }
         else if(param1.shiftKey)
         {
            _loc10_ = _loc7_;
         }
         else
         {
            _loc10_ = _loc6_;
         }
         switch(_loc10_)
         {
            case _loc8_:
               new UseActionImpl(param3,param4,param3.z,UseActionImpl.TARGET_AUTO).perform();
               break;
            case _loc7_:
               new LookActionImpl(param3,param4,param3.z).perform();
               break;
            case _loc6_:
               _loc11_ = {
                  "position":param3.z,
                  "object":param4
               };
               new ObjectContextMenu(param3,_loc11_,_loc11_,null).display(param2,param1.stageX,param1.stageY);
               break;
            case _loc5_:
         }
      }
   }
}
