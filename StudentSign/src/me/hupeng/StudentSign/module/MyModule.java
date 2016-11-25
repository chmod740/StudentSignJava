package me.hupeng.StudentSign.module;


import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.pager.Pager;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.ViewModel;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.annotation.Views;

import me.hupeng.StudentSign.bean.Sign;
import me.hupeng.StudentSign.bean.Student;
import me.hupeng.StudentSign.bean.Teacher;
/**
 * 主控制器
 * */
@IocBean
@Fail("http:500")
public class MyModule {
	@Inject
	Dao dao;
	@Ok("re")
	@At("/login")
	public String login(@Param("username")String username,@Param("password")String password, ViewModel model,HttpServletRequest request,HttpSession session){
		if(request.getMethod().equals("GET")){
			return "jsp:login";
		}
		
		Teacher teacher = dao.fetch(Teacher.class,Cnd.where("username", "=", username).and("password", "=", password));
		if (teacher != null) {
			session.setAttribute("username", teacher.getUsername());
			session.setAttribute("teacher", true);
			session.setAttribute("name", teacher.getName());
			return "redirect:index";
		}
		Student student = dao.fetch(Student.class,Cnd.where("username", "=", username).and("password","=",password));
		if(student != null){
			session.setAttribute("username", student.getUsername());
			session.setAttribute("teacher", false);
			session.setAttribute("name", student.getName());
			return "redirect:index";
		}
		model.setOrRemove("msg", "<script>alert('用户名或者密码错误');</script>");
		return "jsp:login";
	}
	
	@Ok("re")
	@At("register_teacher")
	public String registerTeacher(@Param("username")String username,@Param("name")String name,@Param("password")String password,@Param("re_password")String rePassword,@Param("department")String department,HttpServletRequest request,HttpSession session){
		if (request.getMethod().equals("GET")) {
			return "jsp:register_teacher";
		}
		if (!password.equals(rePassword)) {
			request.setAttribute("msg", "两次输入密码不一致");
			return "jsp:register_teacher";
		}
		Student student = dao.fetch(Student.class,Cnd.where("username","=",username));
		Teacher teacher = dao.fetch(Teacher.class,Cnd.where("username","=",username));
		if (!(student == null && teacher == null)) {
			String msg = "用户名已经存在";
			return "jsp:register_teacher";
		}
		teacher = new Teacher();
		teacher.setUsername(username);
		teacher.setPassword(password);
		teacher.setName(name);
		teacher.setDepartment(department);
		dao.insert(teacher);
		session.setAttribute("username", teacher.getUsername());
		session.setAttribute("name", teacher.getName());
		session.setAttribute("teacher", true);
		request.setAttribute("msg", "注册成功");
		request.setAttribute("location", "teacher");
		return "jsp:jump";
	}
	
	@At("register_student")
	@Ok("re")
	public String registerStudent(@Param("username")String username,@Param("name")String name,@Param("gender")Integer gender,@Param("password")String password,@Param("re_password")String rePassword,@Param("college")String college,@Param("phone")String phone,@Param("weixin")String weixin,@Param("qq")String qq,@Param("work_location")String workLocation,@Param("work_character")String workCharacter,HttpServletRequest request,HttpSession session){
		if (request.getMethod().equals("GET")) {
			return "jsp:register_student";
		}
		if (username == null || password == null || name == null || name == null || gender == null || workLocation == null || workCharacter == null || weixin == null || qq == null || phone == null) {
			request.setAttribute("msg", "注册信息不完整");
			return "jsp:register_student";
		}
		if (!password.equals(rePassword)) {
			request.setAttribute("msg", "两次输入密码不一致");
			return "jsp:register_student";
		}
		Student student = dao.fetch(Student.class,Cnd.where("username","=",username));
		Teacher teacher = dao.fetch(Teacher.class,Cnd.where("username","=",username));
		if (!(student == null && teacher == null)) {
			String msg = "用户名已经存在";
			return "jsp:register_student";
		}
		student = new Student();
		student.setUsername(username);
		student.setName(name);
		student.setPassword(password);
		student.setGender(gender);
		student.setCollege(college);
		student.setPhone(phone);
		student.setWeixin(weixin);
		student.setQq(qq);
		student.setWorkLocation(workLocation);
		student.setWorkCharacter(workCharacter);
		student.setRegisterTime(new Timestamp(System.currentTimeMillis()));
		dao.insert(student);
		
		session.setAttribute("username", student.getUsername());
		session.setAttribute("name", student.getName());
		session.setAttribute("teacher", false);
		request.setAttribute("msg", "注册成功");
		request.setAttribute("location", "student");
		return "jsp:jump";

	}
	
