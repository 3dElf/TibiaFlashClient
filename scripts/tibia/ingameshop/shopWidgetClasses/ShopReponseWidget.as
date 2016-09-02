package tibia.ingameshop.shopWidgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.ingameshop.*;

    public class ShopReponseWidget extends EmbeddedDialog
    {
        private var m_ButtonTimer:Timer;
        private var m_SuccessButton:Button;
        private var m_ButtonAnimation:SimpleAnimationRenderer;
        private var m_ErrorType:int;
        private var m_Message:String;
        private static const PURCHASE_SUCCESS_IDLE_BITMAP:BitmapData = (new PURCHASE_SUCCESS_IDLE() as BitmapAsset).bitmapData;
        private static const BUNDLE:String = "IngameShopWidget";
        private static const PURCHASE_SUCCESS_PRESSED_BITMAP:BitmapData = (new PURCHASE_SUCCESS_PRESSED() as BitmapAsset).bitmapData;
        private static const PURCHASE_SUCCESS_PRESSED:Class = ShopReponseWidget_PURCHASE_SUCCESS_PRESSED;
        private static const PURCHASE_SUCCESS_IDLE:Class = ShopReponseWidget_PURCHASE_SUCCESS_IDLE;

        public function ShopReponseWidget(param1:String, param2:int)
        {
            this.m_ErrorType = param2;
            this.m_Message = param1;
            title = this.getTitleStringByErrorState();
            text = param1;
            width = IngameShopWidget.EMBEDDED_DIALOG_WIDTH;
            if (param2 != IngameShopEvent.ERROR_NO_ERROR)
            {
                minHeight = 175;
                buttonFlags = EmbeddedDialog.OKAY;
            }
            else
            {
                buttonFlags = EmbeddedDialog.NONE;
            }
            return;
        }// end function

        protected function onStoreSuccessButtonAnimationOver(event:TimerEvent) : void
        {
            var _loc_2:* = new CloseEvent(CloseEvent.CLOSE, false, true, EmbeddedDialog.OKAY);
            dispatchEvent(_loc_2);
            return;
        }// end function

        protected function onStoreSuccessButtonClicked(event:MouseEvent) : void
        {
            this.setPurchaseButtonPressedAnimation();
            this.m_ButtonAnimation.removeEventListener(MouseEvent.CLICK, this.onStoreSuccessButtonClicked);
            this.m_ButtonTimer.start();
            return;
        }// end function

        private function setPurchaseButtonPressedAnimation() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            if (this.m_ButtonAnimation != null)
            {
                _loc_1 = 108;
                _loc_2 = 1;
                _loc_3 = PURCHASE_SUCCESS_PRESSED_BITMAP.width / _loc_1;
                _loc_4 = new Vector.<FrameDuration>;
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    _loc_7 = _loc_5 < 5 ? (150) : (100);
                    _loc_4.push(new FrameDuration(_loc_7, _loc_7));
                    _loc_5 = _loc_5 + 1;
                }
                _loc_6 = new AppearanceAnimator(_loc_3, 0, _loc_2, AppearanceAnimator.ANIMATION_ASYNCHRON, _loc_4);
                this.m_ButtonAnimation.setAnimation(PURCHASE_SUCCESS_PRESSED_BITMAP, _loc_1, _loc_6);
            }
            return;
        }// end function

        private function getTitleStringByErrorState() : String
        {
            switch(this.m_ErrorType)
            {
                case IngameShopEvent.ERROR_NO_ERROR:
                {
                    return resourceManager.getString(BUNDLE, "TITLE_PURCHASE_SUCCESS");
                }
                case IngameShopEvent.ERROR_INFORMATION:
                {
                    return resourceManager.getString(BUNDLE, "TITLE_PURCHASE_INFORMATION");
                }
                default:
                {
                    return resourceManager.getString(BUNDLE, "TITLE_PURCHASE_ERROR");
                    break;
                }
            }
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.createChildren();
            if (this.getTextColorStyleNameByErrorState() != null)
            {
                titleBox.setStyle("color", getStyle(this.getTextColorStyleNameByErrorState()));
            }
            if (this.m_ErrorType == IngameShopEvent.ERROR_NO_ERROR)
            {
                _loc_1 = new HBox();
                _loc_1.percentHeight = 100;
                _loc_1.percentWidth = 100;
                this.m_SuccessButton = new Button();
                this.m_SuccessButton.styleName = "purchaseCompletedStyle";
                this.m_ButtonAnimation = new SimpleAnimationRenderer();
                this.m_ButtonAnimation.moveTarget = this.m_SuccessButton;
                this.m_ButtonAnimation.addEventListener(MouseEvent.CLICK, this.onStoreSuccessButtonClicked);
                _loc_2 = content.getChildAt(0) as Text;
                content.removeAllChildren();
                _loc_3 = new TextArea();
                _loc_3.editable = false;
                _loc_3.text = text;
                _loc_3.percentWidth = 100;
                var _loc_4:* = PURCHASE_SUCCESS_IDLE_BITMAP.height;
                _loc_3.height = PURCHASE_SUCCESS_IDLE_BITMAP.height;
                _loc_3.maxHeight = _loc_4;
                _loc_1.addChild(_loc_3);
                _loc_1.addChild(this.m_SuccessButton);
                _loc_1.rawChildren.addChild(this.m_ButtonAnimation);
                content.addChild(_loc_1);
                this.m_ButtonTimer = new Timer(2050);
                this.m_ButtonTimer.addEventListener(TimerEvent.TIMER, this.onStoreSuccessButtonAnimationOver);
                this.setPurchaseButtonIdleAnimation();
            }
            return;
        }// end function

        private function getTextColorStyleNameByErrorState() : String
        {
            switch(this.m_ErrorType)
            {
                case IngameShopEvent.ERROR_NO_ERROR:
                {
                    return "successColor";
                }
                case IngameShopEvent.ERROR_PURCHASE_FAILED:
                {
                    return "errorColor";
                }
                case IngameShopEvent.ERROR_NETWORK:
                {
                    return "errorColor";
                }
                case IngameShopEvent.ERROR_TRANSFER_FAILED:
                {
                    return "errorColor";
                }
                case IngameShopEvent.ERROR_INFORMATION:
                {
                    return "informationColor";
                }
                case IngameShopEvent.ERROR_TRANSACTION_HISTORY:
                {
                }
                default:
                {
                    return null;
                    break;
                }
            }
        }// end function

        private function setPurchaseButtonIdleAnimation() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (this.m_ButtonAnimation != null)
            {
                _loc_1 = 108;
                _loc_2 = 0;
                _loc_3 = PURCHASE_SUCCESS_IDLE_BITMAP.width / _loc_1;
                _loc_4 = 150;
                _loc_5 = new Vector.<FrameDuration>;
                _loc_6 = 0;
                while (_loc_6 < _loc_3)
                {
                    
                    _loc_5.push(new FrameDuration(_loc_4, _loc_4));
                    _loc_6 = _loc_6 + 1;
                }
                _loc_7 = new AppearanceAnimator(_loc_3, 0, _loc_2, AppearanceAnimator.ANIMATION_ASYNCHRON, _loc_5);
                this.m_ButtonAnimation.setAnimation(PURCHASE_SUCCESS_IDLE_BITMAP, _loc_1, _loc_7);
            }
            return;
        }// end function

    }
}
