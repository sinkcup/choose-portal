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
            <div class="module_uri">
                <form method="get" action="">
                    <label for="uri">购买链接：</label>
                    <input type="text" name="uri" id="uri" value="<?=isset($_GET['uri']) ? $_GET['uri'] : ''?>" />
                    <input type="submit" />
                </form>
            </div>
	</div>
	<div class="area_4">
	<?php
        if (isset($_GET['uri']) && !empty($_GET['uri'])) {
	    require FdHelperLib::getViewFilePath('add_product');
        }
	?>
	</div>
</div>
</body>
</html>
