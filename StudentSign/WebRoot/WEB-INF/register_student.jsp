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
			<h1>学工助理签到平台-助理注册</h1>
			<div class="input_form">
				<form id="register_form" method="post" onkeypress="if(event.keyCode==13||event.which==13){ register();}">
                    <input type="hidden" name="type" value="student"/>
                    <input placeholder="学号" type="text" name="username"/>
                    <input placeholder="姓名" type="text" name="name"/>
                    <select name="gender">
                        <option value="">请选择性别</option>
			            <option value="1">男</option>
                        <option value="2">女</option>
    	            </select>
                    <input placeholder="密码" type="password" name="password" >
                    <input placeholder="重复密码" type="password" name="re_password">
                    <select name="college" value="请选择学院">
                        <option selected="selected" value="">请选择学院</option>
                        <option value="蒙古学学院">蒙古学学院</option>
                        <option value="民族学与社会学学院">民族学与社会学学院</option>
                        <option value="文学与新闻传播学院">文学与新闻传播学院</option>
                        <option value="历史与旅游文化学院">历史与旅游文化学院</option>
                        <option value="哲学学院">哲学学院</option>
                        <option value="经济管理学院">经济管理学院</option>
                        <option value="法学院">法学院</option>
                        <option value="外国语学院">外国语学院</option>
                        <option value="公共管理学院">公共管理学院</option>
                        <option value="马克思主义学院">马克思主义学院</option>
                        <option value="数学科学学院">数学科学学院</option>
                        <option value="电子信息工程学院">电子信息工程学院</option>
                        <option value="化学化工学院">化学化工学院</option>
                        <option value="生命科学学院">生命科学学院</option>
                        <option value="环境与资源学院">环境与资源学院</option>
                        <option value="计算机学院(软件学院)">计算机学院(软件学院)</option>
                        <option value="继续教育学院">继续教育学院</option>
                        <option value="国际教育学院">国际教育学院</option>
                        <option value="艺术学院">艺术学院</option>
                        <option value="交通学院">交通学院</option>
                        <option value="创业学院">创业学院</option>
                        <option value="体育教学部">体育教学部</option>
                        <option value="预科">预科</option>
    	            </select>
                    <input placeholder="电话" type="text" name="phone">
                    <input placeholder="微信" type="text" name="weixin">
                    <input placeholder="QQ" type="text" name="qq">
                    <input placeholder="工作地点" type="text" name="work_location">
                    <input placeholder="工作性质" type="text" name="work_character">
				</form>
			</div>

			<div class="ckeck-bg">
				<div class="checkbox-form">
                    <div class="check-left">
							<input onclick="location='register_teacher'" type="submit" value="教工注册">
					</div>
					<div class="check-right">
							<input onclick="register()" type="submit" value="注册">
					</div>
                    <div class="clearfix"></div>
				</div>
			</div>
            <div class="ckeck-bg">
				<p><a href="login">&lt;&lt;&lt;返回登录界面</a></p>
			</div>
		</div>
		<div class="footer">
		</div>
	<!-- //main -->
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script>
        function register() {
            login_form = document.getElementById('register_form');
            login_form.submit();
        }
    </script>
    <%String msg = (String)request.getAttribute("msg");%>
    <%if(msg!=null) {%>
        <script>
            alert('${msg}');
            history.back(-1);
        </script>
    <%} %>

</body>
</html>