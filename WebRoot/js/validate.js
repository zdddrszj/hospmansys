/**********************************************************************************************************************************
 *  目录列表
 *  String 原型自定义函数，由字符串对象直接调用函数，如果符合验证，返回true，否则返回false
 * 		1. trim        					去空格
 * 		2. reallength 					实际长度
 *		3. isMobile					手机号码判断
 * 		4. isTel						电话号码验证
 * 		5. isQQ						QQ号码验证
 * 		6. isChinese					中文验证
 *		7. validateEmail 				邮箱格式验证
 * 		8. validateNum				验证字符串是否是正整数或零
 * 		9. validateSignlessIntegral		验证正整数
 * 		10.validateSignlessDecimal	验证正实数
 *		11.validateDecimal			验证实数
 * 		12.roundTwo					验证两位小数
 * 		13.roundOne					验证一位小数
 * 		14.validateLetter				验证是否是字母或数字
 *		15.validateUrl					验证是否是URL
 * 		16.isNull						验证是否为空
 * 		17.check_specialword			验证是否包含JavaScript常见非法字符 
 * 		18.isPostCode					验证是否是邮政编码
 *		19.isDate						验证是否是正确的日期格式 (只匹配 2013-02-28格式)
 * 		20.isTelAreaCode				验证是否是国内电话区号
 * 	
 *
 * 普通验证函数，调用时需要调用函数名称，传递对应参数
 *
 * 		21.isRegisterUserName(s)  	验证s是否是常用注册用户，由字母、数字、下划线组成、字母开头、长度6-16之间，通过验证返回true
 * 		22.checkIdcard(idcard)		验证idcard是否是正确的身份证号码，返回字符串内容信息如下：
 *										"合法",
 *										"身份证号码位数不对！ 末尾带 X 的请大写",
 *										"身份证号码出生日期超出范围或含有非法字符! 末尾带 X 的请大写",
 *										"身份证号码校验错误! 末尾带 X 的请大写",
 *										"身份证地区非法!"
 * 
 *
 ************************************************************************************************************************************************/
	
	
	
	
	
	
/**
 * 1去空格
 * @author 张化龙(2009.11.17)
 */
String.prototype.trim=function(){
 return this.replace(/(^[\s\u3000]*)|([\s\u3000]*$)/g, "");
}
/**
 * 2实际长度
 * @author 张化龙2009.11.17)
 * @return 长度
 */
String.prototype.reallength=function(){
	return this.replace(/[^\x00-\xff]/g,"^^").length;
}
/**
 * 3手机号码判断
 * @author 张化龙(2009.11.17)
 * @return 是返回true,不是返回false
 */
String.prototype.isMobile = function() {  
  return (/^(?:13\d|15[012356789]|18[0256789]|147)-?\d{5}(\d{3}|\*{3})$/.test(this.trim()));  
} 


/**
 * 4电话号码验证
 * @author 张化龙(2009.11.17)
 * @return 是返回true,不是返回false
 */
String.prototype.isTel = function(){
	// "兼容格式: 国家代码(2到3位)-区号(2到3位)-电话号码(7到8位)-分机号(3位)"
	return (/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/.test(this.trim()));
}

/**
 * 5QQ号码验证 最小5位数，最大9位
 * @author 张化龙(2009.11.17)
 * @return 是返回true,不是返回false
 */
String.prototype.isQQ = function(){
	return (/^[1-9]\d{4,8}$/.test(this.trim()));
}

/**
 * 6是否是中文
 * @author 张化龙(2009.11.17)
 * @return 是中文返回true,不是中文返回false
 */
String.prototype.isChinese = function(){
	return (/^[\u4e00-\u9fa5]+$/.test(this.trim()));
}

/**
 * 7验证电子邮件
 * @author 张化龙(2009.11.17)
 * @return 是返回true,不是返回false
 */
