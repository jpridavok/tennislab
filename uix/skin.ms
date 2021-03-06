include "lib://core/baseClass.ms"
include "lib://graphics/foreground.ms"
include "lib://graphics/background.ms"
include "lib://uix/form.ms"
include "lib://uix/list/listView.ms"
include "lib://uix/tile/tileView.ms"
include "lib://uix/title/titleBar.ms"
include "lib://uix/tab/tabBar.ms"
include "lib://uix/tab/tabItem.ms"
include "lib://uix/control/button.ms"
include "lib://uix/control/textBox.ms"
include "lib://uix/control/label.ms"

/**
Basic class for all derived custom skins.
@class Skin
*/
class Skin : BaseClass
{
    var pressedDelta = System.height / 400;

    /**
    @method init
    @protected
    */
    function init()
    {
        super.init();
    }

    // @region Control, Form, Application

    function drawApplication(canvas, application)
    {
    }

    function drawControl(canvas, control)
    {
        assert control instanceof Control;
        if (Control.style.background instanceof Background)
            Control.style.background.draw(canvas, control);
    }

    function drawForm(canvas, form)
    {
        assert form instanceof Form;
        if (Form.style.background instanceof Background)
            Form.style.background.draw(canvas, form);
    }

    // @region Button

    function drawButton(canvas, button)
    {
        assert button instanceof Button;
        var style = button.pressed ? Button.style.pressed : Button.style;
        var bg = style.background.native;
        var fg = style.foreground.native;
        var (tw, th) = fg.measureText(button.text);
        var delta = button.pressed ? Skin.pressedDelta : 0;
        canvas.drawRoundRect(0, 0, button.width, button.height, 10*Skin.pressedDelta, 10*Skin.pressedDelta, bg);
        canvas.drawText(button.text, (button.width - tw) / 2, (button.height + th) / 2 + delta, fg);
    }

    function drawLabel(canvas, label)
    {
        assert label instanceof Label;
        if (Label.style.background instanceof Background)
            Label.style.background.draw(canvas, label);
    }

    // @endregion

    // @endregion

    // @region ListView

    function drawListView(canvas, list)
    {
        assert list instanceof ListView;
        if (ListView.style.background instanceof Background)
            ListView.style.background.draw(canvas, list);
    }

    function drawListItem(canvas, listItem)
    {
        assert listItem instanceof ListItem;
        var style = listItem.pressed ? ListItem.style.pressed : ListItem.style;
        var bg = style.background.native;
        var fg = style.foreground.native;
        var (tw, th) = fg.measureText(listItem.text);
        var delta = listItem.pressed ? Skin.pressedDelta : 0;
        canvas.drawRect(0, 0, listItem.width, listItem.height, bg);
        canvas.drawText(listItem.text, 10 + delta, (listItem.height + th) / 2 + delta, fg);
        canvas.drawLine(0, listItem.height, listItem.width, listItem.height, fg);
    }

    // @endregion

    // @region TileView

    function drawTileView(canvas, tiles)
    {
        assert tiles instanceof TileView;
        if (TileView.style.background instanceof Background)
            TileView.style.background.draw(canvas, tiles);
    }

    function drawTileItem(canvas, tileItem)
    {
        assert tileItem instanceof TileItem;
        var style = tileItem.pressed ? TileItem.style.pressed : TileItem.style;
        var bg = style.background.native;
        var fg = style.foreground.native;
        var (tw, th) = fg.measureText(tileItem.text);
        var delta = tileItem.pressed ? Skin.pressedDelta : 0;
        canvas.drawRect(0, 0, tileItem.width, tileItem.height, bg);
        canvas.drawText(tileItem.text, 10 + delta, (tileItem.height + th) / 2 + delta, fg);
    }

    // @endregion

    // @region TitleBar

