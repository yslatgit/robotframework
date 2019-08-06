#coding=utf-8
#声明变量名
__all__ = ['employee_export_one','employee_clock_one','employee_staff_one','work_overtime_one','leave_one','retroactive_card_one']

#员工信息表根据工号导出一条
employee_export_one = "select cusercode as '工号' ,psncode 'HR编号',psnname '姓名',case when sex=1 then '男' when  sex=-1 then '女' else '' end '性别' ,phone '手机号码',telphone '工作电话',case when idtype=1 then '身份证' else '' end '证件类型',id '证件号码',case when pk_psncl =1 then '员工' when pk_psncl=2 then '实习生' when  pk_psncl=3 then '合作方' when  pk_psncl=4 then '分供方'when  pk_psncl=5 then '系统账号' when  pk_psncl=6 then '其他'when  pk_psncl=7 then '实习生'when  pk_psncl=-1 then '未分配' else '' end '员工类型',positionlevel '职级',pk_post'岗位',rtrim(deptname) '部门',rgnametree '部门全路径',joinworkdate '参加工作日期',entrydate '入职日期',regulardate '转正日期',quitdate'离职日期' from kq_user where  cusercode='sunpeng1'"

#员工打卡信息
employee_clock_one = "SELECT tp.cusercode,tp.psnname,tb.deptname pk_deptdoc_showname,CONVERT(varchar(16), tm.calendartime, 20),(CASE WHEN tm.signtype != 0 THEN '补签卡' ELSE isnull(tl.displayname, '') END) displayname FROM	sign_data tm INNER JOIN kq_user tp ON tm.pk_psndoc = tp.pk_psndoc LEFT JOIN kq_dept tb ON tp.pk_deptdoc = tb.pk_deptdoc LEFT JOIN sign_location tl ON tm.pk_place = tl.pk_place WHERE tm.dr = 0AND tp.dr = 0 AND tb.dr = 0 AND CONVERT ( CHAR (10),tm.calendartime,23) BETWEEN '2019-07-01' AND '2019-07-31' AND (tp.psnname LIKE '%' + '孙鹏' + '%' OR tp.cusercode LIKE '%' + 'sunpeng1' + '%')AND tb.fdidtree LIKE '%15a7f350f9719f85b3b598140c596e9b%' ORDER BY	cusercode,calendartime"

#员工班组信息
employee_staff_one = "SELECT bp.cusercode '工号',bp.psnname '姓名',tth.teamname '班组',tts.begindate '开始时间',CASE WHEN tts.enddate = '' THEN	'无限' ELSE	tts.enddate END '结束时间' FROM	kq_user (nolock) bp INNER JOIN kq_user_shiftgroup (nolock) tts ON tts.pk_psndoc = bp.pk_psndoc INNER JOIN kq_shiftgroup (nolock) tth ON tth.pk_team_h = tts.pk_team_h WHERE	cusercode = 'sunpeng1' AND tts.begindate <= '2019-07-31'AND (tts.enddate >= '2019-07-01'	OR isnull(tts.enddate, '') = '')AND bp.dr = 0 ORDER BY bp.cusercode,tts.begindate"

#加班单信息
work_overtime_one = "SELECT bp.cusercode AS '工号',bp.psnname '姓名',bd.deptname AS '部门',ttc.timeitemname AS '加班类型',(CASE WHEN tot.leaveID = 0 THEN '加班费' WHEN tot.leaveID = 1 THEN	'转存休' ELSE '' END) '补贴方式',tot.starttime,tot.endtime,(CASE WHEN tot.approve_state = 1 THEN	'通过' WHEN tot.approve_state = 0 THEN	'待审' ELSE '' END) '状态', CONVERT(varchar(16), tot.ts, 20),tot.apply_person '提交人' FROM sheet_ot tot JOIN kq_user bp ON tot.pk_psndoc = bp.pk_psndoc AND bp.dr = 0 JOIN kq_dept bd ON bd.pk_deptdoc = bp.pk_deptdoc JOIN kq_type_define ttc ON ttc.pk_timeitem = tot.pk_timeitem WHERE cusercode = 'duyi'AND starttime >= '2019-07-01' AND endtime <= '2019-07-31' ORDER BY	bp.cusercode,tot.endtime "

#请假单信息
leave_one = "SELECT bp.cusercode AS '工号',bp.psnname '姓名',bd.deptname AS '部门 ',ttc.timeitemname AS '假别',tl.leavebegintime '开始时间 ',tl.leaveendtime '结束时间',(CASE WHEN tl.approve_state = 1 THEN	'通过' WHEN tl.approve_state = 0 THEN	'待审' ELSE	'' END) '状态',CONVERT(varchar(16), tl.ts, 20),	tl.apply_person '提交人' FROM	sheet_leave tl JOIN kq_user bp ON tl.pk_psndoc = bp.pk_psndoc AND bp.dr = 0 JOIN kq_dept bd ON bd.pk_deptdoc = bp.pk_deptdoc JOIN kq_type_define ttc ON ttc.pk_timeitem = tl.pk_leavetype WHERE	cusercode = 'duyi' AND leavebegintime > '2019-07-01'AND leaveendtime < '2019-07-31'ORDER BY	bp.cusercode,	tl.leaveendtime"

#补签卡信息
retroactive_card_one = "SELECT bp.cusercode AS 工号,bp.psnname 姓名,bd.deptname AS 部门, CONVERT(varchar(16), ts.signtime, 20)补签时间,	(CASE	WHEN ts.approve_state = 1 THEN '通过'	WHEN ts.approve_state = 0 THEN '待审'	ELSE ''	END	)'状态',CONVERT (VARCHAR(16), ts.ts, 20),	(CASE	WHEN ts.signtype = 1 THEN	'因公' WHEN ts.signtype = 2 THEN '因私'	ELSE ''	END	)'类型',ts.apply_person FROM sheet_sign ts JOIN kq_user bp ON ts.pk_psndoc = bp.pk_psndoc AND bp.dr = 0 JOIN kq_dept bd ON bd.pk_deptdoc = bp.pk_deptdoc WHERE	cusercode = 'duyi'AND signtime > '2019-07-01'ORDER BY	bp.cusercode,	ts.signtime"