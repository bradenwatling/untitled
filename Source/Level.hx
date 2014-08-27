package;

import openfl.events.Event;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.display.Sprite;

class Level extends Sprite {

    public var mCurrentMove:Array<Point>;

    public function new() {
        super();

        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(event:Event) {
        removeEventListener(Event.ADDED_TO_STAGE, init);
        stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);
    }

    private function draw() {
        graphics.clear();
        graphics.lineStyle(2);
        graphics.beginFill(0xFFFFFF, 0.1);
        var i:Int = 1;
        var current:Point, previous:Point;
        while (i < mCurrentMove.length) {
            previous = mCurrentMove[i - 1];
            current = mCurrentMove[i];
            graphics.moveTo(previous.x, previous.y);
            graphics.lineTo(current.x, current.y);
            i++;
        }
        graphics.endFill();
    }

    private function stage_onMouseDown(event:MouseEvent):Void {
        stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);

        mCurrentMove = new Array<Point>();
        draw();
    }

    private function stage_onMouseMove(event:MouseEvent):Void {
        mCurrentMove.push(new Point(event.stageX, event.stageY));
        draw();
    }

    private function stage_onMouseUp(event:MouseEvent):Void {
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.removeEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
    }
}