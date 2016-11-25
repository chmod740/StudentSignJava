<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- author:hupeng -->
<!-- email:hupeng AT imudges DOT com -->
<!--//                                                                          -->
<!--//                                  _oo8oo_                                 -->
<!--//                                 o8888888o                                -->
<!--//                                 88" . "88                                -->
<!--//                                 (| -_- |)                                -->
<!--//                                 0\  =  /0                                -->
<!--//                               ___/'==='\___                              -->
<!--//                             .' \\|     |// '.                            -->
<!--//                            / \\|||  :  |||// \                           -->
<!--//                           / _||||| -:- |||||_ \                          -->
<!--//                          |   | \\\  -  /// |   |                         -->
<!--//                          | \_|  ''\-&#45;&#45;/''  |_/ |                 -->
<!--//                          \  .-\__  '-'  __/-.  /                         -->
<!--//                        ___'. .'  /&#45;&#45;.&#45;&#45;\  '. .'___       -->
<!--//                     ."" '<  '.___\_<|>_/___.'  >' "".                    -->
<!--//                    | | :  `- \`.:`\ _ /`:.`/ -`  : | |                   -->
<!--//                    \  \ `-.   \_ __\ /__ _/   .-` /  /                   -->
<!--//                =====`-.____`.___ \_____/ ___.`____.-`=====               -->
<!--//                                  `=-&#45;&#45;=`                         -->
<!--//                                                                          -->
<!--//                                                                          -->
<!--//               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~               -->
<!--//                                                                          -->
<!--//                          佛祖保佑         永不宕机/永无bug               -->
<!--//                                                                          -->

<!DOCTYPE html>
<html>
<head>
<title>学工助理签到平台 V1.0</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //for-mobile-apps -->
<link href="static/css/style_register.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<!-- main -->
		<div class="main">
			<h1>学工助理签到平台-修改个人信息</h1>
			<div class="input_form">
				<form id="register_form" method="post" onkeypress="if(event.keyCode==13||event.which==13){ register();}">
                    <input type="hidden" name="type" value="teacher"/>
                    教工号（不可修改）：
                    <input readonly="readonly" placeholder="教工号" type="text" name="username" value="${teacher.username }"/>
                    姓名：
                    <input placeholder="姓名" type="text" name="name" value="${teacher.name }"/>
                    密码：
                    <input placeholder="如果不修改请留空" id="password" type="password" name="password">
                    重复密码：
                    <input placeholder="重复密码" id="re_password" type="password" name="re_password">
                    部门：
                    <input placeholder="部门" type="text" name="department" value="${teacher.department }">
				</form>
			</div>

			<div class="ckeck-bg">
				<div class="checkbox-form">
                    <div class="check-left">
							<input onclick="location='teacher'" type="submit" value="返回主页">
					</div>
					<div class="check-right">
							<input onclick="register()" type="submit" value="确认修改">
					</div>
                    <div class="clearfix"></div>
				</div>
			</div>

		</div>
		<div class="footer">
		</div>
	<!-- //main -->
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script>
        function register() {
        	var password = document.getElementById('password').value;
        	var re_password = document.getElementById('re_password').value;
        	if(password!=re_password){
        		alert("新密码输入不一致，请重新输入");
				return false;
        	}
            login_form = document.getElementById('register_form');
            login_form.submit();
        }
    </script>

</body>
</html>