<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>${token.nickname} —个人中心</title>
		<@_quote.quote 1/>
	</head>
	<body data-target="#one" data-spy="scroll">
		<@_topNav.top 1/>
		<div class="tpl-page-container tpl-page-header-fixed">
		<@_leftNav.left 1.1/>
		<div class="tpl-content-wrapper">
			<div class="tpl-content-page-title">个人资料</div>
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">个人中心</a></li>
                <li class="am-active">个人资料</li>
            </ol>
            <div class="tpl-portlet-components">
	            <div class="row">
					<div class="col-md-10">
						<table class="table table-bordered">
							<tr>
								<th>昵称</th>
								<td>${token.nickname?default('未设置')}</td>
							</tr>
							<tr>
								<th>Email/帐号</th>
								<td>${token.email?default('未设置')}</td>
							</tr>
							<tr>
								<th>创建时间</th>
								<td>${token.createTime?string('yyyy-MM-dd HH:mm')}</td>
							</tr>
							<tr>
								<th>最后登录时间</th>
								<td>${token.lastLoginTime?string('yyyy-MM-dd HH:mm')}</td>
							</tr>
						</table>
					</div>
				</div>
            </div>
            
        </div>
		</div>
		
		<@_quoteAmazeUi.quoteAmazeUi 1/>
	</body>
</html>