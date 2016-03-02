<%@ page language="java" import="java.util.*" import="cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserinfoDoc userinfo = (UserinfoDoc)request.getAttribute("userinfo");
List<Province> provinceList = (List<Province>) request.getAttribute("provinceList");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册用户页面</title>
    <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" media="screen">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script src="My97DatePicker/WdatePicker.js"></script>
   <script src="<%=basePath%>js/form_valid.js" charset="utf-8"></script>
	<script src="<%=basePath %>js/imagePreview.js"></script>
	<script src="<%=basePath %>js/jquery.js"></script>
   <script type="text/javascript">
      	//第一步：创建异步对象
  function  createXmlHttpRequest(){
	  var xmlHttpReq;
	  if(window.XMLHttpRequest){
		  xmlHttpReq=  new XMLHttpRequest();
	  }else if(window.ActiveXObject){
		  new ActiveXObject("Microsoft.XMLHTTP");
	  }
	return   xmlHttpReq;
  }
  
  var xmlHttpRequest;
  
  //获取市
  function findCity(){
	  
	  //得到省份id
	 var provinceId= document.getElementById("provinceId").value;
	 var provinceName="";
	  //得到所选则的省份或直辖市的name
	 var options= document.getElementById("provinceId").options;
	  for(var i=0;i<options.length;i++){
		  if(options[i].selected){
			  provinceName=options[i].firstChild.nodeValue;
			  
		  }
	  }
	    
	  xmlHttpRequest=createXmlHttpRequest();
	  xmlHttpRequest.onreadystatechange=fintCity_callBackxml;
	  xmlHttpRequest.open("post","findCityPatient.action",true);
	  xmlHttpRequest.setRequestHeader("content-type","application/x-www-form-urlencoded");
	  xmlHttpRequest.send("provinceId="+provinceId+"&"+Math.random());  
  }
  
  //通过xml实现的回调
  function  fintCity_callBackxml(){
	  if(xmlHttpRequest.readyState==4){
		  if(xmlHttpRequest.status==200){
			var selectNode=document.getElementById("cityId");
			var optionsNode=selectNode.childNodes;
			for(var i=optionsNode.length-1;i>0;i--){
				selectNode.removeChild(optionsNode[i]);
			}
			var cityString=  xmlHttpRequest.responseXML;
			  for(var i=0;i<cityString.getElementsByTagName("id").length;i++){
					var optionNode=	document.createElement("option");
					optionNode.value=cityString.getElementsByTagName("id")[i].firstChild.nodeValue;
					var cityNameNode=document.createTextNode(cityString.getElementsByTagName("name")[i].firstChild.nodeValue);
					optionNode.appendChild(cityNameNode);
					selectNode.appendChild(optionNode);	
			  }
			}
		  }
	  }
	 
 
  
  //获取地区
   function findArea(){
	  //得到市id
	 var cityId= document.getElementById("cityId").value;
	 var cityName="";
	  //得到所选则的市name
	 var options= document.getElementById("cityId").options;
	  for(var i=0;i<options.length;i++){
		  if(options[i].selected){
			  cityName=options[i].firstChild.nodeValue;
			  
		  }
	  }
	    
	  xmlHttpRequest=createXmlHttpRequest();
	  
	  xmlHttpRequest.onreadystatechange=fintArea_callBackxml;
	  
	  xmlHttpRequest.open("post","findAreaPatient.action",true);
	  xmlHttpRequest.setRequestHeader("content-type","application/x-www-form-urlencoded");
	  xmlHttpRequest.send("cityId="+cityId+"&"+Math.random());
	  
	 
	   
  }
  
  //通过xml实现的回调
  function  fintArea_callBackxml(){
	  if(xmlHttpRequest.readyState==4){
		  if(xmlHttpRequest.status==200){
			var selectNode=document.getElementById("areaId");
			var optionsNode=selectNode.childNodes;
			
			//先移除所有select下的option子节点
			for(var i=optionsNode.length-1;i>0;i--){
				selectNode.removeChild(optionsNode[i]);
			}
			  
			var areaString=  xmlHttpRequest.responseXML;
			 
			  for(var i=0;i<areaString.getElementsByTagName("id").length;i++){
				
					var optionNode=	document.createElement("option");
					optionNode.value=areaString.getElementsByTagName("id")[i].firstChild.nodeValue;
					var areaNameNode=document.createTextNode(areaString.getElementsByTagName("name")[i].firstChild.nodeValue);
					optionNode.appendChild(areaNameNode);
					selectNode.appendChild(optionNode);	
			  }

			}
		  }
		  
	  }
      function uploadcheck(){
    		//取得file里面的值
    		var path = document.getElementById("exampleInputFile").value;
    		if(path.endsWith('.jpg')||path.endsWith('.png')){
    			return true;
    		} else {
    		alert("图片上传格式错误，只能上传以jpg、png格式的图片");
    		return false;
    		}
    	}
  	//表单验证
