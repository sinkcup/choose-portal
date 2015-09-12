<?php
require FdHelperLib::getViewFilePath('head');//由于head中的title是由数据生成的，所以要先查数据，后输出页面。
?>
<body>
<style type="text/css">
/*layout*/
.area_1
{
	width:970px;
	margin:0 auto;
}
.area_3
{
	width:10em;
	float:left;
}
.area_4
{
	margin-left:11em;
}
</style>
<div class="area_1">
	<div class="area_2">
	<?php
	require FdHelperLib::getViewFilePath('logo_and_search');
	?>
	</div>
	<div class="area_3">
	<?php
	//require FdHelperLib::getViewFilePath('group_hidden_categories_nav');
	?>
	</div>
	<div class="area_4">
	<?php
	require FdHelperLib::getViewFilePath('edit_product');
	?>
	<?php
	//require FdHelperLib::getViewFilePath('products_preview');
	?>
	</div>
	<?php
	//require dirname(__FILE__).'/../../controller/list/module_page_num.php';
	?>
</div>
</body>
</html>
