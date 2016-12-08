<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>当前在线Session — SSM + Shiro Demo</title>
		
		<#include "../common/config/reference.ftl"/>
		<@reference/>
		<script  type="text/javascript">
			<@shiro.hasPermission name="/member/changeSessionStatus.shtml">
			$(function(){
				$("a[v=onlineDetails]").on('click',function(){
					var self = $(this);
					var text = $.trim(self.text());
					var index = layer.confirm("确定"+ text +"？",function(){
						changeSessionStatus(self.attr('sessionId'),self.attr('status'),self);
						layer.close(index);
					});
				});
			});
			//改变状态
			function changeSessionStatus(sessionIds,status,self){
				status = !parseInt(status);
				//loading
				var load = layer.load();
				$.post("${basePath}/member/changeSessionStatus.shtml",{status:status,sessionIds:sessionIds},function(result){
					layer.close(load);
					if(result && result.status == 200){
						var classStr = result.sessionStatusText=='踢出'?'fa fa-remove':'fa fa-plus';
						return self.children().attr("class",classStr),
									self.attr('status',result.sessionStatus),
										self.parent().prev().text(result.sessionStatusTextTd);
										layer.msg('操作成功'),!1;
					}else{
						return layer.msg(result.message,function(){}),!1;
					}		
				},'json');
			}
			</@shiro.hasPermission>
			
		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 2/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.member 2/>
				<div class="col-md-10">
					<h2>当前在线用户</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入昵称 / 帐号">
					      </div>
					     <span class=""> <#--pull-right -->
				         	<a class="btn btn-primary" title="查询" type="submit"  onclick="$('#formId').submit();">
			                <i class="fa fa-search"></i></a>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th>SessionID</th>
							<th>昵称</th>
							<th>Email/帐号</th>
							<th>创建回话</th>
							<th>回话最后活动</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
						<#if list?exists && list?size gt 0 >
							<#list list as it>
								<tr>
									<td>${it.sessionId?default('未设置')}</td>
									<td>${it.nickname?default('未设置')}</td>
									<td>${it.email?default('未设置')}</td>
									<td>${it.startTime?string('HH:mm:ss yy-MM-dd')}</td>
									<td>${it.lastAccess?string('HH:mm:ss yy-MM-dd')}</td>
									<td>${(it.sessionStatus)?string('有效','已踢出')}</td>
									<td>
										
										<a class="btn btn-primary"  title="详情" href="${basePath}/member/onlineDetails/${it.sessionId}.shtml">
			                    		<i class="fa fa-external-link-square"></i></a>
										<@shiro.hasPermission name="/member/changeSessionStatus.shtml">
											
											<a class="btn btn-default label-danger"  href="javascript:void(0);"  
											v="onlineDetails" sessionId="${it.sessionId}" status="${(it.sessionStatus)?string(1,0)}" 
											title="${(it.sessionStatus)?string('踢出','激活')}" href="javascript:void(0);">
			                    			<i class="fa ${(it.sessionStatus)?string('fa-remove','fa-plus')}"></i></a>
										</@shiro.hasPermission>
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="center-block" callspan="4">没有用户</td>
							</tr>
						</#if>
						
					</table>
				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>