function validForm() {
		var result = false;
		var frm = document.getElementById("saveUserinfoForm");
		if(validator(frm)) {
		var pw1 = document.getElementById("pw1").value;
		var pw2 = document.getElementById("pw2").value;
		if(pw1==pw2) {
		result = true;
		} else {
		alert("两次密码不一致");
		return false;
		}
		
		}
		if (result&&uploadcheck()) {
			if (confirm("    确认注册用户的【详细信息】信息无误?  " 
					+ "\n\n点击【确定】提交信息，点击【取消】继续修改.")) {
				return true;
			}
		}
		return false;
	}
  	function preview(file,preview,imghead){
		if($.browser.msie){
					//参数 是否是IE，div的id，img的id，高,宽 
			previewImage(true,file,preview,imghead,200,200);
	}else{
					//参数 是否是IE，div的id，img的id，高,宽 
			previewImage(false,file,preview,imghead,200,200);
		}
	}
  	</script>
  </head>
  
  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%=basePath %>js/bootstrap.min.js"></script>
  
  <body>
   <nav class="nav  navbar-inverse" role="navigation">
    
	<div class="navbar-header">
		
    <ul class="nav navbar-nav navbar-right">
      <li><a href="javascript:void">红心医院，您最明智的选择&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前页面：用户注册</a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>
  
<div class="jumbotron">
					<div class="container" align="center">
						<form action="addPatient.action" method="post" onsubmit="return validForm()" id="saveUserinfoForm"  enctype="multipart/form-data">
						<table>

				<tr>
				<td width="300px">
					<div class="control-group">
							  
    			用户名：<input type="text" class="form-control" name="patient.pname" cnName="姓名"  valid="required|isChinese" errmsg="|姓名必须是中文" placeholder="username">
  								
					</div>
				</td>
				<td width="300px">
					
					<div class="control-group">
							  	出生日期:<input type="text" class="form-control" onClick="WdatePicker()" cnName="生日" valid="required" placeholder="birthday" name="patient.pbirthday">
					</div>
				</td>
				</tr>
				
				<tr>
					<td>
					<div class="control-group">
								密码：<input type="password" name="patient.password"  cnName="密码" valid="required" id="pw1" class="form-control" placeholder="password">
						</div>
					</td>
					<td>
					<div class="control-group">
							电话：<input type="text" name="patient.ptel" cnName="电话" valid="required|isMobile" errmsg="|电话格式不规范" class="form-control" placeholder="tel">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
									确认密码：<input type="password" class="form-control" id="pw2"  placeholder="password">
						</div>
					</td>
					<td>
					<div class="control-group">
												
													<div class="controls">
												住址：<select id="provinceId" class="select1" name="provinceId"
						onchange="findCity()" onblur="checkPro()">
						<%
								if (provinceList != null && provinceList.size() > 0) {
									for (int i = 0; i < provinceList.size(); i++) {
										String proid = ""+provinceList.get(i).getProvinceid();
										String provinceName = provinceList.get(i).getProvince();
						%>
						<option value="<%=proid%>"><%=provinceName%></option>
						<%
							}
								}
						%>
					</select> 
					<select id="cityId" onchange="findArea()" name="cityId"
						onblur="checkCity()">
					</select> 
					<select name="areaId" id="areaId" onblur="checkArea()">
					</select>
													</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
					<div class="control-group">
							密保问题：<select class="form-control" name="patient.pquestion">
							  <option>你的小学名字是什么？</option>
							  <option>你父亲的生日是多少？</option>
							  <option>你母亲的生日是多少？</option>
							</select>
							答案：<input type="text" name="patient.panswer"  cnName="密保答案" valid="required" class="form-control" placeholder="answer">
					</div>
					</td>
					<td>
					
					<div class="control-group">
						<div class="controls">
						头像：(头像必须为本人相片。)<input type="file" onblur="uploadcheck()" id="exampleInputFile" cnName="头像" valid="required" name="patient.pimage" onchange="preview(this,'preview','imghead')">
						</div>
					</div>
				  		 <div id="imagePreview" >
				  		 <div id="preview">
					     <img id="imghead" width="200px" height="200px" border=0 />
						 </div>
				  		 </div>
					</td>
				</tr>

<tr>
	<td align="right">
	<input type="reset" class="btn btn-primary" value="重置" />
	
	</td>
	<td align="right">
	<input type="submit" class="btn btn-primary" value="确认注册" />
	</td>
	</tr>
</table>
</form>

  
 					</div>
				</div>
  </body>
</html>
