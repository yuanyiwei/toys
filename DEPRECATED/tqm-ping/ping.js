// ==UserScript==
// @name         ping
// @namespace    https://yyw.moe/
// @version      0.1
// @description  ping in USTC tqm.
// @author       totoro
// @match        https://tqm.ustc.edu.cn/*
// @icon         none
// @grant        none
// @run-at document-end
// ==/UserScript==

// goto https://passport.ustc.edu.cn/login?service=http://tqm.ustc.edu.cn/

(function () {
  "use strict";
  document.body.oncontextmenu = "";

  function ping() {
    document
      .querySelectorAll('.ant-radio-input[value="1"]')
      .forEach((ele) => ele.click());
    setTimeout(() => {
      document.querySelector(".ant-btn-primary").click();
    }, 100);
  }

  var pingBtn = document.createElement("pingBTN");
  pingBtn.innerText = "一键评价";
  pingBtn.onclick = function () {
    ping();
    // alert("!");
  };
  document.querySelector("#root").appendChild(pingBtn);
})();
