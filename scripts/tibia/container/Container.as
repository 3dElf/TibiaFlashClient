package tibia.container
{
   import flash.events.EventDispatcher;
   import tibia.appearances.AppearanceInstance;
   import mx.events.PropertyChangeEvent;
   import mx.events.PropertyChangeEventKind;
   
   public class Container extends EventDispatcher
   {
      
      public static const MAX_NAME_LENGTH:int = 30;
       
      protected var m_Name:String = null;
      
      protected var m_Items:Vector.<AppearanceInstance> = null;
      
      protected var m_IsSubContainer:Boolean = false;
      
      protected var m_Length:int = 0;
      
      protected var m_Window:int = 0;
      
      protected var m_Capacity:int = 0;
      
      protected var m_Object:AppearanceInstance = null;
      
      public function Container(param1:int, param2:AppearanceInstance, param3:String, param4:int, param5:Boolean)
      {
         super();
         this.m_Capacity = param4;
         this.m_Items = new Vector.<AppearanceInstance>();
         this.m_IsSubContainer = param5;
         this.m_Length = 0;
         this.m_Name = param3;
         this.m_Object = param2;
         this.m_Window = param1;
      }
      
      public function get capacity() : int
      {
         return this.m_Capacity;
      }
      
      public function removeItemAt(param1:int) : AppearanceInstance
      {
         if(param1 < 0 || param1 >= this.m_Length)
         {
            throw new RangeError("Container.removeItemAt: Index out of range: " + param1);
         }
         var _loc2_:AppearanceInstance = this.m_Items[param1];
         if(this.m_Length > 0)
         {
            this.m_Length--;
         }
         var _loc3_:int = param1;
         while(_loc3_ < this.m_Length)
         {
            this.m_Items[_loc3_] = this.m_Items[_loc3_ + 1];
            _loc3_++;
         }
         var _loc4_:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
         _loc4_.property = "item";
         _loc4_.kind = PropertyChangeEventKind.UPDATE;
         _loc4_.oldValue = _loc2_;
         _loc4_.newValue = null;
         dispatchEvent(_loc4_);
         return _loc2_;
      }
      
      public function get name() : String
      {
         return this.m_Name;
      }
      
      public function appendItem(param1:AppearanceInstance) : void
      {
         this.m_Items[this.m_Length] = param1;
         this.m_Length++;
         var _loc2_:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
         _loc2_.property = "item";
         _loc2_.kind = PropertyChangeEventKind.UPDATE;
         _loc2_.oldValue = null;
         _loc2_.newValue = param1;
         dispatchEvent(_loc2_);
      }
      
      public function getItemAt(param1:int) : AppearanceInstance
      {
         if(param1 < 0 || param1 >= this.m_Length)
         {
            throw new RangeError("Container.removeItemAt: Index out of range: " + param1);
         }
         return this.m_Items[param1];
      }
      
      public function get length() : int
      {
         return this.m_Length;
      }
      
      public function addItemAt(param1:int, param2:AppearanceInstance) : void
      {
         if(param1 < 0 || param1 > this.m_Length)
         {
            throw new RangeError("Container.addItemAt: Index out of range: " + param1);
         }
         var _loc3_:int = this.m_Length;
         while(_loc3_ > param1)
         {
            this.m_Items[_loc3_] = this.m_Items[_loc3_ - 1];
            _loc3_--;
         }
         this.m_Length++;
         this.m_Items[param1] = param2;
         var _loc4_:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
         _loc4_.property = "item";
         _loc4_.kind = PropertyChangeEventKind.UPDATE;
         _loc4_.oldValue = null;
         _loc4_.newValue = param2;
         dispatchEvent(_loc4_);
      }
      
      public function setItemAt(param1:int, param2:AppearanceInstance) : AppearanceInstance
      {
         if(param1 < 0 || param1 >= this.m_Length)
         {
            throw new RangeError("Container.setItemAt: Index out of range: " + param1);
         }
         var _loc3_:AppearanceInstance = this.m_Items[param1];
         this.m_Items[param1] = param2;
         var _loc4_:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
         _loc4_.property = "item";
         _loc4_.kind = PropertyChangeEventKind.UPDATE;
         _loc4_.oldValue = _loc3_;
         _loc4_.newValue = param2;
         dispatchEvent(_loc4_);
         return _loc3_;
      }
      
      public function get isSubContainer() : Boolean
      {
         return this.m_IsSubContainer;
      }
      
      public function get window() : int
      {
         return this.m_Window;
      }
      
      public function removeAll() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.m_Length)
         {
            this.m_Items[_loc1_] = null;
            _loc1_++;
         }
         this.m_Length = 0;
         var _loc2_:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
         _loc2_.property = "item";
         _loc2_.kind = PropertyChangeEventKind.UPDATE;
         dispatchEvent(_loc2_);
      }
      
      public function get object() : AppearanceInstance
      {
         return this.m_Object;
      }
   }
}
