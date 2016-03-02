var FormValid = function(frm) {
	this.frm = frm;
	this.errMsg = new Array();
	this.errName = new Array();
	this.required = function(inputObj) {
		if (typeof (inputObj) == "undefined" || inputObj.value.trim() == "") {
			return false;
		}
		return true;
	};

	this.eqaul = function(inputObj, formElements) {
		var fstObj = inputObj;
		var sndObj = formElements[inputObj.getAttribute('eqaulName')];
		if (fstObj != null && sndObj != null) {
			if (fstObj.value != sndObj.value) {
				return false;
			}
		}
		return true;
	};

	this.gt = function(inputObj, formElements) {
		var fstObj = inputObj;
		var sndObj = formElements[inputObj.getAttribute('eqaulName')];
		if (fstObj != null && sndObj != null && fstObj.value.trim() != ''
				&& sndObj.value.trim() != '') {
			if (parseFloat(fstObj.value) <= parseFloat(sndObj.value)) {
				return false;
			}
		}
		return true;
	};

	this.compare = function(inputObj, formElements) {
		var fstObj = inputObj;
		var sndObj = formElements[inputObj.getAttribute('objectName')];
		if (fstObj != null && sndObj != null && fstObj.value.trim() != ''
				&& sndObj.value.trim() != '') {
			if (!(eval(parseFloat(fstObj.value)
					+ inputObj.getAttribute('operate')
					+ parseFloat(sndObj.value)))) {
				return false;
			}
		}
		return true;
	};

	this.limit = function(inputObj) {
		var val = inputObj.value;
		var len = 0;
		var isChinese = /^[\u0391-\uFFE5]+$/;
		for ( var i = 0; i < val.length; i++) {
			if (isChinese.test(val.charAt(i))) {
				//len = len + 3;
				len = len + 2;
			} else {
				len = len + 1;
			}
		}
		if (len) {
			var minv = parseInt(inputObj.getAttribute('min'));
			var maxv = parseInt(inputObj.getAttribute('max'));
			minv = minv || 0;
			maxv = maxv || Number.MAX_VALUE;
			return minv <= len && len <= maxv;
		}
		return true;
	};

	this.range = function(inputObj) {
		var val = parseInt(inputObj.value);
		if (inputObj.value) {
			var minv = parseInt(inputObj.getAttribute('min'));
			var maxv = parseInt(inputObj.getAttribute('max'));
			minv = minv || 0;
			maxv = maxv || Number.MAX_VALUE;
			return minv <= val && val <= maxv;
		}
		return true;
	};

	this.requireChecked = function(inputObj) {
		var minv = parseInt(inputObj.getAttribute('min'));
		var maxv = parseInt(inputObj.getAttribute('max'));
		minv = minv || 1;
		maxv = maxv || Number.MAX_VALUE;
		var checked = 0;
		var groups = document.getElementsByName(inputObj.name);
		for ( var i = 0; i < groups.length; i++) {
			if (groups[i].checked)
				checked++;
		}
		return minv <= checked && checked <= maxv;
	};

	this.filter = function(inputObj) {
		var value = inputObj.value;
		var allow = inputObj.getAttribute('allow');
		if (value.trim()) {
			return new RegExp("^.+\.(?=EXT)(EXT)$".replace(/EXT/g, allow.split(
					/\s*,\s*/).join("|")), "gi").test(value);
		}
		return true;
	};

	this.isNo = function(inputObj) {
		var value = inputObj.value;
		var noValue = inputObj.getAttribute('noValue');
		return value != noValue;
	};

	this.isTelephone = function(inputObj) {
		inputObj.value = inputObj.value.trim();
		if (inputObj.value == '') {
			return true;
		} else {
			if (!RegExps.isMobile.test(inputObj.value)
					&& !RegExps.isPhone.test(inputObj.value)) {
				return false;
			}
		}
		return true;
	};

	this.checkReg = function(inputObj, reg, msg) {
		inputObj.value = inputObj.value.trim();
		if (inputObj.value == '') {
			return true;
		} else {
			return reg.test(inputObj.value);
		}
	};

	this.addErrorMsg = function(name, str) {
		this.errMsg.push(str);
		this.errName.push(name);
	};

	this.addAllName = function(name) {
		FormValid.allName.push(name);
	};
};

FormValid.allName = new Array();

FormValid.succeed = function() {
	return true;
};

function validator(frm) {
	//获取表单的校验信息
	var type = new Array();
	var valid = new Array();

	var formElements = frm.elements;
	var fv = new FormValid(frm);
	FormValid.allName = new Array();
	//循环校验每个element信息
	for ( var i = 0; i < formElements.length; i++) {
		if (formElements[i].disabled == true) {
			continue;
		}
		var msgs = fvCheck(formElements[i], fv, formElements);
		if (msgs.length > 0) {
			for (n in msgs) {
				fv.addErrorMsg(formElements[i].name, msgs[n]);
			}
		}
	}
	
	//设置返回值
	if (fv.errMsg.length > 0) {
		var msg = "";
		for (i = 0; i < fv.errMsg.length; i++) {
			msg += "[" + (i + 1) + "]" + fv.errMsg[i] + "\n";
		}
		alert(msg);
		return false;
	} else {
		return true;
	}
}

