<?php
require FdHelperLib::getViewFilePath('head');//由于head中的title是由数据生成的，所以要先查数据，后输出页面。
?>
<body>
<style type="text/css">
/*layout*/
.area_1
{
    width:1240px;
    margin:0 auto;
}
.area_3
{
    width:11em;
    float:left;
}
.area_4
{
    margin-left:12em;
}
.area_5
{
    margin:20px 0 0 0;
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
    require FdHelperLib::getViewFilePath('group_open_categories_nav');
    ?>
    </div>
    <div class="area_4">
    <?php
    require FdHelperLib::getViewFilePath('filter');
    ?>
    <?php
    require FdHelperLib::getViewFilePath('order_by');
    require FdHelperLib::getViewFilePath('products_preview');
    ?>
    </div>
    <?php
    //require dirname(__FILE__).'/../../controller/list/module_page_num.php';
    ?>
    <div class="area_5">
    <?php
        require FdHelperLib::getViewFilePath('contact_us');
    ?>
    </div>
</div>
</body>
</html>
