<%--
  Created by IntelliJ IDEA.
  User: Jack
  Date: 2017/7/25
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>文件上传</title>

    <style type="text/css">
      *{margin: 0px; padding:0px;}
      h1 {
        text-align: center;
        text-shadow: 1px 1px 1px #555;
        border-bottom: 2px dashed #000;
        margin-bottom: 20px;
      }
      .box {
        width: 50%;
        margin: 100px auto;
        box-shadow: 3px 3px 5px #000;
        padding: 20px;
        text-align: center;
      }
      a {
        text-decoration: none;
        background: #467890;
        color: #fff;
        padding: 5px 5px;
        box-shadow: 1px 1px 3px #000;
      }
      a:hover {
        padding:6px 6px;
      }
      ul {
        list-style: none;
        border-bottom: 1px solid #607D8B;
      }
      ul:nth-child(odd) {
        background: #bbbfc1;
      }
      ul:after {
        clear: both;
        content: '';
        display: block;
      }
      li {
        float: left;
      }

      .fileList {
        margin-top:20px;
      }
    </style>
  </head>
  <body>
    <div class="box">
      <h1>文件上传系统</h1>
      <input type="file" multiple onchange="change(this)" style="display: none" id="files"/>
      <a href="javascript:void(0)" onclick="chooseFile()">上传文件</a>
      <div class="fileList" id="fileList">
        <ul>
          <li style="width: 30%;">文件名</li>
          <li style="width: 69%;">上传进度</li>
        </ul>
      </div>
    </div>
    <script type="text/javascript">
      function chooseFile() {
        var file = document.getElementById("files");
        file.click();
      }
      function change(fileInput) {
        var html = "";
        var fileList = document.getElementById("fileList");
        var files = fileInput.files;
        for(var i=0;i<files.length;i++) {
          html += "<ul><li style='width:30%;'>"+files[i].name+"</li><li style='width: 69%;'><progress max='100' value='0' id='prog"+i+"'></progress><span id='label"+i+"'></span></li></ul>";
          upload(files[i],i);
        }
        fileList.innerHTML += html;
      }
      function upload(file,index) {
        var formData = new FormData();
        formData.append(file.name,file);
        var xhr = new XMLHttpRequest();
        var oldLoaded = 0;
        var curLoaded = 0;
        var total = 0;
        xhr.upload.addEventListener("progress",function (event) {
          var prog = document.getElementById("prog"+index);
          var percent = Math.round(event.loaded/event.total*100);
          curLoaded = event.loaded;
          prog.value = percent;
          if(oldLoaded==0) {
            total = event.total;
          }
        },false);
        var interval = setInterval(function () {
          var label = document.getElementById("label"+index);
          var speed = Math.round((curLoaded-oldLoaded)/1024/1024*100)/100;
          var left = Math.round((total-curLoaded)/1024/1024/speed);
          label.innerHTML = " " + speed + " M/s 剩余" + left + " 秒";
          oldLoaded = curLoaded;
        },1000);
        xhr.open("post","upload.do",true);
        xhr.send(formData);
      }
    </script>
  </body>
</html>