    function drawTitleBar(canvas, titleBar)
    {
        assert titleBar instanceof TitleBar;
        var bg = TitleBar.style.background.native;
        var fg = TitleBar.style.foreground.native;
        canvas.drawRect(0, 0, titleBar.width, titleBar.height, bg);
        canvas.drawLine(0, titleBar.height, titleBar.width, titleBar.height, fg);
        if (titleBar.text.length > 0) {
            var (tw, th) = fg.measureText(titleBar.text);
            var (left, right) = titleBar.labelLimits();
            var offset, align = titleBar.labelAlign || #center;
            if (align == #left) offset = left;
            else if (align == #right) offset = right - tw;
            else if (align == #center) offset = left + (right - left)/2 - tw/2;
            else if (align == #screen) offset = System.width/2 - tw/2;
            canvas.drawText(titleBar.text, offset, (titleBar.height + th) / 2, fg);
        }
    }

    function drawTitleItem(canvas, titleItem)
    {
        assert titleItem instanceof TitleItem;
        var bg = TitleItem.style.background.native;
        var fg = TitleItem.style.foreground.native;
        var radius = System.width / 100;
        //canvas.drawRect(0, 0, titleItem.width, titleItem.height, bg);
        canvas.drawRoundRect(0, 0, titleItem.width, titleItem.height, radius, radius, bg);
        var delta = titleItem.pressed ? Skin.pressedDelta : 0;
        if (titleItem.text.length > 0) {
            var text = titleItem.text;
            var (tw, th) = fg.measureText(text);
            th -= fg.fontDescent;
            canvas.drawText(text, (titleItem.width - tw) / 2 + delta, (titleItem.height + th) / 2 + delta, fg);
        } else if (titleItem.icon instanceof Bitmap) {

        } else if (titleItem.icon instanceof Path) {

        }
    }

    // @endregion

    // @region TabBar

    function drawTabBar(canvas, tabBar)
    {
        assert tabBar instanceof TabBar;
        var bg = TabBar.style.background.native;
        var fg = TabBar.style.foreground.native;
        canvas.drawRect(0, 0, tabBar.width, tabBar.height, bg);
    }

    function drawTabItem(canvas, tabItem)
    {
        assert tabItem instanceof TabItem;
        var bg = TabItem.style.background.native;
        var fg = TabItem.style.foreground.native;
        canvas.drawRect(0, 0, tabItem.width, tabItem.height, fg);
        var delta = tabItem.pressed ? Skin.pressedDelta : 0;
        if (tabItem.text.length > 0) {
            var text = tabItem.text;
            var (tw, th) = fg.measureText(text);
            canvas.drawText(text, (tabItem.width - tw) / 2 + delta, (tabItem.height + th) / 2 + delta, fg);
        } else if (tabItem.icon instanceof Bitmap) {

        } else if (tabItem.icon instanceof Path) {

        }
    }

    // @endregion

    // @region TextBox

    function drawTextBoxCursor(canvas, textBox)
    {
        assert textBox instanceof TextBox;
        var bg = TextBox.style.background.native;
        var fg = TextBox.style.foreground.native;
        var (left, top, right, bottom) = textBox.editor.cursorRect;
        canvas.drawRect(left, top, left, bottom, fg);
    }

    function drawTextBox(canvas, textBox)
    {
        assert textBox instanceof TextBox;
        var bg = TextBox.style.background.native;
        var fg = TextBox.style.foreground.native;
        var radius = System.width / 40;
        canvas.drawRoundRect(1, 1, textBox.width - 1, textBox.height - 1, radius, radius, bg);
        canvas.drawRoundRect(1, 1, textBox.width - 1, textBox.height - 1, radius, radius, fg);
    }

    // @endregion
}

// @region Styles

Form.style = {
    background: null
}

Control.style = {
    background: new Background({color: 0xffffffff}),
}

Button.style = {
    width: System.width / 8,
    height: System.height / 9,
    background: new Background({color: 0xff000000}),
    foreground: new Foreground({color: 0xffffffff, fontSize: System.height/30}),
    pressed: {
        background: new Background({color: 0xff000000, style:#stroke}),
        foreground: new Foreground({color: 0xff000000, fontSize: System.height/30}),
    }
}

Label.style = {
    width: System.width / 8,
    height: System.height / 9,
    background: null,
    foreground: new Foreground({color: 0xff000000, fontSize: System.height/30}),
}

ListView.style = {
    background: new Background({color: 0xffffffff}),
}

ListItem.style = {
    width: System.width / 10 * 9,
    height: System.height / 9,
    background: new Background({color: 0xffffffff}),
    foreground: new Foreground({color: 0xff000000, fontSize: System.height/30}),
    pressed: {
        background: new Background({color: 0xff000000}),
        foreground: new Foreground({color: 0xffffffff, fontSize: System.height/30}),
    }
}

TileView.style = {
    background: new Background({color: 0xffffffff}),
}

TileItem.style = {
    width: System.width / 10 * 9,
    height: System.height / 4,
    background: new Background({color: 0xff000000, style:#stroke}),
    foreground: new Foreground({color: 0xff000000, fontSize: System.height/30}),
    pressed: {
        background: new Background({color: 0xff000000}),
        foreground: new Foreground({color: 0xffffffff, fontSize: System.height/30}),
    }
}

TitleBar.style = {
    width: System.width,
    height: System.height / 9,
    padding: System.height / 75,
    background: new Background({color: 0xffffffff}),
    foreground: new Foreground({color: 0xff000000, fontSize: System.height/20}),
}

TitleItem.style = {
    width: System.width / 10,
    height:  50,//System.height / 10,
    background: new Background({color: 0xff000000, style:#stroke}),
    foreground: new Foreground({color: 0xff000000, fontSize: System.height/45, style: #stroke}),
    padding: System.width / 100
}

TabBar.style = {
    background: new Background({color: 0xffffffff}),
    foreground: new Foreground({color: 0xff000000, fontSize: System.height/20}),
}

TabItem.style = {
    background: new Background({color: 0xff000000}),
    foreground: new Foreground({color: 0xff000000, fontSize: System.height/45, style: #stroke}),
    padding: System.width / 100
}

TextBox.style = {
    height: System.height / 10,
    background: new Background({color: 0xffffffff}),
    foreground: new Foreground({color: 0xff000000, fontSize: System.height/35, style: #stroke}),
}

// @endregion
