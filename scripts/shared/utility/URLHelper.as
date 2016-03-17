package shared.utility
{
   import flash.utils.getTimer;
   
   public class URLHelper
   {
       
      public function URLHelper()
      {
         super();
      }
      
      public static function s_NoCache(param1:String) : String
      {
         var _loc2_:String = getTimer().toString(16);
         if(param1.indexOf("?") > 0)
         {
            return param1 + "&__nocache=" + _loc2_;
         }
         return param1 + "?" + _loc2_;
      }
      
      public static function s_GetBasename(param1:String) : String
      {
         var _loc2_:String = param1;
         if(_loc2_.charAt(_loc2_.length - 1) == "/")
         {
            _loc2_ = _loc2_.substr(0,_loc2_.length - 1);
         }
         var _loc3_:int = _loc2_.lastIndexOf("/");
         if(_loc3_ < 0)
         {
            throw new ArgumentError("URLHelpher.s_GetBaseName: No path delimiter found.");
         }
         return _loc2_.substr(_loc3_ + 1);
      }
      
      public static function s_GetPath(param1:String) : String
      {
         var _loc2_:int = param1.lastIndexOf("/");
         if(_loc2_ < 0)
         {
            throw new ArgumentError("URLHelpher.s_GetPath: No path delimiter found.");
         }
         return param1.substr(0,_loc2_);
      }
   }
}
