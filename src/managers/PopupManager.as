package managers
{
  import flash.display.DisplayObjectContainer;
  import mx.core.UIComponent;

  public class PopupManager
  {
    public function PopupManager()
    {
      super();
    }

    public function addPopup(window:UIComponent,
                        parent:UIComponent,
                        modal:Boolean=false):void
    {
      var _root:DisplayObjectContainer =
          DisplayObjectContainer(parent.root);
      if (!_root)
      {
        throw new Error("unko parent");
      }

      var modalShield:ModalShield;
      modalShield = new ModalShield();
      modalShield.percentWidth = 100;
      modalShield.percentHeight = 100;
      modalShield.width = _root.width;
      modalShield.height = _root.height;
      modalShield.horizontalAlign = "center";
      modalShield.verticalAlign = "middle";

      if (modal)
      {
        modalShield.graphics.beginFill(0x333333, 0.3);
        modalShield.graphics.drawRect(0,0,_root.width,_root.height);
      }

      modalShield.addWindow(window);
      _root.addChild(modalShield);

    }

    public function removePopup(window:UIComponent):void
    {
      var p:ModalShield = window.parent as ModalShield;
      if (!p)
        throw new Error("unko parent");
      p.removeWindow(window);
    }
  }
}


import mx.core.UIComponent;
import mx.events.FlexEvent;
import mx.events.ResizeEvent;
import spark.components.VGroup;

class ModalShield extends VGroup
{
  private var _modal:Boolean;

  public function ModalShield(modal:Boolean=false)
  {
    super();

    _modal = modal;
    if (_modal)
    {
      addEventListener(ResizeEvent.RESIZE, resizeHandler);
    }
  }

  public function addWindow(window:UIComponent):void
  {
    this.addElement(window);
    window.addEventListener(FlexEvent.REMOVE, window_removeHandler)
  }

  public function removeWindow(window:UIComponent):void
  {
    if (containsElement(window))
    {
      window.removeEventListener(FlexEvent.REMOVE, window_removeHandler);
      removeElement(window);
      checkedRemoveSelf();
    }
  }

  protected function window_removeHandler(e:FlexEvent):void
  {
    checkedRemoveSelf();
  }

  protected function checkedRemoveSelf():void
  {
    if (numElements <= 1 && parent)
    {
      parent.removeChild(this);
    }
  }

  protected function resizeHandler(e:ResizeEvent):void
  {
    // TODO: リサイズしたときにモーダルを再描画
  }
}
