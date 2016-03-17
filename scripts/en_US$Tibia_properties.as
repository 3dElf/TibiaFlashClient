package
{
   import mx.resources.ResourceBundle;
   
   public class en_US$Tibia_properties extends ResourceBundle
   {
       
      public function en_US$Tibia_properties()
      {
         super("en_US","Tibia");
      }
      
      override protected function getContent() : Object
      {
         var _loc1_:Object = {
            "DLG_ERROR_TITLE":"Error",
            "DLG_LOGINWAIT_TITLE":"Please wait",
            "DLG_CONNECTION_PENDING_TIMEOUT_SECONDS":"seconds",
            "DLG_DEAD_TITLE":"You are dead.",
            "TEXT_SECOND":"{0} second",
            "DLG_ERROR_TEXT_GENERAL":"{0}",
            "DLG_CLIENT_CHANGE_TEXT":"This character lives on a world that needs a different client. Do you want to switch the client?",
            "DLG_CONNECTION_LOST_TEXT":"{0}\n\nWaiting another {1} before closing.",
            "DLG_CONNECTION_LOST_MESSAGE":"Game Server not responding.",
            "DLG_CONNECTING_TITLE":"Please wait",
            "DLG_LOGINERROR_TEXT":"{0}",
            "DLG_ERROR_TEXT_INTERNAL":"An internal error has occurred (Code: {0}.{1}).",
            "DLG_CONNECTIONLOST_TITLE":"Connection lost",
            "DLG_LOGINERROR_TITLE":"Sorry",
            "DLG_LOGINADVICE_TEXT":"{0}",
            "DLG_DEAD_TEXT_UNFAIR":"Alas! Brave adventurer, you have met a sad fate. <br>But do not despair, for the gods will bring you back into the world in exchange for a small sacrifice.<br><br>This death penalty has been reduced by {0}% because it was an unfair fight.<br><br>Simply click on \'<b>Okay</b>\' to resume your journeys in Tibia!",
            "DLG_CLIENT_CHANGE_TITLE":"Different client needed",
            "TEXT_SECONDS":"{0} seconds",
            "DLG_LOGOUT_TEXT":"Are you sure you want to leave Tibia?",
            "DLG_CONNECTING_TEXT":"Connecting to the game server.",
            "DLG_CONNECTION_LOST_TITLE":"Warning",
            "TEXT_MINUTES":"{0} minutes",
            "TEXT_MINUTE":"{0} minute",
            "DLG_DEAD_TEXT_FAIR":"Alas! Brave adventurer, you have met a sad fate. <br>But do not despair, for the gods will bring you back into the world in exchange for a small sacrifice.<br><br>Simply click on \'<b>Okay</b>\' to resume your journeys in Tibia!",
            "DLG_CONNECTIONLOST_TEXT":"Connection to the game server was lost. Please try again later.",
            "DLG_LOGINWAIT_TEXT":"{0}\n\nTrying to reconnect in {1}.",
            "DLG_LOGOUT_TITLE":"Warning",
            "DLG_LOGINADVICE_TITLE":"For Your Information"
         };
         return _loc1_;
      }
   }
}