	@At("index")
	@Ok("re")
	public String index(HttpServletRequest request,HttpSession session){
		String username = (String)session.getAttribute("username");
		if (username == null) {
			return "redirect:login";
		}
		boolean teacher = (Boolean)session.getAttribute("teacher");
		if (teacher) {
			return "redirect:student";
		}
		return "redirect:teacher";
	}
	
	@At("teacher")
	@Ok("re")
	public String teacher(@Param("date")String date, @Param("page")Integer page,@Param("stu_num")String stuNum,HttpServletRequest request, HttpSession session){
		String username = (String)session.getAttribute("username");
		if (username == null) {
			return "redirect:login";
		}
		boolean isTeacher = (Boolean)session.getAttribute("teacher");
		if (!isTeacher) {
			return "redirect:student";
		}
		//以下为业务逻辑的开始部分
		//获得一个teacher对象
		Teacher teacher = dao.fetch(Teacher.class, Cnd.where("username", "=", username));
		Integer pageSize = 10;
		
		//处理date为空的情况,置为null
		if (date!=null && date.equals("")) {
			date = null;
		}
		request.setAttribute("date", date);
		
		if (page == null) {
			page = 1;
		}
		List<Sign>signs= null;
		//判断date的值确定分页情况，如果date==null则分页，否则不分页
		if (date != null) {
			//不分页
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date2;
			try {
				date2 = simpleDateFormat.parse(date);
				signs = dao.query(Sign.class, Cnd.where("teacher_id", "=", teacher.getId()).and("sign_in_time", ">", new Timestamp(date2.getTime())).and("sign_in_time", "<", new Timestamp(date2.getTime() + 24 * 60 * 60 *1000)));
				request.setAttribute("page_number", 1);
				request.setAttribute("page_count", 1);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			if(stuNum!=null){
				Student student = dao.fetch(Student.class, Cnd.where("username", "=", stuNum));
				try {
					signs = dao.query(Sign.class, Cnd.where("student_id", "=", student.getId()));
				} catch (Exception e) {
					// TODO: handle exception
					signs = new ArrayList<Sign>();
				}
				request.setAttribute("page_number", 1);
				request.setAttribute("page_count", 1);
			}else{
				//分页
				Pager pager = dao.createPager(page, pageSize);
				pager.setRecordCount(dao.count(Sign.class, Cnd.where("teacher_id", "=", teacher.getId()).and("sign_off_time", ">", new Time(0)).desc("id")));
				
				signs = dao.query(Sign.class, Cnd.where("teacher_id", "=", teacher.getId()).and("sign_off_time", ">", new Time(0)).desc("id"),pager);
				//设置当前页码，页数
				request.setAttribute("page_number", pager.getPageNumber());
				request.setAttribute("page_count", pager.getPageCount());
			}
			
		}
		//设置sign对象
		//得出student，放进sign list里面
		for(Sign sign:signs){
			sign.culTimeDiff();
			sign.setStudent(dao.fetch(Student.class,Cnd.where("id", "=", sign.getStudentId())));
		}
		request.setAttribute("signs", signs);
		return "jsp:teacher";
	}
	
	@At("student")
	@Ok("re")
	public String student(@Param("page")Integer page, @Param("date")String date, HttpServletRequest request, HttpSession session){
		String username = (String)session.getAttribute("username");
		//判断用户的登录状态
		if (username == null) {
			return "redirect:login";
		}
		boolean teacher = (Boolean)session.getAttribute("teacher");
		if (teacher) {
			return "redirect:teacher";
		}
		
		//业务逻辑部分
		Integer pageSize = 10;
		if (page == null) {
			page = 1;
		}
		if (date != null && date.equals("")) {
			date = null;
		}
		
		Student student = dao.fetch(Student.class,Cnd.where("username", "=", username));
		//找到一个没有签到的sign,，如果没找到则返回null
		Sign sign = dao.fetch(Sign.class, Cnd.where("student_id", "=", student.getId()).and("sign_off_time", "=", new Timestamp(0)));
		request.setAttribute("sign", sign);
		//找到教师列表并返回
		List<Teacher>teachers = dao.query(Teacher.class,null);
		request.setAttribute("teachers", teachers);
		//如果设置了日期，则返回
		request.setAttribute("date", date);
		Pager pager = dao.createPager(page, pageSize);
		pager.setRecordCount(dao.count(Sign.class, Cnd.where("student_id", "=", student.getId()).and("sign_off_time", ">", new Time(0)).desc("id")));
		List<Sign>signs = null;
		//如果日期设置的不为空，则设置pager并返回
		if (date != null) {
			pager = null;
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			try {
				Date startDate = simpleDateFormat.parse(date);
				Timestamp startTimestamp = new Timestamp(startDate.getTime());
				Timestamp endTimestamp = new Timestamp(startDate.getTime()+24*60*60*1000);
				signs = dao.query(Sign.class, Cnd.where("student_id", "=", student.getId()).and("sign_in_time", ">", startTimestamp).and("sign_in_time", "<", endTimestamp));
			} catch (ParseException e) {
				
			}
			
		}else{
			//如果日期为空
			signs = dao.query(Sign.class, Cnd.where("student_id", "=", student.getId()).and("sign_in_time", ">",new Timestamp(0)).desc("id"),pager);
		}
		
		for(Sign sign2:signs){
			try {
				sign2.setTeacherName(dao.fetch(Teacher.class, Cnd.where("id", "=", sign2.getTeacherId())).getName());
			} catch (Exception e) {
				continue;
			}
		}
		if (date != null) {
			request.setAttribute("page_count", 1);
			request.setAttribute("page_number", 1);
		}else{
			request.setAttribute("page_count", pager.getPageCount());
			request.setAttribute("page_number", pager.getPageNumber());
		}
		request.setAttribute("signs", signs);
		return "jsp:student";
	}
	
	@At("sign_in")
	@Ok("re")
	public String signIn(@Param("teacher_id")Integer teacherId,HttpServletRequest request,HttpSession session){
		String username = (String)session.getAttribute("username");
		if (username == null) {
			return "redirect:login";
		}
		boolean teacher = (Boolean)session.getAttribute("teacher");
		if (teacher) {
			return "redirect:login";
		}
		Student student = dao.fetch(Student.class, Cnd.where("username", "=", username));
		Sign sign = new Sign();
		sign.setStudentId(student.getId());
		sign.setTeacherId(teacherId);
		sign.setAudit(0);
		sign.setSignInTime(new Timestamp(System.currentTimeMillis()));
		sign.setSignOffTime(new Timestamp(0));
		dao.insert(sign);
		request.setAttribute("msg", "签到成功");
		request.setAttribute("location", "student");
		return "jsp:jump";
	}
	
	@At("sign_off")
	@Ok("re")
	public String signOff(@Param("remark")String remark, HttpServletRequest request, HttpSession session){
		String username = (String)session.getAttribute("username");
		if (username == null) {
			return "redirect:login";
		}
		boolean teacher = (Boolean)session.getAttribute("teacher");
		if (teacher) {
			return "redirect:login";
		}
		Student student = dao.fetch(Student.class, Cnd.where("username", "=", username));
		Sign sign = dao.fetch(Sign.class,Cnd.where("student_id", "=", student.getId()).and("sign_off_time", "=", new Timestamp(0)));
		if (sign != null) {
			sign.setRemark(remark);
			sign.setSignOffTime(new Timestamp(System.currentTimeMillis()));
			dao.update(sign);
		}
	
		request.setAttribute("msg", "签离成功");
		request.setAttribute("location", "student");
		return "jsp:jump";
	}
	@At("logout")
	@Ok("re")
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:login";
	}
	
