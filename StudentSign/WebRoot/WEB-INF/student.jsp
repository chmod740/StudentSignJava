<%@page import="java.text.SimpleDateFormat"%>
<%@page import="me.hupeng.StudentSign.bean.Teacher"%>
<%@page import="me.hupeng.StudentSign.bean.Sign"%>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>学生助理签到平台</title>
    <link href="static/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
    <style>
        body {
            min-height: 2000px;
            padding-top: 70px;
        }
    </style>

    <script src="static/js/jquery.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/DatePicker/WdatePicker.js"></script>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">学工助理签到平台</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="change_student_info">您好！ ${name }</a></li>
                <li><a href="logout.html">退出</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>

<div class="container">

    <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h2>本次工作时长：</h2>
        <h2 id="div1">00:00:00</h2>


        <p>
        <%Sign sign = (Sign)request.getAttribute("sign"); %>
        <%int pageNumber = (Integer)request.getAttribute("page_number"); %>
        <%int pageCount = (Integer)request.getAttribute("page_count"); %>
        <%if(sign==null){ %>
            <button class="btn btn-primary btn-lg" type="button" data-toggle="modal" data-target="#myModal1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;签到&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>

        <div class="modal fade " id="myModal1" role="dialog" aria-label="myMoalLabel"
             aria-hidden="true">
            <div class="modal-dialog ">

                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h3 class="modal-title" style="color:#000">签到</h3>
                    </div>

                    <form class="form-horizontal" role="form" id="choice_teacher_form" action="sign_in" method="post">
                        <div class="form-group form-group-lg">
                            <label for="error" class="col-lg-2 control-label">请选择负责的教工</label>

                            <div class="col-lg-10 error">
                                <select id="error" class="selectpicker show-tick form-control" name="teacher_id">
                                    <%List<Teacher>teachers=(List<Teacher>)request.getAttribute("teachers"); %>
                                    <%for(Teacher teacher:teachers){ %>
                                        <option value="<%=teacher.getId() %>"><%=teacher.getName() %></option>
                                    <%} %>
                                </select>
                            </div>
                        </div>
                    </form>


                    <div class="modal-footer" ng-controller="car">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="button" id="button" class="btn btn-primary  post-change-notice" onclick="sign_in()">签到</button>
                    </div>

                </div>

            </div>
        </div>
		<%}else{ %>
        <button class="btn btn-primary btn-lg" type="button" data-toggle="modal" data-target="#myModal2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;签离&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
        <div class="modal fade bs-example-modal-lg" id="myModal2" role="dialog" aria-label="myMoalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-lg">

                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h3 class="modal-title" style="color:#000">签离</h3>
                    </div>

                    <div class="modal-body">
                        <form role="form" id="sign_off_form" action="sign_off.html" method="post">
                          <div class="form-group">
                            <textarea name="remark" class="form-control" rows="3"></textarea>
                          </div>
                        </form>

                    </div>

                    <div class="modal-footer" ng-controller="car">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="button" id="button" class="btn btn-primary post-change-notice" onclick="sign_off()">签离</button>
                    </div>

                </div>

            </div>
        </div>
        <%} %>

        </p>

    </div>

</div>


<div class="container" class="table-responsive">
    <div class="col-lg-6">
        选择指定日期：
        <div class="input-group">
            <form method="get" id="date_form">
            	<%String date = (String)request.getAttribute("date"); %>
            	
    			<%SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); %>
                <%if(date == null){ %>
                <input  name='date' id="dateinfo" type="text" class="form-control" onClick="WdatePicker()" value="<%=simpleDateFormat.format(new Date(System.currentTimeMillis()))%>">
                <%}else{ %>
                <input  name='date' id="dateinfo" type="text" class="form-control" onClick="WdatePicker()" value="<%=date%>">
                <%} %>
            </form>
            <span class="input-group-btn">
                <button class="btn btn-default" type="button" onclick="data_picked()">查询指定日期</button>
                <button class="btn btn-default" type="button" onclick="show_all()">显示全部记录</button>
            </span>
        </div><!-- /input-group -->
    </div><!-- /.col-lg-6 -->
    <table class="table table-striped table-bordered">
        <tr>
            <td>签到时间</td>
            <td>签离时间</td>
            <td>工作记录</td>
            <td>所属教工</td>
            <td>审核状态</td>
        </tr>
       	<%List<Sign>signs = (List<Sign>)request.getAttribute("signs"); %>
       	<%SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
       	<%for(Sign sign2:signs){ %>
        <tr>
            <td><%=simpleDateFormat2.format(new Date(sign2.getSignInTime().getTime())) %></td>
            <td><%=simpleDateFormat2.format(new Date(sign2.getSignOffTime().getTime())) %></td>
            <td><%=sign2.getRemark() %></td>
            <td><%=sign2.getTeacherName() %></td>
            <%if (sign2.getAudit() == 0){ %>
            <td>未审核</td>
            <% }else if(sign2.getAudit()==1){%>
            <td>审核通过</td>
            <% }else{ %>
            <td>审核不通过</td>
			<%} %>
        </tr>
        <%} %>
    </table>
    <nav>
        <ul class="pagination">
        	
            <li <% if(pageNumber==1){ %>class="disabled"<%} %> ><a href="student?page=<%=pageNumber-1 %>">&laquo;</a></li>
			<%for(int i = 0;i<pageCount;i++){ %>
            <li <%if((i+1) == pageNumber){ %>class="active"<%} %>><a href="student.html?page=<%=i+1 %>"><%=i+1 %></a></li>
            <%} %>
            <li <%if((pageNumber) == pageCount){ %>class="disabled"<%} %>><a href="student.html?page=<%=pageNumber+1 %>">&raquo;</a></li>
        </ul>
    </nav>
</div>


</body>

<script>
    function sign_in() {
        var choice_teacher_form = document.getElementById('choice_teacher_form');
        choice_teacher_form.submit();
    }
    function sign_off() {
        var sign_off_form = document.getElementById('sign_off_form');
        sign_off_form.submit();
    }
</script>
<%if(sign != null){ %>
<script>
	window.onload = function() {
		//定时器每秒调用一次fnDate()
		setInterval(function() {
			fnDate();
		}, 1000);

	}
	function myrefresh()
	{
       window.location.reload();
	}

	//js 获取当前时间
	function fnDate() {
        var start_time = <%=sign.getSignInTime().getTime()/1000%>;
        var end_time = Date.parse(new Date())/1000;
		var between = end_time - start_time;
        between = parseInt(between);
        var oDiv = document.getElementById("div1");
		var second = between % 60;
        between = between / 60;
        between = parseInt(between);
        var minite = between % 60;
        between = between / 60;
        between = parseInt(between);
        var hour = between;
        var time = '';
		if (hour < 10){
            time = '0' + hour + ':';
        }
        else{
            time = hour + ':';
        }
        if (minite < 10){
            time = time + '0' + minite + ':';
        }
        else{
            time = time + minite + ':';
        }
        if (second < 10){
            time = time + '0' + second;
        }
        else{
            time = time + second;
        }
		oDiv.innerHTML = time;
	}
	//补位 当某个字段不是两位数时补0
	function fnW(str) {
		var num;
		str >= 10 ? num = str : num = "0" + str;
		return num;
	}
</script>
<%} %>
<script>
    function data_picked() {
        var date_form = document.getElementById('date_form');
        date_form.submit();
    }
    function show_all() {
        window.location.href="student.html";
    }
</script>
</html>
