package tibia.creatures.buddylistClasses
{
   import flash.events.EventDispatcher;
   import tibia.reporting.IReportable;
   import mx.events.PropertyChangeEvent;
   import tibia.reporting.reportType.Type;
   import shared.utility.StringHelper;
   
   public class Buddy extends EventDispatcher implements IReportable
   {
      
      protected static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 4;
      
      public static const NUM_BUDDIES:int = int.MAX_VALUE;
      
      protected static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
      
      private static const LOGIN_HIGHLIGHT_TIME:Number = 1000;
       
      protected var m_Online:Boolean = false;
      
      protected var m_Description:String = null;
      
      protected var m_Icon:int = 0;
      
      protected var m_ID:int = 0;
      
      protected var m_LastUpdate:Number = NaN;
      
      protected var m_Notify:Boolean = false;
      
      protected var m_Name:String = null;
      
      public function Buddy(param1:int, param2:String)
      {
         super();
         this.m_ID = param1;
         this.m_Name = param2;
      }
      
      public static function s_Unmarshall(param1:XML, param2:Number) : Buddy
      {
         var ID:int = 0;
         var Description:String = null;
         var DecodeHex:Function = null;
         var a_XML:XML = param1;
         var a_Version:Number = param2;
         if(a_XML == null || a_XML.localName() != "buddy" || a_Version < OPTIONS_MIN_COMPATIBLE_VERSION || a_Version > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("Buddy.s_Unmarshall: Invalid input.");
         }
         var Lst:XMLList = null;
         if((Lst = a_XML.@ID) == null || Lst.length() != 1)
         {
            return null;
         }
         ID = parseInt(Lst[0].toString());
         var Result:Buddy = new Buddy(ID,null);
         if((Lst = a_XML.@description) != null && Lst.length() == 1)
         {
            Description = Lst[0].toString();
            if(a_Version == 2)
            {
               try
               {
                  DecodeHex = function(param1:String, param2:String, param3:int, param4:String):String
                  {
                     return String.fromCharCode(parseInt(param2,16));
                  };
                  Description = Description.replace(/&(?:amp;)*#x([0-9A-F]+);/g,DecodeHex);
               }
               catch(e:Error)
               {
               }
            }
            Result.description = Description;
         }
         if((Lst = a_XML.@notify) != null && Lst.length() == 1)
         {
            Result.notify = Lst[0].toString() == "true";
         }
         if((Lst = a_XML.@icon) != null && Lst.length() == 1)
         {
            Result.icon = parseInt(Lst[0].toString());
         }
         return Result;
      }
      
      [Bindable(event="propertyChange")]
      public function set name(param1:String) : void
      {
         var _loc2_:Object = this.name;
         if(_loc2_ !== param1)
         {
            this._3373707name = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"name",_loc2_,param1));
         }
      }
      
      public function get notify() : Boolean
      {
         return this.m_Notify;
      }
      
      public function get name() : String
      {
         return this.m_Name;
      }
      
      [Bindable(event="propertyChange")]
      public function set lastUpdate(param1:Number) : void
      {
         var _loc2_:Object = this.lastUpdate;
         if(_loc2_ !== param1)
         {
            this._1992879871lastUpdate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lastUpdate",_loc2_,param1));
         }
      }
      
      public function marshall() : XML
      {
         return <buddy ID="{this.m_ID}" description="{this.m_Description != null?this.m_Description:""}" notify="{this.m_Notify}" icon="{this.m_Icon}"/>;
      }
      
      [Bindable(event="propertyChange")]
      public function set description(param1:String) : void
      {
         var _loc2_:Object = this.description;
         if(_loc2_ !== param1)
         {
            this._1724546052description = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"description",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set notify(param1:Boolean) : void
      {
         var _loc2_:Object = this.notify;
         if(_loc2_ !== param1)
         {
            this._1039689911notify = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"notify",_loc2_,param1));
         }
      }
      
      public function get online() : Boolean
      {
         return this.m_Online;
      }
      
      public function get characterName() : String
      {
         return this.m_Name;
      }
      
      private function set _1012222381online(param1:Boolean) : void
      {
         this.m_Online = param1;
      }
      
      private function set _3373707name(param1:String) : void
      {
         this.m_Name = param1;
      }
      
      public function clone() : Buddy
      {
         var _loc1_:Buddy = new Buddy(this.m_ID,this.m_Name);
         _loc1_.description = this.m_Description;
         _loc1_.icon = this.m_Icon;
         _loc1_.lastUpdate = this.m_LastUpdate;
         _loc1_.notify = this.m_Notify;
         _loc1_.online = this.m_Online;
         return _loc1_;
      }
      
      private function set _3226745icon(param1:int) : void
      {
         this.m_Icon = Math.max(0,Math.min(param1,BuddyIcon.NUM_ICONS - 1));
      }
      
      private function set _1039689911notify(param1:Boolean) : void
      {
         this.m_Notify = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set online(param1:Boolean) : void
      {
         var _loc2_:Object = this.online;
         if(_loc2_ !== param1)
         {
            this._1012222381online = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"online",_loc2_,param1));
         }
      }
      
      public function get ID() : int
      {
         return this.m_ID;
      }
      
      private function set _1992879871lastUpdate(param1:Number) : void
      {
         this.m_LastUpdate = param1;
      }
      
      public function isReportTypeAllowed(param1:uint) : Boolean
      {
         return param1 == Type.REPORT_NAME;
      }
      
      [Bindable(event="propertyChange")]
      public function set icon(param1:int) : void
      {
         var _loc2_:Object = this.icon;
         if(_loc2_ !== param1)
         {
            this._3226745icon = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"icon",_loc2_,param1));
         }
      }
      
      public function get highlight() : Boolean
      {
         return Boolean(this.m_Online) && this.m_LastUpdate > Tibia.s_FrameTimestamp - LOGIN_HIGHLIGHT_TIME;
      }
      
      public function setReportTypeAllowed(param1:uint, param2:Boolean = true) : void
      {
      }
      
      public function get icon() : int
      {
         return this.m_Icon;
      }
      
      public function get description() : String
      {
         return this.m_Description;
      }
      
      private function set _1724546052description(param1:String) : void
      {
         this.m_Description = StringHelper.s_Trim(param1);
      }
      
      public function get lastUpdate() : Number
      {
         return this.m_LastUpdate;
      }
   }
}
