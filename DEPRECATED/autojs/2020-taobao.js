auto.waitFor();
var height = device.height;
var width = device.width;
// toast("\n设备宽" + width + "\n" + "设备高" + height + "\n" + "手机型号" + device.model + "\n安卓版本" + device.release);
if (height == 1920) {
  //设置脚本坐标点击所适合的屏幕宽高。
  setScreenMetrics(1080, 1920);
  toast("设备高" + height);
} else if (height == 2340) {
  setScreenMetrics(1080, 2340);
  toast("设备高" + height);
}

click(547, 1264); //点猫 领金币

//浏览15秒领金币
sleep(1500 + random(0, 500));
click(911, 1716);

sleep(1500 + random(0, 500));
if (text("签到").exists()) {
  text("签到").findOne().click();
  sleep(1000 + random(0, 500));
  toast("签到成功");
}
while (text("去进店").exists()) {
  sleep(2000 + random(0, 1000));
  toast("存在去进店");
  text("去进店").findOne().click();
  SLEEP();
  back();
  sleep(2000 + random(0, 1000));
}
while (text("去浏览").exists()) {
  sleep(2000 + random(0, 1000));
  toast("存在去浏览");
  text("去浏览").findOne().click();
  SLEEP();
  back();
  sleep(2000 + random(0, 1000));
}
toast("结束");

function SLEEP() {
  sleep(4000 + random(0, 500));
  randomSwipe(
    width / 4 + random(0, width / 2),
    height / 2 + random(0, height / 3),
    width / 4 + random(0, width / 2),
    height / 5 + random(0, height / 3)
  );
  sleep(2000 + random(0, 500));
  randomSwipe(
    width / 4 + random(0, width / 2),
    height / 2 + random(0, height / 3),
    width / 4 + random(0, width / 2),
    height / 5 + random(0, height / 3)
  );
  sleep(2000 + random(0, 500));
  randomSwipe(
    width / 4 + random(0, width / 2),
    height / 2 + random(0, height / 3),
    width / 4 + random(0, width / 2),
    height / 5 + random(0, height / 3)
  );
  sleep(2000 + random(0, 500));
  randomSwipe(
    width / 4 + random(0, width / 2),
    height / 2 + random(0, height / 3),
    width / 4 + random(0, width / 2),
    height / 5 + random(0, height / 3)
  );
  sleep(2000 + random(0, 500));
  randomSwipe(
    width / 4 + random(0, width / 2),
    height / 2 + random(0, height / 3),
    width / 4 + random(0, width / 2),
    height / 5 + random(0, height / 3)
  );
  sleep(2000 + random(0, 500));
  randomSwipe(
    width / 4 + random(0, width / 2),
    height / 2 + random(0, height / 3),
    width / 4 + random(0, width / 2),
    height / 5 + random(0, height / 3)
  );
  sleep(2000 + random(0, 500));
}

function bezierCreate(x1, y1, x2, y2, x3, y3, x4, y4) {
  var h = 100;
  var cp = [
    { x: x1, y: y1 + h },
    { x: x2, y: y2 + h },
    { x: x3, y: y3 + h },
    { x: x4, y: y4 + h },
  ];
  var numberOfPoints = 100;
  var curve = [];

  var dt = 1.0 / (numberOfPoints - 1);
  for (var i = 0; i < numberOfPoints; i++) {
    var ax, bx, cx;
    var ay, by, cy;
    var tSquared, tCubed;
    var result_x, result_y;

    cx = 3.0 * (cp[1].x - cp[0].x);
    bx = 3.0 * (cp[2].x - cp[1].x) - cx;
    ax = cp[3].x - cp[0].x - cx - bx;
    cy = 3.0 * (cp[1].y - cp[0].y);
    by = 3.0 * (cp[2].y - cp[1].y) - cy;
    ay = cp[3].y - cp[0].y - cy - by;

    var t = dt * i;
    tSquared = t * t;
    tCubed = tSquared * t;
    result_x = ax * tCubed + bx * tSquared + cx * t + cp[0].x;
    result_y = ay * tCubed + by * tSquared + cy * t + cp[0].y;
    curve[i] = { x: result_x, y: result_y };
  }

  var array = [];
  for (var i = 0; i < curve.length; i++) {
    try {
      var j = i < 100 ? i : 199 - i;
      xx = parseInt(curve[j].x);
      yy = parseInt(Math.abs(100 - curve[j].y));
    } catch (e) {
      break;
    }
    array.push([xx, yy]);
  }
  return array;
}

function randomSwipe(sx, sy, ex, ey) {
  //设置随机滑动时长范围
  var timeMin = 500;
  var timeMax = 2000;
  //设置控制点极限距离
  var leaveHeightLength = 500;

  if (Math.abs(ex - sx) > Math.abs(ey - sy)) {
    var my = (sy + ey) / 2;
    var y2 = my + random(0, leaveHeightLength);
    var y3 = my - random(0, leaveHeightLength);

    var lx = (sx - ex) / 3;
    if (lx < 0) {
      lx = -lx;
    }
    var x2 = sx + lx / 2 + random(0, lx);
    var x3 = sx + lx + lx / 2 + random(0, lx);
  } else {
    var mx = (sx + ex) / 2;
    var x2 = mx + random(0, leaveHeightLength);
    var x3 = mx - random(0, leaveHeightLength);

    var ly = (sy - ey) / 3;
    if (ly < 0) {
      ly = -ly;
    }
    var y2 = sy + ly / 2 + random(0, ly);
    var y3 = sy + ly + ly / 2 + random(0, ly);
  }

  var time = random(timeMin, timeMax);
  var track = bezierCreate(sx, sy, x2, y2, x3, y3, ex, ey);
  /*
        log("控制点A坐标：" + x2 + "," + y2)
        log("控制点B坐标：" + x3 + "," + y3)
        log("滑动时长：" + time[1])
    */
  gesture(time, track);
}
