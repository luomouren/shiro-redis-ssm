<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>资料修改 —个人中心</title>
		<@_quote.quote 1/>
	</head>
	<body data-target="#one" data-spy="scroll">
		<@_topNav.top 1/>
		<div class="tpl-page-container tpl-page-header-fixed">
		<@_leftNav.left 1.2/>
		<div class="tpl-content-wrapper">
			<div class="tpl-content-page-title">资料修改</div>
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">个人中心</a></li>
                <li class="am-active">资料修改</li>
            </ol>
            <div class="tpl-portlet-components">
	            <form id="formId" enctype="multipart/form-data" action="${basePath}/user/updateSelf.shtml" method="post">
					  <input type="hidden" value="${token.id}" name="id"/>
					  <div class="form-group">
					    <label for="nickname">昵称</label>
					    <input type="text" class="form-control" autocomplete="off" id="nickname" maxlength="8" name="nickname" value="${token.nickname?default('未设置')}" placeholder="请输入昵称">
					  </div>
					  <div class="form-group">
					    <label for="email">Email（不准修改）</label>
					    <input type="text" class="form-control " disabled autocomplete="off" id="email" maxlength="64" name="email" value="${token.email?default('未设置')}" placeholder="请输入帐号">
					  </div>
					  <div class="form-group">
						  <button type="submit" class="btn btn-success">确定</button>
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
			    		if(result && result.status == 300){
			    			layer.msg(result.message,function(){});
			    			return !1;
			    		}
			    		if(result && result.status == 500){
			    			layer.msg("操作失败！",function(){});
			    			return !1;
			    		}
			    		layer.msg('操作成功！');
			    	},
			    	beforeSubmit:function(){
			    		//判断参数
			    		if($.trim($("#nickname").val()) == ''){
				    		layer.msg('昵称不能为空！',function(){});
				    		$("#nickname").parent().removeClass('has-success').addClass('has-error');
				    		return !1;
			    		}else{
			    			$("#nickname").parent().removeClass('has-error').addClass('has-success');
			    		}
			    		load = layer.load();
			    	},
			    	dataType:"json",
			    	clearForm:false
				});
			
		});
		</script>
			
	</body>
</html>