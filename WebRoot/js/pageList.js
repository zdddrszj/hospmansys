$(function(){
			/*首页*/
			$("#firstPage").click(function(){
				if ($("#currentPage").attr("value") == 1) {
					alert("已经是第一页！！");
				} else {
					$("#currentPage").attr("value",1);
					//$("#f").attr("value","yes");查询用户的时候用到
					$("#fm").submit();//提交表单
				}
			});
			
			/*上一页*/
			$("#prevPage").click(function(){
				if ($("#currentPage").attr("value") == 1) {
					alert("已经是第一页！！");
				} else {
					$("#currentPage").attr("value",(Number)($("#currentPage").attr("value")) - 1);
					//$("#f").attr("value","yes");
					$("#fm").submit();//提交表单
				}
			});
			
			/*下一页*/
			$("#nextPage").click(function(){
				
				if ($("#currentPage").attr("value") == $("#totalPage").attr("value")) {
					alert("已经是最后一页！！");
				} else {
					$("#currentPage").attr("value",(Number)($("#currentPage").attr("value")) + 1);
					//$("#f").attr("value","yes");//页面跳转的时候flag默认是no，所以提交表单获取不到条件，所以修改flag的值
					$("#fm").submit();//提交表单
				}
			});
			
			/*尾页*/
			$("#lastPage").click(function(){
				if ($("#currentPage").attr("value") == $("#totalPage").attr("value")) {
					alert("已经是最后一页！！");
				} else {
					$("#currentPage").attr("value", $("#totalPage").attr("value"));
					//$("#f").attr("value","yes");
					$("#fm").submit();//提交表单
				}
			});
		});