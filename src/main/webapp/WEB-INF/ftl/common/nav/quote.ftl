<#-- 通用css.js引用 -->
<#macro quote index>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <!--Bootstrap各个分辨率都ok-->
	<meta name="viewport" content="width=device-width, initial-scale=1" user-scalable="no">
	<!--开启IE8模式-->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="renderer" content="webkit">
    <title>shiro.demo</title>
    
	<!--网页页签title旁边的icon-->
	<link   rel="icon" href="${basePath}/favicon.ico" type="image/x-icon" />
	<link   rel="shortcut icon" href="${basePath}/favicon.ico" type="image/x-icon" />
	<!--jquery文件需要在bootstrap js和css文件之前引入-->
	<script  type="application/javascript" src="${basePath}/js/common/jquery/3.0.0/jquery-3.0.0.min.js"></script>
	
	<link rel="stylesheet" href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}"/>
	<link rel="stylesheet" href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
	<!-- font-awesome 图标-->
	<link rel="stylesheet" href="${basePath}/js/common/font-awesome/css/font-awesome.min.css">
	
	<script  type="application/javascript" src="${basePath}/js/common/layer/layer.js"></script>
	<script  type="application/javascript" src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script  type="application/javascript" src="${basePath}/js/shiro.demo.js"></script>
	<!-- 我的权限中用到的组织树js-->
	<script  type="application/javascript" src="${basePath}/js/common/bootstrap/bootstrap-treeview.js"></script>
	
	<style type="text/css">
		<!--编辑按钮、删除按钮颜色改为白色-->
		.fa-pencil,.fa-trash-o{
			color:white;
		}
	</style>
	<script baseUrl="${basePath}" src="${basePath}/js/user.login.js"></script>
	<!--*******更换主题amazeui 添加引用  start********-->
	<meta http-equiv="Cache-Control" content="no-siteapp" />
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="${basePath}/js/common/amazeui/css/amazeui.min.css" />
    <link rel="stylesheet" href="${basePath}/js/common/amazeui/css/admin.css">
    <link rel="stylesheet" href="${basePath}/js/common/amazeui/css/app.css">
    <script type="application/javascript" src="${basePath}/js/common/amazeui/js/echarts.min.js"></script>
	
	<!--*******更换主题amazeui 添加引用  end********-->
	
</#macro>