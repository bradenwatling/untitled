package;

import flash.display.Sprite;
import flash.events.MouseEvent;
import motion.Actuate;
import openfl.Assets;

class Main extends Sprite {

    private var mSpriteAnimation:SpriteAnimation;

    public function new() {
        super();

        mSpriteAnimation = new SpriteAnimation();
        mSpriteAnimation.init(Assets.getBitmapData("assets/spritesheet_2.png"), 13, 84, 3, 12);
        mSpriteAnimation.width = 200;
        mSpriteAnimation.height = 200;
        stopMoving();

        addChild(mSpriteAnimation);

        stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
    }

    private function stopMoving() {
        mSpriteAnimation.pause();
        mSpriteAnimation.showFrame(0);
    }

    private function stage_onMouseDown(event:MouseEvent):Void {
        var distance = distance(mSpriteAnimation.x, mSpriteAnimation.y, event.stageX, event.stageY);
        Actuate.stop(mSpriteAnimation);
        Actuate.tween(mSpriteAnimation, distance / 250, { x: event.stageX - mSpriteAnimation.width / 2,
                y: event.stageY - mSpriteAnimation.height / 2 })
                .onUpdate(drawLineToMouse).onComplete(stopMoving);

        mSpriteAnimation.resume();
    }

    private function stage_onMouseMove(event:MouseEvent = null):Void {
        drawLineToMouse();
    }

    private function stage_onMouseUp(event:MouseEvent):Void {
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.removeEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
    }

    private function drawLineToMouse():Void {
        graphics.clear();
        graphics.lineStyle(2);
        graphics.beginFill(0xFFFFFF, 0.1);
        graphics.moveTo(mSpriteAnimation.x + mSpriteAnimation.width / 2, mSpriteAnimation.y + mSpriteAnimation.height / 2);
        graphics.lineTo(mouseX, mouseY);
        graphics.endFill();
    }

    private static function distance(x1:Float, y1:Float, x2:Float, y2:Float):Float {
        return Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
    }
}