String.prototype.validateEmail = function(){
	if (this.length > 100){
			return false;
	}
	var regu = "^(([0-9a-zA-Z]+)|([0-9a-zA-Z]+[_.0-9a-zA-Z-]*[0-9a-zA-Z]+))@([a-zA-Z0-9-]+[.])+([a-zA-Z]{2}|net|NET|com|COM|gov|GOV|mil|MIL|org|ORG|edu|EDU|int|INT)$"
	var re = new RegExp(regu);
	if (this.search(re) != -1) {
	   return true;
	} else {
	  
	   return false;
	}
}


/**
 * 8验证正整数和0
 * @author 张化龙（2009.11.24)
 * @return 是返回true,不是返回false
 */
String.prototype.validateNum = function(){
	return (/^(0{1}|[1-9]{1}\d*)$/.test(this.trim()));
}

/**
 * 9验证正整数
 * @author 豆春雷（2010.4.9)
 * @return 是返回true,不是返回false
 */
String.prototype.validateSignlessIntegral = function(){
	return (/^([1-9]{1}\d*)$/.test(this.trim()));
}
/**
 * 10验证购买数量
 * @author 豆春雷（2010.4.9)
 * @return 是返回true,不是返回false
 */
String.prototype.validatePricingNum = function(){
	return (/^([1-9]{1}[0-9]{0,1})$/.test(this.trim()));
}
/**
 * 11验证正实数
 * @author 豆春雷（2010.4.9)
 * @return 是返回true,不是返回false 
 */
 String.prototype.validateSignlessDecimal = function(){
	return (/^\d+(\.\d+)?$/.test(this.trim()));
}
/**
 * 验证实数
 * @author 韩冰（2010.1.11)
 * @return 是返回true,不是返回false
 */
String.prototype.validateDecimal = function(){
	return (/^-?\d+(\.\d+)?$/.test(this.trim()));
}

/**
 * 验证两位小数（必须有整数位，不能为".5"）
 *
 * @author 仲崇亮（2011.04.01)
 * @return 是返回true,不是返回false
 */
String.prototype.roundTwo = function(){
	return (/^\d+\.?\d{0,2}$/.test(this.trim()));
}
/**
 * 验证一位小数（必须有整数位，不能为".5格式"）
 *
 * @author 仲崇亮（2011.04.01)
 * @return 是返回true,不是返回false
 */
String.prototype.roundOne = function(){
	return (/^\d+\.?\d{0,1}$/.test(this.trim()));
}


/**
 * 验证是否是字母数字
 * @author 张化龙(2009.11.17)
 * @return 是返回true,不是返回false
 */
String.prototype.validateLetter = function(){
	if(this.search){
		return (this.search(new RegExp("^[a-zA-Z0-9]+$","g"))>=0)
	}
}

/**
 * 验证是否是Url
 * @author 张化龙(2009.11.17)
 * @return 是返回true,不是返回false
 */
String.prototype.validateUrl = function(){
	if(this.search){
		return (this.search(new RegExp("^http\:\/\/[a-zA-Z0-9\.]+(\/)$","g"))>=0)
	}
}


/**
 * 判断是否为空
 * @author 张化龙(2009.11.17)
 * @return 是返回true,不是返回false
 */
String.prototype.isNull = function(){
	return (this == "" || this == null || this == "undefined");
}

/**
 * <script,select,update,delete,insert,'为非法字符
 * @author 张化龙(2009.11.17)
 * @return 不是返回true,是返回false
 */
String.prototype.check_specialword = function(){
	return !(/<script|select|update|delete|insert|'/ig).test(this);	
}

/**
 * 只包含汉字，数字，英文，下划线，百分号，反斜杠
 *  @author 张化龙
 * @return
 */
String.prototype.check_specialunit = function(){
	var val = /^[\u4e00-\u9fa5\w\/%]*$/; 
	return val.test(this);	
}

/**
 *  只包含数字，英文，下划线，英文字母开头，6-16位长度验证，常用于注册用户名验证
 *  @author 张化龙
 *  @return
 */
function isRegisterUserName(s)   
{   
var patrn=/^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){5,15}$/;   
	if (!patrn.exec(s)) {
		return false  ;
	}
	return true; 
} 



