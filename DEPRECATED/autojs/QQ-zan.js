"auto";

function scrollDown() {
  className("AbsListView").scrollable().scrollForward();
}

function zan() {
  className("ImageView").desc("赞").click();
}

function showMore() {
  for (let i = 0; i < 2; i++) {
    click("显示更多");
  }
}

toast("打开点赞页面");
sleep(100);

while (notStopped()) {
  for (let i = 0; i < 10; i++) {
    zan();
  }
  showMore();
  scrollDown();
}
