package;

import flash.display.Bitmap;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import openfl.events.TimerEvent;
import openfl.geom.Point;
import openfl.utils.Timer;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import flash.display.Sprite;

class SpriteAnimation extends Sprite {

    private var mFrames:Array<Bitmap>;
    private var mHorizontalFrames:Int;
    private var mVerticalFrames:Int;
    private var mCurrentIndex:Int;
    private var mFirstIndex:Int;
    private var mLastIndex:Int;
    private var mHorizontal:Bool;
    private var mPaused:Bool = true;
    private var mTimer:Timer;

    public function init(image:BitmapData, horizontalFrames:Int, verticalFrames:Int,
                         firstFrame:Int, lastFrame:Int, fps:Float = 15, horizontal:Bool = true,
                         frameWidth:Int = -1, frameHeight:Int = -1) {
        mFrames = new Array<Bitmap>();
        mHorizontalFrames = horizontalFrames;
        mVerticalFrames = verticalFrames;
        mCurrentIndex = firstFrame;
        mFirstIndex = firstFrame;
        mLastIndex = lastFrame;
        mHorizontal = horizontal;

        if (frameWidth == -1) {
            frameWidth = Std.int(image.width / mHorizontalFrames);
        }
        if (frameHeight == -1) {
            frameHeight = Std.int(image.height / mVerticalFrames);
        }
        var target = new Point(0, 0);

        var i = 0;
        while(i < mHorizontalFrames * mVerticalFrames) {
            var frame = new BitmapData(frameWidth, frameHeight);
            var x = Std.int(mHorizontal ? i % mHorizontalFrames : i / mVerticalFrames);
            var y = Std.int(mHorizontal ? i / mHorizontalFrames : i % mVerticalFrames);
            frame.copyPixels(image, new Rectangle(x * frameWidth, y * frameHeight,
                    frameWidth, frameHeight), target);
            mFrames[i] = new Bitmap(frame);
            i++;
        }

        showFrame(mFirstIndex);
        mTimer = new Timer(1000 / fps);
        mTimer.addEventListener(TimerEvent.TIMER, update);
        mTimer.start();
    }

    public function modifyBounds(firstFrame:Int, lastFrame:Int) {
        mFirstIndex = firstFrame;
        mLastIndex = lastFrame;
    }

    public function pause() {
        mPaused = true;
    }

    public function resume() {
        mPaused = false;
    }

    public function stop() {
        mTimer.stop();
    }

    public function showFrame(index:Int) {
        removeChildren(0, numChildren - 1);
        addChild(mFrames[index]);
    }

    public function showFrameAt(x:Int, y:Int) {
        showFrame(getIndex(x, y));
    }

    private function getIndex(x:Int, y:Int):Int {
        return mHorizontal ? y * mHorizontalFrames + x : x * mVerticalFrames + y;
    }

    private function update(event:TimerEvent):Void {
        if (!mPaused) {
            mCurrentIndex++;
            if (mCurrentIndex > mLastIndex) {
                mCurrentIndex = mFirstIndex;
            }

            showFrame(mCurrentIndex);
        }
    }
}