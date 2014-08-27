package;

import flash.geom.Point;
import flash.events.TimerEvent;
import openfl.utils.Timer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import openfl.Assets;

class Main extends Sprite {

    private var mLevel:Level;
    private var mPlayer:SpriteAnimation;

    public function new() {
        super();

        mLevel = new Level();
        mLevel.width = width;
        mLevel.height = height;
        addChild(mLevel);

        mPlayer = new SpriteAnimation();
        mPlayer.init(Assets.getBitmapData("assets/spritesheet.png"), 13, 84, 3, 12);
        mPlayer.width = 200;
        mPlayer.height = 200;
        stopMoving();

        addChild(mPlayer);

        mPlayer.addEventListener(MouseEvent.MOUSE_DOWN, player_onMouseDown);
    }

    private function player_onMouseDown(event:MouseEvent) {
        var currentPosition = 0;
        var currentMove:Array<Point> = mLevel.mCurrentMove;
        if (currentMove != null) {
            var timer = new Timer(20);
            timer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent) {
                if (currentPosition < currentMove.length) {
                    var currentPoint = currentMove[currentPosition];
                    mPlayer.x = currentPoint.x - mPlayer.width / 2;
                    mPlayer.y = currentPoint.y - mPlayer.height / 2;
                    currentPosition++;
                } else {
                    timer.stop();
                }
            });
            timer.start();
        }
    }

    private function stopMoving() {
        mPlayer.pause();
        mPlayer.showFrame(0);
    }
}