package tibia.sessiondump.hints
{
   import shared.utility.Vector3D;
   import tibia.appearances.EffectInstance;
   import tibia.worldmap.WorldMapStorage;
   
   public class SessiondumpHintHighlightObject extends SessiondumpHintBase
   {
      
      private static var FIELD_CONDITIONDATA:String = "conditiondata";
      
      public static const OBJECTTYPE_CREATURE:String = "CREATURE";
      
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
      
      public static const OBJECTTYPE_OBJECT:String = "OBJECT";
      
      private static var CONDITION_TYPE_DRAG_DROP:String = "DRAG_DROP";
      
      private static var FIELD_MULTIUSE_OBJECT_POSITION:String = "multiuseobjectposition";
      
      private static var FIELD_PLAYER_NAME:String = "player-name";
      
      private static var FIELD_PLAYER_OUTFIT_ID:String = "id";
      
      private static var FIELD_PLAYER_OUTFIT_COLOR_LEGS:String = "color-legs";
      
      private static var FIELD_SKIP_TO_TIMESTAMP:String = "skiptotimestamp";
      
      private static var FIELD_MULTIUSE_OBJECT_ID:String = "multiuseobjectid";
      
      private static var FIELD_TUTORIAL_PROGRESS:String = "tutorialprogress";
      
      private static var FIELD_TIMESTAMP:String = "timestamp";
      
      public static const TYPE:String = "HIGHLIGHT_OBJECT";
      
      private static var FIELD_PLAYER_OUTFIT_ADDONS:String = "add-ons";
      
      private static var m_CreatedEffects:Vector.<EffectInstance> = new Vector.<EffectInstance>();
      
      private static var FIELD_AMOUNT:String = "amount";
      
      private static var FIELD_OBJECTID:String = "objectid";
      
      private static var FIELD_CREATURE_NAME:String = "creaturename";
      
      private static var CONDITION_TYPE_CLICK:String = "CLICK";
      
      public static const OBJECTTYPE_UNDEFINED:String = "UNDEFINED";
      
      private static var FIELD_OBJECTDATA:String = "objectdata";
      
      private static var FIELD_TEXT:String = "text";
      
      private static var FIELD_OBJECTINDEX:String = "objectindex";
      
      public static const OBJECTTYPE_CLEAR:String = "CLEAR";
      
      private static var FIELD_SOURCE_COORDINATE:String = "source";
      
      private static var FIELD_PLAYER_OUTFIT_COLOR_HEAD:String = "color-head";
       
      private var m_CreatureID:uint = 0;
      
      private var m_ObjecttypeID:uint = 0;
      
      private var m_ObjecttypeIndex:uint = 0;
      
      private var m_Coordinate:Vector3D = null;
      
      private var m_Objecttype:String = "UNDEFINED";
      
      public function SessiondumpHintHighlightObject()
      {
         super();
         m_Type = TYPE;
      }
      
      public static function s_Unmarshall(param1:Object) : SessiondumpHintBase
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc2_:SessiondumpHintHighlightObject = new SessiondumpHintHighlightObject();
         if(FIELD_OBJECTTYPE in param1)
         {
            _loc2_.m_Objecttype = String(param1[FIELD_OBJECTTYPE]);
         }
         if(FIELD_OBJECTDATA in param1)
         {
            _loc3_ = param1[FIELD_OBJECTDATA];
            switch(_loc2_.m_Objecttype)
            {
               case OBJECTTYPE_OBJECT:
                  _loc4_ = _loc3_[FIELD_COORDINATE] as Object;
                  _loc2_.m_Coordinate = new Vector3D(_loc4_["x"],_loc4_["y"],_loc4_["z"]);
                  _loc2_.m_ObjecttypeID = uint(_loc3_[FIELD_OBJECTID]);
                  _loc2_.m_ObjecttypeIndex = uint(_loc3_[FIELD_OBJECTINDEX]);
            }
         }
         return _loc2_;
      }
      
      override public function perform() : void
      {
         var MapCoordinate:Vector3D = null;
         super.perform();
         var _WorldMapStorage:WorldMapStorage = Tibia.s_GetWorldMapStorage();
         var _EffectInstance:EffectInstance = null;
         try
         {
            if(this.m_Objecttype == OBJECTTYPE_OBJECT)
            {
               _EffectInstance = Tibia.s_GetAppearanceStorage().createEffectInstance(56);
               _EffectInstance.loopEffect = true;
               m_CreatedEffects.push(_EffectInstance);
               MapCoordinate = _WorldMapStorage.toMap(this.m_Coordinate);
               _WorldMapStorage.appendEffect(this.m_Coordinate.x,this.m_Coordinate.y,this.m_Coordinate.z,_EffectInstance);
               _EffectInstance = Tibia.s_GetAppearanceStorage().createEffectInstance(57);
               _EffectInstance.loopEffect = true;
               m_CreatedEffects.push(_EffectInstance);
               _WorldMapStorage.appendEffect(this.m_Coordinate.x,this.m_Coordinate.y,this.m_Coordinate.z,_EffectInstance);
            }
            else if(this.m_Objecttype == OBJECTTYPE_CLEAR)
            {
               while(m_CreatedEffects.length > 0)
               {
                  _EffectInstance = m_CreatedEffects.pop();
                  _EffectInstance.end();
               }
            }
            m_Processed = true;
            return;
         }
         catch(e:Error)
         {
            throw new Error("SessiondumpHintHighlightObject.perform: Failed to highlight object at timestamp " + timestamp + "\n" + e.message);
         }
      }
   }
}
