package tibia.help
{
   import tibia.game.PopUpBase;
   import mx.core.Container;
   import mx.controls.Image;
   import mx.controls.Text;
   import mx.containers.HBox;
   
   public class TutorialHintWidget extends PopUpBase
   {
      
      private static const BUNDLE:String = "TutorialHintWidget";
       
      protected var m_UIImages:Container = null;
      
      private var m_UncommittedImages:Boolean = false;
      
      protected var m_Images:Array = null;
      
      private var m_UncommittedText:Boolean = false;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_UIText:Text = null;
      
      protected var m_Text:String = null;
      
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
      
      override protected function commitProperties() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Image = null;
         super.commitProperties();
         if(this.m_UncommittedText)
         {
            this.m_UIText.htmlText = this.m_Text;
            this.m_UncommittedText = false;
         }
         if(this.m_UncommittedImages)
         {
            if(this.m_UIImages != null)
            {
               this.m_UIImages.removeAllChildren();
               _loc1_ = 0;
               _loc2_ = this.m_Images != null?int(this.m_Images.length):0;
               while(_loc1_ < _loc2_)
               {
                  _loc3_ = new Image();
                  _loc3_.source = this.m_Images[_loc1_];
                  this.m_UIImages.addChild(_loc3_);
                  _loc1_++;
               }
            }
            this.m_UncommittedImages = false;
         }
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
      
      public function get images() : Array
      {
         return this.m_Images;
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIText = new Text();
            this.m_UIText.percentWidth = 100;
            this.m_UIText.percentHeight = 100;
            this.m_UIText.maxWidth = 360;
            addChild(this.m_UIText);
            this.m_UIImages = new HBox();
            this.m_UIImages.percentWidth = 100;
            this.m_UIImages.setStyle("horizontalAlign","center");
            this.m_UIImages.setStyle("verticalAlign","middle");
            addChild(this.m_UIImages);
            this.m_UIConstructed = true;
         }
      }
   }
}