function fvCheck(e, fv, formElements) {
	var validType = e.getAttribute('valid');
	var errorMsg = e.getAttribute('errmsg');
	if (!errorMsg) {
		errorMsg = '';
	}
	if (validType == null)
		return [];
	fv.addAllName(e.name);
	var vts = validType.split('|');
	var ems = errorMsg.split('|');
	var r = [];
	for ( var j = 0; j < vts.length; j++) {
		var curValidType = vts[j];
		var curErrorMsg = ems[j];
		var validResult;
		switch (curValidType) {
		//case 'isNumber':
		//case 'isEmail':
		//case 'isPhone':
		//case 'isMobile':
		//case 'isIdCard':
		//case 'isMoney':
		//case 'isZip':
		//case 'isQQ':
		//case 'isInt':
		//case 'isEnglish':
		//case 'isChinese':
		//case 'isUrl':
		//case 'isDate':
		//case 'isQycode':
		//case 'isDateTime':
		//case 'isChineseLast':
		//case 'isTime':
		case 'isXM':
			var xm = e.value.trim();
			validResult = true;
			if (xm != "") {
				for ( var i = 1; i < xm.length - 1; i++) {

					var a = xm.charAt(i);
					var unicode = a.charCodeAt();
					//unicode 在19968--38191为汉字
					if (!((unicode >= 19968 && unicode <= 40869) || (unicode == 183))) {
						validResult = false;
						break;
					}
				}
				var first = xm.charAt(0).charCodeAt();
				var last = xm.charAt(xm.length - 1).charCodeAt();
				if (first < 19968 || first > 40869 || last < 19968
						|| last > 40869) {
					validResult = false;
				}
				if (!validResult) {
					var name = e.getAttribute('cnName');
					if (typeof (name) != 'undefined') {
						curErrorMsg = name + "包含非法字符";
					} else {
						curErrorMsg = "姓名包含非法字符";
					}
				}
			}
			break;
		case 'numberArea':
			validResult = true;
			var nv = e.value.trim();
			var maxnum = e.getAttribute('maxNumber');
			if (Number(nv) > Number(maxnum)) {
				validResult = false;
				curErrorMsg = '' + e.getAttribute('cnName') + '最大值为' + maxnum;
			}
			var minnum = e.getAttribute('minNumber');
			if (Number(nv) < Number(minnum)) {
				validResult = false;
				curErrorMsg = '' + e.getAttribute('cnName') + '最小值为' + minnum;
			}
			break;
		case 'regexp':
			validResult = fv.checkReg(e, new RegExp(e.getAttribute('regexp'), "g"), curErrorMsg);
			break;
		case 'custom':
			validResult = eval(e.getAttribute('custom') + '(e,formElements)');
			break;
		case 'limit':
			validResult = fv.limit(e);
			curErrorMsg = '' + e.getAttribute('cnName') + '最大长度不能超过' + e.max
					+ '字节（一个汉字为2个字节） ';
			break;
		case 'required':
			validResult = e.value.trim().length > 0 ? true : false;
			curErrorMsg = '' + e.getAttribute('cnName') + '不能为空.';
			break;
		default:
			validResult = fv.checkReg(e, RegExps[curValidType], curErrorMsg);
			break;
		}
		//如果校验的结果为false即没有匹配成功则将错信息添加到数组r中
		if (!validResult) {
			r.push(curErrorMsg);
		}
	}
	return r;
};

String.prototype.trim = function() {
	return this.replace(/^\s*|\s*$/g, "");
};

var RegExps = function() {
};
RegExps.isZhengNum = /^[0-9]+$/;
RegExps.isNumber = /^[-\+]?\d+(\.\d+)?$/;
RegExps.isEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)/;
RegExps.isPhone = /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/;
RegExps.isMobile = /^((\(\d{2,3}\))|(\d{3}\-))?(1)\d{10}$/;
RegExps.isIdCard = /(^\d{15}$)|(^\d{17}[0-9Xx]$)/;
RegExps.isMoney = /^\d+(\.\d+)?$/;
RegExps.isZip = /^[1-9]\d{5}$/;
RegExps.isQQ = /^[1-9]\d{4,10}$/;
RegExps.isInt = /^[-\+]?\d+$/;
RegExps.isEnglish = /^[A-Za-z]+$/;
RegExps.isChinese = /^[\u0391-\uFFE5]+$/;
RegExps.isUrl = /^http[s]?:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
RegExps.isDate = /^\d{4}-\d{1,2}-\d{1,2}$/;
RegExps.isTime = /^\d{4}-\d{1,2}-\d{1,2}\s\d{1,2}:\d{1,2}:\d{1,2}$/;
RegExps.isQycode = /^[\u0391-\uFFE5][0-9]{8}$/;
RegExps.isDateTime = /^\d{4}-\d{1,2}-\d{1,2}\s\d{1,2}:\d{1,2}:\d{1,2}$/;
RegExps.isTime = /^\d{1,2}:\d{1,2}:\d{1,2}$/;
RegExps.isChineseLast = /[\u0391-\uFFE5]+$/;