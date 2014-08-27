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
    private var mPlayerMoveTimer:Timer;

    public function new() {
        super();

        mLevel = new Level();
        mLevel.width = width;
        mLevel.height = height;
        addChild(mLevel);

        mPlayer = new SpriteAnimation();
        mPlayer.init(Assets.getBitmapData("assets/spritesheet.png"), 13, 84, 3, 12);
        mPlayer.width = 100;
        mPlayer.height = 100;
        stopMoving();

        addChild(mPlayer);

        mPlayer.addEventListener(MouseEvent.MOUSE_DOWN, player_onMouseDown);
    }

    private function player_onMouseDown(event:MouseEvent) {
        var currentPosition = 0;
        var currentMove:Array<Point> = mLevel.mCurrentMove;
        if (currentMove != null) {
            mPlayer.resumeAnimation();
            if (mPlayerMoveTimer != null) {
                mPlayerMoveTimer.stop();
            }
            mPlayerMoveTimer = new Timer(30);
            mPlayerMoveTimer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent) {
                if (currentPosition < currentMove.length) {
                    var currentPoint = currentMove[currentPosition];
                    mPlayer.x = currentPoint.x - mPlayer.width / 2;
                    mPlayer.y = currentPoint.y - mPlayer.height / 2;
                    currentPosition++;
                } else {
                    mPlayerMoveTimer.stop();
                    stopMoving();
                }
            });
            mPlayerMoveTimer.start();
        }
    }

    private function stopMoving() {
        mPlayer.pauseAnimation();
        mPlayer.showFrame(0);
    }
}