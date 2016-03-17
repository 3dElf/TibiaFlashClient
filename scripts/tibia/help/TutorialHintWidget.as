package tibia.help
{
   import tibia.game.PopUpBase;
   import mx.controls.Image;
   import mx.controls.Text;
   import mx.containers.HBox;
   import mx.core.Container;
   
   public class TutorialHintWidget extends PopUpBase
   {
      
      private static const BUNDLE:String = "TutorialHintWidget";
       
      private var m_UncommittedText:Boolean = false;
      
      private var m_UncommittedImages:Boolean = false;
      
      private var m_Images:Array = null;
      
      private var m_UIText:Text = null;
      
      private var m_UIImages:Container = null;
      
      private var m_Text:String = null;
      
      public function TutorialHintWidget()
      {
         super();
         title = resourceManager.getString(BUNDLE,"TITLE");
         buttonFlags = PopUpBase.BUTTON_CLOSE;
      }
      
      public function set text(param1:String) : void
      {
         if(this.m_Text != param1)
         {
            this.m_Text = param1;
            this.m_UncommittedText = true;
            invalidateProperties();
         }
      }
      
      public function get text() : String
      {
         return this.m_Text;
      }
      
      public function set images(param1:Array) : void
      {
         if(this.m_Images != param1)
         {
            this.m_Images = param1;
            this.m_UncommittedImages = true;
            invalidateProperties();
         }
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Image = null;
         super.commitProperties();
         if(this.m_UncommittedImages)
         {
            this.m_UIImages.removeAllChildren();
            _loc1_ = this.images != null?int(this.images.length):0;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = new Image();
               _loc3_.source = this.images[_loc2_];
               this.m_UIImages.addChild(_loc3_);
               _loc2_++;
            }
            this.m_UncommittedImages = false;
         }
         if(this.m_UncommittedText)
         {
            this.m_UIText.htmlText = this.text;
            this.m_UncommittedText = false;
         }
      }
      
      public function get images() : Array
      {
         return this.m_Images;
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         this.m_UIText = new Text();
         this.m_UIText.maxWidth = 400;
         this.m_UIText.minWidth = 200;
         addChild(this.m_UIText);
         this.m_UIImages = new HBox();
         this.m_UIImages.percentWidth = 100;
         this.m_UIImages.setStyle("horizontalAlign","center");
         this.m_UIImages.setStyle("verticalAlign","middle");
         addChild(this.m_UIImages);
      }
   }
}