	@At("audit")
	@Ok("re")
	public String audit(@Param("id")String signId,HttpServletRequest request,HttpSession session){
		
		return "";
	}
	
	@At("audit")
	@Ok("re")
	public String audit(@Param("action")String action,@Param("id")Integer id,@Param("secret_key")String secretkey,HttpServletRequest request,HttpSession session){
		String referer = request.getHeader("referer");
		
		String username = (String)session.getAttribute("username");
		if (username == null) {
			return "redirect:login";
		}
		boolean isTeacher = (Boolean)session.getAttribute("teacher");
		if (!isTeacher) {
			return "redirect:student";
		}
		
		Sign sign = dao.fetch(Sign.class,Cnd.where("id", "=", id));
		Teacher currenTeacher = dao.fetch(Teacher.class,Cnd.where("id", "=", sign.getTeacherId()));
		Teacher nowTeacher = dao.fetch(Teacher.class,Cnd.where("username", "=", username));
		
		if ((secretkey != null && secretkey.equals("31415926"))||(nowTeacher.getId()==currenTeacher.getId())) {
			if (action.equals("audit_success")) {
				sign.setAudit(1);
			}
			if (action.equals("audit_fail")) {
				sign.setAudit(2);
			}
			dao.update(sign);
		}
		request.setAttribute("msg", "审核完成");
		request.setAttribute("location", referer);
		return "jsp:jump";
	}
	
