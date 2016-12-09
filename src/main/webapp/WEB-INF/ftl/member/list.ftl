<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>用户列表 —个人中心</title>
		<@_quote.quote 1/>
		<script  type="text/javascript">
			so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
				<@shiro.hasPermission name="/member/deleteUserById.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要删除的选项。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return _delete(array);
				});
				</@shiro.hasPermission>
			});
			<@shiro.hasPermission name="/member/deleteUserById.shtml">
			//根据ID数组，删除
			function _delete(ids){
				var index = layer.confirm("确定这"+ ids.length +"个用户？",function(){
					var load = layer.load();
					$.post('${basePath}/member/deleteUserById.shtml',{ids:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg('删除成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/member/forbidUserById.shtml">
			/*
			*激活 | 禁止用户登录
			*/
			function forbidUserById(status,id){
				var text = status?'激活':'禁止';
				var index = layer.confirm("确定"+text+"这个用户？",function(){
					var load = layer.load();
					$.post('${basePath}/member/forbidUserById.shtml',{status:status,id:id},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(text +'成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</@shiro.hasPermission>
		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		<@_topNav.top 2/>
		<div class="tpl-page-container tpl-page-header-fixed">
		<@_leftNav.left 2.1/>
		<div class="tpl-content-wrapper">
			<div class="tpl-content-page-title">用户列表</div>
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">用户中心</a></li>
                <li class="am-active">用户列表</li>
            </ol>
            <div class="tpl-portlet-components">
            
	            <form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入昵称 / 帐号">
					      </div>
					     <span class=""> <#--pull-right -->
				         	<a class="btn btn-primary" title="查询" type="submit"  onclick="$('#formId').submit();">
			                <i class="fa fa-search"></i></a>
				         	<@shiro.hasPermission name="/member/deleteUserById.shtml">
				         		<a class="btn btn-default label-danger" id="deleteAll" title="删除" href="javascript:void(0);">
			                    <i class="fa fa-trash-o"></i></a>
				         	</@shiro.hasPermission>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
							<th>昵称</th>
							<th>Email/帐号</th>
							<th>登录状态</th>
							<th>创建时间</th>
							<th>最后登录时间</th>
							<th>操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.nickname?default('未设置')}</td>
									<td>${it.email?default('未设置')}</td>
									<td>${(it.status==1)?string('有效','禁止')}</td>
									<td>${it.createTime?string('yyyy-MM-dd HH:mm')}</td>
									<td>${it.lastLoginTime?string('yyyy-MM-dd HH:mm')}</td>
									<td>
										<@shiro.hasPermission name="/member/forbidUserById.shtml">
										
										<a class="btn btn-default label-danger" href="javascript:forbidUserById(${(it.status==1)?string(0,1)},${it.id})"
										 ${(it.status==1)?string('title="禁止登录"><i class="fa fa-eye-slash"','title="激活登录"><i class="fa fa-eye"')}
										 ></i></a>
										</@shiro.hasPermission>
										<@shiro.hasPermission name="/member/deleteUserById.shtml">
											<a class="btn btn-default label-danger"  title="删除" href="javascript:_delete([${it.id}]);">
			                    			<i class="fa fa-trash-o"></i></a>
										</@shiro.hasPermission>
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="6">没有找到用户</td>
							</tr>
						</#if>
					</table>
					<#if page?exists>
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</#if>
				</form>
            </div>
        </div>    
		</div>
		<@_quoteAmazeUi.quoteAmazeUi 1/>
	</body>
</html>