/**
 * 身份证验证开始
 * @author 张化龙(2009.11.17)
 * @return 中文提示信息( var Errors )
 */

function checkIdcard(idcard){
	var Errors=new Array(
		"合法",
		"身份证号码位数不对！ 末尾带 X 的请大写",
		"身份证号码出生日期超出范围或含有非法字符! 末尾带 X 的请大写",
		"身份证号码校验错误! 末尾带 X 的请大写",
		"身份证地区非法!"
	);
	
	var area={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"}

	var idcard,Y,JYM;
	var S,M;
	var idcard_array = new Array();
	
	idcard_array = idcard.split("");
	// 地区检验
	if(area[parseInt(idcard.substr(0,2))]==null) return Errors[4];
		// 身份号码位数及格式检验
		switch(idcard.length){
			case 15:
				if ( (parseInt(idcard.substr(6,2))+1900) % 4 == 0 || ((parseInt(idcard.substr(6,2))+1900) % 100 == 0 && (parseInt(idcard.substr(6,2))+1900) % 4 == 0 )){
					ereg=/^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$/;// 测试出生日期的合法性
				} else {
					ereg=/^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/;// 测试出生日期的合法性
				}
				if(ereg.test(idcard)) return true;//return Errors[0];
				else return Errors[2];
				break;
			case 18:
				// 18位身份号码检测
				// 出生日期的合法性检查
				// 闰年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))
				// 平年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))
				if ( parseInt(idcard.substr(6,4)) % 4 == 0 || (parseInt(idcard.substr(6,4)) % 100 == 0 && parseInt(idcard.substr(6,4))%4 == 0 )){
					ereg=/^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/;// 闰年出生日期的合法性正则表达式
				} else {
					ereg=/^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/;// 平年出生日期的合法性正则表达式
				}
				if(ereg.test(idcard)){// 测试出生日期的合法性
					// 计算校验位
					S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7
					+ (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9
					+ (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10
					+ (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5
					+ (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8
					+ (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4
					+ (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2
					+ parseInt(idcard_array[7]) * 1
					+ parseInt(idcard_array[8]) * 6
					+ parseInt(idcard_array[9]) * 3 ;
					Y = S % 11;
					M = "F";
					JYM = "10X98765432";
					M = JYM.substr(Y,1);// 判断校验位
				
					if(M == idcard_array[17]) return true;//return Errors[0]; // 检测ID的校验位
					else return Errors[3];
					}
				else return Errors[2];
				break;
			default:			
				return Errors[1];
				break;
		}
}
/* 身份证验证结束 */




/**
 * 邮政编码验证
 * @author 张化龙（2009.11.24)
 * @return 是返回true,不是返回false
 */
String.prototype.isPostCode = function(){
	return (/^[1-9]\d{5}(?!\d)$/.test(this.trim()));
}

/**
 * 日期验证
 * @author 张化龙（2009.11.24)
 * @return 是返回true,不是返回false
 */
String.prototype.isDate = function(){
	return (/^((?!0000)[0-9]{4}-((0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-8])|(0[13-9]|1[0-2])-(29|30)|(0[13578]|1[02])-31)|([0-9]{2}(0[48]|[2468][048]|[13579][26])|(0[48]|[2468][048]|[13579][26])00)-02-29)$/.test(this.trim()));
}



/**
 * 校验电话中的区号 格式：0XXX
 * @author 张化龙（2009.11.24)
 * @return 是返回true,不是返回false
 */
String.prototype.isTelAreaCode = function(){
	return (/^0\d{2,3}$/.test(this.trim()));
}

