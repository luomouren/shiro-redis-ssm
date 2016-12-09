<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>密码修改—个人中心</title>
		<@_quote.quote 1/>
	</head>
	<body data-target="#one" data-spy="scroll">
		<@_topNav.top 1/>
		<div class="tpl-page-container tpl-page-header-fixed">
		<@_leftNav.left 1.3/>
		<div class="tpl-content-wrapper">
			<div class="tpl-content-page-title">密码修改</div>
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">个人中心</a></li>
                <li class="am-active">密码修改</li>
            </ol>
            <div class="tpl-portlet-components">
	            <form id="formId" enctype="multipart/form-data" action="${basePath}/user/updatePswd.shtml" method="post">
				  <div class="form-group">
				    <label for="pswd">原密码</label>
				    <input type="password" class="form-control" autocomplete="off" id="pswd" maxlength="20" name="pswd"  placeholder="请输入原密码">
				  </div>
				  <div class="form-group">
				    <label for="newPswd">新密码</label>
				    <input type="password" class="form-control" autocomplete="off" id="newPswd" maxlength="20" name="newPswd" placeholder="请输入新密码">
				  </div>
				  <div class="form-group">
				    <label for="reNewPswd">新密码（再输入一次）</label>
				    <input type="password" class="form-control" autocomplete="off" id="reNewPswd" maxlength="20" name="reNewPswd"placeholder="请再次输入新密码">
				  </div>
				  <div class="form-group">
					  <button type="submit" class="btn btn-success">确定修改</button>
				  </div>
				</form>
            </div>
		</div>
		</div>
		<@_quoteAmazeUi.quoteAmazeUi 1/>
		
		<script>
			$(function(){
				var load;
				$("#formId").ajaxForm({
			    	success:function (result){
			    		layer.close(load);
			    		if(result && result.status != 200){
			    			return layer.msg(result.message,function(){}),!1;
			    		}else{
				    		layer.msg('操作成功！');
				    		$("form :password").val('');
			    		}
			    	},
			    	beforeSubmit:function(){
			    		//判断参数
			    		if($.trim($("#pswd").val()) == ''){
				    		layer.msg('请输入原密码',function(){});
				    		$("#pswd").parent().removeClass('has-success').addClass('has-error');
				    		return !1;
			    		}else{
			    			$("#pswd").parent().removeClass('has-error').addClass('has-success');
			    		}
			    		if($.trim($("#newPswd").val()) == ''){
				    		layer.msg('请输入新密码',function(){});
				    		$("#newPswd").parent().removeClass('has-success').addClass('has-error');
				    		return !1;
			    		}else{
			    			$("#newPswd").parent().removeClass('has-error').addClass('has-success');
			    		}
			    		if($.trim($("#reNewPswd").val()) == ''){
				    		layer.msg('请再次输入新密码',function(){});
				    		$("#reNewPswd").parent().removeClass('has-success').addClass('has-error');
				    		return !1;
			    		}else{
			    			$("#reNewPswd").parent().removeClass('has-error').addClass('has-success');
			    		}
			    		if($("#reNewPswd").val() != $("#newPswd").val()){
			    			return layer.msg('2次新密码输入不一致。',function(){}),!1;
			    		}
			    		load = layer.load('正在提交！！！');
			    	},
			    	dataType:"json",
			    	clearForm:false
				});
			
		});
		</script>
			
	</body>
</html>