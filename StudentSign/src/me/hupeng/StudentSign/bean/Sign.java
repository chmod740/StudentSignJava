package me.hupeng.StudentSign.bean;

import java.sql.Timestamp;
import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

@Table("sign")
public class Sign {
	@Id
	private int id;
	
	@Column("teacher_id")
	private Integer teacherId;
	
	private String teacherName;
	
	@Column("student_id")
	private Integer studentId;

	@Column("sign_in_time")
	private Timestamp signInTime;
	
	@Column("sign_off_time")
	private Timestamp signOffTime;
	
	@Column
	private String remark;
	
	@Column
	private Integer audit; 
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}
	
	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public Integer getStudentId() {
		return studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public Timestamp getSignInTime() {
		return signInTime;
	}

	public void setSignInTime(Timestamp signInTime) {
		this.signInTime = signInTime;
	}

	public Timestamp getSignOffTime() {
		return signOffTime;
	}

	public void setSignOffTime(Timestamp signOffTime) {
		this.signOffTime = signOffTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getAudit() {
		return audit;
	}

	public void setAudit(Integer audit) {
		this.audit = audit;
	}
	
	private Student student;

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}
	
	private String timeDiff;

	public String getTimeDiff() {
		return timeDiff;
	}

	public void setTimeDiff(String timeDiff) {
		this.timeDiff = timeDiff;
	}
	
	public void culTimeDiff(){
		long begin = signInTime.getTime();
		long end = signOffTime.getTime();
		if(end==0){
			end = System.currentTimeMillis();
		}
		long diff = end - begin;
		diff = diff / 1000;
		long s = diff % 60;
		diff = diff / 60;
		long m = diff % 60;
		diff = diff / 60;
		long h = diff;
		this.timeDiff = formatTime(h) + ":" + formatTime(m) + ":" + formatTime(s);
	}
	
	private String formatTime(long t){
		if (t >= 10) {
			return ""+t;
		}else{
			return "0" + t;
		}
	}
}
