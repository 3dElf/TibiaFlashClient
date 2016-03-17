package tibia.sessiondump.hints
{
   import tibia.worldmap.WorldMapStorage;
   import tibia.container.bodyContainerViewWigdetClasses.BodyContainerViewWidgetView;
   import tibia.container.BodyContainerView;
   
   public class SessiondumpHintHighlightUI extends SessiondumpHintBase
   {
      
      private static var FIELD_CONDITIONDATA:String = "conditiondata";
      
      private static var FIELD_COORDINATE:String = "coordinate";
      
      private static var FIELD_SESSIONDUMP:String = "sessiondump";
      
      private static var FIELD_DESTINATION_COORDINATE:String = "destination";
      
      private static var FIELD_CHANNEL:String = "channel";
      
      private static var FIELD_TYPE:String = "type";
      
      private static var FIELD_CONDITIONTYPE:String = "conditiontype";
      
      private static var FIELD_USE_TYPE_ID:String = "usetypeid";
      
      private static var FIELD_PLAYER_OUTFIT_COLOR_TORSO:String = "color-torso";
      
      private static var FIELD_OBJECTTYPE:String = "objecttype";
      
      private static var CONDITION_TYPE_CLICK_CREATURE:String = "CLICK_CREATURE";
      
      private static var FIELD_OBJECTTYPEID:String = "objecttypeid";
      
      private static var FIELD_POSITION:String = "position";
      
      private static var FIELD_TARGET:String = "target";
      
      private static var FIELD_PLAYER_OUTFIT:String = "player-outfit";
      
      private static var FIELD_UIELEMENT:String = "uielement";
      
      private static var FIELD_PLAYER_OUTFIT_COLOR_DETAIL:String = "color-detail";
      
      private static var FIELD_MULTIUSE_TARGET:String = "multiusetarget";
      
      private static var FIELD_CHANNEL_ID:String = "channelid";
      
      private static var FIELD_CREATURE_ID:String = "creatureid";
      
      private static var CONDITION_TYPE_DRAG_DROP:String = "DRAG_DROP";
      
      private static var FIELD_MULTIUSE_OBJECT_POSITION:String = "multiuseobjectposition";
      
      private static var FIELD_PLAYER_NAME:String = "player-name";
      
      private static var FIELD_PLAYER_OUTFIT_ID:String = "id";
      
      private static var FIELD_PLAYER_OUTFIT_COLOR_LEGS:String = "color-legs";
      
      private static var FIELD_SKIP_TO_TIMESTAMP:String = "skiptotimestamp";
      
      private static var FIELD_MULTIUSE_OBJECT_ID:String = "multiuseobjectid";
      
      private static var FIELD_TUTORIAL_PROGRESS:String = "tutorialprogress";
      
      private static var FIELD_TIMESTAMP:String = "timestamp";
      
      public static const TYPE:String = "HIGHLIGHT_UI";
      
      private static var FIELD_PLAYER_OUTFIT_ADDONS:String = "add-ons";
      
      private static var FIELD_AMOUNT:String = "amount";
      
      private static var FIELD_OBJECTID:String = "objectid";
      
      private static var FIELD_CREATURE_NAME:String = "creaturename";
      
      private static var CONDITION_TYPE_CLICK:String = "CLICK";
      
      private static var FIELD_OBJECTDATA:String = "objectdata";
      
      private static var FIELD_TEXT:String = "text";
      
      private static var FIELD_OBJECTINDEX:String = "objectindex";
      
      private static var FIELD_SOURCE_COORDINATE:String = "source";
      
      private static var FIELD_PLAYER_OUTFIT_COLOR_HEAD:String = "color-head";
       
      private var m_UIElement:uint = 0;
      
      public function SessiondumpHintHighlightUI()
      {
         super();
         m_Type = TYPE;
      }
      
      public static function s_Unmarshall(param1:Object) : SessiondumpHintBase
      {
         var _loc2_:SessiondumpHintHighlightUI = new SessiondumpHintHighlightUI();
         if(FIELD_UIELEMENT in param1)
         {
            _loc2_.m_UIElement = uint(param1[FIELD_UIELEMENT]);
         }
         return _loc2_;
      }
      
      override public function perform() : void
      {
         var Identifier:Class = null;
         var SubIdentifier:* = undefined;
         super.perform();
         var _WorldMapStorage:WorldMapStorage = Tibia.s_GetWorldMapStorage();
         try
         {
            Identifier = null;
            SubIdentifier = null;
            switch(this.m_UIElement)
            {
               case 0:
                  Identifier = null;
                  SubIdentifier = -1;
                  break;
               case 1:
                  Identifier = BodyContainerViewWidgetView;
                  SubIdentifier = -1;
                  break;
               case 2:
                  Identifier = BodyContainerViewWidgetView;
                  SubIdentifier = BodyContainerView.NECK;
                  break;
               case 3:
                  Identifier = BodyContainerViewWidgetView;
                  SubIdentifier = BodyContainerView.HEAD;
                  break;
               case 4:
                  Identifier = BodyContainerViewWidgetView;
                  SubIdentifier = BodyContainerView.BACK;
                  break;
               case 5:
                  Identifier = BodyContainerViewWidgetView;
                  SubIdentifier = BodyContainerView.RIGHT_HAND;
                  break;
               case 6:
                  Identifier = BodyContainerViewWidgetView;
                  SubIdentifier = BodyContainerView.LEFT_HAND;
            }
            Tibia.s_GetUIEffectsManager().higlightUIElementByIdentifier(Identifier,SubIdentifier);
            m_Processed = true;
            return;
         }
         catch(e:Error)
         {
            throw new Error("SessiondumpHintHighlightUI.perform: Failed to highlight object");
         }
      }
   }
}
