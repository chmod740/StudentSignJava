
<%@ page import="me.hupeng.StudentSign.bean.Student"%>
<%@ page import="me.hupeng.StudentSign.bean.Teacher"%>
<%@ page import="me.hupeng.StudentSign.bean.Sign"%>
<%@ page import="java.text.SimpleDateFormat"%>
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

<%Integer pageNumber = (Integer)request.getAttribute("page_number"); %>
<%Integer pageCount =(Integer)request.getAttribute("page_count");%>
<%SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%List<Sign>signs = (List<Sign>)request.getAttribute("signs"); %>
<%SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat("yyyy-MM-dd"); %>
<%String date = (String)request.getAttribute("date"); %>
<%if(date == null){ %>
<%date = simpleDateFormat2.format(new Date(System.currentTimeMillis())); %>
<%} %>
<!DOCTYPE html>
<html lang="en">
<head>
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
                <li><a href="change_teacher_info">您好！${name }</a></li>
                <li><a href="logout">退出</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col-lg-6">
            选择指定日期：
            <div class="input-group">
                <form method="get" id="date_form">
                    <input name='date' id="dateinfo" type="text" class="form-control" onClick="WdatePicker()" value="<%=date%>">
                </form>
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" onclick="data_picked()">查询指定日期</button>
                    <button class="btn btn-default" type="button" onclick="show_all()">显示全部记录</button>
                </span>
            </div><!-- /input-group -->
        </div><!-- /.col-lg-6 -->
        <div class="col-lg-6 right">
            <br>
            <div class="input-group">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" onclick="show_all()">显示所有</button>
                 </span>
                <span class="input-group-btn">
                    <button class="btn btn-default" onclick="search_stu_num()" type="button">搜索</button>
                </span>
                <form method="get" id="stu_num_form">
                    <input type="text" class="form-control" name="stu_num" placeholder="请输入要搜索的学号">
                </form>
            </div><!-- /input-group -->
        </div><!-- /.col-lg-6 -->
    </div>
</div>


<div class="container" style="margin-top: 20px;">
    <table class="table table-bordered table-striped">
        <tr>
            <td>学号</td>
            <td>姓名</td>
            <td>签到时间</td>
            <td>签离时间</td>
            <td>工作时长</td>
            <td>工作记录</td>
            <td>审核状态</td>
        </tr>
        <%for(Sign sign:signs){ %>
            <tr>
                <td><a href="" data-toggle="modal" data-target="#Modal<%=sign.getId()%>"><%=sign.getStudent().getUsername() %></a></td>
                <div class="modal fade bs-example-modal-lg" id="Modal<%=sign.getId()%>" role="dialog"
                     aria-label="myMoalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog ">

                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h3 class="modal-title" style="color:#000">学工助理个人信息</h3>
                            </div>

                            <div class="modal-body">
                                <p>学号：<%=sign.getStudent().getUsername() %></p>
                                <p>姓名：<%=sign.getStudent().getName() %></p>
                                <p>性别：<%if(sign.getStudent().getGender()==1) {%>男<%}else{ %>女<%} %></p>
                                <p>学院：<%=sign.getStudent().getCollege() %></p>
                                <p>电话：<%=sign.getStudent().getPhone() %></p>
                                <p>微信：<%=sign.getStudent().getWeixin() %></p>
                                <p>QQ：<%=sign.getStudent().getQq() %></p>
                                <p>工作地点：<%=sign.getStudent().getWorkLocation() %></p>
                                <p>工作性质：<%=sign.getStudent().getWorkCharacter() %></p>
                            </div>

                            <div class="modal-footer" ng-controller="car">
                                <button type="button" class="btn btn-primary"
                                        data-dismiss="modal">关闭
                                </button>
                            </div>

                        </div>

                    </div>
                </div>
                <td><%=sign.getStudent().getName() %></td>
                <td><%=simpleDateFormat.format(new Date(sign.getSignInTime().getTime())) %></td>
                <td><%if(sign.getSignOffTime().getTime()==0){ %>未签离<%} else{%><%=simpleDateFormat.format(new Date(sign.getSignOffTime().getTime())) %><%} %></td>
                <td><%=sign.getTimeDiff() %></td>
                <td><a href="" data-toggle="modal" data-target="#myModal<%=sign.getId()%>">工作记录</a></td>
                <div class="modal fade bs-example-modal-lg" id="myModal<%=sign.getId()%>" role="dialog"
                     aria-label="myMoalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog modal-lg">

                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h3 class="modal-title" style="color:#000">工作记录</h3>
                            </div>

                            <div class="modal-body">
                                <div class="jumbotron">
                                    <h3><%=sign.getRemark()%></h3>
                                </div>
                            </div>

                            <div class="modal-footer" ng-controller="car">
                                <button type="button" class="btn btn-primary"
                                        data-dismiss="modal">关闭
                                </button>
                            </div>

                        </div>

                    </div>
                </div>


                <td>
                    <button class="btn btn-primary" data-toggle="modal" data-target="#buttonModal<%=sign.getId()%>"><%if(sign.getAudit()==0){ %>未审核<%} %><%if(sign.getAudit()==1){ %>审核通过<%} %><%if(sign.getAudit()==2){ %>审核未通过<%} %></button>
                </td>
                <div class="modal fade bs-example-modal-lg" id="buttonModal<%=sign.getId()%>" role="dialog" aria-label="myMoalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog ">

                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h3 class="modal-title" style="color:#000">审核情况</h3>
                            </div>

                            <div class="modal-body">
                                <div align="center">
                                    <button type="button" onclick="audit_success(<%=sign.getId()%>)" class="btn btn-danger btn-lg" data-dismiss="modal">审核通过
                                    </button>
                                    <button type="button" onclick="audit_fail(<%=sign.getId()%>)" class="btn btn-danger btn-lg" data-dismiss="modal">审核未通过
                                    </button>
                                </div>
                            </div>

                            <div class="modal-footer" ng-controller="car">

                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            </div>

                        </div>

                    </div>
                </div>
            </tr>
        <%} %>


    </table>
    <nav>
        <ul class="pagination">
            <li <% if(pageNumber==1){ %>class="disabled"<%} %> ><a href="teacher?page=<%=pageNumber-1 %>">&laquo;</a></li>
			<%for(int i = 0;i<pageCount;i++){ %>
            <li <%if((i+1) == pageNumber){ %>class="active"<%} %>><a href="teacher?page=<%=i+1 %>"><%=i+1 %></a></li>
            <%} %>
            <li <%if((pageNumber) == pageCount){ %>class="disabled"<%} %>><a href="teacher?page=<%=pageNumber+1 %>">&raquo;</a></li>
        </ul>
    </nav>
</div>
<script>
    function data_picked() {
        var date_form = document.getElementById('date_form');
        date_form.submit();
    }
    function show_all() {
        window.location.href = "teacher";
    }
    function search_stu_num() {
        var date_form = document.getElementById('stu_num_form');
        date_form.submit();
    }
    function audit_success(id) {
        if (window.confirm('确认通过审核？')) {
            window.location.href = "audit?action=audit_success&id=" + id;
        }
    }
    function audit_fail (id) {
        if (window.confirm('确认不通过审核？')) {
            window.location.href = "audit?action=audit_fail&id=" + id;
        }
    }
</script>

</body>
</html>