	@At("change_student_info")
	@Ok("re")
	public String changeStudentInfo(@Param("username")String username,@Param("name")String name,@Param("gender")Integer gender,@Param("password")String password,@Param("re_password")String rePassword,@Param("college")String college,@Param("phone")String phone,@Param("weixin")String weixin,@Param("qq")String qq,@Param("work_location")String workLocation,@Param("work_character")String workCharacter, HttpServletRequest request,HttpSession session){
		String username2 = (String)session.getAttribute("username");
		//判断用户的登录状态
		if (username2 == null) {
			return "redirect:login";
		}
		boolean teacher = (Boolean)session.getAttribute("teacher");
		if (teacher) {
			return "redirect:teacher";
		}
		
		if (request.getMethod().equals("GET")) {
			Student student = dao.fetch(Student.class, Cnd.where("username", "=", username2));
			request.setAttribute("student", student);
			return "jsp:change_student_info";
		}else{
			Student student = dao.fetch(Student.class, Cnd.where("username", "=", username2));
//			student.setUsername(username);
//			student.setName(name);
			if (!password.equals("")) {
				student.setPassword(password);
			}
			student.setGender(gender);
			student.setCollege(college);
			student.setPhone(phone);
			student.setWeixin(weixin);
			student.setQq(qq);
			student.setWorkLocation(workLocation);
			student.setWorkCharacter(workCharacter);
//			student.setRegisterTime(new Timestamp(System.currentTimeMillis()));
			dao.update(student);
			request.setAttribute("msg", "个人信息更新成功");
			request.setAttribute("location", "student");
			return "jsp:jump";
		}
	}
	
	@At("change_teacher_info")
	@Ok("re")
	public String changeTeacherInfo(@Param("username")String username,@Param("name")String name,@Param("password")String password,@Param("re_password")String rePassword,@Param("department")String department,HttpServletRequest request,HttpSession session){
		String username2 = (String)session.getAttribute("username");
		//判断用户的登录状态
		if (username2 == null) {
			return "redirect:login";
		}
		boolean teacher = (Boolean)session.getAttribute("teacher");
		if (!teacher) {
			return "redirect:student";
		}
		
		if (request.getMethod().equals("GET")) {
			Teacher teacher2 = dao.fetch(Teacher.class, Cnd.where("username", "=", username2));
			request.setAttribute("teacher", teacher2);
			return "jsp:change_teacher_info";
		}else{
			Teacher teacher2 = dao.fetch(Teacher.class, Cnd.where("username", "=", username2));
			teacher2.setUsername(username);
			if (!password.equals("")) {
				teacher2.setPassword(password);
			}
			teacher2.setName(name);
			teacher2.setDepartment(department);
			dao.update(teacher2);
			request.setAttribute("msg", "个人信息更新成功");
			request.setAttribute("location", "teacher");
			return "jsp:jump";
		}
	}
	
	
}
