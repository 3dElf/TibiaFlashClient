package tibia.cursors
{
   import mx.managers.ICursorManager;
   import flash.ui.Mouse;
   
   public class CustomCursorManagerImpl implements ICursorManager
   {
      
      private static var s_Instance:ICursorManager = null;
       
      protected var m_CursorPriority:int = -1;
      
      protected var m_CursorID:int = 0;
      
      public function CustomCursorManagerImpl()
      {
         super();
      }
      
      public static function getInstance() : ICursorManager
      {
         if(s_Instance == null)
         {
            s_Instance = new CustomCursorManagerImpl();
         }
         return s_Instance;
      }
      
      public function removeCursor(param1:int) : void
      {
         if(this.m_CursorID == param1)
         {
            Mouse.cursor = DefaultCursor.CURSOR_NAME;
            this.m_CursorID = DefaultCursor.CURSOR_ID;
            this.m_CursorPriority = -1;
         }
      }
      
      public function showCursor() : void
      {
      }
      
      public function get currentCursorYOffset() : Number
      {
         return 0;
      }
      
      public function hideCursor() : void
      {
      }
      
      public function get currentCursorID() : int
      {
         return this.m_CursorID;
      }
      
      public function set currentCursorYOffset(param1:Number) : void
      {
      }
      
      public function removeBusyCursor() : void
      {
      }
      
      public function set currentCursorID(param1:int) : void
      {
      }
      
      public function setCursor(param1:Class, param2:int = 2, param3:Number = 0, param4:Number = 0) : int
      {
         if(param2 <= this.m_CursorPriority)
         {
            return 0;
         }
         switch(param1)
         {
            case CrosshairCursor:
               Mouse.cursor = CrosshairCursor.CURSOR_NAME;
               this.m_CursorID = CrosshairCursor.CURSOR_ID;
               break;
            case DragCopyCursor:
               Mouse.cursor = DragCopyCursor.CURSOR_NAME;
               this.m_CursorID = DragCopyCursor.CURSOR_ID;
               break;
            case DragLinkCursor:
               Mouse.cursor = DragLinkCursor.CURSOR_NAME;
               this.m_CursorID = DragLinkCursor.CURSOR_ID;
               break;
            case DragMoveCursor:
               Mouse.cursor = DragMoveCursor.CURSOR_NAME;
               this.m_CursorID = DragMoveCursor.CURSOR_ID;
               break;
            case DragNoneCursor:
               Mouse.cursor = DragNoneCursor.CURSOR_NAME;
               this.m_CursorID = DragNoneCursor.CURSOR_ID;
               break;
            case ResizeHorizontalCursor:
               Mouse.cursor = ResizeHorizontalCursor.CURSOR_NAME;
               this.m_CursorID = ResizeHorizontalCursor.CURSOR_ID;
               break;
            case ResizeVerticalCursor:
               Mouse.cursor = ResizeVerticalCursor.CURSOR_NAME;
               this.m_CursorID = ResizeVerticalCursor.CURSOR_ID;
               break;
            default:
               Mouse.cursor = DefaultCursor.CURSOR_NAME;
               this.m_CursorID = DefaultCursor.CURSOR_ID;
         }
         this.m_CursorPriority = param2;
         return this.m_CursorID;
      }
      
      public function removeAllCursors() : void
      {
         Mouse.cursor = DefaultCursor.CURSOR_NAME;
         this.m_CursorID = DefaultCursor.CURSOR_ID;
         this.m_CursorPriority = -1;
      }
      
      public function registerToUseBusyCursor(param1:Object) : void
      {
      }
      
      public function unRegisterToUseBusyCursor(param1:Object) : void
      {
      }
      
      public function setBusyCursor() : void
      {
      }
      
      public function get currentCursorXOffset() : Number
      {
         return 0;
      }
      
      public function set currentCursorXOffset(param1:Number) : void
      {
      }
   }
}
