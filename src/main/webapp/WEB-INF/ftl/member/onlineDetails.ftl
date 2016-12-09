<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>Session详情 — SSM + Shiro Demo</title>
		<@_quote.quote 1/>
	</head>
	<body data-target="#one" data-spy="scroll">
		<@_topNav.top 2/>
		<div class="tpl-page-container tpl-page-header-fixed">
		<@_leftNav.left 2.2/>
		<div class="tpl-content-wrapper">
			<div class="tpl-content-page-title">在线用户详情</div>
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">用户中心</a></li>
                <li class="am-active">在线用户</li>
            </ol>
            <div class="tpl-portlet-components">
	            <table class="table table-bordered">
						<tr>
							<th>Session Id</th>
							<td>${bo.sessionId?default('—')}</td>
						</tr>
						<tr>
							<th>Session创建时间</th>
							<td>${bo.startTime?string('yyyy年MM月dd日 HH:mm:ss')}</td>
						</tr>
						<tr>
							<th>Session最后交互时间</th>
							<td>${bo.lastAccess?string('yyyy年MM月dd日 HH:mm:ss')}</td>
						</tr>
						<tr>
							<th>Session 状态</th>
							<td>${(bo.sessionStatus)?string('有效','已踢出')}</td>
						</tr>
						<tr>
							<th>Session Host</th>
							<td>${bo.host?default('—')}</td>
						</tr>
						<tr>
							<th>Session timeout</th>
							<td>${bo.timeout}&nbsp;(毫秒) = ${bo.timeout/1000}(秒) = ${bo.timeout/1000/60}(分钟)</td>
						</tr>
						<tr>
							<th>昵称</th>
							<td>${bo.nickname?default('—')}</td>
						</tr>
						<tr>
							<th>Email/帐号</th>
							<td>${bo.email?default('—')}</td>
						</tr>
						<tr>
							<th>创建时间</th>
							<td>${bo.createTime?string('yyyy-MM-dd HH:mm')}</td>
						</tr>
						<tr>
							<th>最后登录时间</th>
							<td>${bo.lastLoginTime?string('yyyy-MM-dd HH:mm')}</td>
						</tr>
					</table>
            </div>
		</div>
		</div>
		<@_quoteAmazeUi.quoteAmazeUi 1/>
	</body>
</html>